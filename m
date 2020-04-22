Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D0C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF03206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1uGHaxY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="hn3u61Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgDVN1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:27:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50511 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDVN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:27:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1B04C125B;
        Wed, 22 Apr 2020 09:27:09 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=kctC3QbxGnNRnpH2Si8fA35MZxo=; b=f1uGHa
        xYMs/JRLH0ylPKDqOnCWo8/cs6yP7tng+BbGY4r68a70Ik9B6Pl44UbLqhVl2v0N
        1SZKGzj91Rn9qebO7b2K1ov37WMmJOGZHL0OnusZNkMCKDojP2bit+Ndh/pLCQXn
        2vAG/XE8PhwMBTLQbaoqpsEBcOGvDf7oefmgE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B93C8C125A;
        Wed, 22 Apr 2020 09:27:09 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=skQgCCgpMr7/68sSM5jIJAK8zQSZRKSb1HMqaNQoOjo=; b=hn3u61FdDFFZLIjJoumE7mFVdUyUX95jMkqfZ3tkQHVb/XMCUMeGSwYSpJaCjP46nZTop9XP+z+Ral1LYugCIZhj3fqwgTp0T08gplDKDPEbHTg0LrMJDITCep7h18FRL7B4caXI6+LGTBpJ1cYa7vYCh6XXMfryXVWfVZNvVZk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A14E8C1259;
        Wed, 22 Apr 2020 09:27:06 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id A72F72DA016E;
        Wed, 22 Apr 2020 09:27:04 -0400 (EDT)
Date:   Wed, 22 Apr 2020 09:27:04 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, rmk+kernel@arm.linux.org.uk
Subject: Re: [PATCH 02/23] sched,bL_switcher: Convert to sched_set_fifo*()
In-Reply-To: <20200422112831.339113081@infradead.org>
Message-ID: <nycvar.YSQ.7.76.2004220926280.2671@knanqh.ubzr>
References: <20200422112719.826676174@infradead.org> <20200422112831.339113081@infradead.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: F6189CE2-849C-11EA-ADF9-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Peter Zijlstra wrote:

> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> In this case, use fifo_low, because it only cares about being above
> SCHED_NORMAL. Effectively no change in behaviour.
> 
> Cc: nico@fluxnic.net
> Cc: rmk+kernel@arm.linux.org.uk
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  arch/arm/common/bL_switcher.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -270,12 +270,11 @@ static struct bL_thread bL_threads[NR_CP
>  static int bL_switcher_thread(void *arg)
>  {
>  	struct bL_thread *t = arg;
> -	struct sched_param param = { .sched_priority = 1 };
>  	int cluster;
>  	bL_switch_completion_handler completer;
>  	void *completer_cookie;
>  
> -	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
> +	sched_set_fifo_low(current);
>  	complete(&t->started);
>  
>  	do {
> 
> 
> 
