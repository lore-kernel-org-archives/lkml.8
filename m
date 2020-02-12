Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141E32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JbCrqKmX";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="M9LnGoTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBLKVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:21:04 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48960 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgBLKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:21:03 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CAG7wT022929;
        Wed, 12 Feb 2020 02:19:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=3tGQFf7WLleAyTJCPxGWHJVEcpC6/7iJE6jrOW3np+o=;
 b=JbCrqKmXOng7bMwAFn4wiYne2SRVdV4HGi74ktVRNB7yLg1JUj3bjGrEZlSi4KwJLIQv
 nvdfoNPzTJq7PSFc2Kl7Zt9oN6p+qCWa+oBAdIAmHPOZgMWEgWKmA9fp/UIxRAH3Jjot
 QL91lZfTVNnM158Orbk5OOU9918z9ijnzLNcYKvBBkNXtGfJf7phbmoICXfJ1s9rgW8m
 0zzlZTX3MdAU+hpbKiXs03T+l5Ac0opn1dERF3JjuGFKA9UWEMhrmxCOzMC7evCaiZZw
 IuzTEdRiW4LBA/66KcVBYAMYTsKjacFXEPy1NnEjtt/ZYYzWTCdvWV5PFUTahHY24A+D Dw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2y1u17nwv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 02:19:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6ZKXXBm3gWy/a2QLHig2kfH7AG1vUBQtP5+ZHHAS4W885IOLQAb4XrFjglWpjRfF/0VAk4WT13wXYYuYlTMarow56aZthNTmS5EA5czopm1br5ER4AHMqcKBSFwO1V2hn3Fnnez2DanrPFNX4CJCMXD+0NHNbvN35zHjQRsiZ5q8madPte9QzrZgiUAgGZcXOJqW+e5xSmcLjx30r4j/yr1B3qpWyO569jg1FiMjFBi1e2SnrhRIsbPIbzcT+lCwUp17pdXgF/CM+WXx+Ugm2YPE4KhHcp+MsjmKPlXOLFWOjTAOoEZsQxfSak7d6+ZKv22exVQxr+hxvItBJmgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tGQFf7WLleAyTJCPxGWHJVEcpC6/7iJE6jrOW3np+o=;
 b=Q4G11SZS+cttkqxaRxXXdJTdp+UxPg6VBHwf8Mm3Fu4aUpl435aco9BB74fOZoGXzOlcHr4/Qgl1x6Qw7JYSxIiK15HWcrh1iMIkBq7KaMDQGwUrX+Pr0YSY7jKt1fPPqkmgyE8ymoznBmgTpTwKByVlWJ69/pbPOEC2x0O0g5Wl60n/T2PnzFV5+yq8NKbNeiDAf1HqqTPcwJX3L72sdW6DLx0MloJs4d8YKSJKfl7kPUIzLFGVJlhmLs3G06SXC35BIL7ilMIjePRSg1tkL98QzzZ+shINXEqa2htrUwwe1GfpF3xL3p5zC/kM4LdDnU7ddL1rpz3nbpoDZsCeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tGQFf7WLleAyTJCPxGWHJVEcpC6/7iJE6jrOW3np+o=;
 b=M9LnGoTFPe/0sooaqv/qWMkyQhQigTzSB1N4LCRYkHrfIjz+4uV09pjyV+uL+e21RxlESppPnauRo7FEOJGLwUGWI50Kchsfr8gAaQKcKV9S6zJSb4ARSkULuifO9X3KJvowSFm0kYdWIXPWiBtl7d5vztYYJABaQNu6TR4ZKJw=
