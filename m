Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEC9C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785AA2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980797;
	bh=sy0aZR96Ca8zfAgxzaqIau0tuJKmSH20xpMv6v/itjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TJoJR2LHGH/XYAhOsLnxA/YMj+fWvqAgcYNGJdsVALyPIWeTAUo9jFnTw8lzr5MpF
	 3+mgBHzuIFwcxIl71t1C67frk6V1CaZo9VolQEIoZSLfqnsEpZ6Dj5BlnWZEDsVJQW
	 oTf6sgr8zP0uWaMVqAywlzf4OKPy5SeJr7EP9Ouo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgIARTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732658AbgIARTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:19:51 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B492207D3;
        Tue,  1 Sep 2020 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598980787;
        bh=sy0aZR96Ca8zfAgxzaqIau0tuJKmSH20xpMv6v/itjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpSSRs53CiZXxpSOuVmXsNXuEeSeeViItUrAmb3/GnrxgtHhPOl+8Xwekl0SfN3Sv
         uG04zUDkeLYaPKhFlulxTfCJCRxiIMqcTPTeZIBh+2982P57NlTNRkEGo9nplG8Jk5
         Qa7vA58sWoVd5uulnV4xqbeH78otNhJs9422igJY=
Date:   Tue, 1 Sep 2020 12:25:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Leesoo Ahn <dev@ooseel.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Niu Xilei <niu_xilei@163.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: fix error message with wrong function name
Message-ID: <20200901172556.GA31464@embeddedor>
References: <20200901130449.15422-1-dev@ooseel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901130449.15422-1-dev@ooseel.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:04:47PM +0900, Leesoo Ahn wrote:
> Error on calling kthread_create_on_node prints wrong function name,
> kernel_thread.
> 
> Signed-off-by: Leesoo Ahn <dev@ooseel.net>

You might need to add the following tag:

Fixes: 94dcf29a11b3 ("kthread: use kthread_create_on_node()")

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  net/core/pktgen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 95f4c6b8f51a..44fdbb9c6e53 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -3699,7 +3699,7 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
>  				   cpu_to_node(cpu),
>  				   "kpktgend_%d", cpu);
>  	if (IS_ERR(p)) {
> -		pr_err("kernel_thread() failed for cpu %d\n", t->cpu);
> +		pr_err("kthread_create_on_node() failed for cpu %d\n", t->cpu);
>  		list_del(&t->th_list);
>  		kfree(t);
>  		return PTR_ERR(p);
> -- 
> 2.25.4
> 
