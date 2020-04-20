Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD1C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E892080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TyxsOAJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDTLTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:19:39 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:6239
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTLTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpTqzReGsrWq0ueTRRTVDznP2htgLrJ7d0SymgY2GCKk+OIzFPCe29U+D+zVsXhLOJ+wqFWiNC3EMvNPNyoxWpGTS4ZoJKUN/fIeiXAwsnlTVmorHVaAgJEdGrKZ1OkPVIUGSMVHCiybVTV8rXW7NT7RjPU7qzdpNsy3uSbHubhZs+mRHeHOqFN6CKinkZTxBE4HGpquR2alfQ4hfWycAHHEyawP84G7Y6d8m5Y+a/rBccsuvtnhQ7mOXW9qkNFrpMjhAHdseaOZQIkKRfeSV037tAwB/VegIYhpFPafGJd5JTgN4yOjYWjIjoqFX2jTTzwkSKtXSrMkKHj0660qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYWk0cpHz7smOILVxDaYOxgIFHwwnNEwpcogfh7ncWY=;
 b=CIcm7pry9VTqzSZzrwmJAaEzPKVIzD1GMj1WGV6J5zjG7XHuGLsy/uokEpHW3BBFR3cc/k5ZyTUhGr4UHwB248IiT0T88ltA9SQ6E3ldOMx9d0cKFP2eF88hm7eb6zb8sNQGFNuqKP6jg9JkjLDiVgq7C0CU3gHnDOPkXnJkA4pmGFjGTdOLeTgUHVO1uJXpTCtQlXbyLN0/cXaKiYaZQvYItz365LJcFQ/gyVnbp43fh33prC8R/nkKjTC3GqshBpGCTxWGdz1jSfwS9KYzT2AvGFqA/z/RZpU+K8Gg9x6bxFTlIEJKVbhE439ts0od2/nB7bVQJyfSXIhVrMEUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=sai.msu.ru smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYWk0cpHz7smOILVxDaYOxgIFHwwnNEwpcogfh7ncWY=;
 b=TyxsOAJRd7WxYuMHi9aCZvEzU62Aw7PzeqaJUAmgNRNF/hsZJ44IyLgjZeGBw5nI/F0SAirWoaplaneZVX9QT3u5pM9tbgvXimE9XjAIerMqQaObVZXCTqyhZa5T3CxauTk/ARk7+botutw6aHqWFLU+mN91ay/BD0+Pj77no88=
Received: from BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40) by
 BN6PR02MB2851.namprd02.prod.outlook.com (2603:10b6:404:fd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Mon, 20 Apr 2020 11:19:34 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::30) by BL0PR01CA0027.outlook.office365.com
 (2603:10b6:208:71::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 11:19:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; sai.msu.ru; dkim=none (message not signed)
 header.d=none;sai.msu.ru; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:19:33
 +0000
Received: from [149.199.38.66] (port=41210 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQURe-0006mn-TC; Mon, 20 Apr 2020 04:18:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQUSa-00013Z-Lu; Mon, 20 Apr 2020 04:19:32 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03KBJLCw028821;
        Mon, 20 Apr 2020 04:19:21 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jQUSP-00011f-37; Mon, 20 Apr 2020 04:19:21 -0700
Subject: Re: [PATCH] ARM: dts: zynq: Fix ethernet PHY for v5 schematics
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     matwey.kornilov@gmail.com, Anton Gerasimov <tossel@gmail.com>
References: <20200420110715.12032-1-matwey@sai.msu.ru>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <752db40d-5aed-4a97-a050-bc1376547f87@xilinx.com>
Date:   Mon, 20 Apr 2020 13:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420110715.12032-1-matwey@sai.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(478600001)(26005)(966005)(82740400003)(31696002)(47076004)(70586007)(36756003)(81166007)(70206006)(2616005)(5660300002)(44832011)(4744005)(426003)(6666004)(31686004)(110136005)(316002)(4326008)(336012)(186003)(8936002)(8676002)(2906002)(356005)(81156014)(9786002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c69064-6935-4039-634b-08d7e51cb392
X-MS-TrafficTypeDiagnostic: BN6PR02MB2851:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2851873131BCF2C600E8BDB9C6D40@BN6PR02MB2851.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzZBPXvTjxKVz5sz8IJXhBct73nysfK3pthfWNlpDWpvdm4Ibrux0TLTzf8hobVrpWsa0uHI4wfONI7SOhBxNaSaaWGmPxWve+quOdtUZi5rC3tZ938684JaG728eiA4BGGKHkz7RPNeal2OKP7agOpEyGb361Jb6Zd90aYRWyrmwIq4ycwEOMQ9CC5vDB68fkOZfUkFlU/0y2p0LhADV9Z7X7xHHstiZOgXOTdTqHPkrl9osalAqlDMfiHIV1giUivGbxSC/fNP42usdyj+c5frLnGCqsbY6CnwrUdNXWNTXVU8adYDWrzTWC5Q8y8ShLyMYoNVJ92aZ+W0h9i0jp0kt559ZEWTKc6Wj9Izyzoi+vdTAn84S8SnyqsfpG7Dcp8nvzImafyI6R/5NZtZVWIlmqQlO0Qh41VybVOMqsM6KHsUm8iUE9kFbY65+bskwy679OFC+VOMb2zfGJYdY+ehGDUgidqUmM9ui53ltjw/YeQnO6EDokOD2n6alC2rEuT1ugjiEyHtl4zYyhxueZPfj+Yh9TVFuQX1yh3qkwnUbY9luJiDOo2qKZrl/86YWg6pRyZ817GlUUnMzC6bnw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:19:33.0664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c69064-6935-4039-634b-08d7e51cb392
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 04. 20 13:07, Matwey V. Kornilov wrote:
> There are at least two different versions existing for MYIR Zturn:
> 
>  * v4 schematics has Atheros AR8035 PHY at 0b000
>      http://www.myirtech.com/download/Zynq7000/Z-TURNBOARD_schematic.pdf
>  * v5 schematics has Micrel KSZ9031 PHY at 0b011
>      v5 schematics available at DVD disk supplied with the board
> 
> Specify both PHYs to make ethernet interface working for any board
> revision. This commit relies on of_mdiobus_register() behaviour.

typo - behavior.

I think it will be very useful to describe that current behavior.
Also would be good to test it on v4.

Thanks,
Michal
