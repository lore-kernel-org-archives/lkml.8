Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37999C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1595A20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="DbJowuWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCLr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:47:26 -0400
Received: from vps.xff.cz ([195.181.215.36]:41220 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593776842; bh=qqqmBER67TiL8jtm7bhHtg++KZK59EXYjjn1FFY2Hhw=;
        h=From:To:Cc:Subject:Date:From;
        b=DbJowuWfMruGil3/tF0lPmG3d0y4hFQRLw+XYenolmZ/mzEj51epdT99Ct62ZSdde
         Zn/toun/nuoisgRPpQPNppJZ4Zq1FtJUSEBIYfe8AeVmbCvM7nCicxuKAoQ6sCYPt6
         ecnmG4VeSr+xvqt5hOH2L9eA71MRPZeQchnhipWc=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix warnings in display/bridge/nwl-dsi.yaml DT example
Date:   Fri,  3 Jul 2020 13:47:15 +0200
Message-Id: <20200703114717.2140832-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes warnings in the example in display/bridge/nwl-dsi.yaml
revealed during port of display/panel/rocktech,jh057n00900.yaml to
yaml.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (2):
  dt-bindings: display: Fix example in nwl-dsi.yaml
  dt-binding: display: Allow a single port node on rocktech,jh057n00900

 .../devicetree/bindings/display/bridge/nwl-dsi.yaml      | 9 +++++----
 .../bindings/display/panel/rocktech,jh057n00900.yaml     | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.27.0

