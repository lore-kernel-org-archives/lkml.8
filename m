Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D682250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LXZOiEqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgHETrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:47:00 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:26093
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbgHETqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN6/6B1UDsH7fVO+semPJxoX8ToHvOwFPQmYl1CQgBowDY8fKbf2o7Y84BJ25DH5kZK2zkGySljp2KjEe2MJosvgJnVYNed2XMM30G/nqmPyAd9kl5XRomVioJebZl4YpLmyD7U5d9qz7K6Ucvs1u8zQPJJCdom/g4rHSmse0pCKax08p6Wtu4xr2WBfZNml+y/nLauxo6qCF9QUvk0b7K1cFR+17qsJy1DXzTT1t9AQimN+xvulYjGR35dHbDEp3LkiC7tIA1tTRyuD/chjF9j3CaYrEawYZcTO8i5ks5soU/D4Tk5gJ2EQd++s+qdV03EOf6hkCSwihDVuz7//Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFJb9UCep43LjVcDKc+feTvLzxUGMsY8oZdIOjetmeU=;
 b=K7gTxPg1Y5W6S4EqPLZPdONqbCVZfl9fLa1629AcYxx01MplzGdCggWSJ18v3ACjmjlejTW3eadYIFGk6foTKtk7CdNL/qV8FH6WBVPngdziOoFRkEBqJWePTp6x5Y5QpIwzg6KmSRyYxMbMmpwpGSYiUwvcj2mn2hJBteZgeuzGEdQWrbuJKMSx6FeJvy1IpXYt+hlc/ek/kMckzRm4ii+xE6NPP0evdlKyGtGE3FBITu2LSI+sB/NYEFvz2/Zt21RPMN2MEaO6gD89wiZQ+npNSdrbm9pHLAiCBvnM32x3w/Y+GGvRhoLFd8LbIHA261Htsz1jb1qkY7rbE7+FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFJb9UCep43LjVcDKc+feTvLzxUGMsY8oZdIOjetmeU=;
 b=LXZOiEqKCMq4f/GahLdUKEqqMYJR0ACiu6f7I2Omo/hqkFk+905h3hvCYTSAWTS7Pdsx0YdWrQpxs/MwKRleuboTnVT7pjksd2Cvv4uwN4GSiNB6fuZoCOGt+Ugl4Nv30ua6NQhBhC0zpO/i/RgGlvqFq1l6J9WXNjBoQBul5hk=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6256.eurprd05.prod.outlook.com (2603:10a6:803:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 19:46:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::10b0:e5f1:adab:799a]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::10b0:e5f1:adab:799a%4]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 19:46:50 +0000
Date:   Wed, 5 Aug 2020 16:46:46 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Eli Cohen <eli@mellanox.com>, "mst@redhat.com" <mst@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805194646.GJ19097@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
 <20200805090304-mutt-send-email-mst@kernel.org>
 <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20 via Frontend Transport; Wed, 5 Aug 2020 19:46:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1k3PN8-003w83-Lt; Wed, 05 Aug 2020 16:46:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b058fdc-5b5d-4581-5778-08d839784bd6
X-MS-TrafficTypeDiagnostic: VI1PR05MB6256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB625692BF03E4715AEBC467BFCF4B0@VI1PR05MB6256.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8BMykAlpUHCKeKWNMa7mNdxeVyYUjxaYKAWIWZYogSiuqTY49/XdU/TKxt0sLjhK42ZjCffboLwP6IzDgJJuPvyfAdHwpKbdGO1GtRRjeU5fsiFwaMFxhV7lRUQAtITZKR9EgtKt/HGZB8Qk44L/mVfBLGAuBkIGFlwg/G8ScTUGYJ1Pxj8RV5QoOKD/zk3nWEYujpZPhTX/W5kmxhhWiZNRj19Ejf5xHblDlMs5OrGGhekQrmluDcNAthl8HVco/cPu5i8+JOrMHdV2wDNCD6oF1vCuAsg+xgHZM98UpDimPVddcfOEWKjvT45pvjfNpgiTUDi1iIqcUG1hfWQrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(5660300002)(2616005)(6636002)(66946007)(1076003)(426003)(66556008)(66476007)(86362001)(4326008)(6862004)(36756003)(33656002)(478600001)(186003)(316002)(107886003)(26005)(54906003)(8936002)(8676002)(37006003)(9786002)(9746002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XOOU3hwUKCXrC1hGxN6x2X1Ohcz9wHa4tIAcGxNf/7Lg7KKmWs0TUirUSo/eNdLbAASHZ3bNQPYt64qU1xbq76pgF0ULsZg91/eLaWNVBrYpVoFJUkdDzme62JGYLEsI67tjJuyy5VIdFfqMYNsAuxFS6I/0PRSTOkEK6cTz+RjcuclQCoT3DBBPowQb5e2TjfAdMV8XuQYBYX+x3ee6ZpHchQeVhH+31c8tV3hiVHTxM+v39B9QBLZ/tYHcTxTyKDdP3aalDfjs2h6kD9Hl/xGpXXSct6evpA5rLy8Igh734TMj6uQExcaQ1hXDtORdLVZsNeX1lzElK0gxtrGUjO5JOM0GHfs4D5HO7IFuMT3gWwveuSPmmgSxapO7TP2nQ+WXhfSCIOuQsLcFu3fU+U129MCmkU5A4MXlHiY6xqYJyyD5cXfJb9DXewcFfZhRk1BOZxsx1V7ytUfmVG9TVOkDAOZq646C23lKlN/B2aR6xOAQgSOl0Ho0CUTp8R3uMfi2Np913YDDLg5cUyd+W6S2rg2voOjr9zuN3eedbFDXT+kUKVQnBoIRYgfxV8S2Q1inWPyssWKOPa9b+V54l48ErMdpDTFKqTwWmER3JFMcn67FZaEl/4kvJbY5Ea05H1OB0UTIE1MqsQ2Bhf7ijw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b058fdc-5b5d-4581-5778-08d839784bd6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 19:46:50.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izUh0R9Z8BtEDwBE7VVuLE0QKHj6eXq+65Jhh3RRCSvaZGTijil0OMCEP0r+tq5wF5SXZRiFIUFbMOqTvUjslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 07:01:52PM +0000, Saeed Mahameed wrote:
> On Wed, 2020-08-05 at 09:12 -0400, Michael S. Tsirkin wrote:
> > On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> > > On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > > > Did you merge this?:
> > > > > git pull
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.gi
> > > > > t mlx5-next
> > > > 
> > > > I can only merge this tree if no one else will. Linus does not
> > > > like getting same patches through two trees.

This is not quite the case

Linus does not like multiple *copies* of the same patches. The same
actual git commits can be OK.

Linus also does not like unnecessarily cross linking trees, mlx5-next
is designed to be small enough and approved enough that it is not
controversial.

Linus really doesn't like it when people jams stuff together in rc7 or
the weeks of the merge window. He wants to see stuff be in linux-next
for at least a bit. So it may be too late regardless.

> We do this all the time with net-next and rdma,
> mlx5-next is a very small branch based on a very early rc that includes
> mlx5 shared stuff between rdma and net-next, and now virtio as well.

Yes, going on two years now? Been working well

Jason
