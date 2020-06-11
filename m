Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03579207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kfDiEnlE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GuviQ1dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFKJX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:23:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42883 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgFKJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:23:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08248580189;
        Thu, 11 Jun 2020 05:23:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 05:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=KT8aImVSVqlrbrlR88jQFQocoP
        NuLOplGRWjjaiH9wg=; b=kfDiEnlEf+G08a7sPegVXiHu9QVSPpUp/oqWZSYkB3
        XgCDvBS9Ah03kQ3SOirbB0YIfvrJFEuszUidvSGwWnOS6Graez0Kc7V3tmhYKqRg
        NpbupVKRZNsLvivgRqqYA39I41qME9baTSNN1tb/cJKDDinRs1cJawZGqjjs1Bjg
        oEP+oK4pt4dkJK2do0oqKjCx/vhH3OD0OzgiFL9xSvAh5qwDlwCaGVdjQcYTVCQx
        eDEqmXRoFeiVnUHG83Hw0rTPednG0wSF2nTjOI4s0K7oGWLPXsHrYEDygbQY+hDE
        PJGNf7NHReSBCOH6sDD+I02HNINnmnBsGG7nNrfT5zYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KT8aImVSVqlrbrlR8
        8jQFQocoPNuLOplGRWjjaiH9wg=; b=GuviQ1dt2l1NP/edva45O9ZAXRMqVqSTF
        DdeiAYMkfB4axltL9nLaNRFsWfW7g47bDvtri4Prg0qLCYGxdgzwkD+DcgrCgs7E
        XilueAE7JIFXd+0CvhIfbhnFjSWOfF/+Qx7SJR7HnaFezuVrP8jVO9YvlsS8ZWDz
        HlCK4kT9tHKIfHkW1iYvSwP79Ugu39U6AVHsZl5F8TQtNGfqahTq6YJ/6spVnKbk
        EUC9yUGt/vwr6UVYB6fWq00NsJlOnVYcRiSNsLLianG6FkbF1e3xCH7MghlkkUBl
        Zaoj/ZlOgGW3tyKS+A+6APw2UfbWrbD0gxs2vvJbw5iyE80EaPdRg==
X-ME-Sender: <xms:CPjhXnj1n0_WFUb2hKy_YfCounKQEIlI0bty8P2uQ1MKfEFRm-2kUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CPjhXkBwO0DKloQYmKnZFW0_ov58slXXLPWgqXtH9Yx8_g7vL-idTA>
    <xmx:CPjhXnGjiLKiAOjXyKq4Zy39d4OeGvKrKuz_uzTL6lAsiOnI0YFzhw>
    <xmx:CPjhXkSJFLboPzj8AkUxZ1OBRVW9MLg4qR7-MoG894JUNj0WXnn1qg>
    <xmx:CvjhXgeDLjT4ZlC-J4u3CP6HGd7hgu8MYJ1u-RsQq8u_A0S4yQj77w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 910E63280059;
        Thu, 11 Jun 2020 05:23:20 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 0/3] clk: bcm: Add BCM2711 DVP driver
Date:   Thu, 11 Jun 2020 11:23:14 +0200
Message-Id: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is yet another smaller patches series that got stripped out of the
huge HDMI one.

Since it depends at build time on patches already queued by Philipp in
reset/next, maybe we should merge the clock driver in the reset tree with
the Acks of Stephen and Mike?

Maxime

Changes from v3:
  - Switch to devm_platform_get_and_ioremap_resource and devm_reset_controller_register
  - Actually use the Kconfig symbol in the Makefile

Maxime Ripard (3):
  dt-bindings: clock: Add BCM2711 DVP binding
  clk: bcm: Add BCM2711 DVP driver
  ARM: dts: bcm2711: Add HDMI DVP

 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml |  47 +++-
 arch/arm/boot/dts/bcm2711.dtsi                                |  15 +-
 drivers/clk/bcm/Kconfig                                       |  11 +-
 drivers/clk/bcm/Makefile                                      |   1 +-
 drivers/clk/bcm/clk-bcm2711-dvp.c                             | 120 +++++++-
 5 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm2711-dvp.c

base-commit: 192e08e14e37b78e83cc2f5b9eb5a15a7d71c4e2
-- 
git-series 0.9.1
