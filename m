Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4018E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="cfuMKh85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgAPNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:23:37 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:20458 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgAPNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:23:35 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GDL9Qr017160;
        Thu, 16 Jan 2020 08:23:08 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xhb7tett0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 08:23:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQOJBDqUq12s1+brHzDfx1J36jXFKre9G+ilJa+9KMADXqanR3OdBVo3S7Fy5UDF9EECoWbExyMEQcWsS5jmj0r1VaCHXDBiEtSQhyjZYMDmFe26eBK6fziW2b4AR/M4Xv9gM3hTdBX1LojQ++TZcYFE1Un4W6ApHVuqjHyyuWC7HJ/3nOPj/48sO1gHkslvPavrInZb6MphgaEZXIK8YU6n6w/yJKBepw3pNtgoGcUukZz3bEx0sX92AtrvwQbTjgcySlV1hUQVNgIEiozvTQclYLfSTVgabm0oNFP0uLiIJZzQ7nt41gbXNzvBa+a0XpB/7I7y4a/icYX75QsZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1A0TVV0RinjTXYSceoz6tha2RJHcz9JsjpvTTIugtc=;
 b=BTwclKMiX4WEcai2BYX5vQW2YU/AITst9Kz0XDru55F1hWPBIo3x1kY59fICGdcKvcH3Tt9o4/Vu0wyuy0OennIsZru1dwMQOYzbIRKQZ1Uv1qy9VuCIA8ura6GzFlyFMp2odSAz4yx2RvGhGMyYEZXTlwUdiMghfZtN0CM82+lu+wG3hcr2lmGjIWxkt2rKHTBDjINdPMjbXQWnWg9X6PMTdJiZmj9sKOGlCJ9wuF1pntpoTidFtVOoxeztq4Km80XyVkpRW8ZSiiZ/fAIch6T75bJ0KOA9x1EFLfwlQF+Fb40UGFQFgHF4vNOeNkAAJ5S3d3IS4uaNi3pmoebw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1A0TVV0RinjTXYSceoz6tha2RJHcz9JsjpvTTIugtc=;
 b=cfuMKh85Fcv4MxQu40HAuVRBcV1twBPtpGEtccAHN/GsvIJeaGJ1pcRdEQuqsXwrhu9UGmIdYVGJyCGwzZXpVIcsLojwMMzECh+Jghn6yXIwAFuyKAsaNdZCSZ37ryEOTiGSZGYTGsu5ZtCE725eenx6hJN3FDse4+UfB7gm/Js=
Received: from BN3PR03CA0064.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::24) by DM6PR03MB4842.namprd03.prod.outlook.com
 (2603:10b6:5:182::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 13:23:07 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN3PR03CA0064.outlook.office365.com
 (2a01:111:e400:7a4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 13:23:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Thu, 16 Jan 2020 13:23:06 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00GDMrNZ023184
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:22:53 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Jan
 2020 08:23:03 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jan 2020 05:23:02 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00GDMx8g025341;
        Thu, 16 Jan 2020 08:22:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <bigeasy@linutronix.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Olbrich <m.olbrich@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RESEND] usb: dwc3: gadget: Handle dequeuing of non queued URB gracefully
Date:   Thu, 16 Jan 2020 15:24:59 +0200
Message-ID: <20200116132459.22383-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106144553.16956-1-alexandru.ardelean@analog.com>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(2906002)(336012)(7636002)(1076003)(54906003)(5660300002)(7696005)(86362001)(44832011)(356004)(26005)(246002)(36756003)(70586007)(186003)(478600001)(8676002)(110136005)(107886003)(966005)(70206006)(316002)(8936002)(4326008)(2616005)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4842;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2d6f25-706c-4f3d-7cae-08d79a8738f0
X-MS-TrafficTypeDiagnostic: DM6PR03MB4842:
X-Microsoft-Antispam-PRVS: <DM6PR03MB48421F81AD87DC874684AB17F9360@DM6PR03MB4842.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sB0oHqINzvy+AWw97n3O0KD2ZfNOzKfNu+ZWRuaMKwQTSTAgdyLw9dDKLpP++uHGeqvt3sF9VFn4v71iqlN6mxCvhnmsPWSMx5dBFj0F6TJiORSf4Am2SsQ1/WuapdwEn/CCqnx5fLwEhMMK4gmOSUo1+QvS37eLQtgeS0P/zO96pByk2/nwzyAvkP9R9Js7m+MV/xPEOyLa+C3Hxvs02RR/Gpzq/pGcFugg5wuXYHelebryeeozZxEqKf3dFMQNTpKdl5+3p6ImhXY3TJL9FLnnd7V81RrbBjXSBnbpl1cLf0DrnkK+7Adsz6GI7WpdNy3BYa0zfaBeqzceEVxdmFYU3PKwcoN4UQBIMMpQ8S+spwnp3d35yJbKzwnYEBck+XBLCXIooQV06BTSOi4AlI0s2+4hWo/i0CX+3vttYZUJiAVFGSM46SCbMrHt8u9I8k9mludBQszz3r6wHN1NrpqnGxJRp+LUrffsZl9fSz0+duBopi/m6CDPWR/tAeoO5HZOnVCA2G8HIPGFAYygw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 13:23:06.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2d6f25-706c-4f3d-7cae-08d79a8738f0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4842
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=862 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Trying to dequeue and URB that is currently not queued should be a no-op
and be handled gracefully.

Use the list field of the URB to indicate whether it is queued or not by
setting it to the empty list when it is not queued.

Handling this gracefully allows for race condition free synchronization
between the complete callback being called to to a completed transfer and
trying to call usb_ep_dequeue() at the same time.

Tested-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

* Added Michael Olbrich's Tested-by tag
  https://lore.kernel.org/linux-usb/20191112144108.GA1859@pengutronix.de/

 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1b8014ab0b25..22a78eb41a5b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -177,7 +177,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 {
 	struct dwc3			*dwc = dep->dwc;
 
-	list_del(&req->list);
+	list_del_init(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
 
@@ -847,6 +847,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->epnum	= dep->number;
 	req->dep	= dep;
 	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
+	INIT_LIST_HEAD(&req->list);
 
 	trace_dwc3_alloc_request(req);
 
@@ -1549,6 +1550,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Not queued, nothing to do */
+	if (list_empty(&req->list))
+		goto out0;
+
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req)
 			break;
-- 
2.20.1

