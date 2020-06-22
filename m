Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415C52083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFVUnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:43:42 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:36544 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgFVUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:43:42 -0400
Received: from [37.163.98.205] (port=42634 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jnTI2-00062o-Ok; Mon, 22 Jun 2020 22:43:39 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v3 0/4] mfd: lp87565: convert DT to yaml, ignore ENx pins and add LP87524-Q1
Date:   Mon, 22 Jun 2020 22:43:25 +0200
Message-Id: <20200622204329.11147-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the first patch in this series is a small but significant variation in how
the lp87565 driver enables the output rails, to allow the kernel to always
know when it is enabling an output. However it can change existing
behaviour (depending on the hardware setup) and thus it should be carefully
evaluated.

The following patches are a fairly straightforward addition of a new chip
variant along DT bindings conversion to yaml.

v3 fixes the yaml errors present in v2.

RFC,v1: https://lkml.org/lkml/2020/6/3/908
v2: https://lkml.org/lkml/2020/6/17/492

Luca

Luca Ceresoli (4):
  regulator: lp87565: enable voltage regardless of ENx pin
  dt-bindings: mfd: lp87565: convert to yaml
  dt-bindings: mfd: lp87565: add LP87524-Q1 variant
  mfd: lp87565: add LP87524-Q1 variant

 .../devicetree/bindings/mfd/lp87565.txt       |  79 ------
 .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 225 ++++++++++++++++++
 drivers/mfd/lp87565.c                         |   4 +
 drivers/regulator/lp87565-regulator.c         |  21 +-
 include/linux/mfd/lp87565.h                   |   1 +
 5 files changed, 249 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml

-- 
2.27.0

