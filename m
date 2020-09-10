Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27DA20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X/D5P5DZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X/D5P5DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIJQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:52:09 -0400
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:35296
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgIJQtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHYHQKqTOoC0bGCtmRTv3gN6h25ebC3MSPuGdcGTq0=;
 b=X/D5P5DZ3vR3eREMFjFCylkBDD/K4FBmXcR+jwmHtKcXjULc4tm52M/ZEWG6Ea0xhGNcnJR8ky9WRVKyprAo6OocznnYJM5tbB8jzF3px8mdPDTnUJDDBJcOt4QVAuSCYvcBrXT7nUycoa6flhHWnbzkJQG7CeuWru46Kefdq1M=
Received: from AM6PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:20b:2e::25)
 by DB7PR08MB3083.eurprd08.prod.outlook.com (2603:10a6:5:28::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 16:49:47 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::7b) by AM6PR05CA0012.outlook.office365.com
 (2603:10a6:20b:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 16:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 16:49:47 +0000
Received: ("Tessian outbound 34b830c8a0ef:v64"); Thu, 10 Sep 2020 16:49:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 379644be06000920
X-CR-MTA-TID: 64aa7808
Received: from 16b4bb85e215.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 454E48A3-3DD7-4AE6-A9D2-A0DA0495BF4A.1;
        Thu, 10 Sep 2020 16:49:41 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16b4bb85e215.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Sep 2020 16:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONszJCMTGX3PHmxZjAdCaT7z1lQ4Cdp613yT6g5+tduGE//1lY56wbT05dqDNS2eIMJ9jjXLIz4d2YJ/yJEax64PCZDF4Qbxd2FSsTzow4WZZ5FxGXhoTcwT4eGmHG62ju+SHhZmJi3mBjSPaTdCSm6JkUbJbcP5o9SK57TU4EpTgnEHrmr70JHQOs1cIGlcWoch4KUpE8tk/jFQmRy7CyM34eefqT4LqsCU+CjevtSfdv9uskF6vUop2UYTSk3GDpfP7ISErcGH+PUzwhpt5Gxw8LpnNUKw7Zdrrnz5TbjiVuZegq4JzVCYPs8gLBhuZ0ulF6NDl3u46AezDf5wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHYHQKqTOoC0bGCtmRTv3gN6h25ebC3MSPuGdcGTq0=;
 b=MYtcjscglkPmU9Pcj6A+ffTM64e1Vp5aTKqvPLJDHcKSL09jgIUiPBTZFd9g9DyE2/KsPVqql+XmeXdx1opumJFElyKRcIFrfgr+N2RiyA2NI5n+9pcB8wfb0aeh6+B6Vp7SJjpj7RWDKU1qU9bY4EgMaFss40YMWuKLwa9CFkXVjvAh2FV4KGTNqXazUJxsryQ7nMZBlS4/jNEh76NJl+TOR13tGAIvg3CyrvQDji23ntoOIyu8SK1SrhJGkvpiL9Ev808SN4UxHEJ3pPIMW9JJ34iBz8omps1krlFTG6g5ain1ryVocOXK74PRIxhBnMzo9fWubthkMe0DbEljZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHYHQKqTOoC0bGCtmRTv3gN6h25ebC3MSPuGdcGTq0=;
 b=X/D5P5DZ3vR3eREMFjFCylkBDD/K4FBmXcR+jwmHtKcXjULc4tm52M/ZEWG6Ea0xhGNcnJR8ky9WRVKyprAo6OocznnYJM5tbB8jzF3px8mdPDTnUJDDBJcOt4QVAuSCYvcBrXT7nUycoa6flhHWnbzkJQG7CeuWru46Kefdq1M=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15)
 by DBAPR08MB5831.eurprd08.prod.outlook.com (2603:10a6:10:1a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 16:49:39 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::2d77:cba8:3fc8:3d4f]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::2d77:cba8:3fc8:3d4f%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 16:49:39 +0000
