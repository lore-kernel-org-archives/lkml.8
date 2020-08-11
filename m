Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4506C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A078220838
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgHKI24 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:28:56 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:58042 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHKI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:28:55 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 04:28:54 EDT
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id ABCCF6000057
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:19:49 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 7A3666000050
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:19:49 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 11 Aug 2020 10:19:49 +0200
Message-Id: <5F3254A4020000A10003A897@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.2.1 
Date:   Tue, 11 Aug 2020 10:19:48 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-kernel@vger.kernel.org>
Subject: heads up: clock_gettime(CLOCK_MONOTONIC, ...) is not monotonic
 with Xen PVM
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm not subscribed to the kernel list, and my kernels are somewhat outdated, but I'd like to let you know:
I found an issue where clock_gettime(CLOCK_MONOTONIC, ...) returned the identical value to two subsequent calls, while the resolution claimed is 1 ns.

Environment: Xen Host x86-64 using SLES11 SP4 (3.0.101-108.87-xen), Xen-Guest using SLES12 SP5 (4.12.14-122.26-default, glibc 2.22)

Typically I take 100 fast clock samples ("samples"), build the differences ("deltas"), and sort the differences. The smallest number shouldn't be zero, right?

Here is one case:
(gdb) print *samples@5
$5 = {{tv_sec = 4127194, tv_nsec = 210786012}, {tv_sec = 4127194,
    tv_nsec = 210790437}, {tv_sec = 4127194, tv_nsec = 210794819}, {
    tv_sec = 4127194, tv_nsec = 210799202}, {tv_sec = 4127194,
    tv_nsec = 210808344}}
(gdb) print *deltas@5
$6 = {{tv_sec = 0, tv_nsec = 4425}, {tv_sec = 0, tv_nsec = 4382}, {tv_sec = 0,
    tv_nsec = 4383}, {tv_sec = 0, tv_nsec = 9142}, {tv_sec = 0, tv_nsec = 0}}
(gdb) print *samples@6
$7 = {{tv_sec = 4127194, tv_nsec = 210786012}, {tv_sec = 4127194,
    tv_nsec = 210790437}, {tv_sec = 4127194, tv_nsec = 210794819}, {
    tv_sec = 4127194, tv_nsec = 210799202}, {tv_sec = 4127194,
    tv_nsec = 210808344}, {tv_sec = 4127194, tv_nsec = 210808344}}

Obviously the last two samples are identical!

In the non-error case I get numbers like this (the hardware is about 10 years old):
get_res: resolution is 0.000000001
get_res: smallest delta is 0.000004171
get_res: largest delta is 0.000007364

Here's the code I used:

#include        <stdlib.h>
#include        <stdarg.h>
#include        <stdio.h>
#include        <string.h>
#include        <unistd.h>
#include        <limits.h>
#include        <errno.h>
#include        <assert.h>
#include        <time.h>
#include        <fcntl.h>
#include        <math.h>
#include        <sys/types.h>

#define NSECS_PER_SECOND        1000000000L     /* nanoseconds per second */
#define CLOCK_SAMPLES   100             /* number of clock samples for
                                         * get_res()
                                         */
typedef struct timespec ts_t;           /* short-cut for struct timespec */

#if _POSIX_C_SOURCE < 199309L
# error "Need POSIX clock_gettime(CLOCK_MONOTONIC)"
#endif

/* get timespec value */
static  int     get_time(ts_t *tsp)
{
        int     result;

        result = clock_gettime(CLOCK_MONOTONIC, tsp);
        return(result);
}

/* time difference tsp1 -= tsp2 */
static  void    subtract_time1(ts_t *tsp1, const ts_t *tsp2)
{
        tsp1->tv_sec -= tsp2->tv_sec;
        tsp1->tv_nsec -= tsp2->tv_nsec;
        if ( tsp1->tv_nsec < 0 )
                --tsp1->tv_sec, tsp1->tv_nsec += NSECS_PER_SECOND;
}

/* time difference tsp1 - tsp2 */
static  ts_t    subtract_time(const ts_t *tsp1, const ts_t *tsp2)
{
        ts_t    result = *tsp1;

        subtract_time1(&result, tsp2);
        return(result);
}

/* compare time stamps tsp1 - tsp2 */
static  int     compare_time(const ts_t *tsp1, const ts_t *tsp2)
{
        if ( tsp1->tv_sec < tsp2->tv_sec )
                return(-1);
        else if ( tsp1->tv_sec > tsp2->tv_sec )
                return(1);
        else if ( tsp1->tv_nsec < tsp2->tv_nsec )
                return(-1);
        else if ( tsp1->tv_nsec > tsp2->tv_nsec )
                return(1);
        return(0);
}

/* qsort-compatible compare time stamps tsp1 - tsp2 */
static  int     cmp_time(const void *tsp1, const void *tsp2)
{
        return(compare_time((const ts_t *) tsp1, (const ts_t *) tsp2));
}

/* get clock resolution */
static  long    get_res(ts_t *tsp)
{
        int             result;
        ts_t            samples[CLOCK_SAMPLES];
        ts_t            deltas[CLOCK_SAMPLES];
        unsigned        u;

        if ( (result = clock_getres(CLOCK_MONOTONIC, tsp)) != 0 )
                goto leave;
        printf("%s: resolution is %ld.%09ld\n", __func__,
               tsp->tv_sec, tsp->tv_nsec);
        assert(tsp->tv_sec == 0);
        for ( u = 0; u < CLOCK_SAMPLES; ++u )
        {
                get_time(samples + u);
        }
        for ( u = 1; u < CLOCK_SAMPLES; ++u )
        {
                deltas[u - 1] = subtract_time(&samples[u], &samples[u - 1]);
                assert(deltas[u - 1].tv_nsec != 0);
        }
        qsort(deltas, CLOCK_SAMPLES - 1, sizeof(deltas[0]), cmp_time);
        for ( u = 0; u < CLOCK_SAMPLES - 1 && deltas[u].tv_nsec == 0; ++u )
        {
                assert(deltas[u].tv_sec == 0);
        }
        if ( u >= CLOCK_SAMPLES - 1 )
        {
                printf("%s: clock did not advance within %d samples\n",
                      __func__, u);
                result = -1;
                goto leave;
        }
        assert(u == 0);
        if ( u > 0 )
                printf("%s: skipped %d zero samples\n", __func__, u);
        printf("%s: smallest delta is 0.%09ld\n", __func__,
               deltas[u].tv_nsec);
        printf("%s: largest delta is 0.%09ld\n", __func__,
              deltas[CLOCK_SAMPLES - 2].tv_nsec);
        if ( deltas[u].tv_nsec > tsp->tv_nsec )
                tsp->tv_nsec = deltas[0].tv_nsec;
leave:  return(result);
}

/* main */
int     main(int argc, char *argv[])
{
        int     result  = 0;
        ts_t    res;

        get_res(&res);
        printf("resolution is 0.%09ld\n", res.tv_nsec);
        return(result);
}
--------- it is intentional that the program aborts on error--------
Output from a newer machine:
get_res: resolution is 0.000000001
get_res: smallest delta is 0.000000030
get_res: largest delta is 0.000000050
resolution is 0.000000030

Regards,
Ulrich Windl
(Keep me on CC if I should read your replies)

