Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E0C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1F206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nislDfeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbgDCNpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:45:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgDCNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:45:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033DjiLq038397;
        Fri, 3 Apr 2020 08:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585921544;
        bh=msl3CK4yocxq+NPxeZVavwswcpbyBOYVu1q6mld4hnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nislDfeNmEpcTKretzQiMIbl9Sz3dyRFj3ZatP/L0WdQaLVfaoYMRoGNsOAxs0ipl
         bT0eFNk3ZJyg0ZZu62IipOZCGxL1D91QYWT207yVXOjJgkBe/VMChjZakjxlov6GoF
         /yH5h3DLO/GtviybfOEm5o+d5kS24vuI2Os7VA7E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 033Dji6t010095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Apr 2020 08:45:44 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 08:45:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 08:45:43 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033DjhLE028601;
        Fri, 3 Apr 2020 08:45:43 -0500
Subject: Re: [PATCH] remoteproc/omap: Fix set_load call in
 omap_rproc_request_timer
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
References: <20200402010812.GA751391@yoga>
 <20200403013134.11407-1-natechancellor@gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4a2b5227-a251-bc90-7177-a75224da4623@ti.com>
Date:   Fri, 3 Apr 2020 08:45:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200403013134.11407-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 8:31 PM, Nathan Chancellor wrote:
> When building arm allyesconfig:

Thanks, Nathan. Also throws up with omap2plus_defconfig.

> 
> drivers/remoteproc/omap_remoteproc.c:174:44: error: too many arguments
> to function call, expected 2, have 3
>         timer->timer_ops->set_load(timer->odt, 0, 0);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~                ^
> 1 error generated.
> 
> This is due to commit 02e6d546e3bd ("clocksource/drivers/timer-ti-dm:
> Enable autoreload in set_pwm") in the clockevents tree interacting with
> commit e28edc571925 ("remoteproc/omap: Request a timer(s) for remoteproc
> usage") from the rpmsg tree.
> 
> This should have been fixed during the merge of the remoteproc tree
> since it happened after the clockevents tree merge; however, it does not
> look like my email was noticed by either maintainer and I did not pay
> attention when the pull was sent since I was on CC.
> 
> Fixes: c6570114316f ("Merge tag 'rproc-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc")
> Link: https://lore.kernel.org/lkml/20200327185055.GA22438@ubuntu-m2-xlarge-x86/
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/remoteproc/omap_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index cdb546f7232e..6955fab0a78b 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -171,7 +171,7 @@ static int omap_rproc_request_timer(struct device *dev, struct device_node *np,
>  	}
>  
>  	/* clean counter, remoteproc code will set the value */
> -	timer->timer_ops->set_load(timer->odt, 0, 0);
> +	timer->timer_ops->set_load(timer->odt, 0);
>  
>  	return 0;
>  }
> 

