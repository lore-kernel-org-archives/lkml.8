Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68118C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CA2207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YfkdN1kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgELI2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgELI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:28:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:28:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u20so2313328ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95GbR0TC2RxBW+8LeWrRYGNf93ycRXGQPznoeVFPxjc=;
        b=YfkdN1kciz/KYl7ns9JAwxFgNKOP0wPqdPc0ksttDUXqoTzfw1QKp22yiiZ9wos4sM
         cD/T2xO2XyMpnqLje9FcDcKEbtfwPmaQNsZZ1XNzfiC7zSwqXRHe7okFEm9DQaXMw3Kn
         rIlgEHeUZQh54spRfnUN602nZsqVlZSkNlSDWTOgvsuzcz3Vu49JwfGBSJqhPbykgjhU
         w8LGUzhqT2fz7f5n6SjJGAhrdAos8uKkxaE/Ofqlt05zf5WFDQ/wIqWttnjZ2d+ZUD3E
         +ZgJxOUuAxhvEUW2qhIf41VgrWnKpEAVMtsgJzu03g5qJrihJhoDY3Z1iZTkfuCbTPEF
         qZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95GbR0TC2RxBW+8LeWrRYGNf93ycRXGQPznoeVFPxjc=;
        b=Nd/peUuln1nEmUC/Qdh2c87VN/MqTzZfpQB+nXyZURGpymKvfHibKdF99lYrKVMNEY
         2mGm5QyxP0UO4+asyvJO9sdivSgTzWASpnCd7WBPaHPHDzsxGDlq327slay5qVmWKoA1
         btJdDB2MP2Icd4q5p93eWjk6Q7OBIz28YHJhhSb+S0tjKfrnu2IpXOF/+o8GcsPXtQqX
         P4Ik9y2elt0HdcPm8/hZ6pgiBcEWmcJuqZjn/+3nmjpTh1cfZEDNpps2FUk2B7EDIUdN
         3oOyV7PtNdTQPIT6bG94PxKGw04NynZvZ6UOYZO2J4hQxT5A+tubmKCXb2+02Vy09aCt
         hh6A==
X-Gm-Message-State: AOAM532l1y2za2SVQMGzPS0BsWkmqUVcjYhgxLu12IUyYvC2j0rcEmoL
        GqdiFSU7EjN5V6MdsbehNU5S7OJ9ptI=
X-Google-Smtp-Source: ABdhPJzP7yoMA2P0CSPKne8R1Adb7IieSl92dmH9QBd5oCS/wyRf/9ihDL58+wdT1kWj7l7HqUi5Hw==
X-Received: by 2002:a2e:b891:: with SMTP id r17mr13079793ljp.34.1589272094748;
        Tue, 12 May 2020 01:28:14 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:61b:c4fe:68d6:9937:777b:c884? ([2a00:1fa0:61b:c4fe:68d6:9937:777b:c884])
        by smtp.gmail.com with ESMTPSA id t16sm14599694lff.72.2020.05.12.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 01:28:14 -0700 (PDT)
Subject: Re: [PATCH 1/3] net: add a CMSG_USER_DATA macro
To:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200511115913.1420836-1-hch@lst.de>
 <20200511115913.1420836-2-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f754c4ac-db7d-6688-5582-2a5f476b0f08@cogentembedded.com>
Date:   Tue, 12 May 2020 11:28:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511115913.1420836-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.05.2020 14:59, Christoph Hellwig wrote:

> Add a variant of CMSG_DATA that operates on user pointer to avoid
> sparse warnings about casting to/from user pointers.  Also fix up
> CMSG_DATA to rely on the gcc extension that allows void pointer
> arithmetics to cut down on the amount of casts.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]
> diff --git a/net/core/scm.c b/net/core/scm.c
> index dc6fed1f221c4..abfdc85a64c1b 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
[...]
> @@ -300,7 +300,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>   	if (fdnum < fdmax)
>   		fdmax = fdnum;
>   
> -	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
> +	for (i=0, cmfptr =(int __user *)CMSG_USER_DATA(cm); i<fdmax;

    Perhaps it's time to add missing spaces consistently, not just one that 
you added?

>   	     i++, cmfptr++)
>   	{
>   		struct socket *sock;

MBR, Sergei
