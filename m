Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C6C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D120801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAVr+MQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBZKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:32:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46449 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:32:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id j7so2252005wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vngWQlvz3qLNyE+RsUPpIfx3/4/BoM3TdKapXgnGefM=;
        b=rAVr+MQ9asGFFPCwpGmzPYsJlVLnY+y+A7jEF6EWliOMg9tNZo6vsGdn3DRk9Nyco/
         L9yHexqIT9vF7QZThDoVLUQ2oY2ezWj5n2KccdFdsYHiW6CsVByLm11YAx+6QN/KxePG
         P4brvkXzi041clzd4qD7Cx5EdUhgDuk7+238QvsirzfvVvWRXpcEiqrS4/yeOF6DPJvR
         YNor9oPqFalMkHt8miFVRcecUHCXiHpPtuNm7L49996lfbrzihkOCfIipNhJuiQVwtau
         qYhVSBmbcLciOYLfuoc6SXgU1MB6MbToQaUHaSJh0+ZNqXKQsVAM+mK4ssuNd2AlRDGi
         3V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vngWQlvz3qLNyE+RsUPpIfx3/4/BoM3TdKapXgnGefM=;
        b=uZyDbl3NM26Ndb5kePyxIlQwaJSdobFpwvO2djFDau6nXd6zre98RLTKZbB9A8tipC
         TeuCZcZvkOO2ukMcRXWJoETmfgmTv5nBmUXaAhrmwyfQg3G/V4qq6hdxUAHMHXwApRNw
         K8M8OzJjjuQhxqx5/uDWJy+Uunay74TFWIBDpwSF7LG7Aqh9+QnL+dncFvvXxmnCfcyw
         /+IubO6phnT90iEt7y4U3laLydSge2N8sHpu/32IZDRlKgxZRGoEQhsJ3lDmQKYm228q
         1COBt0jPhzGp+lhh/NUMi669PTmqqkMuYLocSRbrIVtNcog0O3kPad4w0smw06AQ+6Bz
         2zVA==
X-Gm-Message-State: APjAAAV2h+hHDsTSDugfLD0AWvMRNQZEr51YyXMJpggyatxHa1TgqoUP
        DtDyRBjGbbn7fj5LfI9xUEn9Mw==
X-Google-Smtp-Source: APXvYqzb6yyf+vODvB2zbXWNfTMDHQRw4bYGUlcc7kj85tOH4WaE/t+FchzQiTLY9dQFy5/m85Znlg==
X-Received: by 2002:a5d:4c41:: with SMTP id n1mr4513692wrt.183.1582713155057;
        Wed, 26 Feb 2020 02:32:35 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id z16sm2587090wrp.33.2020.02.26.02.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:32:34 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:33:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 5/5] mfd: rk808: Convert RK805 to shutdown/suspend
 hooks
Message-ID: <20200226103306.GI3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <02639ae880b9d945c4134a28b1eef3db2ed9353f.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02639ae880b9d945c4134a28b1eef3db2ed9353f.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK817,
> so it makes little sense for the driver to have to have two completely
> different mechanisms to handle essentially the same thing. Move RK805
> over to the shutdown/suspend flow to clean things up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c       | 37 ++++++++++++-------------------------
>  include/linux/mfd/rk808.h |  1 -
>  2 files changed, 12 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
