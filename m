Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C56B2192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgEHF62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:58:28 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:38715 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgEHF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:58:26 -0400
IronPort-SDR: fvF/rkZli1Cs6xNkbw6qCLjfIXdzvWhcjEGSxncjizHEcrOZQIpV9bbU602jRtlalQmW1gZJZ2
 KLAPManNZQTb6nvYTWnMn7emCEK/WfzRg+8HXp/K0l4pJb+8NyP/NhqXZlhyo/x5TonaJr1+TK
 qNDczI9fNeaKPCLkV2Sei2fEw3+xbRgejpas6hTUtI0bKS84Op6hYOAx9ZTIph9Ai2ao1suXQ0
 tnttFMxv4DFa7jZMlS79FVPDVHweUjXwMXBQNvyRLlDlE+oCRmlziNLvahmpWPPPjDNuOz/G+W
 FwQ=
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="50670087"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 07 May 2020 21:58:24 -0800
IronPort-SDR: Lwmfk3LwlkrD9MvfacnANYsqdil6hA7tRqwf5THrWdRUbTryaWGj04Cc+iN+T44hiEpF5qVdQ4
 kE1cOsTPoyf8VBhHSsf+7fz2YPxfzTtou4+vZX1XZidMsrkuy8qxpaOvGcsvXlwUtGTZpZU1zt
 oIk5J69sdGsa78Ul9jWu6neGP2C/eU4d8OQF0O/iL7jHo+NZ85AsghxIs9BUmraMhk0bSfMOLE
 WmaSnPG6qi6EPe4NDQIwoPVqBSP8JMX+D4opNd+f4sodVbmU1jPBoyTlC/K6X+mpB3My7DvKLl
 0BQ=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <bsz@semihalf.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v11 22/56] dt-bindings: input: atmel: provide name of configuration file
Date:   Thu, 7 May 2020 22:56:22 -0700
Message-ID: <20200508055656.96389-23-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508055656.96389-1-jiada_wang@mentor.com>
References: <20200508055656.96389-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to set name of configuration file

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 530312fc7a99..4705d7753c54 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -40,6 +40,9 @@ Optional properties for main touchpad device:
 - vdd: vdd: phandle to Power supply regulator
 - avdd: phandle to Analog Power supply regulator
 
+- atmel,cfg_name: Provide name of configuration file in OBP_RAW format. This
+    will be downloaded from the firmware loader on probe to the device.
+
 Example:
 
 	touch@4b {
-- 
2.17.1

