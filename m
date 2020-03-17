Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8EBC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OrfhVnn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgCQJJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:09:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35894 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgCQJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:09:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so21910602ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=To90Aks1QffLWwmCVhWp92G2t7kKA7+CEhKhINvOIzQ=;
        b=OrfhVnn77/q/QbU3GLdBl8/vFd/OmkvQ5h26M/H7pVe9WwMGkLALnwxMK+CxEwCjhY
         XvcpVnYykjrO730oo7sXyrArDMF3y+Eu3kh7YqHNnLktiOBMsJchzTWmn5VR4K/NbnTB
         wt6ZYuCPlzONROFDGLLwv1AEBR6DtGCb2XCWmCtEhh2ad1JrDf9F+sowm4cuRAmt244I
         5Ldoz6Rafdb3cBN80a5HuE8qpA12fNf8Wvsst4xo+qS+ABvksoCfy+2VIks8mEG9gc+D
         elBddi3V4K3YBnTGQaQi33Un+enw3KKaqpLrb6zGGu2aqGeKI9qLaUkMxjkEq3x35Nuw
         BuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=To90Aks1QffLWwmCVhWp92G2t7kKA7+CEhKhINvOIzQ=;
        b=VONdoOfIok1anAX2U3xblWNavq3FqayS6YKLOQeqRKmIzFQ9RYcoy85ea50gPufHB6
         M3FbnN9HnMB5CnIdqt4KQPcJyguALp5OpKsa9VMFXrnj4lRiz1PKK2iE9duGDubESc0o
         Mkas2jI//SMA7bCoHEUT9ftsNYY8LVpJOwId/ZMAWncKVo1CZpXAlK+prOAKP4XyAkzN
         onb+jHSlPhojFOo9AQ6FmNfSkfwUHR3TmJ0k4hpJvnWj3r8CpuhLAPfV2zVOBfCFFUou
         Y+Mwjf1cf7u4GBUNL5SeJWJLgxpgxYMfnLmQvTBM+TfZKJGLyvVyWBsOdqxZozqwP6VG
         Fyuw==
X-Gm-Message-State: ANhLgQ04UYF9YlAN4+/7jeFuEuhI1UYDT//7ExImUGtPqeX4dKyYByx2
        OiK97xsIdvQ3WWuw0+ageiq7xg==
X-Google-Smtp-Source: ADFU+vsTOYO0auHM8js2HOb5sViti64Bjr9l2wyOuM9fFyeZM4T9/eByqc5cktvLY+az7E8U+3Gqqg==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2148589ljp.116.1584436178731;
        Tue, 17 Mar 2020 02:09:38 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:48ef:94a3:a481:5e62:4324:124b? ([2a00:1fa0:48ef:94a3:a481:5e62:4324:124b])
        by smtp.gmail.com with ESMTPSA id k2sm2202120lfo.36.2020.03.17.02.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 02:09:38 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] firmware: tee_bnxt: remove unused variable init
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <20200317040742.12143-1-rayagonda.kokatanur@broadcom.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e94bbb2c-6f36-61bb-d26a-2ce3e1a139e0@cogentembedded.com>
Date:   Tue, 17 Mar 2020 12:09:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317040742.12143-1-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 17.03.2020 7:07, Rayagonda Kokatanur wrote:

> Remove unused variable initialization.

    I think it's not an initialization, it's an assignment. :-)

> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>   drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> index ed10da5313e8..6fd62657e35f 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
>   	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
>   
>   	while (rbytes)  {
> -		nbytes = rbytes;
> -
>   		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
>   
>   		/* Fill additional invoke cmd params */

MBR, Sergei
