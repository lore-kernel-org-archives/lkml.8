Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296F8C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6DD20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="phsdt6tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCXKD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:03:28 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:28673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbgCXKD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXL567Yr/keS7/3gQLxdf0Jk8pGFTsyRlTj8ej36Luqz2O4qcynb6TgQKbGIEhPnGlBy/WhnmsShF0Iegz43zUJ3/WQACrZhumhMVYYSweL1a1bY5EHdkjv2KK6GnS7NUB3dHSxU0LqrNnePDGGzV/ERPCxNi5DaR8uh9D3Ge4f25DZ5hL9uMjgnNRLe5obpS1shx3TOmwMWBr2Xo0OCVqLJQmZdX++f1Nd4Zk++UUys62ALyfBLxXaRn3U5r1ldW+R2G17eLM9sU+LzgmjvdDjr4yBFWldQCIuUN9Rn9SZrbJQlx5bf7/5IyRZkOxfGaKhcR+KyvCmphTc2MDFj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuO8IivCQlPjR/s0qI+xVFMzQNpMXrnAmCVmzXoLJPw=;
 b=Rl/CravGpjKkalGg5cDPtl3NEA+oi58qELJzDhArVsl0+0ya+d27pwralfR0k1gLb/Bk0LNiaSl4Va8K7QAUPcMQow1xD/xuTk2pWR4tmWqKJlY2jwIXW1z18jeQHKR6fZQUXH1roR0XfqufOLp3Sdl8BC6u1d4RM7GtqJ7gOAmbsgvzd+SosBgfBj18C7MD2q/SWBM8Xcu2XARiG6GEXBk0J3XkWmTmhoDWKh81NnaicVt3vZo9U+KljPY4lCLqTP+G2RHAcMBAaZxw8LbtWNsdYEqFKrAF34hzQQ0eSdK96EP58ujW5CTRP0dHhWnsfKpGD6pAgr6DBB0HufmvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuO8IivCQlPjR/s0qI+xVFMzQNpMXrnAmCVmzXoLJPw=;
 b=phsdt6tngVVDJ1+6L2wNvXWnO6cgFFp+q8uc9aXEkYj4CtP3WG4uEUbooDRA36sKIzqBMdmtZHEcQ9UToXgodBk7UNSbxyQfay3uFb+ZndWDTqjBs0v9uuvVK2ARQAcrk3KX59ojhi2d91IRitQuat4BELTiCmd+HxOp/aWtUeg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4903.eurprd08.prod.outlook.com (10.255.78.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Tue, 24 Mar 2020 10:03:25 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 10:03:25 +0000
Date:   Tue, 24 Mar 2020 10:03:23 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6656: remove unneeded variable: ret
Message-ID: <20200324100323.GB7693@jiffies>
References: <20200324064545.1832227-1-jbwyatt4@gmail.com>
 <20200324064545.1832227-2-jbwyatt4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324064545.1832227-2-jbwyatt4@gmail.com>
X-ClientProxiedBy: CWLP265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::26) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (54.37.17.75) by CWLP265CA0278.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 10:03:25 +0000
X-Originating-IP: [54.37.17.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 137de9bf-3e9d-401f-1b0e-08d7cfda97e0
X-MS-TrafficTypeDiagnostic: DBBPR08MB4903:
X-Microsoft-Antispam-PRVS: <DBBPR08MB49031A57317C3C953CF05121B3F10@DBBPR08MB4903.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39830400003)(66556008)(66476007)(53546011)(66946007)(33716001)(9576002)(1076003)(33656002)(9686003)(4744005)(5660300002)(55016002)(2906002)(44832011)(956004)(508600001)(26005)(8936002)(186003)(81166006)(81156014)(8676002)(7416002)(6916009)(16526019)(54906003)(316002)(4326008)(86362001)(52116002)(6496006)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4903;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9/ZtjxGUvbkXl9ykYE2Sq4X92CrpAT4zIv0DYKJz/hf+aR328O7fScGUntfAiXgZCTbizsiUMzBddKJO5qdH+PO3ov//VWikhKupVJYHrm1Q2GECdFwjL4RXMs8zROLeCCCE/5+UYB0Q02mwizlT2v/zHqh0M7+4aPTPevR7Nx/KVWD7V3NfIumIEJlvGCXga9XY3S7kFPI/LROHV1g2Of5NcM9cOeVhoin5L5TbwdQ2uNW6rpMQXXctkWMRLWmb8N/9wItUUBBFqRp8tzeGNjkQW8PeiGJ4XZwegsC0GJ/8SxH6ZECMVD3mB6bUpIOWNIvdXuVth8syZf7RkMEV7t07mNg8YHD1DWBiiODFn/CC7ZZ0l8u8hkrzJst6lGDEkBYRAPPnBrS6cPV0gDyYkS7jPfJdWrPtOP0h4U0YTteKJs+pGmEjdZAlzk6tu+D
X-MS-Exchange-AntiSpam-MessageData: s7/1nt5+DX/OWO1oUmPTJ2wMwA0uoDX0z7Y2oubNFBcRXyFungZpfDckDViuR8GtH5Tf6k6dWbe9pSUHBbU27cATpFBqZciyRhw8DcFozgNEo9XbrgD6wOAR67ImukK5lVLqs02KdTi/2yuxVfe6wA==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 137de9bf-3e9d-401f-1b0e-08d7cfda97e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:03:25.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9DR1fMR85MFCQN54oLzAjDXpRE8zn8O64SKQSxzIYuSCDinVkp+rIT25guvKXAFcldHLBZyS37RiXX/TYkPf+WRo0sybK3nTrEM9n0hvsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 23:45:44, John B. Wyatt IV wrote:
>  	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);

This function, and all the functions called in vnt_radio_power_on() returns
a value, why don't you catch it and act accordingly (forward error code
for example) instead of silencing it?

Thanks,
Quentin
