Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F3C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B5E20784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="GbrwXQG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCTLXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:23:55 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:53108 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgCTLXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZJrg1yDpv5ww0Brt1nAj95Gt3EySAGZ87ZQ9VnS/sEQ=; b=GbrwXQG+7PqA7MImIDjC8UvY/k
        iXkbgroGKcuE9AdMkYpIvTNOXSlHZj5JscwU8+lYQRu4+xK3WpkQsKKdNGvCaLUKoiCmwcASXthKk
        8sk4I/RQ93p0VB1jqOxtVE88tz8q+ZueDK+L53GgD00R/M6kD1+tSmETZ3qRrlv4cyuni9lP2jsON
        fj7lk6fq4GBffWsPqtuyJ7QMJBVSVVNAsQMuejYQbXIuq/TIo/VdQt5CvTyUjUpL0+TRJT8GGADyi
        qDskACq68WeooW01ToNYjfgapbxnrjDzqw4TFdEC5anYw34pXC6AleqFVdaHbcnnx+yxoHcz0APiq
        HnRi0/GA==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:57936 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jFFk1-0011ci-Ha; Fri, 20 Mar 2020 12:23:05 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH v2 0/5] Add support for Topwise A721 tablet
Date:   Fri, 20 Mar 2020 12:21:31 +0100
Message-Id: <20200320112205.7100-1-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for the Topwise A721 tablet and it's display.
It is an old tablet (around 2012) but it might be useful as reference
as the devicetree is pretty complete.

Changes from v1:
* Split into multiple patches
* dt-binding: use yaml instead of txt
* dt-binding: add Topwise A721 to sunxi.yaml
* dt-binding: add Topwise to vendor-prefixes
* drm: Add bus_format, bus_flags and connector_type
* dts: Use SPDX license identifier instead of boilerplate license text
* dts: Remove pinctrl leftovers

Pascal Roeleven (5):
  dt-bindings: panel: Add binding for Starry KR070PE2T
  drm: panel: Add Starry KR070PE2T
  dt-bindings: vendor-prefixes: Add Topwise
  dt-bindings: arm: Add Topwise A721
  ARM: dts: sun4i: Add support for Topwise A721 tablet

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../bindings/display/panel/panel-simple.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts  | 242 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  29 +++
 6 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts

-- 
2.20.1

