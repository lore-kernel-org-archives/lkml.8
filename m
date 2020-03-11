Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349EC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2A5208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgCKJAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:00:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37896 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:00:51 -0400
Received: from p5b127c69.dip0.t-ipconnect.de ([91.18.124.105] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jBxEM-0000VE-HA; Wed, 11 Mar 2020 10:00:46 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] drm/rockchip: rgb: don't count non-existent devices when determining subdrivers
Date:   Wed, 11 Mar 2020 10:00:45 +0100
Message-ID: <2624804.tm1DkxDElZ@phil>
In-Reply-To: <20200121224828.4070067-1-heiko@sntech.de>
References: <20200121224828.4070067-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. Januar 2020, 23:48:28 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> rockchip_drm_endpoint_is_subdriver() may also return error codes.
> For example if the target-node is in the disabled state, so no
> platform-device is getting created for it.
> 
> In that case current code would count that as external rgb device,
> which in turn would make probing the rockchip-drm device fail.
> 
> So only count the target as rgb device if the function actually
> returns 0.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

applied to drm-misc-next


