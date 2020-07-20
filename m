Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC201C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957CB22C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="y6E+AEZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgGTLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgGTLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:32:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:32:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a21so11856706otq.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4aOpnJ5nNTSoh+24DIHU9Yc6fbVLox9dEbplxI8c3XQ=;
        b=y6E+AEZ8IQJVm3X2o13djBW+1Vf4VpbL6pKjyhd3+gC2k6hAaZGOARiutNbHtgSGIM
         do+Ufwzue+EVznFQFJ86lM4G9op8pADrEBnZCbVUZr/EuepgaIqcMrJ4VIllxbeqOxep
         uhsxKAIp9IgJfgQpnkldzK47/RfH9NUEpW3wqDcizycFB+qQ66h1cmngPLBQmqi98ZTh
         MXlq+/g3dGwptMSYSOmPyZsDGzrk0+sg7LHuQTyxqwF0JH423Xu7xLd2x4mXIvGuTqL4
         jquQFs8KwKK7y493pfilmkdJcNySDmEbCpZorfdEuPB4btjuCf5FlT6IhdykGqmFuwUc
         F9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4aOpnJ5nNTSoh+24DIHU9Yc6fbVLox9dEbplxI8c3XQ=;
        b=QNzFmGRmFzRfWSIDB0DIB+1p6BDkrbXncMZtwzP3WooVjVymK5dyC8lHG1bHsbELUY
         gvKO3obuKiXcvfox3lafKu/ENGJKrBbVeMmuhX82k017l6zTdNHdFFgt5KWraYa4HtGj
         4Tci8cz+llMcSiS+8i9g3dGVpcqcFCExoM+OX9lTvAs506RNlESvGTn2xG5P61sSrfcu
         H5Cusavp2NWaYKAX46VnRPmjEIREHFVlLnFkKEs1EME55/SqmH6V5LJdCCmyF6MDLAtJ
         txL1oaA6aMXgO245IVXTLsh846n90wZclDThRq3gUFcOGpXEdLlt7XLjVQl4TDcWsrkn
         DyIg==
X-Gm-Message-State: AOAM53271kEX5SVb2XQotya+3ZiQak3Q2R/RSlpprsasZZAr24fWdy49
        MAlO6zVWJdLA8J2RtRij4/enRA==
X-Google-Smtp-Source: ABdhPJw/yHTCBRjfXGBieriP8jxN6PeazZCMLX87Ky6/wie17ObyFIZb8Nq/8qVGhRaeFIsgo4zR8w==
X-Received: by 2002:a9d:4f01:: with SMTP id d1mr17348549otl.73.1595244752642;
        Mon, 20 Jul 2020 04:32:32 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:8045:5514:398b:d262])
        by smtp.gmail.com with ESMTPSA id k2sm3462605otn.56.2020.07.20.04.32.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 04:32:32 -0700 (PDT)
Date:   Mon, 20 Jul 2020 06:32:30 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: remve duplicate code in __ipmi_bmc_register()
Message-ID: <20200720113230.GA2961@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200720080838.148737-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720080838.148737-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:08:38PM +0800, Jing Xiangfeng wrote:
> __ipmi_bmc_register() jumps to the label 'out_free_my_dev_name' in an
> error path. So we can remove duplicate code in the if (rv).

Looks correct, queued for next release.

Thanks,

-corey

> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index e1b22fe0916c..737c0b6b24ea 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3080,8 +3080,6 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>  	rv = sysfs_create_link(&bmc->pdev.dev.kobj, &intf->si_dev->kobj,
>  			       intf->my_dev_name);
>  	if (rv) {
> -		kfree(intf->my_dev_name);
> -		intf->my_dev_name = NULL;
>  		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
>  			rv);
>  		goto out_free_my_dev_name;
> -- 
> 2.17.1
> 
