Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B423EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E142073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgC3Qeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:34:46 -0400
Received: from mx.sdf.org ([205.166.94.20]:62779 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgC3Qeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:34:46 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02UGYDT4006227
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 16:34:16 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02UGYCSx027097;
        Mon, 30 Mar 2020 16:34:12 GMT
Date:   Mon, 30 Mar 2020 16:34:12 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        lkml@sdf.org
Subject: Re: [RFC PATCH v1 29/50] fs/ocfs2/journal: Use prandom_u32() and not
 /dev/random for timeout
Message-ID: <20200330163412.GA2459@SDF.ORG>
References: <202003281643.02SGhIOY022599@sdf.org>
 <016c2bdc-68eb-245f-2292-d00d0d8e45a5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016c2bdc-68eb-245f-2292-d00d0d8e45a5@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 08:09:33PM +0800, Joseph Qi wrote:
> Sorry for the late reply since I might miss this mail.

You're hardly late; I expect replies to dribble in for a week.

> On 2019/3/21 11:07, George Spelvin wrote:
>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>> index 68ba354cf3610..939a12e57fa8b 100644
>> --- a/fs/ocfs2/journal.c
>> +++ b/fs/ocfs2/journal.c
>> @@ -1884,11 +1884,8 @@ int ocfs2_mark_dead_nodes(struct ocfs2_super *osb)
>>   */
>>  static inline unsigned long ocfs2_orphan_scan_timeout(void)
>>  {
>> -	unsigned long time;
>> -
>> -	get_random_bytes(&time, sizeof(time));
>> -	time = ORPHAN_SCAN_SCHEDULE_TIMEOUT + (time % 5000);
>> -	return msecs_to_jiffies(time);
>> +	return msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT) +
>> +		prandom_u32_max(5 * HZ);
> 
> Seems better include the prandom_u32_max() into msecs_to_jiffies()?

What I'm trying to take advantage of here is constant propagation.

msecs_to_jiffies is zero cost (it's evaluated entirely at compile 
time) if its argument is a compile-time constant.  It's a function call
and a few instructions if its argument is variable.

msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT + prandom_u32_max(5000))
would be forced to use the expensive version.

The compiler does't know, but *I* know, that msecs_to_jiffies() is a 
linear function, and prandom_u32_max() is a sort-of linear function.

(It's a linear function for a given PRNG starting state, so each 
individual call is linear, but multiple calls mess things up.)

Modulo a bit of rounding, we have:

msecs_to_jiffies(a + b) = msecs_to_jiffies(a) + msecs_to_jiffies(b)
msecs_to_jiffies(a) * b = msecs_to_jiffies(a * b)
prandom_u32_max(a) * b = prandom_u32_max(a * b)
prandom_u32_max(msecs_to_jiffies(a)) = msecs_to_jiffies(prandom_u32_max(a))

By doing the addition in jiffies rather than milliseconds, we get the 
cheap code.  It's not a huge big deal, but it's definitely smaller and 
faster.

Admittedly, I happen to be using HZ = 300, which requires a multiply to 
convert, and makes the resultant random numbers slightly non-uniform.  
The default HZ = 250 makes it just a divide by 4, which is pretty simple.

(When HZ = 300, you get 1..3 ms -> 1 jiffy, 4..6 ms -> 2 jiffies, and
7..10 ms -> 3 jiffies.  Multiples of 3 are 33% more likely to be chosen.)

It just seems silly and wasteful to pick a random number between 0 and 
4999 (plus 30000), only to convert it to a random number between 0 and 
1249 (plus 7500).

And if HZ = 2000 ever happens, the timeout won't be artificially limited
to integer milliseconds.
