Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0DC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32482080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WLKbq/8n";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AxEtURSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgAJJq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:46:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23578 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgAJJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:46:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A9h26a003745;
        Fri, 10 Jan 2020 01:45:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=dnhh0blQRHTvfNCUjaAoV2H6e3IlXLK1HA+6hxMEDEE=;
 b=WLKbq/8n1Czt6qu2vp8ZILJdL5fUiLYId3J1mQnag6v1VXSOwNidiLmYnVXs69cU2H3R
 MaQpDGQJ8qj/1xI6XYgStSh/dPwevS1YAvVpwr7JyRFRfyKFxPsus+pdy1yK+Qlya0IL
 hOK1IsvW1o2srWdEmtVV66nqhn3WNOyhOeNYAAH79mT6SPZRRJUXX27zKKLeIgq/oNuw
 PM7nGd2AoVph3nKnvfiejWorSU1IYHk6VJfjUMuj3fartUyqKmqwWXBayRE8MLUQXIib
 Sxz7LtF+PcDbKmE52IktUKC3Sg3bMk0Kl3fypppDAs9d4JdgHiMpoI5Sr9SF7cGG/UTI IA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xar524vvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 01:45:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeH7SGbhI9YJ2Uvb/UtPjvMfnPVbOM5Dj4VRyrnH33uVMB4lJmew548B0W8MI53c1OCUG9EV4VilYllIDtYRMMdVp2pkDNyY3/kYDoCS7YvuVctfQ81t5mPkZazdmH9UfPzrEoOuwkwuNR53eb3S7hu5gc+oaDnRNDDAGtfa2zSuLY7DY2JTc4D0lR5XWCpkUx2Kem8DaP0d5zvv45H+t5rL5geuMBY9z/at1mWyFJOCkJgVV0/RUEzV1ix2A+g9rVv3cK3EPSH3iquNmKyHixmd+ZjsoSjPNFZ/bKhOT5UTfya4cKJzKG8iFIoBCS/wUF70ePegKbqstdOtwE9WdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnhh0blQRHTvfNCUjaAoV2H6e3IlXLK1HA+6hxMEDEE=;
 b=XGnVKv+5ecfu6E96v1nfpZ26AQELDKitJnxPaDp6AguFyxO3v00VvNFc67y+lIYbLBpDxM0Xl0ubgKMgiLg6kYTt2isOmfNu2vF+P5/buH/BkkEz2Ab6iE4v4A3/SHS8jyw69s9Ur5l6p6qQRI2UiIPtDv96xthsMQItsjzkplcnmT8MSj2eqX56WcJSH2TCa3MoQw4UVHSYhn9daG9m6Ya+CeozywaWDlH4FtQi0JT90UnQXaFQoUtKfd8EAeGSeGT7roIQWhEbzckra1G+N/UMEd9TqyGwaVTMCg3qgF9tOGo1oWlLH30+bESjahH/EaBVkj/4/MFGIz+dHKqAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=infradead.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnhh0blQRHTvfNCUjaAoV2H6e3IlXLK1HA+6hxMEDEE=;
 b=AxEtURScr8BGxQL/YV00U9jIeZea6fQirafQJu9O9PE827PTM8OmCEiRkUo9McHo/AXxmT5sBa+LBGjJ8LhoXDu//PM4shrdDiuv4yrzLwEJOFEqh+jFwl1tl7p7/TOyFLRgv2pzi7GiPQxxbSW5cC+vqvVhv1gLpRJBsSbB+9Y=
Received: from CH2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:610:20::27)
 by BL0PR07MB4947.namprd07.prod.outlook.com (2603:10b6:208:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Fri, 10 Jan
 2020 09:45:53 +0000
Received: from DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::203) by CH2PR07CA0014.outlook.office365.com
 (2603:10b6:610:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Fri, 10 Jan 2020 09:45:53 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM6NAM12FT003.mail.protection.outlook.com (10.13.179.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 09:45:53 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 00A9jnMG167399
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 01:45:50 -0800
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 10 Jan 2020 01:45:48 -0800
Date:   Fri, 10 Jan 2020 10:45:20 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: rawnand: cadence: Change types of function
 parameters keeping DMA address
Message-ID: <20200110094519.GA23024@global.cadence.com>
References: <1575546963-436-1-git-send-email-piotrs@cadence.com>
 <20200109202003.44ec5102@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109202003.44ec5102@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(199004)(36092001)(189003)(8676002)(5660300002)(6916009)(81166006)(81156014)(316002)(86362001)(356004)(8936002)(4326008)(33656002)(4744005)(55016002)(16526019)(6666004)(70206006)(2906002)(54906003)(478600001)(1076003)(36906005)(336012)(426003)(70586007)(26005)(6286002)(186003)(956004)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4947;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5bd7ad-ea6b-4e4a-8ed7-08d795b1e231
X-MS-TrafficTypeDiagnostic: BL0PR07MB4947:
X-Microsoft-Antispam-PRVS: <BL0PR07MB4947A456901D7D2210B1CFE2DD380@BL0PR07MB4947.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02788FF38E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAdGWnjQeURudW4uQ/3KxokMwbSJL4wIezNkJQGQlVlVd6uiXmyJkw0dYvt8tUJ0oh/GdOIqvJFp4URySimdTdeXQ185wOODmRTU4xX59lMnOi4g7By2nSP5Y8GmFimx4QybvhhEIKqcKYAJor5TTEBug0Cv1NVql7JsQrRA7vgv34fHrUsHnRp6WY6BZXNvwpE7lUbQVPQh06+G++lvVBwL7Y4fyW/Yxu9yM0FW2vbxHwFgHqovumYRoD0XMxPDKn+y0wllvMm1MkNRUqGJqJZ2WLuFm/Nf28dt3cWe6uuT6DNeYMHQPiVZlpQz+9rWuJcPIBHfWRQGG4elT+EKsZPAG3/MrQpQnlMCh4Kdn+DiDsQImlf2yTubGMwUcW+tP+u8FCOyKrbDMPnOVgiOa69kaO+Mc6k+D5tlRn/gjQwODxkQYRxRzAjnRLUYEEvGPziolhr2zq20DC79SrJ44leblCU7LL7A7/0FUTeFt3+Drve/bsMIc0RSoG+bNkPm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 09:45:53.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5bd7ad-ea6b-4e4a-8ed7-08d795b1e231
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4947
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001100083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01/09/2020 20:20, Miquel Raynal wrote:

Hi Miquel

>
>Hi Piotr,
>
>Piotr Sroka <piotrs@cadence.com> wrote on Thu, 5 Dec 2019 12:55:58
>+0100:
>
>> It was changed to avoid compilation warnings during type casting.
>>
>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> ---
>
>I just realized that I received three patches for the same issue about
>a month ago, yours was totally valid but I choose to apply the one from
>someone not contributing a lot to encourage him, hope you don't mind :)
>
>Cheers,
>Miquèl
>

I don't mind :), most importantly it's fixed.

Thanks
Piotr


