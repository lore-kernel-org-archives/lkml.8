Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A38C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E8620828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="fa7m2cQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIJcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:32:15 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:28414
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgCIJcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:32:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc8cdFowd53YM9/JBxMGwC1oZUh67cAwfkuQtGjdotbTjCKw2Ve7qCYCIwyV7kwlZVwdgkwF76/hKTeVUCE85NE0U7qhYT9howKhjGHinTiEZz7uoy/rxG3VTYfrLccpfbsTHb2RIPayhI4XOIOY+lXbzH7uKyYVXVYREYvqvfHP/rJAJVQLuIe1GrJVOeyNSo7FTUx8oppBBZSGPRu+OyXentUOGMBHn+cwtaVls/DDEVMN71QV25fWbB4wzu8wEtZD+AZYPAM2ld+ztcC4vVmwyGYhqL+SzqBdW0JDwlK52CWwRBf5o3huWW0U2TecY/r32O817A+ZKmwcc5t7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSPrmTZOdIdd4o1kwyRCEMvht6/xVEaoyjDV8IEajck=;
 b=JGbuFBCb+7/k5OqTQ1zREt1CS7gDJZME5WOxXv6kNBFjoz94kNLQ7y3F1JtxXd8eTng14qPhrRWgL2IfomHqBtegUs3AsqtTNXNSvSIy531nWLm0DpGPlZ1tgNQqbXZrDBNvp50wJoJNVTyYQqdb1MiwjXVT7uuH0gUuxfepIlRQSmhiVe0CKSn3cV0vwOqzvt14KwE6oRowxmG9tFKCaVWe8ZVWzGoQUXzYirlFyG7xFi5q+WoYOCutvkPWLyTSGP4SZyD2rOe0+4d+D4LXZTyM05roUJUlCjHwgkwBLWngYOLS+z+Xf0fZSRAWQtyvW7veJNnODRvvxMmKqeruRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSPrmTZOdIdd4o1kwyRCEMvht6/xVEaoyjDV8IEajck=;
 b=fa7m2cQoomvzDXp1OU2LBPu0E3CL8BEEQne+ag3BJS5IFHOVwjSmHJiCSoiv4TJewbs89GMELYcnVwOfEVfGULpaq7/oI9qi9QgfLLvJiH4IJcXASaGaLR0v5iXitUx8JnaJ+whnGyLHJ8MBisNkw8XEJSz67h52NuWvBXP4/a4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4506.eurprd08.prod.outlook.com (20.179.44.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 09:32:12 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 09:32:12 +0000
Date:   Mon, 9 Mar 2020 09:32:10 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200309093210.GA7693@qd-ubuntu>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
 <20200301131701.GA7487@ubuntu>
 <20200301150913.GA1470815@kroah.com>
 <20200307082906.GA2948@ubuntu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307082906.GA2948@ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CWLP123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:59::34) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from qd-ubuntu (89.21.227.133) by CWLP123CA0070.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 09:32:11 +0000
X-Originating-IP: [89.21.227.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559c506b-33cb-4f69-e4eb-08d7c40cbedd
X-MS-TrafficTypeDiagnostic: DBBPR08MB4506:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4506C1236EE912552B6DC354B3FE0@DBBPR08MB4506.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39830400003)(366004)(199004)(189003)(86362001)(8936002)(6916009)(1076003)(508600001)(8676002)(33656002)(81166006)(81156014)(4744005)(316002)(186003)(16526019)(6496006)(52116002)(54906003)(9686003)(33716001)(4326008)(956004)(26005)(5660300002)(55016002)(2906002)(66946007)(44832011)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4506;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocRmDrFFo1zxPpJ9+Dme4V8zt8HBbdUzFWvulCN120LQ0aCJMsjTJLSaKP9ucC75mFvOEkiJoYfc+rPbglsbePSdmrPWujxBgDASxGMBLyqszGXz0YHg1nAmkl2b9dCm+6B4/mmo0/dGB2D3Tal5Hwg1Vsu3+q+X5WT5CnWsIrUv4qTZD0+mZTlsyCVmAZ7KFwByME8ANygkElNHJgnC5X/OmBkQjDVUdCVt7mRYKWbKf93/JvXYeZtigHFRPniElGw2wVyaSCJKk1y3z98ggRlPO7EJFkucQZ2JdfCVZg+Rzxe0HMuGnWDfwR/YvsY++OA9lj/9+7VGswgdKUcBO+5lbtT3D1vGJWDVWnG28wyTQBR0u/sCsYZdtYBSn8fPUVYhhKL3wQ6lnmkkD+WhUPwLAT88rCFEEsuDkGOkOSQQ1zQAsxf47tAlbZstDLJm
X-MS-Exchange-AntiSpam-MessageData: Dg8J0JjfJl1DLteZRRWlGbj10cwmQjBXtJHqmlC5KVBRWxw0192BQdouc+OxXObvfwo7lMC5NaqTxYZgryeEMX30l3f6do/YQnSLpEg9XOM+LApCCozRDr082r74OeVlBx4Wt1MMEw9mwMXQj3JfiQ==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 559c506b-33cb-4f69-e4eb-08d7c40cbedd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 09:32:11.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKdmATgMgX5UXXly/mKB958A8Ic8ORAJPc4JGe+PNgwN8dP06LRngV891OW6WrQsW3huDf5pyVMydOwWj7l7WQHGCfoa56GHZMcWt8gCG5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 09:29:06AM +0100, Oscar Carter wrote:
> On Sun, Mar 01, 2020 at 04:09:13PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Mar 01, 2020 at 02:17:01PM +0100, Oscar Carter wrote:
> > This is a USB driver, performance is always limited to the hardware, not
> > the CPU location of variables.
> 
> Thank you for the explanation.
> 
> >
> > Please always benchmark things to see if it actually makes sense to make
> > changes like this, before proposing them.
> 
> I'm sorry.
> 

I've been removed from CC list on Greg's answer, so I haven't seen the
explanation earlier and reviewed the patch the next day. I should have
know better, won't happen again.

Thank you,
Quentin
