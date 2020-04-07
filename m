Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D5EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51322075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGVMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:12:52 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46087 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:12:52 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 13A81FF802;
        Tue,  7 Apr 2020 21:12:42 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 0/5] arm: dts: linksys: rename codename to model
Date:   Tue,  7 Apr 2020 11:08:10 -1000
Message-Id: <20200407210816.866084-1-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys chose to use codenames for a few of their devices and sell their
them under an entirely different name.

codename  model name
rango  -> wrt3200acm
mamba  -> wrt1900ac
cobra  -> wrt1900ac-v2
caiman -> wrt1200ac
shelby -> wrt1900acs

This introduces some extra loops in OpenWrt, a distribution specialized
on embedded Internet facing devices, as both codename and model name are
used within the build system. The double naming requires developers to
keep track of that mapping and introduces inconsistencies:

To build a specific device in OpenWrt profiles are used, named after the
the compatible string for targets using device tree (similar to how .dts
files are named in the linux source tree). However, the first item of
the DT `compatible` list in this case is `linksys,rango`, which is
inconsistent with the model name and not what common users would expect.

Such double naming complicates currently the automatic search for
firmware upgrade as the build system does not support such mapping.
Ideally the first item of the DT `compatible` list would contain a
string suitable to be used as a filename recognizable by normal users to
belong to that device.

With this patch set the Linksys device tree files are moved from
containing the codename to contain a sanitized model name and also use
it as first entry of the DT `compatible` list.

Paul Spooren (5):
  arm: dts: linksys: rename rango to wrt3200acm
  arm: dts: linksys: rename mamba to wrt1900ac
  arm: dts: linksys: rename cobra to wrt1900ac-v2
  arm: dts: linksys: rename caiman to wrt1200ac
  arm: dts: linksys: rename shelby to wrt1900acs

 arch/arm/boot/dts/Makefile                    | 10 +++----
 ...n.dts => armada-385-linksys-wrt1200ac.dts} | 26 +++++++++---------
 ...ts => armada-385-linksys-wrt1900ac-v2.dts} | 27 ++++++++++---------
 ....dts => armada-385-linksys-wrt1900acs.dts} | 25 ++++++++---------
 ....dts => armada-385-linksys-wrt3200acm.dts} | 26 +++++++++---------
 ...ba.dts => armada-xp-linksys-wrt1900ac.dts} | 27 ++++++++++---------
 6 files changed, 72 insertions(+), 69 deletions(-)
 rename arch/arm/boot/dts/{armada-385-linksys-caiman.dts => armada-385-linksys-wrt1200ac.dts} (80%)
 rename arch/arm/boot/dts/{armada-385-linksys-cobra.dts => armada-385-linksys-wrt1900ac-v2.dts} (78%)
 rename arch/arm/boot/dts/{armada-385-linksys-shelby.dts => armada-385-linksys-wrt1900acs.dts} (80%)
 rename arch/arm/boot/dts/{armada-385-linksys-rango.dts => armada-385-linksys-wrt3200acm.dts} (83%)
 rename arch/arm/boot/dts/{armada-xp-linksys-mamba.dts => armada-xp-linksys-wrt1900ac.dts} (92%)


base-commit: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
-- 
2.25.1

