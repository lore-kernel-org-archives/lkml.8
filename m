Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093BCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C182C2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="razxkL4e";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="o2EPmf8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgDQQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:21:03 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38708 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgDQQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:21:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HGAD30019642;
        Fri, 17 Apr 2020 09:20:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=kIy93AiUPn/dA0sJp6KbAC099Af2OqcrFBEP9JM47BI=;
 b=razxkL4ea6zK6ncXYzD7eQgoLGdrz/t9WVdd8V1uSA++g+K+NHUZR1WbSNqdltsyZz3Y
 Xg4FtGv6vl9h+mE3lBI8WKrs7jRTryuXpJ0JJ/G6D8H3uWlGbpz2SsURCld1GR+uyfZN
 jo/H0uhkJ6y7dfUCi51TcGWWavIjzhBL6UKiWrBcx2jpsQbB3D6eoQWkMG0gTqu7C3NP
 J+4i0fxTnhthsJzqkmqER+/i/oWVN5QgcIoqNzZm8jbRJxU8uIriNc/FM8xhX53/hGhe
 KWkICTBwWp4jMkBjFDqby+4veDYXVpUEwAH89e8TCwNr8Cj7iLUVyC6RAFTYOzjR9EA7 wg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30dn7954vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmATSKxE49aH9T8q6S10KHaFvD/glIQsNtooZRXjiDNLwQCWWB+SQQkZldfA+XS+qLsGxMWOjX2NdLmeUsO3OmGSDlH2z1wNsIO7ei0tXMK5pGKREsKAytVAngTVDHqn2GnI3LEmtym0FDe15UMvbfsf/BTYOp2s2zCvI5jMYGktbRAL5jVV2HpyO9rnsMHQ6mfj3vH9tlaXKrEn/hENePYjorEQJDVmx15j0bX2hGzNtooM95WHRqNMHy4ErkdDbEux62whvZumVJkZaH6uGSrBj6TuJDe4TiI3sxSpiAnjgN0klRt9hRLV2x1UQ8Of8TBxKzp1b5JP6enSaLC7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIy93AiUPn/dA0sJp6KbAC099Af2OqcrFBEP9JM47BI=;
 b=dsP22hi1NUMGNkeTszPL2pTMGIrAFfnBsiEdJRT8UGSJZQE1I4/tohtBBKqxtX5/K4SVSFz5H5kcBXKtD/dj97J8nedNYw1yUb8+TOMqoKIM4mSHPJsXMcGWb3zvTzTLPh9LzCfcy3r5avMvKwIvRDVZxeWKzF7xO3FABAJkxaAnFDSSipyppoE/VNvhK2shXTui80DBYZzWcijW09yd/EIH2uNXInazlis4P4szR1NJpHGeALk2x8hlIFuab7sJtlM4PUJHZ5HJvTdP07FZyVzMvMD8ytPWgE9JWnT2qTLVvb2L6waSgMXM03G0x1OSnTWAkSQrQVng2q7jodx73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIy93AiUPn/dA0sJp6KbAC099Af2OqcrFBEP9JM47BI=;
 b=o2EPmf8yo4VvnQhmfSvZMDkqeyB7fm3ADW1fzFxRalTETEt3WEDb2d1Lj6dIWdBIrxLr5VUiGCCT7KC0MvcGW1aX4Kyb7jMOYANQU7fSWynnKuX4lWpBBfSldJv2fVALL7/HKlJUCSz5v2v65OFbV5FIJ7BhbAJiBvrwi6/ORRI=
