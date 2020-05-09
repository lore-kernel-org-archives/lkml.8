Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB3C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C7C2192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wfN2uKNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgEICS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:18:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50438 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbgEICSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:18:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588990705; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=PdeLtGZ+DGs0gr7xsOcsm7ijC6Gtv17gqP52PwY/Q/k=; b=wfN2uKNj64C9YxjuyW+jNGQGQ+Gb9oMll21DqJ18V5mGrgj9GOp9xOI2X9hdYbsMkhxsrcCk
 YyCafM4wmu9sA8g0BcQVlaypqdekryIdavqkfWtsFxQ9YWnNk+9LYQ6A2jG/SR2txMeRP06I
 tmYkvU4o7LEOHEn+e9IA++jWMzA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb612eb.7f97801e7340-smtp-out-n01;
 Sat, 09 May 2020 02:18:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63567C4478F; Sat,  9 May 2020 02:18:19 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91F16C433D2;
        Sat,  9 May 2020 02:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91F16C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Sat, 9 May 2020 07:48:12 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 3/4] sched/idle: Disable idle call on least latency
 requirements
Message-ID: <20200509021812.GM19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-4-parth@linux.ibm.com>
 <20200508083601.GJ19464@codeaurora.org>
 <328de1bf-57d1-023d-29aa-11a540212015@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328de1bf-57d1-023d-29aa-11a540212015@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:49:04PM +0530, Parth Shah wrote:
> Hi Pavan,
> 
> On 5/8/20 2:06 PM, Pavan Kondeti wrote:
> > On Thu, May 07, 2020 at 07:07:22PM +0530, Parth Shah wrote:
> >> Restrict the call to deeper idle states when the given CPU has been set for
> >> the least latency requirements
> >>
> >> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> >> ---
> >>  kernel/sched/idle.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index b743bf38f08f..85d72a6e2521 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -262,7 +262,8 @@ static void do_idle(void)
> >>  		 * broadcast device expired for us, we don't want to go deep
> >>  		 * idle as we know that the IPI is going to arrive right away.
> >>  		 */
> >> -		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> >> +		if (cpu_idle_force_poll || tick_check_broadcast_expired() ||
> >> +		    per_cpu(nr_lat_sensitive, cpu)) {
> >>  			tick_nohz_idle_restart_tick();
> >>  			cpu_idle_poll();
> >>  		} else {
> >> -- 
> >> 2.17.2
> >>
> > 
> > Since nr_lat_sensitive updates can happen remotely (when a latency sensitive
> > task becomes non-latency sensitive task), we may need to add this condition
> > in cpu_idle_poll() as well.
> > 
> 
> Right. but if the CPU is running idle_task then it will again come back to
> do_idle and read the refcount. Its a penalty in power-saving for 1
> do_idle() loop but it is difficult to put up checks for any change in
> latency_nice value.
> 

Yes, when the CPU exits to serve an interrupt, we note the change in latency
task count and enter C-state.

I asked this because all checks that are present here are also present in
cpu_idle_poll().

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
