Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F55C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDB22051A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587972713;
	bh=DZdOOmaliopb1c/d+hQBZorZ2uag5Ojix0LVE++Gam4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IXDbz5dfjEBt99abVEFT/4Da8Aqt0t5Qo5ztfNRY2rZq3VS37xuYnXJwfYYs+WSPK
	 3ErKOLyZGw66Lentkp6aYBxN8bWoQ50glP4OZlfYjxmEZOZJ2rMEMvtxijzUAV8WIV
	 8iZpR/OrdE0X9Q9Jw776w7L6XC/7DmEv/zeR2Pj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgD0Hbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgD0Hbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:31:45 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD8E2087E;
        Mon, 27 Apr 2020 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587972704;
        bh=DZdOOmaliopb1c/d+hQBZorZ2uag5Ojix0LVE++Gam4=;
        h=From:To:Cc:Subject:Date:From;
        b=D+OF96DcXa41/8DKZPoNSCHmxtCvE5jf5wXLWbN4j9ZtdbXntBxH5/iq+k9WcAPMs
         K3O6VCUxQWjBGbIX5rHgyxbO8LgcfvKmiAEmYFnTZpUcB+ZJg2LTvjRZ8biskEB5V8
         z6REXBnynG5PCkM3lHhLvTk3PgcQ166jiloQYtAE=
Received: by wens.tw (Postfix, from userid 1000)
        id 602325FBB9; Mon, 27 Apr 2020 15:31:42 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: rockchip: misc. cleanups and improvements
Date:   Mon, 27 Apr 2020 15:31:29 +0800
Message-Id: <20200427073132.29997-1-wens@kernel.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi,

Here is the remaining patch for roc-rk3399-pc, along with a few other
new patches.

  - Based on discussions from v1, patch one, newly added, drops the list
    of valid values for linux,default-triggers.

  - Patch two is the same as in v1

  - Patch three, new, sets dr_mode to "host" to the dwc2 OTG controller,
    matching what the board uses it for, a host port. This gets rid of
    a warning from the kernel.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (3):
  dt-bindings: leds: common: Drop enumeration for linux,default-triggers
  arm64: dts: rockchip: rk3399-roc-pc: Fix MMC numbering for LED
    triggers
  arm64: dts: rockchip: rk3328-roc-cc: Set dr_mode to "host" for OTG

 .../devicetree/bindings/leds/common.yaml      | 21 +------------------
 .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |  1 +
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts  |  8 +++++++
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  4 ++--
 4 files changed, 12 insertions(+), 22 deletions(-)

-- 
2.26.0

