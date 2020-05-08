Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02334218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TJJ9hJOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEHTEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:04:50 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:35550
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbgEHTEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIHbrEiFZbJiRfBRUdaw/5y/+CuScIu+l3rZzkvfsrRvGxrfqWS63o5LgKz90tr/ZKSCyxrSou0D26zBmjoKvcOZcHdFXj79F/mO8zJ18ZPOUxuPqh1UzMX9cKrmF9dR+tV+rYhbmaHgqg4KEYDTq+qyYznsaWhTRBa66OXVgLChLleFjMCONY6rpwZmQcVBlFF+90RZ2z80ZVhwk2jT8nZr58hfm9KCXuZaNK8tSI6l6QAUrrPET2dF2WJDU9TUbDdxnIortm+PcTHsBogEXf+UyXM7iCugfujXe1lIX4r13LmstDRj9a2u+xvbuooQ8rnBlbsu62pFBl4jSXLzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG7W9bO/kUmTaCGU67eRg9hjRJJDalEbM2nghpSaQHY=;
 b=SgtVnBvWTf9p8k0JgykR5p31s+Kd8NjLyHfTNUgWXi/kGW4tlqSefLxHHs7af9/buXR8dQbDc9AQ1ZJJ7tQBsAXGaQrdnBK745j0XaK2w+b4XgBjzh7vnOVf8odEhKGUJDOEejxQ//p6QHuwzvmnsLv6l37HBaBkWUGGXyGWaOwXGsv06gM5FVe+zn32mTxsUvod+f79Z54xW7k4WdC0bAdSVBT7Lik6GNsEvA54wJ2dPIUjTFxGFBt0578WYHevAwrvWw0/oaSYMs4C+EFFlKxnx+cgojKy5Os62+26PyZyWNNzg250jl0AvuEgNR0yqbhAOgrnKTxuXIwHMRlJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG7W9bO/kUmTaCGU67eRg9hjRJJDalEbM2nghpSaQHY=;
 b=TJJ9hJOuXdzCJzmq2pLmv3cdIJM6lAJ/B/aKW7TkyJZKHr7KKaqPoZLeqm6ZJayFqroZ1Yh/f6bwso1h8e2ukMAuE8EHuxMyZukzDyRIUT1QmE9wTlpYcbmhTXB7FthFXt2U6dRrBjn5xU96ZOyyqmoAKQmO768ML2f3qoBSQCo=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6718.eurprd05.prod.outlook.com (2603:10a6:800:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 8 May
 2020 19:04:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2979.030; Fri, 8 May 2020
 19:04:42 +0000
Date:   Fri, 8 May 2020 16:04:39 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nouveau: fix dependencies for DEVICE_PRIVATE
Message-ID: <20200508190439.GK19158@mellanox.com>
References: <20200508144017.3501418-1-arnd@arndb.de>
 <20200508144017.3501418-2-arnd@arndb.de>
 <20200508150041.GI19158@mellanox.com>
 <CAK8P3a1vCx=XibDdoDqG9obpCFx0JCibAvcKFh6E7_NR_hJ03A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1vCx=XibDdoDqG9obpCFx0JCibAvcKFh6E7_NR_hJ03A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:208:120::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:208:120::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Fri, 8 May 2020 19:04:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jX8IZ-0001df-11; Fri, 08 May 2020 16:04:39 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 405a62f3-67d8-46dc-f801-08d7f382aa3e
X-MS-TrafficTypeDiagnostic: VI1PR05MB6718:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6718A1A63C6D72A6B09635E7CFA20@VI1PR05MB6718.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPTBPTI+jehoswQ5d0x5l9XgTPSa2giUxPfTXNsoht0VUPxicn0KmUBYoiwLJVS0ZQPUpwXMOlcDdYvpMgLURdFXfARnnqa8vFrjde+SI4Wbo2e5V9tOM+/voXKEUMwao3kSJ4m3oz8CibFEyw5txZxtmvIy8JZ5iICxtYpA86vWJhteeMpr8W+5OHFSEb+aZ3b5mcGA2QqLTV3fI2VTjETfmTIh1E+QKgZSzn+ScBUu4E2R54N4uVOAhxwCfrRqNHMmwt36kMAkmszOetMZDA15EacoCnkj5s//KC0tKVHCRrwO6BhyT5TTk/+gw/k9MvcS1CdgBZtb9Kdik0Li6EBqvklFk4tTH9bPF+pKe31kc3RZTPqUoVwSKw4MAs9QuAJ9CYJY1MFpknVf2ZGxARmjmHC/CPtiGLVENw3YToexCWqwqS/auW7NQf8XdkOxCtPKeGSxw5QLXCuot/PQOt7h+WXa5UnKBzWF2wf52y72JzAxbdqs3v2d6/ZBacE3ozLRf9qvtc+FInAChENgy72+mvANGAUZpet/J7+Ds0bB+Ht5paXo+M01MYF32UAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(33430700001)(83290400001)(5660300002)(83280400001)(83300400001)(83320400001)(4326008)(2906002)(66946007)(4744005)(186003)(316002)(66476007)(1076003)(66556008)(8936002)(7416002)(33440700001)(53546011)(54906003)(36756003)(8676002)(83310400001)(2616005)(26005)(52116002)(478600001)(9746002)(33656002)(9786002)(6916009)(86362001)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bR1h/maGrb3Y/oSmgYmQnxQLmSnuNshtIOAxZhqV8S+0ADKqx7kfoKjWGTxrYnrGPhje2yCLHguXks7cqpwftJDQd0y8HkNmnnZbjn9uoI7NVSViQ+mGqbPxGlwMyNSnM+pOTFz1qywhcGXXRLy21xVK7qtHZlbVhjU1R/D6kWFNsWPsUreNfNvWHM4ugHzU/1HGM/6H4/mQWA2cbdRReu2D3Fu0054m9MrbrHxbmVUL/hJoyKDa26hI1CQ7Hfc6c13xdjndrzSwfnBBz3S9V/QuDeWKBTUEqs/98J9JjsBPo2IDViMuNC2b0B8PUViiP53NiDGCXEAv25S+LAMYjqQU3gcXucLtxXXpeBbB6uIncvXOpxcZeSz88ekbYl+tTUM1t6IPEaQC5fvYk/n002Jm/kxySoiNtmFtPudvE6mdUR4OGvbuyDTPsISy9ZmeP9o4NgL2tPI1lwWEh+9LZfSXtARDqnrU1xGuM4MaoePIK51C2FIsC3oWh0P9QQq6
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405a62f3-67d8-46dc-f801-08d7f382aa3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 19:04:42.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XtYNMvIR233NlHKc2dfdTbX0AWqn8NaRp6SJYgim4W/yKUtqMHVFRTHQCcD4VwX1nIRwiLP2uGP55GeKLcg1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:05:03PM +0200, Arnd Bergmann wrote:
> On Fri, May 8, 2020 at 5:00 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Fri, May 08, 2020 at 04:40:09PM +0200, Arnd Bergmann wrote:
> > > CONFIG_DEVICE_PRIVATE cannot be selected in configurations
> > > without ZONE_DEVICE:
> >
> > It is kind of unfortunate to lift dependencies from DEVICE_PRIVATE
> > into the users, is this really how kconfig is supposed to work or is
> > something else wrong here?
> 
> Usually the problem is trying to use 'select' for something that can
> be done with 'depends on'. I have actually no idea what
> CONFIG_DEVICE_PRIVATE does, as it lacks a help text
> and is a rather generic term.

It is a sub mode of ZONE_DEVICE, ie DEVICE_PRIVATE turns on a certain
kind of ZONE_DEVICE page.

Both ZONE_DEVICE and DEVICE_PRIVATE are APIs families drivers use,
there is no reason for a user to select either of these directly.

Jason