Received: from BN3PR03CA0114.namprd03.prod.outlook.com (2603:10b6:400:4::32)
 by BN7PR07MB4483.namprd07.prod.outlook.com (2603:10b6:406:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 16:20:49 +0000
Received: from BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::82) by BN3PR03CA0114.outlook.office365.com
 (2603:10b6:400:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:20:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT046.mail.protection.outlook.com (10.13.183.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:20:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGKiDL025776
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Apr 2020 12:20:46 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:20:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:20:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGKiwD029988;
        Fri, 17 Apr 2020 18:20:44 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGKico029987;
        Fri, 17 Apr 2020 18:20:44 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 1/8] i3c: master: mastership handover document
Date:   Fri, 17 Apr 2020 18:20:42 +0200
Message-ID: <1587140442-29932-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36092001)(46966005)(82740400003)(47076004)(2906002)(81156014)(356005)(81166007)(2616005)(478600001)(4326008)(8676002)(26826003)(426003)(5660300002)(107886003)(36756003)(336012)(86362001)(42186006)(26005)(316002)(36906005)(186003)(54906003)(110136005)(70586007)(8936002)(70206006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f08ebfe6-314d-4985-de41-08d7e2eb4a2b
X-MS-TrafficTypeDiagnostic: BN7PR07MB4483:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4483414F90580BCE99774A2BC1D90@BN7PR07MB4483.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuPR8ZeixU7GWYk8QXu0ZiGmdB928KQ7m/kcXdHIEgtexLH09HubKMS6Oh7h+cPq1YDrATUl4ch/n/NZdpTAd1U6/yBt+vS4uH+NvqWCjBE0qhZc2JHYm0EVzNCc2IAKN+rdGDbtOv4yHYFc0qSFvebgvXyKNha7IdbDNfW0SfdKwwtSjTpV4SSPzjdqNxGOoNmFsSiufpXrJYUmOKESDJj6Y1MgEgxcr9dab5pYsX6cdkOkohtzG36j8VsXUYIBiMeUbsnKJxiUMkpGmIm5vmtOGROI5+ogDYT5430bzQDKpcAdfoZcd7HIyGyirgr2gkamWgT5yMPIJqKG1vSsJaJeSB4s7FJ41ZoCuh7EYib+Aug+e4jYsvofaTzFsFJRQWy2f1ZLHjHLofQPW/gpkz6+z2tX8WW2Q/0EuX26NFW2y98ScoppH2+i0pl7LyOC50HnFJxv2gTU8/Ndqv7sOT043wP/YvaypsN+B3tza1OD27mSd4GKx1CH7+2tuL5oJr/D5iiUNt57NqfrXdt0qVzvE00156+aOc3q4dU69Fo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:20:48.5545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08ebfe6-314d-4985-de41-08d7e2eb4a2b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4483
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flow diagram for I3C mastership handover, DEFSLVS
processing and secondary master initialization.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../i3c/mastership-handover-flow-diagram.rst  | 209 ++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/mastership-handover-flow-diagram.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b..9a38c5ba87cb 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   mastership-handover-flow-diagram
diff --git a/Documentation/driver-api/i3c/mastership-handover-flow-diagram.rst b/Documentation/driver-api/i3c/mastership-handover-flow-diagram.rst
new file mode 100644
index 000000000000..04cd9f1283e0
--- /dev/null
+++ b/Documentation/driver-api/i3c/mastership-handover-flow-diagram.rst
@@ -0,0 +1,209 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+I3C mastership handover flow
+============================
+
+Main master		Sec Master1		Sec Master 2
+
+1. Initialize I3C	1. Initialize I3C	1. Initialize I3C
+   bus in Pure mode	   bus in Pure mode	   bus in Pure mode
+
+defslvs_done flag	defslvs_done flag	defslvs_done flag
+    = true			= false		= false
+
+2. Do DAA + SETDASA	2. Spawn init. thread	2. Spawn init. thread
+			Initialization thread	Initialization thread
+			Wait for DEFSLVS	Wait for DEFSLVS
+			processing		processing
+			Wait for		Wait for
+			defslvs_done flag	defslvs_done flag
+				= true		= true
+
+3. Send DEFSLVS		DEFSLVS ISR		DEFSLVS ISR
+			Set flag to indicate	Set flag to indicate
+			DEFSLVS	processing is	DEFSLVS	processing is
+			pending			pending
+			defslvs_done flag	defslvs_done flag
+				= false			= false
+
+			Defer DEFSLVS		Defer DEFSLVS
+			processing to bottom	processing to bottom
+			half			half
+
+
+			DEFSLVS bottom half	DEFSLVS bottom half
+			Try to acquire bus	Try to acquire bus
+			i3c_master_acquire_bus	i3c_master_acquire_bus
+
+
+			i3c_sec_mst_acquire_bus i3c_sec_mst_acquire_bus
+			state machine
+			1. Wait until DA is
+			   assigned
+
+4. Register all
+   slaves and
+   master devive
+
+5. Program bus mode
+   as per board
+   info (DTS)
+
+6. Send ENEC MR,
+   HJ, SIR CCC
+   Initialization
+   complete
+
+			2. Check if DISEC MR	2. Check if DISEC MR
+			   is received		   is received
+			   If not, initiate	   If not, initiate
+			   MR request		   MR request
+
+
+		Sec master with highest priority (lowest address) get
+		mastership. Some controllers may not have way of knowing
+		if mastership is granted and can keep waiting for
+		GETACCMST.To avoid this, on reception of MR request
+		from highest priority secondary master, current master
+		send DISEC MR, HJ events to remaining master devices.
+
+MR request ISR
+1. Disable IBI
+   in controller
+
+MR request
+bottom half
+1. Send DISEC
+   MR, HJ
+   to all but
+   master device
+   to which MR
+   is granted
+						3. Received DISEC MR
+						   Go back to WAIT
+						   DA state
+
+						1. Wait until DA
+						   is assigned
+						2. Check if DISEC MR
+						   is received
+						   Wait until ENEC MR
+						   is received before
+						   sending next MR request
+
+2. Send GETACCMST
+   to secondary		3. Wait for MR DONE
+   master to which
+   mastership is to
+   be granted
+			4. MR granted
+			5. Update
+			   current_master
+
+
+			DEFSLVS bottom half
+			continue...
+			Controller driver read
+			out DEFSLVS data in
+			defslvs_data structure
+
+			Call
+			i3c_master_process_defslvs
+			until it is processed
+			successfully. And set
+			defslvs_done flag = true.
+
+			i3c_master_process_defslvs
+			1. Bus init to correct
+			   mode based on
+			   defslvs data
+			2. Register I2C devices
+			   from defslvs_data
+			   Since I3C devices are not
+			   hot pluggable this is
+			   done only once
+			3. Register all I3C devices
+			   from defslvs_data, make
+			   sure if device is already
+			   registered, i3cdev and
+			   IBI data is retained
+			   i3cdev is the link between
+			   I3C driver and I3C subsystem
+			4. Delete I3C device from
+			   older device list which are
+			   not found in defslvs_data
+			   (Unplugged ?)
+
+			Initialization thread
+			continue...
+			3. Register master device,
+			   and I3C/I2C device created
+			   based on defslvs_data
+			4. Enable controller IBI
+			5. Send ENEC MR, HJ
+			   Initialization complete
+							3. Initiate MR request
+
+
+			MR request ISR
+			Disable IBI in controller
+
+			MR request bottom half
+			Send DISEC MR, HJ to
+			other master devices
+
+			Send GETACCMST to secondary	4. Wait for MR DONE
+			master to which mastership
+			is to be granted
+
+							5. MR granted
+							6. Update
+							   current_master
+
+
+							DEFSLVS bottom half
+							continue...
+							Controller driver read
+							out DEFSLVS data in
+							defslvs_data structure
+
+							Call
+							i3c_master_process_defslvs
+							until it is processed
+							successfully. And set
+							defslvs_done flag = true
+
+							i3c_master_process_defslvs
+							1. Bus init to correct
+							   mode based on
+							   defslvs data
+							2. Register I2C devices
+							   from defslvs_data
+							   Since I3C devices are
+							   not hot pluggable
+							   this is done only once
+							3. Register all I3C devices
+							   from defslvs_data, make
+							   sure if device is
+							   already registered,
+							   i3cdev and IBI data is
+							   retained
+							   i3cdev is the link
+							   between I3C driver and
+							   I3C subsystem
+							4. Delete I3C device from
+							   older device list which
+							   are not found in
+							   defslvs_data
+							   (Unplugged ?)
+
+							Initialization thread
+							continue...
+							3. Register master
+							   device, and I3C/I2C
+							   device created
+							   based on defslvs_data
+							4. Enable controller IBI
+							5. Send ENEC MR, HJ
+							   Initialization complete
-- 
2.17.1

