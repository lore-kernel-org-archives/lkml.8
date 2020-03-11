Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB236C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F004D20739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgCKUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:03:47 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:6517 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730960AbgCKUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:03:47 -0400
X-IronPort-AV: E=Sophos;i="5.70,541,1574089200"; 
   d="scan'208";a="41620347"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Mar 2020 05:03:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D63E640E06EA;
        Thu, 12 Mar 2020 05:03:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 0/2] Add LVDS panel support to HiHope RZ/G2M
Date:   Wed, 11 Mar 2020 20:03:38 +0000
Message-Id: <1583957020-16359-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

The HiHope RZ/G2M is advertised as supporting panel idk-1110wr from
Advantech, but the panel doesn't come with the board, it has to purchased
separatey, therefore this series adds panel support to a new DT.

v3->v4
 * Included rzg2-advantech-idk-1110wr-panel.dtsi in
   r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts file instead of re-inventing
   the wheel.
 * Dropped the Ack from Laurent for patch 2/2 due to above changes

v2->v3
 * Included Reviewed-by from Rob and Laurent
 * Switched to dual license
 * Added myself as the maintainer
 * Updated copyright year
 * Rebased the patches

v1->v2
 * fixed a space according to Geert's feedback.

Thanks,
Prabhakar

Fabrizio Castro (2):
  dt-bindings: display: Add idk-1110wr binding
  arm64: dts: renesas: Add HiHope RZ/G2M board with idk-1110wr display

 .../display/panel/advantech,idk-1110wr.yaml        | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts        | 52 ++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts

-- 
2.7.4

