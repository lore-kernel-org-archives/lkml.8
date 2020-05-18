Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E387C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B16207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgERWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:52:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53064 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgERWwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:52:47 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaock-0000GM-7J; Tue, 19 May 2020 00:52:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Justin Swartz <justin.swartz@risingedge.co.za>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 0/1] Add rga to rk322x device tree
Date:   Tue, 19 May 2020 00:52:40 +0200
Message-Id: <158984232928.2265632.16859446100127654389.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200419125134.29923-1-justin.swartz@risingedge.co.za>
References: <558b35c3-7f75-8d0d-048b-c55c06fa8a53@gmail.com> <20200419125134.29923-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 12:51:32 +0000, Justin Swartz wrote:
> This patchset aims to enable use of Rockchip's RGA, a 2D raster
> graphic acceleration unit, on rk322x based devices.
> 
> Changes in v5:
>   - Remove the patch to rockchip-rga device tree binding documentation
>     as Johan Jonker has already included mention of "rockchip,rk3228-rga"
>     since the conversion to YAML.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: add rga node for rk322x
      commit: 54b1a4e070330c3fba5becfb0b619bf360bc2657

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
