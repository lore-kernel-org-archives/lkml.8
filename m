Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35490C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219B52067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="guUfJT3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgHDFdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:33:18 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:42467
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbgHDFdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:33:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDp5U0lW5LMschi8DLzexhaQqXI3nC4Pf+k+GjqYswnhcz8xYosJ17oau3wRdGBZ2yGNMqIBxRP5NY7Y19gcs1tZi/m4PruaS9ueEkS/gzq9QZjoyOnkgmho2juljS7PxVcSOHK4SHdOpvKmy3fNv5AjH1Rcl7pPr+NSfBeqB7U/r/YRIlUagudEMoz9iPyUujwuoU7yASGeTPFg2PkoT3cRdJSUERvQc3077uRKzFbWU2aldi8n3OY/2/fD3R2DWIXwL0QqulWVvkIXYToab62SQz7WC7in5NwCV5s4LOpyf0fcUN7Q/CNNsyw9Swb4upaVe7qNoMxXmbBJU4UTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iMDfcs1DS+6Brmuj6ATX4qE6qJ/jBVrdfCYSRcML6k=;
 b=XPTdYhpWjto1cm3DZzHcec4GSn8iR+8bxc6SLXS5FQZGO4hh0ivx0xKWh2DiJeFozftAmwj7U+R8cDRbquH1mDItzXmpUb8Qrwl1yedFQpJaFc2Nn5R309h8Wf+eaR/wt2f1AK/3sZB3sb3bkGDtEgfVBilPDOQ4aWyG2yBTqALf+QA2B743CBNYxdy2YLItHnWa5dtQQR6oXDKepmSt7zEyt6lNv+uM3Fa9qozePUCNjAeL6WLRkyGRsAJNUri6TgMu3izNzye4FhZx696LYQ++XYhISNC3DaK/vJWdwJeOMZTi0gyGDrPQcAHX6+E6w3Qf4M0uZALdWdNI5mRXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iMDfcs1DS+6Brmuj6ATX4qE6qJ/jBVrdfCYSRcML6k=;
 b=guUfJT3x1D1VWhMVtAMhbv68uYsbOzbBp7YxrJ9Y0MChF6rit0+/2SFqEfqoPxR/LmhnkXeO6c9TRoRoEhneBTAGzoqQcFyXzWW7nHW0JR/ZlTRbU8oBJPjP1lDVIg4H3AKJpXQw5Uwdb8ExOhwfCEgly1QnIpVzXkjJAp3adQs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB5715.eurprd05.prod.outlook.com (2603:10a6:208:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 05:33:13 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 05:33:13 +0000
Date:   Tue, 4 Aug 2020 08:33:10 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200804053310.GA58580@mtl-vdi-166.wap.labs.mlnx>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
 <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
 <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
 <20200803163235-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803163235-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR03CA0103.eurprd03.prod.outlook.com
 (2603:10a6:208:69::44) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR03CA0103.eurprd03.prod.outlook.com (2603:10a6:208:69::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 05:33:12 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f3a1bb-5faa-4a9a-ee19-08d83837e1bb
X-MS-TrafficTypeDiagnostic: AM0PR05MB5715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB57156CE11AF06C2E183B5D83C54A0@AM0PR05MB5715.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC/LDZWkjzz1eO5dddeVdOvsAojIRlfdrb+MtzW6UWr+ynuI+uDlvOCE0j8bnctrt8pb1J+3MM29yZ82ibE0BJfERAuUylp6BODpIpQ5kh4g7rI5Rn6vUcff9D4tnnmbyEVRHilyoeE9r8nCfE7s/guMkFwEH594wIgNvyHdeC0RH3z/Q0Xyea0pU2ycuPH9FunHytdWmTp0s4hUny0O8beEy9shQHTrmcqnX6pRMg5G5EUy2nb2pcQ460XsSnkr9VHCDLc09H2plh4rRAW3zg5FxclEy0ZGRlC7KX6goZ+vKXK0KIQyFGNMDgBigx2PfgXgPoNLhv1qXvxx9uLoTK6o2YmyY4SCJXwiRBePFYileC49p5gtA0VkOXc5FpchRKJUlYZ8amplnVa9brOzLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(66946007)(6506007)(478600001)(4326008)(8936002)(86362001)(107886003)(316002)(52116002)(7696005)(186003)(956004)(26005)(16526019)(1076003)(2906002)(6916009)(66476007)(66556008)(33656002)(5660300002)(966005)(8676002)(55016002)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jMmRvbYLDbqhk985jxB4XZ09pOmxB5SaC5ifrIRRKk938+imbnV7Zxtvchiz5cutJ2ufLk5ILyzXc24NmfyynQTBRakq3ZsTyyeFT/QWBARrGz2o+0fA/Dlcp1xCU+ysCDMz1ujkIHALJGY146Z9cAkatKxZH8NkapQ2aIBkQgJ1r3JpSiL349uG0kHWLLRLY2KdFggv7p5bOXTm9r9qyxjZeKfPpoHxrRPHEE80U2NwfUskMhoW56MBPHjiwcImqg3W0n7965puvs5ZxUYs1BNUL8c2sOXTRSSbe+jb2SgdJTnRP7n09Aai/fCLEOqaCl0tm8aZVyfSdzT4WHcQpgfyfjGivq5G1Pa3ysvaJQLZSeOlsUo6yw0rS9b9zaA0zC4QCPStGO5OPmNsVyk7RvstcDynhJ8mXOZC9X2+8l8MSe+zly7zDb/z/McsTKrWi0JykXOcPqO/QGQ3TDm+uluXDKM1lN4mFLzxdnz01cS2SU2HgFxDG8Vysw5yAQbyLE1sWxltDwe2o95p5C4vTnsfVE2ulK/H2bGWre9KHWSfk1S0AJIGHn/gK/aH/ycUJXOQP2Y4Avap1gWdUIxQsowWukmQEO2I/vLhlHqRbfBoweRnl7buP8uSfFtu5yULJJalXKEW2GaXFM9AyUUowQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f3a1bb-5faa-4a9a-ee19-08d83837e1bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 05:33:13.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j0+MFLX7uZv1ErAtDpXvpvTXvtPDpV6JP+MYavUcEWFa5eWnEe8DRZoGChG3i7lgeOOzngyLDWI9JWtgABtrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:34:50PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 29, 2020 at 08:54:52AM +0300, Eli Cohen wrote:
> > On Tue, Jul 28, 2020 at 02:53:34PM +0800, Jason Wang wrote:
> > > 
> > > Just notice Michael's vhost branch can not compile due to this commit:
> > > 
> > > commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
> > > Author: Michael S. Tsirkin <mst@redhat.com>
> > > Date:   Mon Jul 27 10:51:55 2020 -0400
> > > 
> > >     vdpa: make sure set_features in invoked for legacy
> > > 
> > > Let's wait for Michael to clarify the correct branch to use then.
> > >
> > 
> > Michael, are you going to send a path to a git tree that I can rebase my
> > series on top of it, or maybe you can just take my v3 and apply them on
> > the right tree? If you do, you can take Jason's patches from the series
> > he posted here https://lkml.org/lkml/2020/7/1/301 and take my 0003-0010
> > patches.
> > 
> > Let me know.
> 
> It's a bit too hard to figure out how to put these pieces together, when
> I tried I run into some conflicts, and given I can't test them I'd
> rather you did this.  Please also note kbuild test bot reported a build
> failure on mips.
> 
> A good tree to base your work on is the linux-next branch
> in https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 

ok, will do and send v4
