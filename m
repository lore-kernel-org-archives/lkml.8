Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01B020717
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCEXua convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:50:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54882 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgCEXua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:50:30 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jA0G3-0006bt-CC; Fri, 06 Mar 2020 00:50:27 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: remove enable-gpio of backlight on rk3399 evb
Date:   Fri, 06 Mar 2020 00:50:26 +0100
Message-ID: <79203414.aRzC3Zld2O@phil>
In-Reply-To: <20200305113912.32226-4-andy.yan@rock-chips.com>
References: <20200305113912.32226-1-andy.yan@rock-chips.com> <20200305113912.32226-4-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. März 2020, 12:39:11 CET schrieb Andy Yan:
> There is no enable-gpio for backlight control on rk3399 evb,
> actually GPIO1_B5 is for LCD panle enable. So remove it from backlight
> dt node.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied for 5.7

Thanks
Heiko


