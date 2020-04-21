Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3087C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B252A206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587461897;
	bh=Wwmy5yMfOOS/GCTIsUM1/NwOzDNkNh6C9kXX+XiAPg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxuMgsqVIemWku/T0X3ZhtGNCUiNu9Js316rfg28kvtmVjLJbpzh2E3xExlVpE30m
	 CnPA5lH52XzBxBgvOpm0VMu1M6EPG9kh2Kgew/FP5MMFhtfWSxO1udH/AQPv/9dtpB
	 sKJxGVXKwD4EQRl7s02yCDIaClsiiBspPLj06pBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgDUJiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:38:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43053 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgDUJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:38:16 -0400
Received: by mail-ej1-f67.google.com with SMTP id gr25so10474796ejb.10;
        Tue, 21 Apr 2020 02:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGBcI73VU2JONip5DkkM7BykwieGTB1otFveN1pvYmE=;
        b=REGek+KsgVl1C28U/v9NV3ociTKxEAwHLPXMrFYZ5MYS6XGxA6izg7m7aafY2CtJva
         IvxoQHCG5wqE37P0Czre2ykcDL0nThRSRA+uvs5LLTR3ZLlCEZUd4Pr5voPlXkMftmsT
         npM+xykFsomqPFTOBYrCWi4YoUd8I6N5SpKaDVvGt/HbWc1SHFL7sVeqT9WcX9XYGxVn
         qXWB1kDkbaYp8D6CTceAZ+MN6FeHHhvE6qwRKpuJHrkMxA/kYU+UaF+3QhghDZrSc29h
         VLv5H8afXHDf3zr8tzbyYaPPv+AD6gpcfpzotX8bMwLmUa8SxAnxom6fAQ1rPjrWEcHb
         VVwA==
X-Gm-Message-State: AGi0PuY2ITiLU3E5crrr4n78G2RUqCTxFqkI09jZL7+tdoyx8GhE761G
        hWdpf7eaZUkERWkanR02FywO5sho
X-Google-Smtp-Source: APiQypIvWtysc4ninhQola2RZmSLC9gKOAScPv8GH1q630D+x/ENlDK5A4qXDOXskHD8rD8D2axIVw==
X-Received: by 2002:a17:906:14c:: with SMTP id 12mr20545531ejh.125.1587461894089;
        Tue, 21 Apr 2020 02:38:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id sb17sm414298ejb.75.2020.04.21.02.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 02:38:13 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:38:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ARM: samsung: Omit superfluous error message in
 s3c_adc_probe()
Message-ID: <20200421093810.GB30127@kozik-lap>
References: <20200419070541.14820-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200419070541.14820-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 03:05:41PM +0800, Tang Bin wrote:
> In the function s3c_adc_probe(), when get irq failed,
> the function platform_get_irq() logs an error message,
> so remove redundant message here.
> 
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  arch/arm/plat-samsung/adc.c | 4 +---

Thanks, applied.

Best regards,
Krzysztof