Received: from SN4PR0701CA0041.namprd07.prod.outlook.com
 (2603:10b6:803:2d::26) by BN6PR07MB3457.namprd07.prod.outlook.com
 (2603:10b6:405:63::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29; Wed, 12 Feb
 2020 10:19:44 +0000
Received: from MW2NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::203) by SN4PR0701CA0041.outlook.office365.com
 (2603:10b6:803:2d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25 via Frontend
 Transport; Wed, 12 Feb 2020 10:19:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT032.mail.protection.outlook.com (10.13.180.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Wed, 12 Feb 2020 10:19:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 01CAJfxp149659
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 02:19:42 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 12 Feb 2020 11:19:40 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Feb 2020 11:19:40 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01CAJeTI022542;
        Wed, 12 Feb 2020 11:19:40 +0100
Received: (from jpawar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01CAJdtQ022539;
        Wed, 12 Feb 2020 11:19:39 +0100
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <peter.chen@nxp.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>, <sparmar@cadence.com>,
        <jpawar@cadence.com>
Subject: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed function.
Date:   Wed, 12 Feb 2020 11:19:08 +0100
Message-ID: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(36092001)(5660300002)(54906003)(2616005)(426003)(107886003)(36906005)(336012)(36756003)(42186006)(478600001)(186003)(316002)(356004)(26005)(6666004)(6916009)(70586007)(70206006)(4326008)(8676002)(81156014)(8936002)(86362001)(81166006)(30864003)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3457;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f791a968-3d04-4035-e66e-08d7afa5141b
X-MS-TrafficTypeDiagnostic: BN6PR07MB3457:
X-Microsoft-Antispam-PRVS: <BN6PR07MB3457E3CDCFF3CA0CAD4D070EC11B0@BN6PR07MB3457.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3JR0uj9wmyo4YgqNWRfvv1F2QtuZh76BxPRZ42rGQaCJKpf5Zw5r7Dq7VDwRJ0jGgHZbfB47SIdidcQKTcQRrlCJ3pWpGYiPTdWk/AWaHPd0UeEGDm5f0mWS6iDcKv0ZnwTTpdY5NGQ/u0S+vcJgTBeuxShlJ/mudw4GSIZ6mNDlg8WwKd+h4Vu03djTMfB/WuCJzU8V7ulRBUiHT+25n63otKNy4CixjgZFrJPHZI2BQ9BGXC2GKBbcenz6ZY8kahkPZARF/Nb/GCSvyOYQnJJHasvea9qSG9qEMutcC6JEl5C3OmS4GMpnKva5i+9AHEHc9rxc/tcTqnRU+7s8Xq6Gka+IJijtEsVL8MJXoHIQrwDn3DUV0RdStUldHbYGtWDBH4xffSx0oqbihTcXxETl32jCkoh4pawjzxud/rfamjSolQF3GXUWHD7Wr0celz97iQmB6hQ7BksLwAv7QMhqQ8Qq4ssrsHBWz+TtznT/Emb6CK6V+r4779h4+NC
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 10:19:43.7442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f791a968-3d04-4035-e66e-08d7afa5141b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3457
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_04:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=43 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002120083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds additional parameter alt to config_ep_by_speed function.
This additional parameter allows to improve this function and
find proper usb_ss_ep_comp_descriptor.

Problem has appeared during testing f_tcm (BOT/UAS) driver function.

f_tcm function for SS use array of headers for both  BOT/UAS alternate
setting:

static struct usb_descriptor_header *uasp_ss_function_desc[] = {
        (struct usb_descriptor_header *) &bot_intf_desc,
        (struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
        (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,

        (struct usb_descriptor_header *) &uasp_intf_desc,
        (struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
        (struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
        (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_status_desc,
        (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_status_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
        (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
        (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
        NULL,
};

The first 5 descriptors are associated with BOT alternate setting,
and others are associated  with UAS.

During handling UAS alternate setting f_tcm drivr invokes
config_ep_by_speed and this function sets incorrect companion endpoint
descriptor in usb_ep object.

Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
case set ep->comp_desc to bot_uasp_ss_bi_desc.

This is due to the fact that it search endpoint based on endpoint
address:

        for_each_ep_desc(speed_desc, d_spd) {
                chosen_desc = (struct usb_endpoint_descriptor *)*d_spd;
                if (chosen_desc->bEndpoitAddress == _ep->address)
                        goto ep_found;
        }

And in result it uses the descriptor from BOT alternate setting
instead UAS.

Finally, it causes that controller driver during enabling endpoints
detect that just enabled endpoint for bot.

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/composite.c               | 46 ++++++++++++++------
 drivers/usb/gadget/function/f_acm.c          |  7 +--
 drivers/usb/gadget/function/f_ecm.c          |  7 +--
 drivers/usb/gadget/function/f_eem.c          |  4 +-
 drivers/usb/gadget/function/f_fs.c           |  3 +-
 drivers/usb/gadget/function/f_hid.c          |  4 +-
 drivers/usb/gadget/function/f_loopback.c     |  2 +-
 drivers/usb/gadget/function/f_mass_storage.c |  5 ++-
 drivers/usb/gadget/function/f_midi.c         |  2 +-
 drivers/usb/gadget/function/f_ncm.c          |  7 +--
 drivers/usb/gadget/function/f_obex.c         |  4 +-
 drivers/usb/gadget/function/f_phonet.c       |  4 +-
 drivers/usb/gadget/function/f_rndis.c        |  7 +--
 drivers/usb/gadget/function/f_serial.c       |  4 +-
 drivers/usb/gadget/function/f_sourcesink.c   | 11 +++--
 drivers/usb/gadget/function/f_subset.c       |  4 +-
 drivers/usb/gadget/function/f_tcm.c          | 36 +++++++--------
 drivers/usb/gadget/function/f_uac1_legacy.c  |  2 +-
 drivers/usb/gadget/function/f_uvc.c          |  5 ++-
 drivers/usb/gadget/function/u_audio.c        |  4 +-
 include/linux/usb/composite.h                |  2 +-
 21 files changed, 99 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 3b4f67000315..a9df15ad2fcf 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -96,33 +96,35 @@ function_descriptors(struct usb_function *f,
 }
 
 /**
- * next_ep_desc() - advance to the next EP descriptor
+ * next_desc() - advance to the next desc_type descriptor
  * @t: currect pointer within descriptor array
+ * @desc_type: descriptor type
  *
- * Return: next EP descriptor or NULL
+ * Return: next desc_type descriptor or NULL
  *
- * Iterate over @t until either EP descriptor found or
+ * Iterate over @t until either desc_type descriptor found or
  * NULL (that indicates end of list) encountered
  */
 static struct usb_descriptor_header**
-next_ep_desc(struct usb_descriptor_header **t)
+next_desc(struct usb_descriptor_header **t, u8 desc_type)
 {
 	for (; *t; t++) {
-		if ((*t)->bDescriptorType == USB_DT_ENDPOINT)
+		if ((*t)->bDescriptorType == desc_type)
 			return t;
 	}
 	return NULL;
 }
 
 /*
- * for_each_ep_desc()- iterate over endpoint descriptors in the
- *		descriptors list
- * @start:	pointer within descriptor array.
- * @ep_desc:	endpoint descriptor to use as the loop cursor
+ * for_each_desc() - iterate over desc_type descriptors in the
+ * descriptors list
+ * @start: pointer within descriptor array.
+ * @iter_desc: desc_type descriptor to use as the loop cursor
+ * @desc_type: wanted descriptr type
  */
-#define for_each_ep_desc(start, ep_desc) \
-	for (ep_desc = next_ep_desc(start); \
-	      ep_desc; ep_desc = next_ep_desc(ep_desc+1))
+#define for_each_desc(start, iter_desc, desc_type) \
+	for (iter_desc = next_desc(start, desc_type); \
+	      iter_desc; iter_desc = next_desc(iter_desc + 1, desc_type))
 
 /**
  * config_ep_by_speed() - configures the given endpoint
@@ -130,6 +132,7 @@ next_ep_desc(struct usb_descriptor_header **t)
  * @g: pointer to the gadget
  * @f: usb function
  * @_ep: the endpoint to configure
+ * @alt: alternate setting number
  *
  * Return: error code, 0 on success
  *
@@ -144,9 +147,11 @@ next_ep_desc(struct usb_descriptor_header **t)
  */
 int config_ep_by_speed(struct usb_gadget *g,
 			struct usb_function *f,
-			struct usb_ep *_ep)
+			struct usb_ep *_ep,
+			u8 alt)
 {
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
+	struct usb_interface_descriptor *int_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
 	struct usb_ss_ep_comp_descriptor *comp_desc = NULL;
@@ -182,8 +187,21 @@ int config_ep_by_speed(struct usb_gadget *g,
 	default:
 		speed_desc = f->fs_descriptors;
 	}
+
+	/* find correct alternate setting descriptor */
+	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
+		int_desc = (struct usb_interface_descriptor *)*d_spd;
+
+		if (int_desc->bAlternateSetting == alt) {
+			speed_desc = d_spd;
+			goto intf_found;
+		}
+	}
+	return -EIO;
+
+intf_found:
 	/* find descriptors */
-	for_each_ep_desc(speed_desc, d_spd) {
+	for_each_desc(speed_desc, d_spd, USB_DT_ENDPOINT) {
 		chosen_desc = (struct usb_endpoint_descriptor *)*d_spd;
 		if (chosen_desc->bEndpointAddress == _ep->address)
 			goto ep_found;
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 7c152c28b26c..0be4a07f1624 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -430,7 +430,8 @@ static int acm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		usb_ep_disable(acm->notify);
 
 		if (!acm->notify->desc)
-			if (config_ep_by_speed(cdev->gadget, f, acm->notify))
+			if (config_ep_by_speed(cdev->gadget, f,
+					       acm->notify, alt))
 				return -EINVAL;
 
 		usb_ep_enable(acm->notify);
@@ -445,9 +446,9 @@ static int acm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			dev_dbg(&cdev->gadget->dev,
 				"activate acm ttyGS%d\n", acm->port_num);
 			if (config_ep_by_speed(cdev->gadget, f,
-					       acm->port.in) ||
+					       acm->port.in, alt) ||
 			    config_ep_by_speed(cdev->gadget, f,
-					       acm->port.out)) {
+					       acm->port.out, alt)) {
 				acm->port.in->desc = NULL;
 				acm->port.out->desc = NULL;
 				return -EINVAL;
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 7f5cf488b2b1..e5a122cdaa98 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -544,7 +544,8 @@ static int ecm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		usb_ep_disable(ecm->notify);
 		if (!(ecm->notify->desc)) {
 			VDBG(cdev, "init ecm ctrl %d\n", intf);
-			if (config_ep_by_speed(cdev->gadget, f, ecm->notify))
+			if (config_ep_by_speed(cdev->gadget, f,
+					       ecm->notify, alt))
 				goto fail;
 		}
 		usb_ep_enable(ecm->notify);
@@ -563,9 +564,9 @@ static int ecm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		    !ecm->port.out_ep->desc) {
 			DBG(cdev, "init ecm\n");
 			if (config_ep_by_speed(cdev->gadget, f,
-					       ecm->port.in_ep) ||
+					       ecm->port.in_ep, alt) ||
 			    config_ep_by_speed(cdev->gadget, f,
-					       ecm->port.out_ep)) {
+					       ecm->port.out_ep, alt)) {
 				ecm->port.in_ep->desc = NULL;
 				ecm->port.out_ep->desc = NULL;
 				goto fail;
diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index b81a91d504bd..2cfb1ceb45f1 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -196,9 +196,9 @@ static int eem_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (!eem->port.in_ep->desc || !eem->port.out_ep->desc) {
 			DBG(cdev, "init eem\n");
 			if (config_ep_by_speed(cdev->gadget, f,
-					       eem->port.in_ep) ||
+					       eem->port.in_ep, alt) ||
 			    config_ep_by_speed(cdev->gadget, f,
-					       eem->port.out_ep)) {
+					       eem->port.out_ep, alt)) {
 				eem->port.in_ep->desc = NULL;
 				eem->port.out_ep->desc = NULL;
 				goto fail;
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6171d28331e6..374b3b23cd02 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1950,7 +1950,8 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 	while(count--) {
 		ep->ep->driver_data = ep;
 
-		ret = config_ep_by_speed(func->gadget, &func->function, ep->ep);
+		ret = config_ep_by_speed(func->gadget, &func->function,
+					 ep->ep, 0);
 		if (ret) {
 			pr_err("%s: config_ep_by_speed(%s) returned %d\n",
 					__func__, ep->ep->name, ret);
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f3816a5c861e..9cbf622dc33c 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -647,7 +647,7 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		usb_ep_disable(hidg->in_ep);
 
 		status = config_ep_by_speed(f->config->cdev->gadget, f,
-					    hidg->in_ep);
+					    hidg->in_ep, alt);
 		if (status) {
 			ERROR(cdev, "config_ep_by_speed FAILED!\n");
 			goto fail;
@@ -672,7 +672,7 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		usb_ep_disable(hidg->out_ep);
 
 		status = config_ep_by_speed(f->config->cdev->gadget, f,
-					    hidg->out_ep);
+					    hidg->out_ep, alt);
 		if (status) {
 			ERROR(cdev, "config_ep_by_speed FAILED!\n");
 			goto free_req_in;
diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index 1803646b3678..6ff45212bf8e 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -362,7 +362,7 @@ static int enable_endpoint(struct usb_composite_dev *cdev,
 {
 	int					result;
 
-	result = config_ep_by_speed(cdev->gadget, &(loop->function), ep);
+	result = config_ep_by_speed(cdev->gadget, &loop->function, ep, 0);
 	if (result)
 		goto out;
 
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 7c96c4665178..9aa9fd4e4785 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2241,7 +2241,8 @@ static int do_set_interface(struct fsg_common *common, struct fsg_dev *new_fsg)
 	fsg = common->fsg;
 
 	/* Enable the endpoints */
-	rc = config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_in);
+	rc = config_ep_by_speed(common->gadget, &fsg->function,
+				fsg->bulk_in, 0);
 	if (rc)
 		goto reset;
 	rc = usb_ep_enable(fsg->bulk_in);
@@ -2251,7 +2252,7 @@ static int do_set_interface(struct fsg_common *common, struct fsg_dev *new_fsg)
 	fsg->bulk_in_enabled = 1;
 
 	rc = config_ep_by_speed(common->gadget, &(fsg->function),
-				fsg->bulk_out);
+				fsg->bulk_out, 0);
 	if (rc)
 		goto reset;
 	rc = usb_ep_enable(fsg->bulk_out);
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 46af0aa07e2e..f371ef38a251 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -343,7 +343,7 @@ static int f_midi_start_ep(struct f_midi *midi,
 
 	usb_ep_disable(ep);
 
-	err = config_ep_by_speed(midi->gadget, f, ep);
+	err = config_ep_by_speed(midi->gadget, f, ep, 0);
 	if (err) {
 		ERROR(cdev, "can't configure %s: %d\n", ep->name, err);
 		return err;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 1d900081b1f0..f5c1ad67aa58 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -876,7 +876,8 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 
 		if (!(ncm->notify->desc)) {
 			DBG(cdev, "init ncm ctrl %d\n", intf);
-			if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
+			if (config_ep_by_speed(cdev->gadget, f,
+					       ncm->notify, alt))
 				goto fail;
 		}
 		usb_ep_enable(ncm->notify);
@@ -905,9 +906,9 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			    !ncm->port.out_ep->desc) {
 				DBG(cdev, "init ncm\n");
 				if (config_ep_by_speed(cdev->gadget, f,
-						       ncm->port.in_ep) ||
+						       ncm->port.in_ep, alt) ||
 				    config_ep_by_speed(cdev->gadget, f,
-						       ncm->port.out_ep)) {
+						       ncm->port.out_ep, alt)) {
 					ncm->port.in_ep->desc = NULL;
 					ncm->port.out_ep->desc = NULL;
 					goto fail;
diff --git a/drivers/usb/gadget/function/f_obex.c b/drivers/usb/gadget/function/f_obex.c
index ab26d84ed95e..bacceced3bba 100644
--- a/drivers/usb/gadget/function/f_obex.c
+++ b/drivers/usb/gadget/function/f_obex.c
@@ -212,9 +212,9 @@ static int obex_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			dev_dbg(&cdev->gadget->dev,
 				"init obex ttyGS%d\n", obex->port_num);
 			if (config_ep_by_speed(cdev->gadget, f,
-					       obex->port.in) ||
+					       obex->port.in, alt) ||
 			    config_ep_by_speed(cdev->gadget, f,
-					       obex->port.out)) {
+					       obex->port.out, alt)) {
 				obex->port.out->desc = NULL;
 				obex->port.in->desc = NULL;
 				goto fail;
diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 8b72b192c747..e1f04447c6da 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -416,8 +416,8 @@ static int pn_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (alt == 1) {
 			int i;
 
-			if (config_ep_by_speed(gadget, f, fp->in_ep) ||
-			    config_ep_by_speed(gadget, f, fp->out_ep)) {
+			if (config_ep_by_speed(gadget, f, fp->in_ep, alt) ||
+			    config_ep_by_speed(gadget, f, fp->out_ep, alt)) {
 				fp->in_ep->desc = NULL;
 				fp->out_ep->desc = NULL;
 				spin_unlock(&port->lock);
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 0d8e4a364ca6..d5dde0e2f2ef 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -547,7 +547,8 @@ static int rndis_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 
 		if (!rndis->notify->desc) {
 			VDBG(cdev, "init rndis ctrl %d\n", intf);
-			if (config_ep_by_speed(cdev->gadget, f, rndis->notify))
+			if (config_ep_by_speed(cdev->gadget, f,
+					       rndis->notify, alt))
 				goto fail;
 		}
 		usb_ep_enable(rndis->notify);
@@ -563,9 +564,9 @@ static int rndis_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (!rndis->port.in_ep->desc || !rndis->port.out_ep->desc) {
 			DBG(cdev, "init rndis\n");
 			if (config_ep_by_speed(cdev->gadget, f,
-					       rndis->port.in_ep) ||
+					       rndis->port.in_ep, alt) ||
 			    config_ep_by_speed(cdev->gadget, f,
-					       rndis->port.out_ep)) {
+					       rndis->port.out_ep, alt)) {
 				rndis->port.in_ep->desc = NULL;
 				rndis->port.out_ep->desc = NULL;
 				goto fail;
diff --git a/drivers/usb/gadget/function/f_serial.c b/drivers/usb/gadget/function/f_serial.c
index 1406255d0865..784455c57dd5 100644
--- a/drivers/usb/gadget/function/f_serial.c
+++ b/drivers/usb/gadget/function/f_serial.c
@@ -158,8 +158,8 @@ static int gser_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	if (!gser->port.in->desc || !gser->port.out->desc) {
 		dev_dbg(&cdev->gadget->dev,
 			"activate generic ttyGS%d\n", gser->port_num);
-		if (config_ep_by_speed(cdev->gadget, f, gser->port.in) ||
-		    config_ep_by_speed(cdev->gadget, f, gser->port.out)) {
+		if (config_ep_by_speed(cdev->gadget, f, gser->port.in, alt) ||
+		    config_ep_by_speed(cdev->gadget, f, gser->port.out, alt)) {
 			gser->port.in->desc = NULL;
 			gser->port.out->desc = NULL;
 			return -EINVAL;
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index ed68a4860b7d..86124149de7d 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -650,7 +650,8 @@ enable_source_sink(struct usb_composite_dev *cdev, struct f_sourcesink *ss,
 
 	/* one bulk endpoint writes (sources) zeroes IN (to the host) */
 	ep = ss->in_ep;
-	result = config_ep_by_speed(cdev->gadget, &(ss->function), ep);
+	result = config_ep_by_speed(cdev->gadget, &ss->function,
+				    ep, alt);
 	if (result)
 		return result;
 	result = usb_ep_enable(ep);
@@ -668,7 +669,7 @@ enable_source_sink(struct usb_composite_dev *cdev, struct f_sourcesink *ss,
 
 	/* one bulk endpoint reads (sinks) anything OUT (from the host) */
 	ep = ss->out_ep;
-	result = config_ep_by_speed(cdev->gadget, &(ss->function), ep);
+	result = config_ep_by_speed(cdev->gadget, &ss->function, ep, alt);
 	if (result)
 		goto fail;
 	result = usb_ep_enable(ep);
@@ -690,7 +691,8 @@ enable_source_sink(struct usb_composite_dev *cdev, struct f_sourcesink *ss,
 	/* one iso endpoint writes (sources) zeroes IN (to the host) */
 	ep = ss->iso_in_ep;
 	if (ep) {
-		result = config_ep_by_speed(cdev->gadget, &(ss->function), ep);
+		result = config_ep_by_speed(cdev->gadget, &ss->function,
+					    ep, alt);
 		if (result)
 			goto fail2;
 		result = usb_ep_enable(ep);
@@ -711,7 +713,8 @@ enable_source_sink(struct usb_composite_dev *cdev, struct f_sourcesink *ss,
 	/* one iso endpoint reads (sinks) anything OUT (from the host) */
 	ep = ss->iso_out_ep;
 	if (ep) {
-		result = config_ep_by_speed(cdev->gadget, &(ss->function), ep);
+		result = config_ep_by_speed(cdev->gadget, &ss->function,
+					    ep, alt);
 		if (result)
 			goto fail3;
 		result = usb_ep_enable(ep);
diff --git a/drivers/usb/gadget/function/f_subset.c b/drivers/usb/gadget/function/f_subset.c
index 4d945254905d..5362ae567f6c 100644
--- a/drivers/usb/gadget/function/f_subset.c
+++ b/drivers/usb/gadget/function/f_subset.c
@@ -264,8 +264,8 @@ static int geth_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	}
 
 	DBG(cdev, "init + activate cdc subset\n");
-	if (config_ep_by_speed(cdev->gadget, f, geth->port.in_ep) ||
-	    config_ep_by_speed(cdev->gadget, f, geth->port.out_ep)) {
+	if (config_ep_by_speed(cdev->gadget, f, geth->port.in_ep, alt) ||
+	    config_ep_by_speed(cdev->gadget, f, geth->port.out_ep, alt)) {
 		geth->port.in_ep->desc = NULL;
 		geth->port.out_ep->desc = NULL;
 		return -EINVAL;
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 36504931b2d1..3c564629d268 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -392,12 +392,12 @@ static void bot_set_alt(struct f_uas *fu)
 
 	fu->flags = USBG_IS_BOT;
 
-	config_ep_by_speed(gadget, f, fu->ep_in);
+	config_ep_by_speed(gadget, f, fu->ep_in, USB_G_ALT_INT_BBB);
 	ret = usb_ep_enable(fu->ep_in);
 	if (ret)
 		goto err_b_in;
 
-	config_ep_by_speed(gadget, f, fu->ep_out);
+	config_ep_by_speed(gadget, f, fu->ep_out, USB_G_ALT_INT_BBB);
 	ret = usb_ep_enable(fu->ep_out);
 	if (ret)
 		goto err_b_out;
@@ -849,21 +849,21 @@ static void uasp_set_alt(struct f_uas *fu)
 	if (gadget->speed >= USB_SPEED_SUPER)
 		fu->flags |= USBG_USE_STREAMS;
 
-	config_ep_by_speed(gadget, f, fu->ep_in);
+	config_ep_by_speed(gadget, f, fu->ep_in, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_in);
 	if (ret)
 		goto err_b_in;
 
-	config_ep_by_speed(gadget, f, fu->ep_out);
+	config_ep_by_speed(gadget, f, fu->ep_out, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_out);
 	if (ret)
 		goto err_b_out;
 
-	config_ep_by_speed(gadget, f, fu->ep_cmd);
+	config_ep_by_speed(gadget, f, fu->ep_cmd, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_cmd);
 	if (ret)
 		goto err_cmd;
-	config_ep_by_speed(gadget, f, fu->ep_status);
+	config_ep_by_speed(gadget, f, fu->ep_status, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_status);
 	if (ret)
 		goto err_status;
@@ -1780,7 +1780,7 @@ static struct usb_pipe_usage_descriptor uasp_bi_pipe_desc = {
 	.bPipeID =		DATA_IN_PIPE_ID,
 };
 
-static struct usb_endpoint_descriptor uasp_ss_bi_desc = {
+static struct usb_endpoint_descriptor bot_uasp_ss_bi_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
 	.bEndpointAddress =	USB_DIR_IN,
@@ -1823,7 +1823,7 @@ static struct usb_pipe_usage_descriptor uasp_bo_pipe_desc = {
 	.bPipeID =		DATA_OUT_PIPE_ID,
 };
 
-static struct usb_endpoint_descriptor uasp_ss_bo_desc = {
+static struct usb_endpoint_descriptor bot_uasp_ss_bo_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
 	.bEndpointAddress =	USB_DIR_OUT,
@@ -1947,16 +1947,16 @@ static struct usb_descriptor_header *uasp_hs_function_desc[] = {
 
 static struct usb_descriptor_header *uasp_ss_function_desc[] = {
 	(struct usb_descriptor_header *) &bot_intf_desc,
-	(struct usb_descriptor_header *) &uasp_ss_bi_desc,
+	(struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
 	(struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
-	(struct usb_descriptor_header *) &uasp_ss_bo_desc,
+	(struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
 	(struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
 
 	(struct usb_descriptor_header *) &uasp_intf_desc,
-	(struct usb_descriptor_header *) &uasp_ss_bi_desc,
+	(struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
 	(struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
 	(struct usb_descriptor_header *) &uasp_bi_pipe_desc,
-	(struct usb_descriptor_header *) &uasp_ss_bo_desc,
+	(struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
 	(struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
 	(struct usb_descriptor_header *) &uasp_bo_pipe_desc,
 	(struct usb_descriptor_header *) &uasp_ss_status_desc,
@@ -2016,14 +2016,14 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	bot_intf_desc.bInterfaceNumber = iface;
 	uasp_intf_desc.bInterfaceNumber = iface;
 	fu->iface = iface;
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_bi_desc,
+	ep = usb_ep_autoconfig_ss(gadget, &bot_uasp_ss_bi_desc,
 			&uasp_bi_ep_comp_desc);
 	if (!ep)
 		goto ep_fail;
 
 	fu->ep_in = ep;
 
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_bo_desc,
+	ep = usb_ep_autoconfig_ss(gadget, &bot_uasp_ss_bo_desc,
 			&uasp_bo_ep_comp_desc);
 	if (!ep)
 		goto ep_fail;
@@ -2042,14 +2042,14 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	fu->ep_cmd = ep;
 
 	/* Assume endpoint addresses are the same for both speeds */
-	uasp_bi_desc.bEndpointAddress =	uasp_ss_bi_desc.bEndpointAddress;
-	uasp_bo_desc.bEndpointAddress = uasp_ss_bo_desc.bEndpointAddress;
+	uasp_bi_desc.bEndpointAddress =	bot_uasp_ss_bi_desc.bEndpointAddress;
+	uasp_bo_desc.bEndpointAddress = bot_uasp_ss_bo_desc.bEndpointAddress;
 	uasp_status_desc.bEndpointAddress =
 		uasp_ss_status_desc.bEndpointAddress;
 	uasp_cmd_desc.bEndpointAddress = uasp_ss_cmd_desc.bEndpointAddress;
 
-	uasp_fs_bi_desc.bEndpointAddress = uasp_ss_bi_desc.bEndpointAddress;
-	uasp_fs_bo_desc.bEndpointAddress = uasp_ss_bo_desc.bEndpointAddress;
+	uasp_fs_bi_desc.bEndpointAddress = bot_uasp_ss_bi_desc.bEndpointAddress;
+	uasp_fs_bo_desc.bEndpointAddress = bot_uasp_ss_bo_desc.bEndpointAddress;
 	uasp_fs_status_desc.bEndpointAddress =
 		uasp_ss_status_desc.bEndpointAddress;
 	uasp_fs_cmd_desc.bEndpointAddress = uasp_ss_cmd_desc.bEndpointAddress;
diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 349deae7cabd..0bcebe6e74c3 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -601,7 +601,7 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		return 0;
 	} else if (intf == audio->as_intf) {
 		if (alt == 1) {
-			err = config_ep_by_speed(cdev->gadget, f, out_ep);
+			err = config_ep_by_speed(cdev->gadget, f, out_ep, alt);
 			if (err)
 				return err;
 
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index fb0a892687c0..7d4a479baebb 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -290,7 +290,8 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		usb_ep_disable(uvc->control_ep);
 
 		if (!uvc->control_ep->desc)
-			if (config_ep_by_speed(cdev->gadget, f, uvc->control_ep))
+			if (config_ep_by_speed(cdev->gadget, f,
+					       uvc->control_ep, alt))
 				return -EINVAL;
 
 		usb_ep_enable(uvc->control_ep);
@@ -341,7 +342,7 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		usb_ep_disable(uvc->video.ep);
 
 		ret = config_ep_by_speed(f->config->cdev->gadget,
-				&(uvc->func), uvc->video.ep);
+					&uvc->func, uvc->video.ep, alt);
 		if (ret)
 			return ret;
 		usb_ep_enable(uvc->video.ep);
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 6d956f190f5a..acaa2288cf35 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -360,7 +360,7 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 
 	ep = audio_dev->out_ep;
 	prm = &uac->c_prm;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	config_ep_by_speed(gadget, &audio_dev->func, ep, 0);
 	req_len = prm->max_psize;
 
 	prm->ep_enabled = true;
@@ -413,7 +413,7 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 
 	ep = audio_dev->in_ep;
 	prm = &uac->p_prm;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	config_ep_by_speed(gadget, &audio_dev->func, ep, 0);
 
 	ep_desc = ep->desc;
 
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 8675e145ea8b..73ffc05d69e7 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -250,7 +250,7 @@ int usb_function_activate(struct usb_function *);
 int usb_interface_id(struct usb_configuration *, struct usb_function *);
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
-			struct usb_ep *_ep);
+			struct usb_ep *_ep, u8 alt);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
-- 
2.20.1

