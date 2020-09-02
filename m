Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAD20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgIBO3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:29:52 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46818 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbgIBOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:24:09 -0400
Received: from [88.147.20.154] (port=49114 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kDTfP-0002rt-BY; Wed, 02 Sep 2020 16:23:17 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] mfd: lp87565: convert DT to yaml and add LP87524-Q1
Date:   Wed,  2 Sep 2020 16:22:56 +0200
Message-Id: <20200902142259.28349-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
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

the following patches are a fairly straightforward addition of a new chip
variant along with DT bindings conversion to yaml.

v5 adds the description of the "regulators" DT node and has smaller
improvements to the bindings. No changes to the driver since v2.

RFC,v1: https://lkml.org/lkml/2020/6/3/908
v2: https://lkml.org/lkml/2020/6/17/492
v3: https://lkml.org/lkml/2020/6/22/1139
v4: https://lkml.org/lkml/2020/8/17/830

Luca

Luca Ceresoli (3):
  dt-bindings: mfd: lp87565: convert to yaml
  dt-bindings: mfd: add LP87524-Q1
  mfd: lp87565: add LP87524-Q1 variant

 .../devicetree/bindings/mfd/lp87565.txt       |  79 ------------
 .../bindings/mfd/ti,lp87524-q1.yaml           | 112 ++++++++++++++++++
 .../bindings/mfd/ti,lp87561-q1.yaml           |  83 +++++++++++++
 .../bindings/mfd/ti,lp87565-q1.yaml           | 101 ++++++++++++++++
 drivers/mfd/lp87565.c                         |   4 +
 include/linux/mfd/lp87565.h                   |   1 +
 6 files changed, 301 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml

-- 
2.28.0

