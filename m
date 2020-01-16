Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333FC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE382077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BBIu5639"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgAPN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:27:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12668 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgAPN10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:27:26 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GDJtY7029100;
        Thu, 16 Jan 2020 08:27:03 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xf93b5tcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 08:27:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa8DUu1kpcJwSvv8hI7VV3bbxPAY4Lpdh8fLQYnDYD+yUrfAsEYSBg6NHuVhKACUi3ei7m/wgg6pjKlY1h5vzANG9XIgasMtuGbYvHv5Pe3fnK4/MFP1btdU0HPDSsDk5nH9maXzraC3NBY1yuWLJoEQ9xJgwAUIfG5JBqwx8jCGh6LA+ZfEETS73yjIEC56c0WXpGZAwBf2xMdC9mWifdJT+IibJXjkcdyjQzkyfpIC6RDEUO+40/HQay1lHB4PKYkoysh5q+cWg/DhFQOcrGbQ/6G2zFr/rLwoKImBR+Wo6HY9uxekgLYN5fJxHKgE8tRgbNCsQ7OtbeiVXkvA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyvDkhNXSLxCEC8HItp+oVoHF2xwXjPjAkMzntP12DY=;
 b=S18PWJv5cBxtb8WWmiO2I8IlgqgONAQ3GFeYZb5BhmKlj/rxdkxOVlERhlBZV2RK1qDxZQ6yqhWJYKSEF9Vqb2SEhyzAk00W4nNtbmeDCLI66ytDcuEQXZqbH+a5BYJz7DOBW9fP5rwJX4g0MgtvxCtR8Kn1/YfZcOL3MmyVoESX5ZITiwcAjXUe9mTgMN1vLVYRJn/rh4HF+5QHco8lMCabbMBnq65f37Z3sErpy709+jphSJ7/u4ljQv2YDOf/BiL+wthJCyeRsGerIiLnfMwZN/XGlpG1uilWGVgyeYTKZzy9CPqYGkrPlZZD2kRL+3q5VYhQwKNB0jwEafRmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyvDkhNXSLxCEC8HItp+oVoHF2xwXjPjAkMzntP12DY=;
 b=BBIu5639471bUoMqWwqXXvlCt23CzNA4OhMx/C++IUCo9fwUxbsut4cr/fp5Esv4A2g9RY2jCVZAUIPAheTVj08JXluJrZ/x+kNb5u9NVI6jVEwvIWj/wmTtn6NGzTJsoIUlQ7I3h/TEh9X9ccvoq4uABktz48OV2zF/EeCvitE=
Received: from MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27)
 by BN7PR03MB4449.namprd03.prod.outlook.com (2603:10b6:408:3f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 13:27:02 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MN2PR03CA0022.outlook.office365.com
 (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 13:27:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Thu, 16 Jan 2020 13:27:01 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00GDQmJE023526
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:26:48 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 05:26:59 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jan 2020 05:26:59 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00GDQu00025603;
        Thu, 16 Jan 2020 08:26:56 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mina86@mina86.com>, <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RESEND] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags
Date:   Thu, 16 Jan 2020 15:29:01 +0200
Message-ID: <20200116132901.23977-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106120219.15028-1-alexandru.ardelean@analog.com>
References: <20191106120219.15028-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(2906002)(44832011)(7696005)(8936002)(1076003)(7636002)(478600001)(426003)(5660300002)(4326008)(8676002)(246002)(336012)(6666004)(356004)(36756003)(107886003)(316002)(54906003)(110136005)(70206006)(86362001)(70586007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4449;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e47387-f5f7-4e8b-c631-08d79a87c530
X-MS-TrafficTypeDiagnostic: BN7PR03MB4449:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4449271F266BA7831A8DB84DF9360@BN7PR03MB4449.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zxyy0BO6zD3b4pI3YHoCBtUlgcHmyWyR5hIFzE2KtDNvixcjCM0hpmiKv/zIcC/hme7Qpmlkm8yf9AHt7IQMOfYnaHoVmddaXcTbevAi3XaIBz+PcoXQccARrVP6Hs7zzVvABNy2+wKJexiOMkgVFoRoC117ZD/ij5XiJStg6cWNdaH8IYTAnNqJy4aTD3V94mkU+6Pi9sD6KaYaQF/QO2Cf3pIyF2hAS7vki+3CtmuJca2buCA0lD7F2iAVciyMJHSRi8w9potpAX/ZBbEOzlVELwzhkG/PpTesNIxo4+gHnd8WxbEE/uUHITj+Zl/0yNJYzcEVyWw1YHjI8kPioXbo8C4FVYHcNm84FmR5nUbXkS/oo1jQoTpj1s7jrJhz1wCt+ZbX7TQ1vSATihZfghR2fSoDRUW+4uI19mzd+TloetHJaGPnNAa1M39+FOug
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 13:27:01.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e47387-f5f7-4e8b-c631-08d79a87c530
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4449
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=525 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

ffs_aio_cancel() can be called from both interrupt and thread context. Make
sure that the current IRQ state is saved and restored by using
spin_{un,}lock_irq{save,restore}().

Otherwise undefined behavior might occur.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/usb/gadget/function/f_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6f8b67e61771..bdac92d3a8d0 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1162,18 +1162,19 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
+	unsigned long flags;
 	int value;
 
 	ENTER();
 
-	spin_lock_irq(&epfile->ffs->eps_lock);
+	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
 
 	if (likely(io_data && io_data->ep && io_data->req))
 		value = usb_ep_dequeue(io_data->ep, io_data->req);
 	else
 		value = -EINVAL;
 
-	spin_unlock_irq(&epfile->ffs->eps_lock);
+	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
 
 	return value;
 }
-- 
2.20.1