Subject: Re: [PATCH 1/1] of: properties of reserved-memory nodes
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nd <nd@arm.com>
References: <20200910162020.3927-1-xypron.glpk@gmx.de>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <c163b528-cf26-7733-c4c6-471bfd84cc43@arm.com>
Date:   Thu, 10 Sep 2020 17:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200910162020.3927-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::14) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.178] (188.30.219.21) by LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 16:49:38 +0000
X-Originating-IP: [188.30.219.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25912823-ba07-4ae1-3f67-08d855a986cf
X-MS-TrafficTypeDiagnostic: DBAPR08MB5831:|DB7PR08MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3083FA4F16AD6EA860A26EBA95270@DB7PR08MB3083.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cvElFkCIjmNv8QITjx55im6P5u6rQq8YFMKcB1AFHr3a8YsVcvF1eV9l4djUpkZItDUs9nsOGlmDzj1Joak1rNMbopHagQYDOSBLYt5t6gPatzyHdx4PIz8FL1KqznyNbT/aewpZZ0zd81UFPjR2+OfoLTCtdhp65yl5b26p7PDnC0+oymmtGZCHZKLAPAhHMrWUsL6iDYGksxQYCHoxgNJnhA/EK3AghyeimFNtINK40UcFSZS6t/xQBntIUmmkmWF/RIXtTwiQOllpEZMNXd/YdDLz7ay3y51Uwxc3b0Cl/SHzvCQR3YXGRs9uqgCV40tsynen06pojW63HQy2UUoNDt5oIpO6r8sZgbvBm4tMsvGeuN8xaBxj7fdYtX7h
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(956004)(44832011)(5660300002)(186003)(2906002)(6486002)(26005)(16576012)(54906003)(6666004)(110136005)(31686004)(478600001)(55236004)(16526019)(53546011)(4326008)(66946007)(86362001)(31696002)(66476007)(36756003)(316002)(6636002)(8676002)(8936002)(66556008)(52116002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jhAc7H138/wqXP/+ls6ur5EvaEYyQn4/qSxsd7vy1K+POO101TGyAGiSYFVKWruudmzRQm7HNVUL22wdMGpkSjCpu/tQ1IYlnTPzysKcIPH4boO+4Dx7+BwH6ov4+sI8JKIolYDC4F2Pd6HA5KsZ62PjZxd6IzhMkWtIuvvtTf9sJoSKK8xLx9z8WKFr9bVYA4LDPHSPTT8hJfCq3Q+l047yk1agEYa11eR0zy7GbM8ZJTxesIReeKTPD1C9KFq73jbL/ggWwfJrb9z2xW8cSMCy/+TXUrR2QM+MsYCf2PVOQn+4CM1vplunMP/BKKwRB1KKFevOTkYV4SgOKOXRr7rbT6MHoXcE5oJcv0URiCSNHZRlUreJRz45evFSfmmtydUUvvPPPt3p0NKJirqOnqQjkaPd57fbLC+t0WoyWYWid2X1lMu5bOvQ++bWEE91Z1AUtd1Zt0CAGASM7MwsBTkgd32kSVL7lqjQwx4UfRpT2QJwgdHW44ZbJ9tqQSku9lnGoqS75DBgXX/oH5SU2ayD4zK1PXi0lN8ZYndzFgT4XSkyyuB60LH/P1UuMxVYh9d+5cr7GW/CqzTBOI9iy59Zl7FxXyC2xUzFI0X4WpjJMCOnxHbotTrj4AexIKiOhFlF7WBAJg4ywZHq2MgMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5831
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e1e63051-941b-49ab-a960-08d855a98206
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSE95wQYu4TmraNUyz+uQeQjK5bAQrIcpC9mgglMGOSaf9uMkguldpSBubqTZ/uSxdfpPKQeqFPyj6d7QlCFWE4QmoBK7GESemNzfqKpxYRSoGpZPyxuuDbFT0LdH4itBbhWTwYsnCYuXXfMLJF7ArO5IcPxQjPjlLa78Y1PVxMnzxBirpgzjfzSMd/UPUd9SKFPVKpXjJQut461iKo0VkAFV5oTb1wu2KL4Im7p/tDFSlo+ge9pHz965Ha4BHA5JaxY1QXbA8OVLl8Ybmmamblzu9yVJ2afifqHAPts5MSCSWycgTFOrEFBCW7DMAPdTH4ZG0xSPfphXhRL6+uBDpPvesh2RygDK5RUqfTHJn5gOL1AA496cJ0LpgiPvmDv7T+dfUSDHmN3R3RG4qFYv+Oa8Z+zJdXPOjhq66i26HzIdG/Vcg5ll/Yt5wLSlGeY
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(36756003)(53546011)(2906002)(44832011)(70206006)(70586007)(82310400003)(4326008)(336012)(31696002)(356005)(55236004)(82740400003)(81166007)(47076004)(36906005)(110136005)(86362001)(478600001)(8676002)(316002)(54906003)(16576012)(6486002)(6666004)(450100002)(8936002)(26005)(186003)(16526019)(6636002)(956004)(31686004)(5660300002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 16:49:47.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25912823-ba07-4ae1-3f67-08d855a986cf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2020 17:20, Heinrich Schuchardt wrote:
> The reusable and the no-map property are mutually exclusive.
> Clarify this in the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Acked-by: Grant Likely <grant.likely@arm.com>

> ---
>   .../devicetree/bindings/reserved-memory/reserved-memory.txt    | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index bac4afa3b197..eb987203548f 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -64,6 +64,9 @@ reusable (optional) - empty property
>         system can use that region to store volatile or cached data that
>         can be otherwise regenerated or migrated elsewhere.
> 
> +A node must not carry both the no-map and the reusable property as these are
> +logically contradictory.
> +
>   Linux implementation note:
>   - If a "linux,cma-default" property is present, then Linux will use the
>     region for the default pool of the contiguous memory allocator.
> --
> 2.28.0
> 
