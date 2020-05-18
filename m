Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE68C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F113207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FVhTqInH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Zkoc5fC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERKqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:46:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53452 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgERKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:46:38 -0400
X-Greylist: delayed 1945 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 06:46:38 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IA7Itu015284;
        Mon, 18 May 2020 03:14:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=JGCI0K7ErXhX+0uqiitYKaGwWB54QXRCljibeszCWk8=;
 b=FVhTqInHlS8x+OZcNn2duh1dLCxJChHTri2/6snoltXTx8QERdfKpxfukCEUyhAbBS0v
 3LX5T/Uj2caOx5Qz1jquD3VUuC6jOERJoN9kUn1lcslCwLV3G1ozmMYDEWHJqvSlZFYj
 U5754NIITOllHy8MFCaE/1QyMCWe3+SlkuPf3h2Ue5WruH8/6GYlianztsDhUEzCW1bC
 SboUnS+C9IC/2659n6u8DXtvxQUa0qa+e5y2O531MzttNbWgKWIR7vrjnlC/tmlxYrf6
 eA5gDI+gla8Iqf6WKp08KvDkPMPrJuSwVSLNu9OF8sqUy9gmXlKhatlitbRSAfJxirXf 7A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 312cqy67wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 03:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngYlfqKklXdFfM7HttqJ+3Kv+h/HrWizHZaLRPIIUaQD63ogBrehvC3SL/2yjFBLXuo85ii1RjnhKXaY1WW1TjEw4oxmkO7cUkWeNIbdCPrilw6/P06eok0XY4Jv8N5SDjqGTkeO2AyW1zc+b8/IdOp9lbTumMb6KDG65GGIOwrVAR4Iw0sQNvwq/dY766qxNrEEsqtDD9QMGIpkuwhV8N8b0Ek5ZJhRBT11iUIv/jK70IKzxFuWF5bIREh//PtKd4MT/nyYYrNIGVuAOT1FA+1m626iT1dXYKc7bfYvltdc4pn7RERsGVXvgLn+/uvRsEPG9Tp6YinYJXBnFIIJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGCI0K7ErXhX+0uqiitYKaGwWB54QXRCljibeszCWk8=;
 b=lAbfz3qnMWXRt24mm/bk578aKDnwlBIyznHEdtcVlcdjWw5b7ByU3kftE8LTnGJ2gf44Z82+tDv+SbxXYoBM542QPyo/hgs6h+wURxijU7a0j+WeTXbdHBnoHNCGuxqgzhN5y1CNj40MhPz2mBxXmihRHI7oSWD9GevxekSTPFh4zxBUGuWydCI2j9vCDqeRD26uv5Z8GQpDPfVZE+823K7CJizZEeSm9e9ScYebjhJpnja5w8GDdE8dCQqr7IkxJE/qFx5GV/BBIQJhLyzvvgcbw6nkgZj6I0WlFeSg2HcxGmxvbDFS8pyF5RTg25c0T58YUDxXBgVi67P9RvX+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGCI0K7ErXhX+0uqiitYKaGwWB54QXRCljibeszCWk8=;
 b=Zkoc5fC1Xnj9Xq+/Z1oAVGSg67YM3r5dFVd782f5A1vAKt2MrxkQDFNazGLl/KkVjrWJm1AQAQqAPBAu3ZEko/VrRqjsmJPQ6FVqNaMUw3Hghft8Qzmvpi8cHwiCW995wUtbgvHWrL7e7+vyRIWz3F1d08MkDCejMz/Pvg+P12M=
