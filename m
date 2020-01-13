Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E84C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AABD207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAMN7i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:59:38 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMN7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:59:37 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ir0Fd-0003DP-Se; Mon, 13 Jan 2020 14:59:29 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] drm/rockchip: Add missing vmalloc header
Date:   Mon, 13 Jan 2020 14:59:29 +0100
Message-ID: <1782062.vAMIso9ooe@phil>
In-Reply-To: <1577779956-7612-1-git-send-email-krzk@kernel.org>
References: <1577779956-7612-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Dezember 2019, 09:12:36 CET schrieb Krzysztof Kozlowski:
> The Rockship DRM GEM code uses vmap()/vunmap() so vmalloc header must be
> included to avoid warnings like (on IA64, compile tested):
> 
>     drivers/gpu/drm/rockchip/rockchip_drm_gem.c: In function ‘rockchip_gem_alloc_iommu’:
>     drivers/gpu/drm/rockchip/rockchip_drm_gem.c:134:20: error:
>         implicit declaration of function ‘vmap’ [-Werror=implicit-function-declaration]
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

applied to drm-misc-next

Thanks
Heiko


