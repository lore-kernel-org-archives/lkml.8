Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0675C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABCF208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFQKHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:07:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43876 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgFQKH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:07:29 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlUyb-0006xc-4j; Wed, 17 Jun 2020 12:07:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/rockchip: Add per-pixel alpha support for the PX30 VOP
Date:   Wed, 17 Jun 2020 12:07:23 +0200
Message-Id: <159238836640.1484955.4774492722376755146.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200416140526.262533-1-paul.kocialkowski@bootlin.com>
References: <20200416140526.262533-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 16:05:26 +0200, Paul Kocialkowski wrote:
> Compared to its predecessors, the PX30 VOP has a different register layout
> for enabling per-pixel alpha. Instead of src_alpha_ctl and dst_alpha_ctl,
> there is a single alpha control register. This register takes some fields
> from src_alpha_ctl, but with a different layout.
> 
> Add support for the required fields to the PX30 VOP window descriptions,
> which makes per-pixel-alpha formats behave correctly.

Applied, thanks!

[1/1] drm/rockchip: Add per-pixel alpha support for the PX30 VOP
      commit: 2aae8ed1f390a42ec752e4403ffca877fb3260e1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
