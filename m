Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2439C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C962077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DS89j9PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgATIoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:44:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36605 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:44:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so13796825wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s+lxv8yS+tPPVLLVda+OIOe+B0+kZ5og8HXVAwOgVOE=;
        b=DS89j9PWMbSs7Q0oYxvC9+QxP7mMSQtykSp6CPFm9blhsNBPlaMHsPGvSxHMFwMWYf
         mce//OGWonh+G0xoWFBeMQ6MygHTpF/5MXnrL8h2bDTKR5wY8YOQ0tCm1yfjldA1AzcF
         DdOkqgraTIAY2ENvTPKz6wEVvJaqaVn/g0objOAyDQ4PagQTQ75B5YcW+L3q6VG0qrLv
         QOoQ/s7+hBCUPWP3K8MhMjLpe5THZ8jHhX5GoXsIBpf+VGSNSXshpqmK2meAgKvEwHQL
         d7AxVplHo9ZfzqOwGdNhqWXXLBe8I9I0KxmqKoEYZvXF1IWpMDYPcXH9SUha06mzy86L
         m3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s+lxv8yS+tPPVLLVda+OIOe+B0+kZ5og8HXVAwOgVOE=;
        b=q6ss2YzLqXTUSfvJ5Ga4QhcUq+0rxLL26Hz7Gy7GaoYPD0QGTVno8cng6r/TMGvCep
         8aXRnM18xvyv57LWCbwWhXhLOy+8byNCzviT1P+OUuNPHVTqtLbBLtB3S83F43mYWAhH
         tXLh0mxn2fuGTuXCUMtorAgDo1MUnf7jkZn8M2eS7LqevggGKo9Ocbx3XtGKqLXqLJXH
         RkLR8KFZHst3NNg7uuHHvntagfJ4s5NONRjZbXxqUZ25rNYuTCpiKeDLJ8FgWYOiadWx
         dUN90Ca8MDSZJWoq54LSJP3HiIwAg47wyMQdJd01q43G7t4bdpe/5Xc8Zka8m5OZ65oj
         sUAA==
X-Gm-Message-State: APjAAAW4cJsT/FLjNX/Yc7GQLCIggUqe5F4fS9K4xdoOQRazXXwK1zuP
        WovmEb1DFh5WPbiHpIByZsTXBQ==
X-Google-Smtp-Source: APXvYqyxULuntfgFhWunP/TGRe20THFA3uILY3jQLy0UfU93w71D1ribWIK30iqLIEbqoWtsxy0iAQ==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr18331493wme.133.1579509863421;
        Mon, 20 Jan 2020 00:44:23 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id b137sm3009206wme.26.2020.01.20.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:44:22 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:44:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 2/4] mfd: Add for PMIC MT6359 registers definition
Message-ID: <20200120084439.GX15507@dell>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
 <1579506450-21830-3-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579506450-21830-3-git-send-email-Wen.Su@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Wen Su wrote:

> From: Wen Su <wen.su@mediatek.com>
> 
> This adds MediaTek PMIC MT6359 registers definition for the
> following sub modules:
> 
> - Regulator
> - RTC
> - Interrupt
> 
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

FYI, this is a real Acked-by.

Whoever takes this set can take this patch.

> Signed-off-by: Wen Su <wen.su@mediatek.com>
> ---
>  include/linux/mfd/mt6359/registers.h | 531 +++++++++++++++++++++++++++++++++++
>  1 file changed, 531 insertions(+)
>  create mode 100644 include/linux/mfd/mt6359/registers.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
