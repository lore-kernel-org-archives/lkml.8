Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A066CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD6620738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691101;
	bh=sBUCv5w3lNjKLqyJWKSVBjVv87IacI3e30a6X4QqE6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JfZy0sLjCQGNiIpmcmKUGT+ubcWHOzA98NAXh53AzUjFvdd+RzXx3wEn+4RD5/DrL
	 oe7/aDeCA3OLIv1zbPTWb4X64MwUp4VksKvRMnkKnZq+/wiVRyzAmNqLcCKurJmYql
	 GcuQgHfmxgpRU9J2Au7hXWyff9sWPA/RogkbuRXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404090AbgHQTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:05:00 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41785 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgHQPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:45:26 -0400
Received: by mail-ej1-f67.google.com with SMTP id t10so18278770ejs.8;
        Mon, 17 Aug 2020 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=88NsSfMcBydVtMdxoydTDCkwKyXtq2TXNnD+2/bVGE0=;
        b=Jafkq9PPkG1zkZN6RAB54JHNcKYZvbiTZjQswfkCRrI8IOa2GEQr6RRASL9kGvdgiL
         bmli8G8wVuP6URqwOb+BY4imLLXLLGxJp9Y1+UQtBVWuCcU9/lZjMF2pmVbM06UBTZbf
         Dq7nhknCdaXCF5N0fhN+k5F8AVUaR1MJHQHPRLI40ez7uJfL7uJaIayxwcZSlkc1cXuO
         cCZGh8vNEkigwC3WZGmARUcb8XJh4b5MktgTxY1Kj/94FOVs9qr7JkVoj7i2OD7TW5h/
         2CXw0N4deO9/RMUw405l/HpHlT8tX2SU27FAR2jYQsRtAT7DMP9QcdC0sxrKiojR4/Tl
         LG5Q==
X-Gm-Message-State: AOAM531X+jvynh68dYEE0m29e8TBGHKe0qfX7x6tmkCLbFpoC44vWL0q
        7VlLE/dTyEinS0SeEHVGn/U=
X-Google-Smtp-Source: ABdhPJxhZ268mQwED+RocFeuapgWW+9IdkMyvpMZGdBWtySWhBhqmYB3SPqu8gQUSnqzUJrm7lL6yA==
X-Received: by 2002:a17:906:228a:: with SMTP id p10mr15557518eja.23.1597679124911;
        Mon, 17 Aug 2020 08:45:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id s18sm14671616ejd.54.2020.08.17.08.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:45:24 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:45:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: s3c: fix return value check in
 s3c_usb_otgphy_init()
Message-ID: <20200817154522.GA15887@kozik-lap>
References: <20200728022756.87687-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728022756.87687-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:27:56AM +0800, Qinglang Miao wrote:
> the function clk_get() returns ERR_PTR() in case of error and
> never returns NULL. So there's no need to test whether xusbxti
> is NULL, just remove the redundant part in the return value check.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  arch/arm/mach-s3c64xx/setup-usb-phy.c | 2 +-

Thanks, applied.

Best regards,
Krzysztof

