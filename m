Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F9C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDAD206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD1CyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1CyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:54:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66323206E2;
        Tue, 28 Apr 2020 02:54:08 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:54:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
Message-ID: <20200427225406.7cacc796@gandalf.local.home>
In-Reply-To: <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
References: <20200424045314.16017-1-gshan@redhat.com>
        <20200424101132.GC1167@C02TD0UTHF1T.local>
        <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 10:59:14 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Mark,
> 
> On 4/24/20 8:11 PM, Mark Rutland wrote:
> > [Adding Steve, who added str_has_prefix()]
> > 
> > On Fri, Apr 24, 2020 at 02:53:14PM +1000, Gavin Shan wrote:  
> >> The NUMA option is parsed by str_has_prefix() and the invalid option
> >> like "numa=o" can be regarded as "numa=off" wrongly.  
> > 
> > Are you certain that can pass? If that can happen, str_has_prefix() is
> > misnamed and does not seem to do what its kerneldoc says it does, as
> > "off" is not a prefix of "o".
> >   
> 
> Yes, It's possible. str_has_prefix() depends on strncmp(). In this particular
> case, it's equal to the snippet of code as below: strncmp() returns zero.
> str_has_prefix() returns 3.

Wait! strncmp("o", "off", 3) returns zero?

That to me looks like a bug!

This means str_has_prefix() is broken in other areas as well.


> 
> int strncmp(const char *cs, const char *ct, size_t count)
> {
>          unsigned char c1, c2;
> 
>          while (count) {
>                  c1 = *cs++;
>                  c2 = *ct++;
>                  if (c1 != c2)
>                          return c1 < c2 ? -1 : 1;
>                  if (!c1)                             /* break after first character is compared */

Crap! That is totally wrong!

/me goes to fix...

-- Steve

>                          break;
>                  count--;
>          }
>          return 0;                                    /* 0 returned */
> }
> 
> static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
> {
>          size_t len = strlen("o");
>          return strncmp("o", "off", 1) == 0 ? len : 0;
> }
> 
> >> This fixes the issue with sysfs_streq(), which have more sanity checks,
> >> to avoid accepting the invalid options.  
> > 
> > That doesn't sound immediately right, since this is an early parameter,
> > which has nothing to do with sysfs. Perhaps that's just a misleading
> > name?
> >   
> 
> sysfs_streq() was introduced to compare the parameters received from sysfs
> entry, but I don't think it has to be necessarily tied with sysfs entry.
> So the name is bit misleading. Alternatively, we also can fix it in another
> way (as below) if we try to avoid using sysfs_streq().
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 4decf1659700..b0c1ec78f50f 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -29,9 +29,13 @@ static __init int numa_parse_early_param(char *opt)
>   {
>          if (!opt)
>                  return -EINVAL;
> -       if (str_has_prefix(opt, "off"))
> +
> +       if (strlen(opt) >= 3 && str_has_prefix(opt, "off"))
>                  numa_off = true;
> 
> > Thanks,
> > Mark.
> >   
> 
> Thanks,
> Gavin
> 
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   arch/arm64/mm/numa.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >> index 4decf1659700..bd458b28616a 100644
> >> --- a/arch/arm64/mm/numa.c
> >> +++ b/arch/arm64/mm/numa.c
> >> @@ -29,7 +29,8 @@ static __init int numa_parse_early_param(char *opt)
> >>   {
> >>   	if (!opt)
> >>   		return -EINVAL;
> >> -	if (str_has_prefix(opt, "off"))
> >> +
> >> +	if (sysfs_streq(opt, "off"))
> >>   		numa_off = true;
> >>   
> >>   	return 0;
> >> -- 
> >> 2.23.0
> >>  
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >   

