Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4258C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6B20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsrMU/Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCLIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:38:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36405 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:38:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so4075592lfd.3;
        Thu, 12 Mar 2020 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=njL/xVSacl4Pc5DEtw15HmBhPQTizshbsVWkVfiTBLY=;
        b=QsrMU/Di9LHFG3fLS4fRPfTghm0L3MmVK4fDq2O6pVXfffFJJgCux0XhJrPdT/OG3l
         TPivR1AqMUAbI8OqP2jZumDnYk0Mg3E8dG4ZtIRPKTnkrwtXyVRdZ277/Dykzg93aJHi
         g8xlqXUhusZUp7FcZmzWuYMAt65NbGt/ieBSRKxJYYEbzJPMoVdCumL3qXvTQfQmVrS3
         S/Pvfn0E7iinf39J1JAt6xmwzvYd4WpBgjpxcioZrey6Fv6iWi7nzpDPAmwNQhNKTq6e
         bwgOImhXXrATX4HsFQtJE5HP8hIK/nGveHg3k8/OyJHDezuDa4tt2TI+dTTgVnaLnPhF
         8+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=njL/xVSacl4Pc5DEtw15HmBhPQTizshbsVWkVfiTBLY=;
        b=fJMpjIj9Tr+bI3zVBD6sbRScCduM5DxS6VUjpg11yVFOtlBSVUXn9sjKjHWQUJmwaG
         bXJ7cYAgjgGqO3VyhdzgBnzvvIgUrAYa8P+wI0tyEts0aYb5/fcGwyQr4ZSwTFZU5EMm
         Zrpd43sUVa5AtMbT0dIghrzjtP1JvlRHGwxRWZG+5aRSX7PCrGI1OAjpaDLrO7AW9uCc
         KXcoMT60oj3zL0CR/d50lk2iL5ZnE17zBDbzuhCauX81BZy7J2LInqclUIgwZr3V33dW
         gqHi8thmDFYNs9I7dN8QNJASi48i9I84cmSYWqjwSBRm1t72XdTRfigghBvPb/sUlLAq
         /L0Q==
X-Gm-Message-State: ANhLgQ2ftofpNMQpdXpgCtZilG4J/leke+UA7123oqBoUa2keyQJky/P
        HFaP0bMVpyrvjrbUemBxaEs=
X-Google-Smtp-Source: ADFU+vspNzeVCKKtcvLNBCDPv0jVjywH/HxnrsGdojEsAE4CAtpd936CF7NW+rGunjAHjRSrMALCEQ==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr4777532lff.176.1584002316800;
        Thu, 12 Mar 2020 01:38:36 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id x8sm1091616lfn.24.2020.03.12.01.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 01:38:36 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Igor Opaniuk <igor.opaniuk@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ARM: dts: toradex: DTS license/copyright clean-up
Date:   Thu, 12 Mar 2020 10:38:27 +0200
Message-Id: <20200312083830.18011-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Replace boiler plate licenses texts with the SPDX license
identifiers in Toradex Vybrid-based SoM device trees.
2. As X11 is identical to the MIT License, but with an extra sentence
that prohibits using the copyright holders' names for advertising or
promotional purposes without written permission, use MIT license instead
of X11 ('s/X11/MIT/g').
3. Replace "Toradex AG" with "Toradex" in the Copyright notice.
4. Use GPL2.0+ instead of GPL2.0, as it's used now by default for all
new DTS files.

v2:
- Drop switching from GPL2.0+ to GPL2.0 [Marcel Ziswiler]
- Replace "Toradex AG" with "Toradex" in the Copyright notice [Marcel Ziswiler]

Igor Opaniuk (3):
  arm: dts: imx6: toradex: use SPDX-License-Identifier
  arm: dts: imx7: toradex: use SPDX-License-Identifier
  arm: dts: vf: toradex: SPDX tags and copyright cleanup

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 40 +-----------------
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 40 +-----------------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 40 +-----------------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 40 +-----------------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 40 +-----------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 40 +-----------------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   | 41 +------------------
 arch/arm/boot/dts/imx7-colibri.dtsi           | 41 +------------------
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   | 41 +------------------
 arch/arm/boot/dts/imx7d-colibri.dtsi          | 41 +------------------
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts   | 41 +------------------
 arch/arm/boot/dts/imx7s-colibri.dtsi          | 41 +------------------
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi     | 40 +-----------------
 arch/arm/boot/dts/vf-colibri.dtsi             | 39 +-----------------
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts   | 40 +-----------------
 arch/arm/boot/dts/vf500-colibri.dtsi          | 40 +-----------------
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts   | 40 +-----------------
 arch/arm/boot/dts/vf610-colibri.dtsi          | 40 +-----------------
 arch/arm/boot/dts/vf610m4-colibri.dts         | 39 +-----------------
 19 files changed, 37 insertions(+), 727 deletions(-)

-- 
2.17.1

