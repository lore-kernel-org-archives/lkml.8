Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5618C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871D720717
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCEXrC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:47:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54824 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEXrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:47:02 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jA0CY-0006aW-Td; Fri, 06 Mar 2020 00:46:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: Add pmic dt tree for rk3399 evb
Date:   Fri, 06 Mar 2020 00:46:50 +0100
Message-ID: <33721271.s4QA4oKXoP@phil>
In-Reply-To: <20200305113912.32226-3-andy.yan@rock-chips.com>
References: <20200305113912.32226-1-andy.yan@rock-chips.com> <20200305113912.32226-3-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. März 2020, 12:39:10 CET schrieb Andy Yan:
> RK3399 EVB use 2 SYR837/8 and a RK808 for power supply,
> Add regulator tree for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---

I applied this for 5.7 after fixing quite a number of issues
- spaces instead of tabs in one syr
- odering of nodes and properties
- node names


Heiko


