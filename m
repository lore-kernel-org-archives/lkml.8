Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06B520768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UUTIl4m0";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qxBRs8T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFZE4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:56:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:46372 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgFZE4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:56:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q4qPJm016256;
        Thu, 25 Jun 2020 21:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=31rIn1Vs4yr5Y3F+Rmnz7NGop3ffCVylx+CBCH4SwYY=;
 b=UUTIl4m0Ea346m8lAAnZb1NqjUcGN+qEBCUU/fJnx0V5Qi6G+/8bLn+v8h+ko0jyW37M
 JTYr6LxyIj9ddsVSIX2/sxqbcfpKvAAk0mASGs0cPlREE9ZAqmbkT4jMOXHAchtg96vf
 lya3oJOuwdHVYymuDFEH7DfLGRMtOksR56t1+Lo6tni4+eusM/kmY4WFVSeyDd8B2v3/
 uiTAYAbGv74DllL3FHysTdpGTr9L4VsenFeo4CpQF+wpMIfhhEMEu6XqIynX2nUvM/gk
 28Y7kZOeUTOFYKaNTzcaUmADLxOUW0DkOE9lQ4MudqVKYT8sZ5RywCXvXlYbbMb+Ia1V ag== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31uur5sh5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkQvIGleeyjiF5tHk9NewAVyFSqegARtw5plcIpzD8bJ9Zw0pZvR0YEesRxC5A2kj73H/GNFVefSdYpbqkuHpZvfcgZLn7gJsWW7LgNgPUbKBjIOVTXeUGOxmLfMtplbcip9paj+gHaS/tfEFgRlGUmDNPu070IXWAQ7mXcg4FKJhBgfPbM6Oekfc0rD1MvsHap1ZfuOqJhgoFT+9K8E9jiif9rF/9bEOLx1iqL59MGM7PurJ428B1oDTcZjSUfAeZwZw1yqXKY0zZ6GVtloStbAGup0GiJ5q0Kh3ekFw6YIe9zCQpMw5O4+K8R1IXvxBnYlxIX428CFBXol7ubHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31rIn1Vs4yr5Y3F+Rmnz7NGop3ffCVylx+CBCH4SwYY=;
 b=iDdZvCMUkEh1C673SBfjoJ68AXXQK4h/609I5IUmx11CW0uLxODGDi+lYYa8cn56XHBMEJRyRotDGv9n9B5GVwvcNWosLVm8KD5MoBJ1+65q8Ymdi8c7Sfgm6F3Zmom2u+8nGzqdjsnjF2XQasKBpMi7Rn7I6CAYMMA626ZvBMXXkOEWEOXU3XaWYNQx5E5qD1lu8Hmb4jVo1uQBc2aFUNFDX6Y/d6G4V53NNcF2ZKVhmzNQFdqif2nmPoSIHh8/yyAwByxljcWZzs6lwpQ+h0H0M4GRVNVCH5QoN2xqDsirN4NtgbKDp4UwmlcVD6DvpEBQgZooSzOcD26Mji9Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31rIn1Vs4yr5Y3F+Rmnz7NGop3ffCVylx+CBCH4SwYY=;
 b=qxBRs8T/IlRi++VZZTDXLicCW02D9XFkDKUDb6g+6nKDh1nQpgBfyr/bVP35LF3n4ZwiplC2y9g6WqNEclEo1cFb5FA03McWz+8QSmQi5JuIBKlLMWvK+8W/npFmNvW34GRiX/RJ8g6BRU3vpE6hyW5TEJaUpUsPLTiPRGQbuVI=
Received: from DM5PR10CA0014.namprd10.prod.outlook.com (2603:10b6:4:2::24) by
 SN1PR07MB4125.namprd07.prod.outlook.com (2603:10b6:802:30::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Fri, 26 Jun 2020 04:55:58 +0000
Received: from DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::74) by DM5PR10CA0014.outlook.office365.com
 (2603:10b6:4:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 04:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT004.mail.protection.outlook.com (10.13.178.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.13 via Frontend Transport; Fri, 26 Jun 2020 04:55:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 05Q4tnkE202776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:55:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 26 Jun 2020 06:55:50 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Jun 2020 06:55:50 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 05Q4toBm010946;
        Fri, 26 Jun 2020 06:55:50 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 05Q4toxT010945;
        Fri, 26 Jun 2020 06:55:50 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <devicetree@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>, <ben.dooks@codethink.co.uk>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <weiyongjun1@huawei.com>, <jpawar@cadence.com>,
        <kurahul@cadene.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH RFC 5/5] usb: cdnsp: Add tracepoints for CDNSP driver
Date:   Fri, 26 Jun 2020 06:54:50 +0200
Message-ID: <20200626045450.10205-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200626045450.10205-1-pawell@cadence.com>
References: <20200626045450.10205-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36092001)(46966005)(336012)(86362001)(36756003)(54906003)(30864003)(5660300002)(426003)(107886003)(47076004)(4326008)(478600001)(81166007)(110136005)(82740400003)(36906005)(316002)(70206006)(8676002)(70586007)(42186006)(82310400002)(356005)(2906002)(83380400001)(7416002)(186003)(2616005)(8936002)(26005)(1076003)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3033c4-c300-4cd3-f92b-08d8198d3671
X-MS-TrafficTypeDiagnostic: SN1PR07MB4125:
X-Microsoft-Antispam-PRVS: <SN1PR07MB4125495580BF9A2344679AB2DD930@SN1PR07MB4125.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFUK+e6cd1Fvkirk1uPzXfvEGfoqpBkI+aSFBsqF1bL65AJ3My69eQOgn+aTY2PmTOAGeiLwcnojpbU+JMBo2Vg+gE6ehsTKJsBzt2RMYSIlL4WVQGLG4RH3846ur4rFMR0q5RgzmtOXcaSjcEMNdiD4BNQMijHrxxLXD1inswYu9cRMQySMAnLjGmJzAdU1v4FIJXMhKkFxgUndWRsVRr2ECkpQoR0ZKmDxWJyx+1y8m0BFsIjKWTbRH6w6F0YUSSXuVmKUH6iQU0eIzyncl2aZxW4jS93rm2UBWb9fQSw8g1gSIhCifPm/ySsz2fafDjq8LJk9/hH0PfFm1aaj5AZwVzFrIlI5JQx/3az6DHKShcNrcTIpZ6it8TqHw8yP58KN0nps4B8TSCJe7eA+7PLC7ph5b7JzkaKPf45WXj3kklX7xCMfUvw3AGaNAi+anttdgBWHgDTYf/oAmMMF4A==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 04:55:56.6347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3033c4-c300-4cd3-f92b-08d8198d3671
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4125
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_01:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=2 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds the series of tracepoints that can  be used for
debugging issues detected in driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdnsp/Makefile |   5 +
 drivers/usb/cdnsp/debug.h  | 583 ++++++++++++++++++++++++++
 drivers/usb/cdnsp/ep0.c    |  24 +-
 drivers/usb/cdnsp/gadget.c |  61 ++-
 drivers/usb/cdnsp/gadget.h |   2 +
 drivers/usb/cdnsp/mem.c    |  15 +-
 drivers/usb/cdnsp/ring.c   |  75 +++-
 drivers/usb/cdnsp/trace.c  |  12 +
 drivers/usb/cdnsp/trace.h  | 839 +++++++++++++++++++++++++++++++++++++
 9 files changed, 1604 insertions(+), 12 deletions(-)
 create mode 100644 drivers/usb/cdnsp/debug.h
 create mode 100644 drivers/usb/cdnsp/trace.c
 create mode 100644 drivers/usb/cdnsp/trace.h

diff --git a/drivers/usb/cdnsp/Makefile b/drivers/usb/cdnsp/Makefile
index 386b6a7b8b4e..067005c5ac32 100644
--- a/drivers/usb/cdnsp/Makefile
+++ b/drivers/usb/cdnsp/Makefile
@@ -1,9 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o				:= -I$(src)
 
 cdnsp-y					:= core.o drd.o
 
 obj-$(CONFIG_USB_CDNSP) 		+= cdnsp.o
 cdnsp-$(CONFIG_USB_CDNSP_GADGET)	+= ring.o gadget.o mem.o ep0.o
+ifneq ($(CONFIG_USB_CDNSP_GADGET),)
+cdnsp-$(CONFIG_TRACING)			+= trace.o
+endif
 
 cdnsp-$(CONFIG_USB_CDNSP_HOST)		+= host.o
 
