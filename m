Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B736C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B18322B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="SJ6JFGTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgHEUMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHEQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:34 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02on0631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe05::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAAC00869A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cak5xyR3KUMq43XbA2vlAEAfgBgsAh7WuCQ4KnaY7k3DJ9J/0kwqFfboTD8XmqaLIeoOHVgWqctiVA6+e2UQdUXsgmXR9Dke9cn9V710sfL9tzedBNQRfCpOE/rK940SgXkqkMhcZVEZjxGMVuLVP+tya4k3FrfPEnpOSQ4Xi6Tj8UV8Fobt/Mfrez1ZgwEnv7D6KWXImwdXSHVklCG6nw+JR3qGrJM5ZaXpTUyAFM8N8AfD5OMkefg0q+8R3oI+bF+Dh0E/fDGef0d36RXzsN9SneMJyIq80mG43ELbP5ktKzqJjc/dHdZAlvYSuqMzE2Furo/O0oBP5fjH1HsNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbZP+klGJ2QwpyaOEcuajI61mtvAop+EzZBGa2ZnRlc=;
 b=TYUfhPODFVsOmNhXAbC2OgJ5u50Ve+5woGyU6y2qAlFiMZ1lujHWx61EBXxf4C47UnZD+kmIGpVUgAWPOQngpM92LLsQP9nj9SdO7K+vTGbzRJ+cIox8urr3UDDuLJsv1K633MNHPbp8ggtOgrd0u40Pgz0sR0W95aRIwhqtSS8zsnxhfy/rQkoQX6s8Avsqc56aV80fzL3dA3X2Cj4L7ln6RLUX50WsZefs3/qCr6F6DD2KiglOWo0Dx7Ev4lfM/rPRQ7rJgww/6uMv47jcbe8QCxURHI50ewV+IKFfZVIr5iCUK7ZEPsRiUB13ZM3ESoPLnQ1irC3DtvsWFq1dMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbZP+klGJ2QwpyaOEcuajI61mtvAop+EzZBGa2ZnRlc=;
 b=SJ6JFGTG0dkaWmds0u3f3Y3a8vPYYyFMWYg4IEITeRKJsMCiRhm/0KUPgF14uNf/QlsexfAoDR96UCYBealk+iw9rkCe2ZU9A9HVfFtOEIZUxkA4vjK+Xj5x/jP5Z7vWcnwquqa7ygYBR9OE9KflWfGUgIDVGyFnjk8uLTseNk0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR05MB3378.eurprd05.prod.outlook.com (2603:10a6:205:d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.27; Wed, 5 Aug
 2020 13:02:02 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 13:02:02 +0000
Date:   Wed, 5 Aug 2020 16:01:58 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805084604-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 13:02:01 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae1b5536-bff4-4835-6153-08d8393fbee4
X-MS-TrafficTypeDiagnostic: AM4PR05MB3378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR05MB3378A541A55CCF0BFC50857AC54B0@AM4PR05MB3378.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+vrnMm4HfSsl4L9vE7MhQj7Zn+zEshr4q/LIt3jGVuGSqwx8+8P76a560a93H8cbpmPZDZ4aUU623fScRyX2ENZBLHs2r30ALje3lPBQXhsbWNac8qIcxPmRu3EfNjvlHnPdAcCPGYageXosX7Yho+Lf7REbjdVh4hWStxGSJ8t9YbRe9xO/KHfDtrHGP9lvzlXZOQ/0FkXz4ij56Ry6StH1VDIBAopzmqqWyZX4B9QJfPsBN1uwI3WWWZ+8MEu+BFiSsTAmYM/cR46z/pnvM7fiFwTi6LWloIYFEx1tVT2XWX9aTnrPVCQBK3+Fy6yPdYUrHsbQtH3PJS7oC57Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(6666004)(186003)(1076003)(66946007)(6506007)(478600001)(16526019)(26005)(956004)(4744005)(5660300002)(66476007)(6916009)(9686003)(316002)(55016002)(66556008)(2906002)(8936002)(4326008)(107886003)(7696005)(52116002)(8676002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Wxea2JcINurQ34DVXSkUBJGLfcmji/2NN2drk63spz/pnskcnURJOMkWvIjXh8OD+4ORIfrk1LuCkrnskAthoTW2FGRW4hnfc8uMSNW8eNaa7kCI82FlcUV8EAkXTcJl7lhSHxDRmZ3rPnrUIeymYlJSzjw8PudpOMid8KP+BQoy80rDCsxMd3JqRPD3YXuYUZnY3fB0eBYRFD2W9CO2CY3cqiIw4Bm9it3S5wpjQxvXrnouYzQxWuElgqpqnSQxwWUODZNhwvUpJWBDQ7fcs1pBt8WTRkEzfW9PoWAWIkLd/nkEmzr7ikXhfMK2pv0kvwyD3er61lbajyE80WrwlSAFd8sRKRJhPx92Tpb/wRAdo3zG4Q2G/mBz5a71Xa1hiXliCS2puEqVvlYfA8Xa36cEUKe61FAySTOb9cfpF/MU7sL3B9GWH3kjSJ+dKSt6bbl756ShXkObyxs05OaX8KegbFj9eITyy8yzH2mLg9NGHuIYhXIxK/ZkYpSsAn5X
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b5536-bff4-4835-6153-08d8393fbee4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 13:02:02.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNAS/eUgtJ6Z4RuC4/NEVS2QYkJHnFj5PFqn+WgueVDSsW6Rq8uoO3UdW8EywiUMF6lXzYTHfrhHFda9p4Q17Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > 
> > Did you merge this?:
> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
> 
> 
> I can only merge this tree if no one else will. Linus does not like
> getting same patches through two trees.
> 
> Is this the case? Is mlx5-next going to be merged through
> my tree in this cycle?
> 

Saeed Mahameed from Mellanox (located in California) usuaally sends out
net patches. So he's supposed to send that to Dave Miller.

I think Saeed should answer this. Let's wait a few more hours till he
wakes up.
