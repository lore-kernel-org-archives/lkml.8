Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3936C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFD3204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgHQOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:50:48 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60391 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbgHQOu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:50:29 -0400
Received: from [78.134.86.56] (port=43576 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1k7gSv-0003f6-MY; Mon, 17 Aug 2020 16:50:25 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] mfd: lp87565: convert DT to yaml and add LP87524-Q1
Date:   Mon, 17 Aug 2020 16:50:15 +0200
Message-Id: <20200817145018.3992-1-luca@lucaceresoli.net>
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

v4 splits the yaml bindings as requested by Rob Herring and as a few minor
improvements to the bindings. No changes to the driver since v2.

RFC,v1: https://lkml.org/lkml/2020/6/3/908
v2: https://lkml.org/lkml/2020/6/17/492
v3: https://lkml.org/lkml/2020/6/22/1139

Luca

Luca Ceresoli (3):
  dt-bindings: mfd: lp87565: convert to yaml
  dt-bindings: mfd: add LP87524-Q1
  mfd: lp87565: add LP87524-Q1 variant

 .../devicetree/bindings/mfd/lp87565.txt       |  79 -------------
 .../bindings/mfd/ti,lp87524-q1.yaml           | 105 ++++++++++++++++++
 .../bindings/mfd/ti,lp87561-q1.yaml           |  68 ++++++++++++
 .../bindings/mfd/ti,lp87565-q1.yaml           |  85 ++++++++++++++
 drivers/mfd/lp87565.c                         |   4 +
 include/linux/mfd/lp87565.h                   |   1 +
 6 files changed, 263 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml

-- 
2.28.0

