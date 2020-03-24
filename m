Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A7C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F502070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="la+g9pcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCXLzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:55:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54228 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgCXLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:55:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so2866422wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fax5ZgfXWzYU+VwwDzJf6kISwXPDcjB+QjrCoRw4H8s=;
        b=la+g9pcgRf05+iKrxkxl43WiX6GGRaqy2cDCM2ljCp2QtldsvIc3ZQhGxr2KX73uhA
         pfQYjEaONiBr65YM5Xl4Two8pwBcO/YFFi+cSswDXYX8u1yvMTWZl6LEtLBV5PxOgr0S
         PDWaOeJsv1Tv9kaKVdGRnQYAkyXFIJhueEbKYNGFzFRiYT74YvSF+NTDw8b8pL0p+Bhs
         NhcAl6oN1hcB2OWnq2v+9ow7yO2YaDwxaIohWPwByXZcgQ2nn44gJuLf5ZC9t/syMmzQ
         DnE/W2u5b20VKbrfb5pemqqrrXBrt/9C+zjmr5ZTkTyygNpDJhIU+eO5KmW2TRCBh1gA
         cg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fax5ZgfXWzYU+VwwDzJf6kISwXPDcjB+QjrCoRw4H8s=;
        b=XQPe3ztJS71oehvqieiv35MddVZc8rXiN+Ey0SASDxayFMUrq63F2FcnhRUR2NOS9H
         OVAoOnwRCT21MQLcXpWgUE2T+iCw1+HmfmiBxKUJbfarnMU1YK9/qmyi4WsYg94CKzgY
         D2TlW49TtzMVLxCxrxbkv4TmMGGddAewC0RFKHP0zJhgPoUkfinTHgLVHEED5le4lbwb
         lfrV4GkD1PD88ISCl3QTNPZ/lyZgFCCpbacyiQJ49GrFX9Y6VkBThW0+ApgjEVi0wtIX
         UuhuwPQql6/mQ3PCcrb6d9vYdqTgS4GWamBTCbqU8fFvvMJTGNA18P69LwykjE5aMYU7
         5F5A==
X-Gm-Message-State: ANhLgQ24FPCKEAhMclcRkWNReeScQW+HZtpdAxdAl22Owp/XAV5hevqV
        zA7jYv02H8m9nSZ6ljgdp2olKNchcjw=
X-Google-Smtp-Source: ADFU+vvrSE701XTI3NJ6VUEToPOC9az1u7iFJOxeEnDtGQdOws9mx8K1+xzW5oaUkPMRybRDYfmRpg==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr5063803wmj.29.1585050941959;
        Tue, 24 Mar 2020 04:55:41 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id l64sm4078498wmf.30.2020.03.24.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 04:55:41 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:56:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: dln2: Allow to be enumerated via ACPI
Message-ID: <20200324115630.GA442973@dell>
References: <20200323200237.51416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323200237.51416-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020, Andy Shevchenko wrote:

> On some platforms user may want to enumerate DLN2 device, its children,
> to be enumerated via ACPI. In order to achieve this, let's distinguish
> children by _ADR value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/dln2.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