Received: from DM5PR21CA0024.namprd21.prod.outlook.com (2603:10b6:3:ac::34) by
 DM6PR07MB5066.namprd07.prod.outlook.com (2603:10b6:5:1f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Mon, 18 May 2020 10:14:04 +0000
Received: from DM6NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::db) by DM5PR21CA0024.outlook.office365.com
 (2603:10b6:3:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.4 via Frontend
 Transport; Mon, 18 May 2020 10:14:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT007.mail.protection.outlook.com (10.13.178.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Mon, 18 May 2020 10:14:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04IADtgs020992
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 May 2020 06:14:02 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 18 May 2020 12:12:46 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 May 2020 12:12:46 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04IACk2X030559;
        Mon, 18 May 2020 12:12:46 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04IACbwd030453;
        Mon, 18 May 2020 12:12:37 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <kurahul@cadence.com>, <jpawar@cadence.com>,
        <Thinh.Nguyen@synopsys.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: gadget: Fix issue with config_ep_by_speed function.
Date:   Mon, 18 May 2020 12:08:45 +0200
Message-ID: <20200518100844.28293-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(36092001)(46966005)(47076004)(82740400003)(82310400002)(81166007)(356005)(36906005)(107886003)(54906003)(8676002)(316002)(70206006)(42186006)(70586007)(1076003)(110136005)(6666004)(8936002)(478600001)(186003)(2616005)(26005)(2906002)(426003)(4326008)(336012)(5660300002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57263b70-2691-420a-de6b-08d7fb143155
X-MS-TrafficTypeDiagnostic: DM6PR07MB5066:
X-Microsoft-Antispam-PRVS: <DM6PR07MB50664050C260195289D5EB52DDB80@DM6PR07MB5066.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCJbcRlJgPON4+Gk9vWJKaHURryoeFDenAfvHw+mOWcUHR0hjED9Vag0CqzqztTA79uJGrxUwmYAOESrtQAsdrm6PZUxQMnUNLv6VBnUCU2PSlLQ3y1ZbmxUyrHyD2j7pCy3dm5dJgZXXXL1bG3PDb7kn6LKaNGzkvtxIHYTgTsk0bfQiKBTt+omn9KX3+ZXt/jATiuqIV6LKQUU0fFISBsxcv0Lbl4abgU2r6dq2Hv9+WKmDAN3H4RHrrIGxJlCCbIc5AQJg/QkZaGKCfFPdZmXhF72WhrHyVU/NR5TJa4iKsBepMKXF00SKHc52+unzp/HYraPtJj/5mXysSPv8Ngc7jy1cIFYmTlsoXvP2tB4vH0SOnkJMyG5xkBr961MX8slnNmi0P7BJ5QNNG33hGl81KPw/BWyfRMjsDKaXKY2EtOzmwgq2fN8oeAnEp4tHNBcrwrESPHzHW0FaGKpPmsiCv52hvFULALs5XuteScIQzetO99SiTd0i/dp9f07tiV9FwWxxQ/MjErf/uHp4kJ4Q/LZdn+osnErojSoAiY=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 10:14:04.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57263b70-2691-420a-de6b-08d7fb143155
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5066
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_03:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 cotscore=-2147483648 impostorscore=0
 mlxlogscore=993 phishscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new config_ep_by_speed_and_alt function which
extends the config_ep_by_speed about alt parameter.
This additional parameter allows to find proper usb_ss_ep_comp_descriptor.

Problem has appeared during testing f_tcm (BOT/UAS) driver function.

f_tcm function for SS use array of headers for both  BOT/UAS alternate
setting:

static struct usb_descriptor_header *uasp_ss_function_desc[] = {
        (struct usb_descriptor_header *) &bot_intf_desc,
        (struct usb_descriptor_header *) &uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_ss_bo_desc,
        (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,

        (struct usb_descriptor_header *) &uasp_intf_desc,
        (struct usb_descriptor_header *) &uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_bo_desc,
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
and others are associated with UAS.

During handling UAS alternate setting f_tcm driver invokes
config_ep_by_speed and this function sets incorrect companion endpoint
descriptor in usb_ep object.

Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
case set ep->comp_desc to uasp_ss_bi_desc.

This is due to the fact that it searches endpoint based on endpoint
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
Changelog:
v2
- redefine config_ep_by_speed() instead removing it.
- remove changes from f_tcm.c file.

 drivers/usb/gadget/composite.c | 78 ++++++++++++++++++++++++++--------
 include/linux/usb/composite.h  |  3 ++
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 3b4f67000315..858a71fbcd13 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -96,40 +96,43 @@ function_descriptors(struct usb_function *f,
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
+	     iter_desc; iter_desc = next_desc(iter_desc + 1, desc_type))
 
 /**
- * config_ep_by_speed() - configures the given endpoint
+ * config_ep_by_speed_and_alt() - configures the given endpoint
  * according to gadget speed.
  * @g: pointer to the gadget
  * @f: usb function
  * @_ep: the endpoint to configure
+ * @alt: alternate setting number
  *
  * Return: error code, 0 on success
  *
@@ -142,11 +145,13 @@ next_ep_desc(struct usb_descriptor_header **t)
  * Note: the supplied function should hold all the descriptors
  * for supported speeds
  */
-int config_ep_by_speed(struct usb_gadget *g,
-			struct usb_function *f,
-			struct usb_ep *_ep)
+int config_ep_by_speed_and_alt(struct usb_gadget *g,
+				struct usb_function *f,
+				struct usb_ep *_ep,
+				u8 alt)
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
@@ -237,6 +255,32 @@ int config_ep_by_speed(struct usb_gadget *g,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(config_ep_by_speed_and_alt);
+
+/**
+ * config_ep_by_speed() - configures the given endpoint
+ * according to gadget speed.
+ * @g: pointer to the gadget
+ * @f: usb function
+ * @_ep: the endpoint to configure
+ *
+ * Return: error code, 0 on success
+ *
+ * This function chooses the right descriptors for a given
+ * endpoint according to gadget speed and saves it in the
+ * endpoint desc field. If the endpoint already has a descriptor
+ * assigned to it - overwrites it with currently corresponding
+ * descriptor. The endpoint maxpacket field is updated according
+ * to the chosen descriptor.
+ * Note: the supplied function should hold all the descriptors
+ * for supported speeds
+ */
+int config_ep_by_speed(struct usb_gadget *g,
+			struct usb_function *f,
+			struct usb_ep *_ep)
+{
+	return config_ep_by_speed_and_alt(g, f, _ep, 0);
+}
 EXPORT_SYMBOL_GPL(config_ep_by_speed);
 
 /**
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 8675e145ea8b..2040696d75b6 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -249,6 +249,9 @@ int usb_function_activate(struct usb_function *);
 
 int usb_interface_id(struct usb_configuration *, struct usb_function *);
 
+int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
+				struct usb_ep *_ep, u8 alt);
+
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
 
-- 
2.17.1