diff --git a/drivers/usb/cdnsp/debug.h b/drivers/usb/cdnsp/debug.h
new file mode 100644
index 000000000000..d6345d4d2911
--- /dev/null
+++ b/drivers/usb/cdnsp/debug.h
@@ -0,0 +1,583 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence CDNSP DRD Driver.
+ *
+ * Copyright (C) 2020 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *
+ */
+#ifndef __LINUX_CDNSP_DEBUG
+#define __LINUX_CDNSP_DEBUG
+
+static inline const char *cdnsp_trb_comp_code_string(u8 status)
+{
+	switch (status) {
+	case COMP_INVALID:
+		return "Invalid";
+	case COMP_SUCCESS:
+		return "Success";
+	case COMP_DATA_BUFFER_ERROR:
+		return "Data Buffer Error";
+	case COMP_BABBLE_DETECTED_ERROR:
+		return "Babble Detected";
+	case COMP_TRB_ERROR:
+		return "TRB Error";
+	case COMP_RESOURCE_ERROR:
+		return "Resource Error";
+	case COMP_NO_SLOTS_AVAILABLE_ERROR:
+		return "No Slots Available Error";
+	case COMP_INVALID_STREAM_TYPE_ERROR:
+		return "Invalid Stream Type Error";
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		return "Slot Not Enabled Error";
+	case COMP_ENDPOINT_NOT_ENABLED_ERROR:
+		return "Endpoint Not Enabled Error";
+	case COMP_SHORT_PACKET:
+		return "Short Packet";
+	case COMP_RING_UNDERRUN:
+		return "Ring Underrun";
+	case COMP_RING_OVERRUN:
+		return "Ring Overrun";
+	case COMP_VF_EVENT_RING_FULL_ERROR:
+		return "VF Event Ring Full Error";
+	case COMP_PARAMETER_ERROR:
+		return "Parameter Error";
+	case COMP_CONTEXT_STATE_ERROR:
+		return "Context State Error";
+	case COMP_EVENT_RING_FULL_ERROR:
+		return "Event Ring Full Error";
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		return "Incompatible Device Error";
+	case COMP_MISSED_SERVICE_ERROR:
+		return "Missed Service Error";
+	case COMP_COMMAND_RING_STOPPED:
+		return "Command Ring Stopped";
+	case COMP_COMMAND_ABORTED:
+		return "Command Aborted";
+	case COMP_STOPPED:
+		return "Stopped";
+	case COMP_STOPPED_LENGTH_INVALID:
+		return "Stopped - Length Invalid";
+	case COMP_STOPPED_SHORT_PACKET:
+		return "Stopped - Short Packet";
+	case COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR:
+		return "Max Exit Latency Too Large Error";
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return "Isoch Buffer Overrun";
+	case COMP_EVENT_LOST_ERROR:
+		return "Event Lost Error";
+	case COMP_UNDEFINED_ERROR:
+		return "Undefined Error";
+	case COMP_INVALID_STREAM_ID_ERROR:
+		return "Invalid Stream ID Error";
+	default:
+		return "Unknown!!";
+	}
+}
+
+static inline const char *cdnsp_trb_type_string(u8 type)
+{
+	switch (type) {
+	case TRB_NORMAL:
+		return "Normal";
+	case TRB_SETUP:
+		return "Setup Stage";
+	case TRB_DATA:
+		return "Data Stage";
+	case TRB_STATUS:
+		return "Status Stage";
+	case TRB_ISOC:
+		return "Isoch";
+	case TRB_LINK:
+		return "Link";
+	case TRB_EVENT_DATA:
+		return "Event Data";
+	case TRB_TR_NOOP:
+		return "No-Op";
+	case TRB_ENABLE_SLOT:
+		return "Enable Slot Command";
+	case TRB_DISABLE_SLOT:
+		return "Disable Slot Command";
+	case TRB_ADDR_DEV:
+		return "Address Device Command";
+	case TRB_CONFIG_EP:
+		return "Configure Endpoint Command";
+	case TRB_EVAL_CONTEXT:
+		return "Evaluate Context Command";
+	case TRB_RESET_EP:
+		return "Reset Endpoint Command";
+	case TRB_STOP_RING:
+		return "Stop Ring Command";
+	case TRB_SET_DEQ:
+		return "Set TR Dequeue Pointer Command";
+	case TRB_RESET_DEV:
+		return "Reset Device Command";
+	case TRB_FORCE_HEADER:
+		return "Force Header Command";
+	case TRB_CMD_NOOP:
+		return "No-Op Command";
+	case TRB_TRANSFER:
+		return "Transfer Event";
+	case TRB_COMPLETION:
+		return "Command Completion Event";
+	case TRB_PORT_STATUS:
+		return "Port Status Change Event";
+	case TRB_HC_EVENT:
+		return "Device Controller Event";
+	case TRB_MFINDEX_WRAP:
+		return "MFINDEX Wrap Event";
+	case TRB_ENDPOINT_NRDY:
+		return "Endpoint Not ready";
+	case TRB_HALT_ENDPOINT:
+		return "Halt Endpoint";
+	case TRB_FLUSH_ENDPOINT:
+		return "FLush Endpoint";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline const char *cdnsp_ring_type_string(enum cdnsp_ring_type type)
+{
+	switch (type) {
+	case TYPE_CTRL:
+		return "CTRL";
+	case TYPE_ISOC:
+		return "ISOC";
+	case TYPE_BULK:
+		return "BULK";
+	case TYPE_INTR:
+		return "INTR";
+	case TYPE_STREAM:
+		return "STREAM";
+	case TYPE_COMMAND:
+		return "CMD";
+	case TYPE_EVENT:
+		return "EVENT";
+	}
+
+	return "UNKNOWN";
+}
+
+static inline char *cdnsp_slot_state_string(u32 state)
+{
+	switch (state) {
+	case SLOT_STATE_ENABLED:
+		return "enabled/disabled";
+	case SLOT_STATE_DEFAULT:
+		return "default";
+	case SLOT_STATE_ADDRESSED:
+		return "addressed";
+	case SLOT_STATE_CONFIGURED:
+		return "configured";
+	default:
+		return "reserved";
+	}
+}
+
+static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
+					   u32 field1, u32 field2, u32 field3)
+{
+	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
+	int type = TRB_FIELD_TO_TYPE(field3);
+	unsigned int ep_num;
+	int ret = 0;
+	u32 temp;
+
+	ep_num = DIV_ROUND_UP(ep_id, 2);
+
+	switch (type) {
+	case TRB_LINK:
+		ret += snprintf(str, size,
+				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_TC ? 'T' : 't',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_TRANSFER:
+	case TRB_COMPLETION:
+	case TRB_PORT_STATUS:
+	case TRB_HC_EVENT:
+		ret += snprintf(str, size,
+				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
+				" len %ld slot %ld flags %c:%c",
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				cdnsp_trb_type_string(type), field1, field0,
+				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
+				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+				field3 & EVENT_DATA ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_MFINDEX_WRAP:
+		ret += snprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SETUP:
+		ret += snprintf(str, size,
+				"type '%s' bRequestType %02x bRequest %02x "
+				"wValue %02x%02x wIndex %02x%02x wLength %d "
+				"length %ld TD size %ld intr %ld Setup ID %ld "
+				"flags %c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field0 & 0xff,
+				(field0 & 0xff00) >> 8,
+				(field0 & 0xff000000) >> 24,
+				(field0 & 0xff0000) >> 16,
+				(field1 & 0xff00) >> 8,
+				field1 & 0xff,
+				(field1 & 0xff000000) >> 16 |
+				(field1 & 0xff0000) >> 16,
+				TRB_LEN(field2), GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				TRB_SETUPID_TO_TYPE(field3),
+				field3 & TRB_IDT ? 'D' : 'd',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DATA:
+		ret += snprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld TD size %ld "
+				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_IDT ? 'D' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STATUS:
+		ret += snprintf(str, size,
+				"Buffer %08x%08x length %ld TD size %ld intr"
+				"%ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_NORMAL:
+	case TRB_ISOC:
+	case TRB_EVENT_DATA:
+	case TRB_TR_NOOP:
+		ret += snprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld "
+				"TD size %ld intr %ld "
+				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_BEI ? 'B' : 'b',
+				field3 & TRB_IDT ? 'T' : 't',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
+		break;
+	case TRB_CMD_NOOP:
+	case TRB_ENABLE_SLOT:
+		ret += snprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DISABLE_SLOT:
+		ret += snprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_ADDR_DEV:
+		ret += snprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_BSR ? 'B' : 'b',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_CONFIG_EP:
+		ret += snprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_DC ? 'D' : 'd',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_EVAL_CONTEXT:
+		ret += snprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_EP:
+	case TRB_HALT_ENDPOINT:
+	case TRB_FLUSH_ENDPOINT:
+		ret += snprintf(str, size,
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STOP_RING:
+		ret += snprintf(str, size,
+				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				TRB_TO_SLOT_ID(field3),
+				TRB_TO_SUSPEND_PORT(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SET_DEQ:
+		ret += snprintf(str, size,
+				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_STREAM_ID(field2),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_DEV:
+		ret += snprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_ENDPOINT_NRDY:
+		temp  = TRB_TO_HOST_STREAM(field2);
+
+		ret += snprintf(str, size,
+				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), temp,
+				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
+				temp == STREAM_REJECTED ? "(REJECTED)" : "",
+				TRB_TO_DEV_STREAM(field0),
+				field3 & TRB_STAT ? 'S' : 's',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	default:
+		ret += snprintf(str, size,
+				"type '%s' -> raw %08x %08x %08x %08x",
+				cdnsp_trb_type_string(type),
+				field0, field1, field2, field3);
+	}
+
+	return str;
+}
+
+static inline const char *cdnsp_decode_slot_context(u32 info, u32 info2,
+						    u32 int_target, u32 state)
+{
+	static char str[1024];
+	int ret = 0;
+	u32 speed;
+	char *s;
+
+	speed = info & DEV_SPEED;
+
+	switch (speed) {
+	case SLOT_SPEED_FS:
+		s = "full-speed";
+		break;
+	case SLOT_SPEED_HS:
+		s = "high-speed";
+		break;
+	case SLOT_SPEED_SS:
+		s = "super-speed";
+		break;
+	case SLOT_SPEED_SSP:
+		s = "super-speed plus";
+		break;
+	default:
+		s = "UNKNOWN speed";
+	}
+
+	ret = sprintf(str, "%s Ctx Entries %ld",
+		      s, (info & LAST_CTX_MASK) >> 27);
+
+	ret += sprintf(str + ret, " [Intr %ld] Addr %ld State %s",
+		       GET_INTR_TARGET(int_target), state & DEV_ADDR_MASK,
+		       cdnsp_slot_state_string(GET_SLOT_STATE(state)));
+
+	return str;
+}
+
+static inline const char *cdnsp_portsc_link_state_string(u32 portsc)
+{
+	switch (portsc & PORT_PLS_MASK) {
+	case XDEV_U0:
+		return "U0";
+	case XDEV_U1:
+		return "U1";
+	case XDEV_U2:
+		return "U2";
+	case XDEV_U3:
+		return "U3";
+	case XDEV_DISABLED:
+		return "Disabled";
+	case XDEV_RXDETECT:
+		return "RxDetect";
+	case XDEV_INACTIVE:
+		return "Inactive";
+	case XDEV_POLLING:
+		return "Polling";
+	case XDEV_RECOVERY:
+		return "Recovery";
+	case XDEV_HOT_RESET:
+		return "Hot Reset";
+	case XDEV_COMP_MODE:
+		return "Compliance mode";
+	case XDEV_TEST_MODE:
+		return "Test mode";
+	case XDEV_RESUME:
+		return "Resume";
+	default:
+		break;
+	}
+
+	return "Unknown";
+}
+
+static inline const char *cdnsp_decode_portsc(char *str, size_t size,
+					      u32 portsc)
+{
+	int ret;
+
+	ret = snprintf(str, size, "%s %s %s Link:%s PortSpeed:%d ",
+		       portsc & PORT_POWER ? "Powered" : "Powered-off",
+		       portsc & PORT_CONNECT ? "Connected" : "Not-connected",
+		       portsc & PORT_PED ? "Enabled" : "Disabled",
+		       cdnsp_portsc_link_state_string(portsc),
+		       DEV_PORT_SPEED(portsc));
+
+	if (portsc & PORT_RESET)
+		ret += snprintf(str + ret, size - ret, "In-Reset ");
+
+	ret += snprintf(str + ret, size - ret, "Change: ");
+	if (portsc & PORT_CSC)
+		ret += snprintf(str + ret, size - ret, "CSC ");
+	if (portsc & PORT_WRC)
+		ret += snprintf(str + ret, size - ret, "WRC ");
+	if (portsc & PORT_RC)
+		ret += snprintf(str + ret, size - ret, "PRC ");
+	if (portsc & PORT_PLC)
+		ret += snprintf(str + ret, size - ret, "PLC ");
+	if (portsc & PORT_CEC)
+		ret += snprintf(str + ret, size - ret, "CEC ");
+	ret += snprintf(str + ret, size - ret, "Wake: ");
+	if (portsc & PORT_WKCONN_E)
+		ret += snprintf(str + ret, size - ret, "WCE ");
+	if (portsc & PORT_WKDISC_E)
+		ret += snprintf(str + ret, size - ret, "WDE ");
+
+	return str;
+}
+
+static inline const char *cdnsp_ep_state_string(u8 state)
+{
+	switch (state) {
+	case EP_STATE_DISABLED:
+		return "disabled";
+	case EP_STATE_RUNNING:
+		return "running";
+	case EP_STATE_HALTED:
+		return "halted";
+	case EP_STATE_STOPPED:
+		return "stopped";
+	case EP_STATE_ERROR:
+		return "error";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *cdnsp_ep_type_string(u8 type)
+{
+	switch (type) {
+	case ISOC_OUT_EP:
+		return "Isoc OUT";
+	case BULK_OUT_EP:
+		return "Bulk OUT";
+	case INT_OUT_EP:
+		return "Int OUT";
+	case CTRL_EP:
+		return "Ctrl";
+	case ISOC_IN_EP:
+		return "Isoc IN";
+	case BULK_IN_EP:
+		return "Bulk IN";
+	case INT_IN_EP:
+		return "Int IN";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *cdnsp_decode_ep_context(char *str, size_t size,
+						  u32 info, u32 info2,
+						  u64 deq, u32 tx_info)
+{
+	u8 max_pstr, ep_state, interval, ep_type, burst, cerr, mult;
+	bool lsa, hid;
+	u16 maxp, avg;
+	u32 esit;
+	int ret;
+
+	esit = CTX_TO_MAX_ESIT_PAYLOAD_HI(info) << 16 |
+	       CTX_TO_MAX_ESIT_PAYLOAD_LO(tx_info);
+
+	ep_state = info & EP_STATE_MASK;
+	max_pstr = CTX_TO_EP_MAXPSTREAMS(info);
+	interval = CTX_TO_EP_INTERVAL(info);
+	mult = CTX_TO_EP_MULT(info) + 1;
+	lsa = !!(info & EP_HAS_LSA);
+
+	cerr = (info2 & (3 << 1)) >> 1;
+	ep_type = CTX_TO_EP_TYPE(info2);
+	hid = !!(info2 & (1 << 7));
+	burst = CTX_TO_MAX_BURST(info2);
+	maxp = MAX_PACKET_DECODED(info2);
+
+	avg = EP_AVG_TRB_LENGTH(tx_info);
+
+	ret = snprintf(str, size, "State %s mult %d max P. Streams %d %s",
+		       cdnsp_ep_state_string(ep_state), mult,
+		       max_pstr, lsa ? "LSA " : "");
+
+	ret += snprintf(str + ret, size - ret,
+			"interval %d us max ESIT payload %d CErr %d ",
+			(1 << interval) * 125, esit, cerr);
+
+	ret += snprintf(str + ret, size - ret,
+			"Type %s %sburst %d maxp %d deq %016llx ",
+			cdnsp_ep_type_string(ep_type), hid ? "HID" : "",
+			burst, maxp, deq);
+
+	ret += snprintf(str + ret, size - ret, "avg trb len %d", avg);
+
+	return str;
+}
+
+#endif /*__LINUX_CDNSP_DEBUG*/
diff --git a/drivers/usb/cdnsp/ep0.c b/drivers/usb/cdnsp/ep0.c
index 407a7ad06ddb..22eb5786ed64 100644
--- a/drivers/usb/cdnsp/ep0.c
+++ b/drivers/usb/cdnsp/ep0.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 
 #include "gadget.h"
+#include "trace.h"
 
 static void cdnsp_ep0_stall(struct cdnsp_device *pdev)
 {
@@ -24,11 +25,13 @@ static void cdnsp_ep0_stall(struct cdnsp_device *pdev)
 	preq = next_request(&pep->pending_list);
 
 	if (pdev->three_stage_setup) {
+		trace_cdnsp_ep0_data_stage("send stall");
 		ret = cdnsp_halt_endpoint(pdev, pep, true);
 
 		if (preq)
 			cdnsp_gadget_giveback(pep, preq, -ECONNRESET);
 	} else {
+		trace_cdnsp_ep0_status_stage("send stall");
 		pep->ep_state |= EP0_HALTED_STATUS;
 
 		if (preq)
@@ -43,6 +46,8 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
 {
 	int ret;
 
+	trace_cdnsp_ep0_request("delagete");
+
 	spin_unlock(&pdev->lock);
 	ret = pdev->gadget_driver->setup(&pdev->gadget, ctrl);
 	spin_lock(&pdev->lock);
@@ -61,11 +66,15 @@ static int cdnsp_ep0_set_config(struct cdnsp_device *pdev,
 
 	switch (state) {
 	case USB_STATE_ADDRESS:
+		trace_cdnsp_ep0_set_config("from Address state");
+
 		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
 		if (!cfg && !ret)
 			usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
 		break;
 	case USB_STATE_CONFIGURED:
+		trace_cdnsp_ep0_set_config("from Configured state");
+
 		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
 		if (!cfg && !ret)
 			usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
@@ -125,6 +134,7 @@ static int cdnsp_ep0_set_address(struct cdnsp_device *pdev,
 
 int cdnsp_status_stage(struct cdnsp_device *pdev)
 {
+	trace_cdnsp_ep0_status_stage("preparing");
 	pdev->ep0_stage = CDNSP_STATUS_STAGE;
 	pdev->ep0_preq.request.length = 0;
 
@@ -207,18 +217,21 @@ static int cdnsp_ep0_handle_feature_device(struct cdnsp_device *pdev,
 	switch (le16_to_cpu(ctrl->wValue)) {
 	case USB_DEVICE_REMOTE_WAKEUP:
 		pdev->remote_wakeup_allowed = !!set;
+		trace_cdnsp_remote_wakeup_allowed(set);
 		break;
 	case USB_DEVICE_U1_ENABLE:
 		if (state != USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
 			return -EINVAL;
 
 		pdev->u1_allowed = !!set;
+		trace_cdnsp_u1(set);
 		break;
 	case USB_DEVICE_U2_ENABLE:
 		if (state != USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
 			return -EINVAL;
 
 		pdev->u2_allowed = !!set;
+		trace_cdnsp_u2(set);
 		break;
 	case USB_DEVICE_LTM_ENABLE:
 		ret = -EINVAL;
@@ -411,6 +424,8 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 	int ret = 0;
 	__le16 len;
 
+	trace_cdnsp_ctrl_req(ctrl);
+
 	if (!pdev->gadget_driver)
 		goto out;
 
@@ -421,8 +436,10 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 	}
 
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED)
+	if (pdev->eps[0].ep_state & EP_HALTED) {
+		trace_cdnsp_ep0_halted("Restore to normal state");
 		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	}
 
 	/*
 	 * Finishing previous SETUP transfer by removing request from
@@ -431,6 +448,7 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 	if (!list_empty(&pdev->eps[0].pending_list)) {
 		struct cdnsp_request	*req;
 
+		trace_cdnsp_ep0_request("Remove previous");
 		req = next_request(&pdev->eps[0].pending_list);
 		cdnsp_ep_dequeue(&pdev->eps[0], req);
 	}
@@ -452,8 +470,10 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 	if (!len)
 		pdev->ep0_stage = CDNSP_STATUS_STAGE;
 
-	if (ret == USB_GADGET_DELAYED_STATUS)
+	if (ret == USB_GADGET_DELAYED_STATUS) {
+		trace_cdnsp_ep0_status_stage("delayed");
 		return;
+	}
 out:
 	if (ret < 0)
 		cdnsp_ep0_stall(pdev);
diff --git a/drivers/usb/cdnsp/gadget.c b/drivers/usb/cdnsp/gadget.c
index 8cba6a22c998..50f3cc514ca0 100644
--- a/drivers/usb/cdnsp/gadget.c
+++ b/drivers/usb/cdnsp/gadget.c
@@ -20,6 +20,7 @@
 #include <linux/dmi.h>
 
 #include "gadget.h"
+#include "trace.h"
 #include "core.h"
 #include "drd.h"
 
@@ -113,7 +114,9 @@ void cdnsp_set_link_state(struct cdnsp_device *pdev,
 	if (pdev->active_port)
 		port_num = pdev->active_port->port_num;
 
+	trace_cdnsp_handle_port_status(port_num, readl(port_regs));
 	writel(temp, port_regs);
+	trace_cdnsp_link_state_changed(port_num, readl(port_regs));
 }
 
 static void cdnsp_disable_port(struct cdnsp_device *pdev,
@@ -232,6 +235,8 @@ static int cdnsp_start(struct cdnsp_device *pdev)
 	temp |= (CMD_R_S | CMD_DEVEN);
 	writel(temp, &pdev->op_regs->command);
 
+	trace_cdnsp_init("Turn on controller");
+
 	/*
 	 * Wait for the STS_HALT Status bit to be 0 to indicate the device is
 	 * running.
@@ -342,8 +347,10 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	struct usb_request *request;
 	int ret = 0;
 
-	if (preq->epnum == 0 && !list_empty(&pep->pending_list))
+	if (preq->epnum == 0 && !list_empty(&pep->pending_list)) {
+		trace_cdnsp_request_enqueue_busy(preq);
 		return -EBUSY;
+	}
 
 	request = &preq->request;
 	request->actual = 0;
@@ -358,6 +365,8 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 
 	list_add_tail(&preq->list, &pep->pending_list);
 
+	trace_cdnsp_request_enqueue(preq);
+
 	switch (usb_endpoint_type(pep->endpoint.desc)) {
 	case USB_ENDPOINT_XFER_CONTROL:
 		ret = cdnsp_queue_ctrl_tx(pdev, preq);
@@ -378,6 +387,7 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	list_del(&preq->list);
 
 err:
+	trace_cdnsp_request_enqueue_error(preq);
 
 	return ret;
 }
@@ -413,6 +423,7 @@ int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	int ret = 0;
 
 	pdev = pep->pdev;
+	trace_cdnsp_request_dequeue(preq);
 
 	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING) {
 		ret = cdnsp_cmd_stop_ep(pdev, pep);
@@ -523,11 +534,14 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	cmd_trb = pdev->cmd.command_trb;
 	pdev->cmd.status = 0;
 
+	trace_cdnsp_cmd_wait_for_compl(pdev->cmd_ring, &cmd_trb->generic);
+
 	ret = readl_poll_timeout_atomic(&pdev->op_regs->cmd_ring, val,
 					!CMD_RING_BUSY(val), 1,
 					CDNSP_CMD_TIMEOUT);
 	if (ret) {
 		dev_err(pdev->dev, "ERR: Timeout while waiting for command\n");
+		trace_cdnsp_cmd_timeout(pdev->cmd_ring, &cmd_trb->generic);
 		pdev->cdnsp_state = CDNSP_STATE_DYING;
 		return -ETIMEDOUT;
 	}
@@ -570,6 +584,8 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 			continue;
 		}
 
+		trace_cdnsp_handle_command(pdev->cmd_ring, &cmd_trb->generic);
+
 		pdev->cmd.status = GET_COMP_CODE(le32_to_cpu(event->event_cmd.status));
 		if (pdev->cmd.status == COMP_SUCCESS)
 			return 0;
@@ -586,6 +602,8 @@ int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
 {
 	int ret = 0;
 
+	trace_cdnsp_ep_halt(value ? "Set" : "Clear");
+
 	if (value) {
 		ret = cdnsp_cmd_stop_ep(pdev, pep);
 		if (ret < 0)
@@ -606,6 +624,8 @@ int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
 		cdnsp_queue_reset_ep(pdev, pep->idx);
 		cdnsp_ring_cmd_db(pdev);
 		ret = cdnsp_wait_for_cmd_compl(pdev);
+		trace_cdnsp_handle_cmd_reset_ep(pep->out_ctx);
+
 		if (ret)
 			return ret;
 
@@ -662,6 +682,9 @@ static int cdnsp_update_eps_configuration(struct cdnsp_device *pdev,
 	    (ep_sts != EP_STATE_DISABLED && ctrl_ctx->drop_flags))
 		ret = cdnsp_configure_endpoint(pdev);
 
+	trace_cdnsp_configure_endpoint(cdnsp_get_slot_ctx(&pdev->out_ctx));
+	trace_cdnsp_handle_cmd_config_ep(pep->out_ctx);
+
 	cdnsp_zero_in_ctx(pdev);
 
 	return ret;
@@ -687,6 +710,7 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
 	/* If device is not setup, there is no point in resetting it. */
 	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
 	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+	trace_cdnsp_reset_device(slot_ctx);
 
 	if (slot_state <= SLOT_STATE_DEFAULT &&
 	    pdev->eps[0].ep_state & EP_HALTED) {
@@ -714,6 +738,8 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
 	for (i = 1; i < 31; ++i)
 		pdev->eps[i].ep_state |= EP_STOPPED;
 
+	trace_cdnsp_handle_cmd_reset_dev(slot_ctx);
+
 	if (ret)
 		dev_err(pdev->dev, "Reset device failed with error code %d",
 			ret);
@@ -770,6 +796,8 @@ int cdnsp_alloc_streams(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
 	/* The stream context array size must be a power of two */
 	num_stream_ctxs = roundup_pow_of_two(num_streams);
 
+	trace_cdnsp_stream_number(pep, num_stream_ctxs, num_streams);
+
 	ret = cdnsp_alloc_stream_info(pdev, pep, num_stream_ctxs, num_streams);
 	if (ret)
 		return ret;
@@ -795,6 +823,8 @@ int cdnsp_disable_slot(struct cdnsp_device *pdev)
 	pdev->slot_id = 0;
 	pdev->active_port = NULL;
 
+	trace_cdnsp_handle_cmd_disable_slot(cdnsp_get_slot_ctx(&pdev->out_ctx));
+
 	memset(pdev->in_ctx.bytes, 0, 2112);
 	memset(pdev->out_ctx.bytes, 0, 2112);
 
@@ -821,6 +851,8 @@ int cdnsp_enable_slot(struct cdnsp_device *pdev)
 	if (!ret)
 		pdev->slot_id = 1;
 
+	trace_cdnsp_handle_cmd_enable_slot(cdnsp_get_slot_ctx(&pdev->out_ctx));
+
 	return ret;
 }
 
@@ -835,8 +867,10 @@ int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev setup)
 	int dev_state = 0;
 	int ret = 0;
 
-	if (!pdev->slot_id)
+	if (!pdev->slot_id) {
+		trace_cdnsp_slot_id("incorrect");
 		return -EINVAL;
+	}
 
 	if (!pdev->active_port->port_num)
 		return -EINVAL;
@@ -844,8 +878,10 @@ int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev setup)
 	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
 	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
 
-	if (setup == SETUP_CONTEXT_ONLY && dev_state == SLOT_STATE_DEFAULT)
+	if (setup == SETUP_CONTEXT_ONLY && dev_state == SLOT_STATE_DEFAULT) {
+		trace_cdnsp_slot_already_in_default(slot_ctx);
 		goto out;
+	}
 
 	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
 	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
@@ -861,10 +897,14 @@ int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev setup)
 	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
 	ctrl_ctx->drop_flags = 0;
 
+	trace_cdnsp_setup_device_slot(slot_ctx);
+
 	cdnsp_queue_address_device(pdev, pdev->in_ctx.dma, setup);
 	cdnsp_ring_cmd_db(pdev);
 	ret = cdnsp_wait_for_cmd_compl(pdev);
 
+	trace_cdnsp_handle_cmd_addr_dev(cdnsp_get_slot_ctx(&pdev->out_ctx));
+
 	/* Zero the input context control for later use. */
 	ctrl_ctx->add_flags = 0;
 	ctrl_ctx->drop_flags = 0;
@@ -879,6 +919,8 @@ void cdnsp_set_usb2_hardware_lpm(struct cdnsp_device *pdev,
 	if (pdev->active_port != &pdev->usb2_port || !pdev->gadget.lpm_capable)
 		return;
 
+	trace_cdnsp_lpm(enable);
+
 	if (enable)
 		writel(PORT_BESL(CDNSP_DEFAULT_BESL) | PORT_L1S_NYET | PORT_HLE,
 		       &pdev->active_port->regs->portpmsc);
@@ -958,6 +1000,7 @@ static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
 	pep->ep_state &= ~EP_STOPPED;
 
 finish:
+	trace_cdnsp_ep_enable_end(pep, 0);
 	spin_unlock_irqrestore(&pdev->lock, flags);
 
 	return ret;
@@ -1014,6 +1057,7 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 	pep->ep_state |= EP_STOPPED;
 
 finish:
+	trace_cdnsp_ep_disable_end(pep, 0);
 	spin_unlock_irqrestore(&pdev->lock, flags);
 
 	return ret;
@@ -1032,6 +1076,8 @@ static struct usb_request *cdnsp_gadget_ep_alloc_request(struct usb_ep *ep,
 	preq->epnum = pep->number;
 	preq->pep = pep;
 
+	trace_cdnsp_alloc_request(preq);
+
 	return &preq->request;
 }
 
@@ -1040,6 +1086,7 @@ static void cdnsp_gadget_ep_free_request(struct usb_ep *ep,
 {
 	struct cdnsp_request *preq = to_cdnsp_request(request);
 
+	trace_cdnsp_free_request(preq);
 	kfree(preq);
 }
 
@@ -1108,6 +1155,7 @@ static int cdnsp_gadget_ep_set_halt(struct usb_ep *ep, int value)
 	preq = next_request(&pep->pending_list);
 	if (value) {
 		if (preq) {
+			trace_cdnsp_ep_busy_try_halt_again(pep, 0);
 			ret = -EAGAIN;
 			goto done;
 		}
@@ -1171,6 +1219,8 @@ void cdnsp_gadget_giveback(struct cdnsp_ep *pep,
 	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
 					preq->direction);
 
+	trace_cdnsp_request_giveback(preq);
+
 	if (preq != &pdev->ep0_preq) {
 		spin_unlock(&pdev->lock);
 		usb_gadget_giveback_request(&pep->endpoint, &preq->request);
@@ -1251,6 +1301,7 @@ static int cdnsp_run(struct cdnsp_device *pdev,
 	temp = readl(&pdev->ir_set->irq_pending);
 	writel(IMAN_IE_SET(temp), &pdev->ir_set->irq_pending);
 
+	trace_cdnsp_init("Controller ready to work");
 	return 0;
 err:
 	cdnsp_halt(pdev);
@@ -1404,6 +1455,8 @@ static void cdnsp_stop(struct cdnsp_device *pdev)
 
 	cdnsp_consume_all_events(pdev);
 	cdnsp_clear_cmd_ring(pdev);
+
+	trace_cdnsp_exit("Controller stopped.");
 }
 
 /*
@@ -1471,6 +1524,8 @@ static int cdnsp_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	struct cdnsp_device *pdev = gadget_to_cdnsp(gadget);
 	struct cdnsp *cdns = dev_get_drvdata(pdev->dev);
 
+	trace_cdnsp_pullup(is_on);
+
 	if (!is_on) {
 		cdnsp_reset_device(pdev);
 		cdnsp_clear_vbus(cdns);
diff --git a/drivers/usb/cdnsp/gadget.h b/drivers/usb/cdnsp/gadget.h
index 298f97be24ad..129a9363b39e 100644
--- a/drivers/usb/cdnsp/gadget.h
+++ b/drivers/usb/cdnsp/gadget.h
@@ -1581,4 +1581,6 @@ static inline struct cdnsp_request *next_request(struct list_head *list)
 int cdnsp_remove_request(struct cdnsp_device *pdev, struct cdnsp_request *preq,
 			 struct cdnsp_ep *pep);
 
+#include "debug.h"
+
 #endif /* __LINUX_CDNSP_GADGET_H */
diff --git a/drivers/usb/cdnsp/mem.c b/drivers/usb/cdnsp/mem.c
index 4a72c7d833ab..7545eb47d9d5 100644
--- a/drivers/usb/cdnsp/mem.c
+++ b/drivers/usb/cdnsp/mem.c
@@ -16,6 +16,7 @@
 #include <linux/usb.h>
 
 #include "gadget.h"
+#include "trace.h"
 
 static void cdnsp_free_stream_info(struct cdnsp_device *pdev,
 				   struct cdnsp_ep *pep);
@@ -282,6 +283,8 @@ void cdnsp_ring_free(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
 	if (!ring)
 		return;
 
+	trace_cdnsp_ring_free(ring);
+
 	if (ring->first_seg) {
 		if (ring->type == TYPE_STREAM)
 			cdnsp_remove_stream_mapping(ring);
@@ -407,7 +410,7 @@ static struct cdnsp_ring *cdnsp_ring_alloc(struct cdnsp_device *pdev,
 			cpu_to_le32(LINK_TOGGLE);
 
 	cdnsp_initialize_ring_info(ring);
-
+	trace_cdnsp_ring_alloc(ring);
 	return ring;
 fail:
 	kfree(ring);
@@ -468,6 +471,7 @@ int cdnsp_ring_expansion(struct cdnsp_device *pdev,
 	}
 
 	cdnsp_link_rings(pdev, ring, first, last, num_segs);
+	trace_cdnsp_ring_expansion(ring);
 
 	return 0;
 }
@@ -625,6 +629,8 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 		stream_info->stream_ctx_array[cur_stream].stream_ring =
 			cpu_to_le64(addr);
 
+		trace_cdnsp_set_stream_ring(cur_ring);
+
 		ret = cdnsp_update_stream_mapping(cur_ring);
 		if (ret) {
 			cdnsp_ring_free(pdev, cur_ring);
@@ -713,6 +719,7 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev, gfp_t flags)
 	pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
 	pdev->cmd.in_ctx = &pdev->in_ctx;
 
+	trace_cdnsp_alloc_priv_device(pdev);
 	return 0;
 fail:
 	dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
@@ -779,6 +786,8 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev)
 	ep0_ctx->deq = cpu_to_le64(pdev->eps[0].ring->first_seg->dma |
 				   pdev->eps[0].ring->cycle_state);
 
+	trace_cdnsp_setup_addressable_priv_device(pdev);
+
 	return 0;
 }
 
@@ -1141,6 +1150,8 @@ static void cdnsp_add_in_port(struct cdnsp_device *pdev,
 	port_offset = CDNSP_EXT_PORT_OFF(temp);
 	port_count = CDNSP_EXT_PORT_COUNT(temp);
 
+	trace_cdnsp_port_info(addr, port_offset, port_count, port->maj_rev);
+
 	port->port_num = port_offset;
 	port->exist = 1;
 }
@@ -1191,6 +1202,8 @@ static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev, gfp_t flags)
 		return -ENODEV;
 	}
 
+	trace_cdnsp_init("Found USB 2.0 ports and  USB 3.0 ports.");
+
 	pdev->usb2_port.regs = (struct cdnsp_port_regs *)
 			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
 				(pdev->usb2_port.port_num - 1));
diff --git a/drivers/usb/cdnsp/ring.c b/drivers/usb/cdnsp/ring.c
index a6baf27ad778..e05bc13f9416 100644
--- a/drivers/usb/cdnsp/ring.c
+++ b/drivers/usb/cdnsp/ring.c
@@ -61,6 +61,7 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 
+#include "trace.h"
 #include "gadget.h"
 
 /*
@@ -153,7 +154,7 @@ void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
 	if (ring->type == TYPE_EVENT) {
 		if (!cdnsp_last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
 			ring->dequeue++;
-			return;
+			goto out;
 		}
 
 		if (cdnsp_last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
@@ -161,7 +162,7 @@ void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
 
 		ring->deq_seg = ring->deq_seg->next;
 		ring->dequeue = ring->deq_seg->trbs;
-		return;
+		goto out;
 	}
 
 	/* All other rings have link trbs. */
@@ -173,6 +174,8 @@ void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
 		ring->deq_seg = ring->deq_seg->next;
 		ring->dequeue = ring->deq_seg->trbs;
 	}
+out:
+	trace_cdnsp_inc_deq(ring);
 }
 
 /*
@@ -227,6 +230,8 @@ static void cdnsp_inc_enq(struct cdnsp_device *pdev,
 		ring->enqueue = ring->enq_seg->trbs;
 		next = ring->enqueue;
 	}
+
+	trace_cdnsp_inc_enq(ring);
 }
 
 /*
@@ -255,6 +260,7 @@ static inline int cdnsp_room_on_ring(struct cdnsp_device *pdev,
 /* Ring the doorbell after placing a command on the ring. */
 void cdnsp_ring_cmd_db(struct cdnsp_device *pdev)
 {
+	trace_cdnsp_cmd_drbl("Ding Dong");
 	writel(DB_VALUE_CMD, &pdev->dba->cmd_db);
 }
 
@@ -290,6 +296,8 @@ static int cdnsp_ring_ep_doorbell(struct cdnsp_device *pdev,
 	else
 		db_value = DB_VALUE(pep->idx, stream_id);
 
+	trace_cdnsp_tr_drbl(pep, stream_id);
+
 	writel(db_value, reg_addr);
 
 	return 1;
@@ -472,6 +480,8 @@ static void cdnsp_find_new_dequeue_state(struct cdnsp_device *pdev,
 
 	state->new_deq_seg = new_seg;
 	state->new_deq_ptr = new_deq;
+
+	trace_cdnsp_new_deq_state(state);
 }
 
 /*
@@ -532,6 +542,10 @@ struct cdnsp_segment *cdnsp_trb_in_td(struct cdnsp_device *pdev,
 		/* If the end TRB isn't in this segment, this is set to 0 */
 		end_trb_dma = cdnsp_trb_virt_to_dma(cur_seg, end_trb);
 
+		trace_cdnsp_looking_trb_in_td(suspect_dma, start_dma,
+					      end_trb_dma, cur_seg->dma,
+					      end_seg_dma);
+
 		if (end_trb_dma > 0) {
 			/*
 			 * The end TRB is in this segment, so suspect should
@@ -582,6 +596,9 @@ void cdnsp_unmap_td_bounce_buffer(struct cdnsp_device *pdev,
 
 	preq = td->preq;
 
+	trace_cdnsp_bounce_unmap(td->preq, seg->bounce_len, seg->bounce_offs,
+				 seg->bounce_dma, 0);
+
 	if (!preq->direction) {
 		dma_unmap_single(pdev->dev, seg->bounce_dma,
 				 ring->bounce_buf_len,  DMA_TO_DEVICE);
@@ -619,6 +636,9 @@ static int cdnsp_cmd_set_deq(struct cdnsp_device *pdev,
 	cdnsp_ring_cmd_db(pdev);
 	ret = cdnsp_wait_for_cmd_compl(pdev);
 
+	trace_cdnsp_handle_cmd_set_deq(cdnsp_get_slot_ctx(&pdev->out_ctx));
+	trace_cdnsp_handle_cmd_set_deq_ep(pep->out_ctx);
+
 	/*
 	 * Update the ring's dequeue segment and dequeue pointer
 	 * to reflect the new position.
@@ -670,6 +690,9 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 
 	memset(&deq_state, 0, sizeof(deq_state));
 
+	trace_cdnsp_remove_request(pep->out_ctx);
+	trace_cdnsp_remove_request_td(preq);
+
 	cur_td = &preq->td;
 	ep_ring = cdnsp_request_to_transfer_ring(pdev, preq);
 
@@ -779,6 +802,8 @@ static void cdnsp_handle_port_status(struct cdnsp_device *pdev,
 	writel(cdnsp_port_state_to_neutral(portsc) |
 	       (portsc & PORT_CHANGE_BITS), &port_regs->portsc);
 
+	trace_cdnsp_handle_port_status(pdev->active_port->port_num, portsc);
+
 	pdev->gadget.speed = cdnsp_port_speed(portsc);
 	link_state = portsc & PORT_PLS_MASK;
 
@@ -937,8 +962,10 @@ static int cdnsp_giveback_first_trb(struct cdnsp_device *pdev,
 		start_trb->field[3] &= cpu_to_le32(~TRB_CYCLE);
 
 	if ((pep->ep_state & EP_HAS_STREAMS) &&
-	    !pep->stream_info.first_prime_det)
+	    !pep->stream_info.first_prime_det) {
+		trace_cdnsp_wait_for_prime(pep, stream_id);
 		return 0;
+	}
 
 	return cdnsp_ring_ep_doorbell(pdev, pep, stream_id);
 }
@@ -1213,8 +1240,10 @@ static int cdnsp_handle_tx_event(struct cdnsp_device *pdev,
 	if (invalidate || !pdev->gadget.connected)
 		goto cleanup;
 
-	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_DISABLED)
+	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_DISABLED) {
+		trace_cdnsp_ep_disabled(pep->out_ctx);
 		goto err_out;
+	}
 
 	/* Some transfer events don't always point to a trb*/
 	if (!ep_ring) {
@@ -1261,8 +1290,23 @@ static int cdnsp_handle_tx_event(struct cdnsp_device *pdev,
 		 * list.
 		 */
 		if (list_empty(&ep_ring->td_list)) {
-			if (pep->skip)
+			/*
+			 * Don't print warnings if it's due to a stopped
+			 * endpoint generating an extra completion event, or
+			 * a event for the last TRB of a short TD we already
+			 * got a short event for.
+			 * The short TD is already removed from the TD list.
+			 */
+			if (!(trb_comp_code == COMP_STOPPED ||
+			      trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
+			      ep_ring->last_td_was_short))
+				trace_cdnsp_trb_without_td(ep_ring,
+					(struct cdnsp_generic_trb *)event);
+
+			if (pep->skip) {
 				pep->skip = false;
+				trace_cdnsp_ep_list_empty_with_skip(pep, 0);
+			}
 
 			goto cleanup;
 		}
@@ -1319,6 +1363,9 @@ static int cdnsp_handle_tx_event(struct cdnsp_device *pdev,
 		ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma)
 				       / sizeof(*ep_trb)];
 
+		trace_cdnsp_handle_transfer(ep_ring,
+					    (struct cdnsp_generic_trb *)ep_trb);
+
 		if (cdnsp_trb_is_noop(ep_trb))
 			goto cleanup;
 
@@ -1384,6 +1431,8 @@ int cdnsp_handle_event(struct cdnsp_device *pdev)
 	if (cycle_bit != pdev->event_ring->cycle_state)
 		return 0;
 
+	trace_cdnsp_handle_event(pdev->event_ring, &event->generic);
+
 	/*
 	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
 	 * reads of the event's flags/data below.
@@ -1539,6 +1588,7 @@ static void cdnsp_queue_trb(struct cdnsp_device *pdev, struct cdnsp_ring *ring,
 	trb->field[2] = cpu_to_le32(field3);
 	trb->field[3] = cpu_to_le32(field4);
 
+	trace_cdnsp_queue_trb(ring, trb);
 	cdnsp_inc_enq(pdev, ring, more_trbs_coming);
 }
 
@@ -1569,6 +1619,8 @@ static int cdnsp_prepare_ring(struct cdnsp_device *pdev,
 		if (cdnsp_room_on_ring(pdev, ep_ring, num_trbs))
 			break;
 
+		trace_cdnsp_no_room_on_ring("try ring expansion");
+
 		num_trbs_needed = num_trbs - ep_ring->num_trbs_free;
 		if (cdnsp_ring_expansion(pdev, ep_ring, num_trbs_needed,
 					 mem_flags)) {
@@ -1732,6 +1784,8 @@ static int cdnsp_align_td(struct cdnsp_device *pdev,
 	/* Is the last nornal TRB alignable by splitting it. */
 	if (*trb_buff_len > unalign) {
 		*trb_buff_len -= unalign;
+		trace_cdnsp_bounce_align_td_split(preq, *trb_buff_len,
+						  enqd_len, 0, unalign);
 		return 0;
 	}
 
@@ -1768,6 +1822,9 @@ static int cdnsp_align_td(struct cdnsp_device *pdev,
 	seg->bounce_len = new_buff_len;
 	seg->bounce_offs = enqd_len;
 
+	trace_cdnsp_bounce_map(preq, new_buff_len, enqd_len, seg->bounce_dma,
+			       unalign);
+
 	return 1;
 }
 
@@ -2010,13 +2067,17 @@ int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
 	u32 ep_state = GET_EP_CTX_STATE(pep->out_ctx);
 	int ret = 0;
 
-	if (ep_state == EP_STATE_STOPPED || ep_state == EP_STATE_DISABLED)
+	if (ep_state == EP_STATE_STOPPED || ep_state == EP_STATE_DISABLED) {
+		trace_cdnsp_ep_stopped_or_disabled(pep->out_ctx);
 		goto ep_stopped;
+	}
 
 	cdnsp_queue_stop_endpoint(pdev, pep->idx);
 	cdnsp_ring_cmd_db(pdev);
 	ret = cdnsp_wait_for_cmd_compl(pdev);
 
+	trace_cdnsp_handle_cmd_stop_ep(pep->out_ctx);
+
 ep_stopped:
 	pep->ep_state |= EP_STOPPED;
 	return ret;
@@ -2030,6 +2091,8 @@ int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
 	cdnsp_ring_cmd_db(pdev);
 	ret = cdnsp_wait_for_cmd_compl(pdev);
 
+	trace_cdnsp_handle_cmd_flush_ep(pep->out_ctx);
+
 	return ret;
 }
 
diff --git a/drivers/usb/cdnsp/trace.c b/drivers/usb/cdnsp/trace.c
new file mode 100644
index 000000000000..1f0b102f11a8
--- /dev/null
+++ b/drivers/usb/cdnsp/trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence CDNSP DRD Driver.
+ *
+ * Copyright (C) 2020 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/usb/cdnsp/trace.h b/drivers/usb/cdnsp/trace.h
new file mode 100644
index 000000000000..4f6fba944fd5
--- /dev/null
+++ b/drivers/usb/cdnsp/trace.h
@@ -0,0 +1,839 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence CDNSP DRD Driver.
+ * Trace support header file
+ *
+ * Copyright (C) 2020 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cdnsp-dev
+
+/*
+ * The TRACE_SYSTEM_VAR defaults to TRACE_SYSTEM, but must be a
+ * legitimate C variable. It is not exported to user space.
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR cdnsp_dev
+
+#if !defined(__CDNSP_DEV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __CDNSP_DEV_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "gadget.h"
+
+/*
+ * There is limitation for single buffer size in TRACEPOINT subsystem.
+ * By default TRACE_BUF_SIZE is 1024, so no all data will be logged.
+ * To show more data this must be increased. In most cases the default
+ * value is sufficient.
+ */
+#define CDNSP_MSG_MAX 500
+
+DECLARE_EVENT_CLASS(cdnsp_log_ep,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id),
+	TP_STRUCT__entry(
+		__string(name, pep->name)
+		__field(unsigned int, state)
+		__field(u32, stream_id)
+		__field(u8, enabled)
+		__field(unsigned int, num_streams)
+		__field(int, td_count)
+		__field(u8, first_prime_det)
+		__field(u8, drbls_count)
+	),
+	TP_fast_assign(
+		__assign_str(name, pep->name);
+		__entry->state = pep->ep_state;
+		__entry->stream_id = stream_id;
+		__entry->enabled = pep->ep_state & EP_HAS_STREAMS;
+		__entry->num_streams = pep->stream_info.num_streams;
+		__entry->td_count = pep->stream_info.td_count;
+		__entry->first_prime_det = pep->stream_info.first_prime_det;
+		__entry->drbls_count = pep->stream_info.drbls_count;
+	),
+	TP_printk("%s: SID: %08x ep state: %x stream: enabled: %d num  %d "
+		  "tds %d, first prime: %d drbls %d",
+		  __get_str(name), __entry->state, __entry->stream_id,
+		  __entry->enabled, __entry->num_streams, __entry->td_count,
+		  __entry->first_prime_det, __entry->drbls_count)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_tr_drbl,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_wait_for_prime,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_ep_list_empty_with_skip,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_ep_enable_end,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_ep_disable_end,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DEFINE_EVENT(cdnsp_log_ep, cdnsp_ep_busy_try_halt_again,
+	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
+	TP_ARGS(pep, stream_id)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_enable_disable,
+	TP_PROTO(int set),
+	TP_ARGS(set),
+	TP_STRUCT__entry(
+		__field(int, set)
+	),
+	TP_fast_assign(
+		__entry->set = set;
+	),
+	TP_printk("%s", __entry->set ? "enabled" : "disabled")
+);
+
+DEFINE_EVENT(cdnsp_log_enable_disable, cdnsp_pullup,
+	TP_PROTO(int set),
+	TP_ARGS(set)
+);
+
+DEFINE_EVENT(cdnsp_log_enable_disable, cdnsp_u1,
+	TP_PROTO(int set),
+	TP_ARGS(set)
+);
+
+DEFINE_EVENT(cdnsp_log_enable_disable, cdnsp_u2,
+	TP_PROTO(int set),
+	TP_ARGS(set)
+);
+
+DEFINE_EVENT(cdnsp_log_enable_disable, cdnsp_lpm,
+	TP_PROTO(int set),
+	TP_ARGS(set)
+);
+
+DEFINE_EVENT(cdnsp_log_enable_disable, cdnsp_remote_wakeup_allowed,
+	TP_PROTO(int set),
+	TP_ARGS(set)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_simple,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg),
+	TP_STRUCT__entry(
+		__string(text, msg)
+	),
+	TP_fast_assign(
+		__assign_str(text, msg)
+	),
+	TP_printk("%s", __get_str(text))
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_exit,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_init,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_slot_id,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_cmd_drbl,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_no_room_on_ring,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_status_stage,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_data_stage,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_request,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_set_config,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_halted,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep_halt,
+	TP_PROTO(char *msg),
+	TP_ARGS(msg)
+);
+
+TRACE_EVENT(cdnsp_looking_trb_in_td,
+	TP_PROTO(dma_addr_t suspect, dma_addr_t trb_start, dma_addr_t trb_end,
+		 dma_addr_t curr_seg, dma_addr_t end_seg),
+	TP_ARGS(suspect, trb_start, trb_end, curr_seg, end_seg),
+	TP_STRUCT__entry(
+		__field(dma_addr_t, suspect)
+		__field(dma_addr_t, trb_start)
+		__field(dma_addr_t, trb_end)
+		__field(dma_addr_t, curr_seg)
+		__field(dma_addr_t, end_seg)
+	),
+	TP_fast_assign(
+		__entry->suspect = suspect;
+		__entry->trb_start = trb_start;
+		__entry->trb_end = trb_end;
+		__entry->curr_seg = curr_seg;
+		__entry->end_seg = end_seg;
+	),
+	TP_printk("DMA: suspect event: %pad, trb-start: %pad, trb-end %pad, "
+		  "seg-start %pad, seg-end %pad",
+		  &__entry->suspect, &__entry->trb_start, &__entry->trb_end,
+		  &__entry->curr_seg, &__entry->end_seg)
+);
+
+TRACE_EVENT(cdnsp_port_info,
+	TP_PROTO(__le32 __iomem *addr, u32 offset, u32 count, u32 rev),
+	TP_ARGS(addr, offset, count, rev),
+	TP_STRUCT__entry(
+		__field(__le32 __iomem *, addr)
+		__field(u32, offset)
+		__field(u32, count)
+		__field(u32, rev)
+	),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->offset = offset;
+		__entry->count = count;
+		__entry->rev = rev;
+	),
+	TP_printk("Ext Cap %p, port offset = %u, count = %u, rev = 0x%x",
+		  __entry->addr, __entry->offset, __entry->count, __entry->rev)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_deq_state,
+	TP_PROTO(struct cdnsp_dequeue_state *state),
+	TP_ARGS(state),
+	TP_STRUCT__entry(
+		__field(int, new_cycle_state)
+		__field(struct cdnsp_segment *, new_deq_seg)
+		__field(dma_addr_t, deq_seg_dma)
+		__field(union cdnsp_trb	*, new_deq_ptr)
+		__field(dma_addr_t, deq_ptr_dma)
+	),
+	TP_fast_assign(
+		__entry->new_cycle_state = state->new_cycle_state;
+		__entry->new_deq_seg = state->new_deq_seg;
+		__entry->deq_seg_dma = state->new_deq_seg->dma;
+		__entry->new_deq_ptr = state->new_deq_ptr,
+		__entry->deq_ptr_dma = cdnsp_trb_virt_to_dma(state->new_deq_seg,
+							     state->new_deq_ptr);
+	),
+	TP_printk("New cycle state = 0x%x, New dequeue segment = %p (0x%pad dma), "
+		  "New dequeue pointer = %p (0x%pad dma)",
+		  __entry->new_cycle_state, __entry->new_deq_seg,
+		  &__entry->deq_seg_dma, __entry->new_deq_ptr,
+		  &__entry->deq_ptr_dma
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_deq_state, cdnsp_new_deq_state,
+	TP_PROTO(struct cdnsp_dequeue_state *state),
+	TP_ARGS(state)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_ctrl,
+	TP_PROTO(struct usb_ctrlrequest *ctrl),
+	TP_ARGS(ctrl),
+	TP_STRUCT__entry(
+		__field(u8, bRequestType)
+		__field(u8, bRequest)
+		__field(u16, wValue)
+		__field(u16, wIndex)
+		__field(u16, wLength)
+		__dynamic_array(char, str, CDNSP_MSG_MAX)
+	),
+	TP_fast_assign(
+		__entry->bRequestType = ctrl->bRequestType;
+		__entry->bRequest = ctrl->bRequest;
+		__entry->wValue = le16_to_cpu(ctrl->wValue);
+		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
+		__entry->wLength = le16_to_cpu(ctrl->wLength);
+	),
+	TP_printk("%s", usb_decode_ctrl(__get_str(str), CDNSP_MSG_MAX,
+					__entry->bRequestType,
+					__entry->bRequest, __entry->wValue,
+					__entry->wIndex, __entry->wLength)
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_ctrl, cdnsp_ctrl_req,
+	TP_PROTO(struct usb_ctrlrequest *ctrl),
+	TP_ARGS(ctrl)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_bounce,
+	TP_PROTO(struct cdnsp_request *preq, u32 new_buf_len, u32 offset,
+		 dma_addr_t dma, unsigned int unalign),
+	TP_ARGS(preq, new_buf_len, offset, dma, unalign),
+	TP_STRUCT__entry(
+		__string(name, preq->pep->name)
+		__field(u32, new_buf_len)
+		__field(u32, offset)
+		__field(dma_addr_t, dma)
+		__field(unsigned int, unalign)
+	),
+	TP_fast_assign(
+		__assign_str(name, preq->pep->name);
+		__entry->new_buf_len = new_buf_len;
+		__entry->offset = offset;
+		__entry->dma = dma;
+		__entry->unalign = unalign;
+	),
+	TP_printk("%s buf len %d, offset %d, dma %pad, unalign %d",
+		  __get_str(name), __entry->new_buf_len,
+		  __entry->offset, &__entry->dma, __entry->unalign
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_bounce, cdnsp_bounce_align_td_split,
+	TP_PROTO(struct cdnsp_request *preq, u32 new_buf_len, u32 offset,
+		 dma_addr_t dma, unsigned int unalign),
+	TP_ARGS(preq, new_buf_len, offset, dma, unalign)
+);
+
+DEFINE_EVENT(cdnsp_log_bounce, cdnsp_bounce_map,
+	TP_PROTO(struct cdnsp_request *preq, u32 new_buf_len, u32 offset,
+		 dma_addr_t dma, unsigned int unalign),
+	TP_ARGS(preq, new_buf_len, offset, dma, unalign)
+);
+
+DEFINE_EVENT(cdnsp_log_bounce, cdnsp_bounce_unmap,
+	TP_PROTO(struct cdnsp_request *preq, u32 new_buf_len, u32 offset,
+		 dma_addr_t dma, unsigned int unalign),
+	TP_ARGS(preq, new_buf_len, offset, dma, unalign)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_trb,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(u32, field0)
+		__field(u32, field1)
+		__field(u32, field2)
+		__field(u32, field3)
+		__field(union cdnsp_trb *, trb)
+		__field(dma_addr_t, trb_dma)
+		__dynamic_array(char, str, CDNSP_MSG_MAX)
+	),
+	TP_fast_assign(
+		__entry->type = ring->type;
+		__entry->field0 = le32_to_cpu(trb->field[0]);
+		__entry->field1 = le32_to_cpu(trb->field[1]);
+		__entry->field2 = le32_to_cpu(trb->field[2]);
+		__entry->field3 = le32_to_cpu(trb->field[3]);
+		__entry->trb = (union cdnsp_trb *)trb;
+		__entry->trb_dma = cdnsp_trb_virt_to_dma(ring->deq_seg,
+							 (union cdnsp_trb *)trb);
+
+	),
+	TP_printk("%s: %s trb: %p(%pad)", cdnsp_ring_type_string(__entry->type),
+		  cdnsp_decode_trb(__get_str(str), CDNSP_MSG_MAX,
+				   __entry->field0, __entry->field1,
+				   __entry->field2, __entry->field3),
+				   __entry->trb, &__entry->trb_dma
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_handle_event,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_trb_without_td,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_handle_command,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_handle_transfer,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_queue_trb,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_cmd_wait_for_compl,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_cmd_timeout,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(cdnsp_log_trb, cdnsp_defered_event,
+	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_pdev,
+	TP_PROTO(struct cdnsp_device *pdev),
+	TP_ARGS(pdev),
+	TP_STRUCT__entry(
+		__field(struct cdnsp_device *, pdev)
+		__field(struct usb_gadget *, gadget)
+		__field(dma_addr_t, out_ctx)
+		__field(dma_addr_t, in_ctx)
+		__field(u8, port_num)
+	),
+	TP_fast_assign(
+		__entry->pdev = pdev;
+		__entry->gadget = &pdev->gadget;
+		__entry->in_ctx = pdev->in_ctx.dma;
+		__entry->out_ctx = pdev->out_ctx.dma;
+		__entry->port_num = pdev->active_port ?
+				pdev->active_port->port_num : 0xFF;
+	),
+	TP_printk("pdev %p gadget %p ctx %pad | %pad, port %d ",
+		  __entry->pdev, __entry->gadget, &__entry->in_ctx,
+		  &__entry->out_ctx, __entry->port_num
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_pdev, cdnsp_alloc_priv_device,
+	TP_PROTO(struct cdnsp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(cdnsp_log_pdev, cdnsp_free_priv_device,
+	TP_PROTO(struct cdnsp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_device,
+	TP_PROTO(struct cdnsp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_addressable_priv_device,
+	TP_PROTO(struct cdnsp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_request,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__string(name, req->pep->name)
+		__field(struct usb_request *, request)
+		__field(struct cdnsp_request *, preq)
+		__field(void *, buf)
+		__field(unsigned int, actual)
+		__field(unsigned int, length)
+		__field(int, status)
+		__field(dma_addr_t, dma)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, zero)
+		__field(unsigned int, short_not_ok)
+		__field(unsigned int, no_interrupt)
+		__field(struct scatterlist*, sg)
+		__field(unsigned int, num_sgs)
+		__field(unsigned int, num_mapped_sgs)
+
+	),
+	TP_fast_assign(
+		__assign_str(name, req->pep->name);
+		__entry->request = &req->request;
+		__entry->preq = req;
+		__entry->buf = req->request.buf;
+		__entry->actual = req->request.actual;
+		__entry->length = req->request.length;
+		__entry->status = req->request.status;
+		__entry->dma = req->request.dma;
+		__entry->stream_id = req->request.stream_id;
+		__entry->zero = req->request.zero;
+		__entry->short_not_ok = req->request.short_not_ok;
+		__entry->no_interrupt = req->request.no_interrupt;
+		__entry->sg = req->request.sg;
+		__entry->num_sgs = req->request.num_sgs;
+		__entry->num_mapped_sgs = req->request.num_mapped_sgs;
+	),
+	TP_printk("%s; req U:%p/P:%p, req buf %p, length %u/%u, status %d, "
+		  "buf dma (%pad), SID %u, %s%s%s, sg %p, num_sg %d,"
+		  " num_m_sg %d",
+		  __get_str(name), __entry->request, __entry->preq,
+		  __entry->buf, __entry->actual, __entry->length,
+		  __entry->status, &__entry->dma,
+		  __entry->stream_id, __entry->zero ? "Z" : "z",
+		  __entry->short_not_ok ? "S" : "s",
+		  __entry->no_interrupt ? "I" : "i",
+		  __entry->sg, __entry->num_sgs, __entry->num_mapped_sgs
+		)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_request_enqueue,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_request_enqueue_busy,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_request_enqueue_error,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_request_dequeue,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_request_giveback,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_alloc_request,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdnsp_log_request, cdnsp_free_request,
+	TP_PROTO(struct cdnsp_request *req),
+	TP_ARGS(req)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_ep_ctx,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u64, deq)
+		__field(u32, tx_info)
+		__dynamic_array(char, str, CDNSP_MSG_MAX)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->ep_info);
+		__entry->info2 = le32_to_cpu(ctx->ep_info2);
+		__entry->deq = le64_to_cpu(ctx->deq);
+		__entry->tx_info = le32_to_cpu(ctx->tx_info);
+	),
+	TP_printk("%s", cdnsp_decode_ep_context(__get_str(str), CDNSP_MSG_MAX,
+						__entry->info, __entry->info2,
+						__entry->deq, __entry->tx_info)
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_ep_disabled,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_ep_stopped_or_disabled,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_remove_request,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_stop_ep,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_flush_ep,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_set_deq_ep,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_reset_ep,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_config_ep,
+	TP_PROTO(struct cdnsp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_slot_ctx,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u32, int_target)
+		__field(u32, state)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->dev_info);
+		__entry->info2 = le32_to_cpu(ctx->dev_port);
+		__entry->int_target = le64_to_cpu(ctx->int_target);
+		__entry->state = le32_to_cpu(ctx->dev_state);
+	),
+	TP_printk("%s", cdnsp_decode_slot_context(__entry->info,
+						  __entry->info2,
+						  __entry->int_target,
+						  __entry->state)
+	)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_slot_already_in_default,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_handle_cmd_enable_slot,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_handle_cmd_disable_slot,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_reset_device,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_setup_device_slot,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_handle_cmd_addr_dev,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_handle_cmd_reset_dev,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_handle_cmd_set_deq,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_configure_endpoint,
+	TP_PROTO(struct cdnsp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_td_info,
+	TP_PROTO(struct cdnsp_request *preq),
+	TP_ARGS(preq),
+	TP_STRUCT__entry(
+		__string(name, preq->pep->name)
+		__field(struct usb_request *, request)
+		__field(struct cdnsp_request *, preq)
+		__field(union cdnsp_trb *, first_trb)
+		__field(union cdnsp_trb *, last_trb)
+		__field(dma_addr_t, trb_dma)
+	),
+	TP_fast_assign(
+		__assign_str(name, preq->pep->name);
+		__entry->request = &preq->request;
+		__entry->preq = preq;
+		__entry->first_trb = preq->td.first_trb;
+		__entry->last_trb = preq->td.last_trb;
+		__entry->trb_dma = cdnsp_trb_virt_to_dma(preq->td.start_seg,
+							 preq->td.first_trb)
+	),
+	TP_printk("%s req/preq:  %p/%p, first trb %p[vir]/%pad(dma), last trb %p",
+		  __get_str(name), __entry->request, __entry->preq,
+		  __entry->first_trb, &__entry->trb_dma,
+		  __entry->last_trb
+		)
+);
+
+DEFINE_EVENT(cdnsp_log_td_info, cdnsp_remove_request_td,
+	TP_PROTO(struct cdnsp_request *preq),
+	TP_ARGS(preq)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_ring,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(void *, ring)
+		__field(dma_addr_t, enq)
+		__field(dma_addr_t, deq)
+		__field(dma_addr_t, enq_seg)
+		__field(dma_addr_t, deq_seg)
+		__field(unsigned int, num_segs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, cycle_state)
+		__field(unsigned int, num_trbs_free)
+		__field(unsigned int, bounce_buf_len)
+	),
+	TP_fast_assign(
+		__entry->ring = ring;
+		__entry->type = ring->type;
+		__entry->num_segs = ring->num_segs;
+		__entry->stream_id = ring->stream_id;
+		__entry->enq_seg = ring->enq_seg->dma;
+		__entry->deq_seg = ring->deq_seg->dma;
+		__entry->cycle_state = ring->cycle_state;
+		__entry->num_trbs_free = ring->num_trbs_free;
+		__entry->bounce_buf_len = ring->bounce_buf_len;
+		__entry->enq = cdnsp_trb_virt_to_dma(ring->enq_seg,
+						     ring->enqueue);
+		__entry->deq = cdnsp_trb_virt_to_dma(ring->deq_seg,
+						     ring->dequeue);
+	),
+	TP_printk("%s %p: enq %pad(%pad) deq %pad(%pad) segs %d stream %d"
+		  "free_trbs %d bounce %d cycle %d",
+		  cdnsp_ring_type_string(__entry->type), __entry->ring,
+		  &__entry->enq, &__entry->enq_seg,
+		  &__entry->deq, &__entry->deq_seg,
+		  __entry->num_segs,
+		  __entry->stream_id,
+		  __entry->num_trbs_free,
+		  __entry->bounce_buf_len,
+		  __entry->cycle_state
+		)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_ring_alloc,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_ring_free,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_set_stream_ring,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_ring_expansion,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_inc_enq,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(cdnsp_log_ring, cdnsp_inc_deq,
+	TP_PROTO(struct cdnsp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DECLARE_EVENT_CLASS(cdnsp_log_portsc,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc),
+		TP_STRUCT__entry(
+				__field(u32, portnum)
+				__field(u32, portsc)
+				__dynamic_array(char, str, CDNSP_MSG_MAX)
+				),
+		TP_fast_assign(
+				__entry->portnum = portnum;
+				__entry->portsc = portsc;
+				),
+		TP_printk("port-%d: %s",
+			  __entry->portnum,
+			  cdnsp_decode_portsc(__get_str(str), CDNSP_MSG_MAX,
+					      __entry->portsc)
+			)
+);
+
+DEFINE_EVENT(cdnsp_log_portsc, cdnsp_handle_port_status,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc)
+);
+
+DEFINE_EVENT(cdnsp_log_portsc, cdnsp_link_state_changed,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc)
+);
+
+TRACE_EVENT(cdnsp_stream_number,
+	TP_PROTO(struct cdnsp_ep *pep, int num_stream_ctxs, int num_streams),
+	TP_ARGS(pep, num_stream_ctxs, num_streams),
+	TP_STRUCT__entry(
+		__string(name, pep->name)
+		__field(int, num_stream_ctxs)
+		__field(int, num_streams)
+	),
+	TP_fast_assign(
+		__entry->num_stream_ctxs = num_stream_ctxs;
+		__entry->num_streams = num_streams;
+	),
+	TP_printk("%s Need %u stream ctx entries for %u stream IDs.",
+		  __get_str(name), __entry->num_stream_ctxs,
+		  __entry->num_streams)
+);
+
+#endif /* __CDNSP_TRACE_H */
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
-- 
2.17.1

