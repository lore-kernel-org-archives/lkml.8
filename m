Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE569C3F2D5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F932468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137141;
	bh=khNZpal75NB7bd/Ewap9EUE1W9d//7akeZ11lNiLq5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/9oigWcAUpHArCkf6FP34h+TKGPzfulxHsayrTW02VAI2nuV9cSxzkOdOcJCEWYv
	 Z4XMqn7JjWHw11v1Bzh20T955SpguvQxHFypNC8HePBVp0pdPjMTdBXHntxEPpSpXo
	 1RcXxpc9wcNAbQXVQi/Vz5640yaIiY/La1OtcHdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCBITA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgCBIQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13427246C0;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=khNZpal75NB7bd/Ewap9EUE1W9d//7akeZ11lNiLq5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2YieucKMziE6b1vfxm9geXU65A/CBsvKUI0ejtYzB9Sf8GYcrodXqISiRoY0kNeci
         Uzx+d6KoHBXlo3g+W7yNpmQzmPR2JsLQuqmwqRw0Cf9au+69S+6uQekGl/echeUCd+
         xJ+lLovMpHD+ItajKEyVKP116qW0T1Bxwo+rFO9Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003xM-8c; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/42] docs: scsi: convert bnx2fc.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:43 +0100
Message-Id: <f239116bd2c36f6fc8deb62e325bb8161da04270.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/{bnx2fc.txt => bnx2fc.rst} | 18 ++++++++++++------
 Documentation/scsi/index.rst                  |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)
 rename Documentation/scsi/{bnx2fc.txt => bnx2fc.rst} (91%)

diff --git a/Documentation/scsi/bnx2fc.txt b/Documentation/scsi/bnx2fc.rst
similarity index 91%
rename from Documentation/scsi/bnx2fc.txt
rename to Documentation/scsi/bnx2fc.rst
index 80823556d62f..2fef2dff80c7 100644
--- a/Documentation/scsi/bnx2fc.txt
+++ b/Documentation/scsi/bnx2fc.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
 Operating FCoE using bnx2fc
 ===========================
 Broadcom FCoE offload through bnx2fc is full stateful hardware offload that
@@ -24,6 +27,7 @@ Driver Usage Model:
 
 2. Configure the interfaces on which bnx2fc driver has to operate on.
 Here are the steps to configure:
+
 	a. cd /etc/fcoe
 	b. copy cfg-ethx to cfg-eth5 if FCoE has to be enabled on eth5.
 	c. Repeat this for all the interfaces where FCoE has to be enabled.
@@ -39,8 +43,10 @@ discovery and log into the targets.
 
 5. "Symbolic Name" in 'fcoeadm -i' output would display if bnx2fc has claimed
 the interface.
-Eg:
-[root@bh2 ~]# fcoeadm -i
+
+Eg::
+
+ [root@bh2 ~]# fcoeadm -i
     Description:      NetXtreme II BCM57712 10 Gigabit Ethernet
     Revision:         01
     Manufacturer:     Broadcom Corporation
@@ -60,16 +66,16 @@ Eg:
         State:             Online
 
 6. Verify the vlan discovery is performed by running ifconfig and notice
-<INTERFACE>.<VLAN>-fcoe interfaces are automatically created.
+   <INTERFACE>.<VLAN>-fcoe interfaces are automatically created.
 
 Refer to fcoeadm manpage for more information on fcoeadm operations to
 create/destroy interfaces or to display lun/target information.
 
-NOTE:
+NOTE
 ====
 ** Broadcom FCoE capable devices implement a DCBX/LLDP client on-chip. Only one
 LLDP client is allowed per interface. For proper operation all host software
 based DCBX/LLDP clients (e.g. lldpad) must be disabled. To disable lldpad on a
-given interface, run the following command:
+given interface, run the following command::
 
-lldptool set-lldp -i <interface_name> adminStatus=disabled
+	lldptool set-lldp -i <interface_name> adminStatus=disabled
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 1e37227f3536..d453fb3f1f7d 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -14,5 +14,6 @@ Linux SCSI Subsystem
    aic79xx
    aic7xxx
    bfa
+   bnx2fc
 
    scsi_transport_srp/figures
-- 
2.21.1

