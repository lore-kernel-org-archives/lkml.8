Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683FAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6FE20724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594617207;
	bh=sNwEMnzMjnyMevJ5fKpvrizzjBpnAP1Ys8GpNfdQ4z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K8iKZ3WKmRycQ3t03nAGSmIPGhrToPZ4ZX2vmETwx7uEmEzbIG7QJ86xBE59tL6d+
	 uAd+PWq052PTaVXBKRUJc98PyK4xI6el/1AOGJB7aafkUq+Zs8C1hTShbtebhQ7dY5
	 n3wO3nIYumo61ymr++AM4A1gQeW4vOr4eOoV1DkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgGMFNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgGMFNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:13:24 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B96720724;
        Mon, 13 Jul 2020 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594617204;
        bh=sNwEMnzMjnyMevJ5fKpvrizzjBpnAP1Ys8GpNfdQ4z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQz2OglxSySt85av7NPMFfZTqueb0DO9C+FssnfRj/rvOcaw8elpB8cmWzWPKMA/0
         75CwnQVm0Nfr5lSbEQ6j/a8Hl/GgWqF5PPffLE3tjdir9/a0VZy6Ox7FSrmWTXtueK
         3gooGbQ918iysruy8cbUAF5Bm5mKvRXjMAo+eynE=
Date:   Mon, 13 Jul 2020 10:43:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH RESEND] phy: exynos5-usbdrd: Calibrating makes sense only
 for USB2.0 PHY
Message-ID: <20200713051320.GW34333@vkoul-mobl>
References: <CGME20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf@eucas1p1.samsung.com>
 <20200708133800.3336-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708133800.3336-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-20, 15:38, Marek Szyprowski wrote:
> PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
> calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.

Applied, thanks

-- 
~Vinod
