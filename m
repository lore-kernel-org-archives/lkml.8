Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D4620792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Eq3vD3hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:56:06 -0400
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:55223
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgFLT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQLbC85plqmqo9wY3FWmk9V8rYQe6lNdDTX6ZCiC5xk5iQKjP7bQfv9jp3wrt/8htjLbxylkfR0xsPr5BYsjmz08hPnysWodO590TndOBmUF3Pmgbngg1Oog39k3w2DHNMUit3ETv1t0G9b3JtK1zGXrQ63gGQm0mOpwcqPjImH4yRDDffvOTlkILNdWsHr2z4zGtrDS7YtFTYfwBoYUicix1W01i9RQetNhlxOFXXEWbG6EVClOJ8zs3WCzvxSTvLwhEf0E+f5RY5JNEbIBgcxtf1xWS6mm2z1m/MY2yUgclApGBnUhVYAjpFrAwoojWhmIO3x9vVOU58Hw55r3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPzWPA2pGlBjHoarRzT1gV96y/tLFDZNwVWTSndmro=;
 b=nB8Xjp+X347z722R6sV1C2gTB6z45s+IRYeaxcmr2SNVknT4Opnfo/bAQvetXh2/lFGwv4xnwlnIMqWg5VFBAcG0HUE0vKpT3PxmVjj8IYHCl7L+0BtZsroTRhBfH8B9p4z3Cc9cMC+RCQk3XeMmYISBje/XFk+eZoHRravKS5iJv3yrxIYCJLc8IWJ9Eac142IM7T2a97rs1zMyT7iFUiudd1niucBcm3YQxphCKnzcSw+wrOlXh3qNNcC/YyKJV8kXnv0NvIBXg8QLTzUCJtI8CTHC9vx2Ss0l2xJCzwhVOep3FJ3S/4f1x8AHTdff4VPrmr0/dgiLLk2Ub/HJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPzWPA2pGlBjHoarRzT1gV96y/tLFDZNwVWTSndmro=;
 b=Eq3vD3hpfFLch+N9kOyg+mHHaxV4HvRIxoY4FUyWnUibtEgQ1rEF9JR8YmXt2+lvfdrQg9HlOWP2I007X7E9o7hlYM8DGnADn9kEY9vt/ERpUIQtbPrBQlih/ljQtRByZia0LgHUsuEB/z71w1WceVsgJppuN3wn+dOvcScwNkY=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5134.eurprd05.prod.outlook.com (2603:10a6:803:ad::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 19:55:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3088.023; Fri, 12 Jun 2020
 19:55:59 +0000
Date:   Fri, 12 Jun 2020 16:55:56 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
Message-ID: <20200612195556.GN65026@mellanox.com>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
 <20200612193524.GL8681@bombadil.infradead.org>
 <20200612194204.GM65026@mellanox.com>
 <266b26e6-5f6f-9178-948a-fcae20c16112@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266b26e6-5f6f-9178-948a-fcae20c16112@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Fri, 12 Jun 2020 19:55:59 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jjpmO-006mAu-9U; Fri, 12 Jun 2020 16:55:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a88762ee-d214-4ed2-c67d-08d80f0aa0e0
X-MS-TrafficTypeDiagnostic: VI1PR05MB5134:
X-Microsoft-Antispam-PRVS: <VI1PR05MB51341A1A1BB14DF7F9E0A78FCF810@VI1PR05MB5134.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFdKU5unx0XD1XX/IIu1A+scqtcrRn7peJrdE7NvPK6VFqtOb8uEqxTg1XDznYSxutBonG2XA3QoQMM9WufdHgXsOklYQ7Wbrr5QOrM0sQ7evll2c+r5JesImhlus4CagtvT1OFmWzbhIyBgNSCv8Z5ddtWl9H6t0ex2N6C8hj3elZlu1L+Y2Ur8SW9PWevbYViHvQxO+uSIFqseC3l2b4XXTWmgwfm0BM8ojnld4cFqHcUwxu1nxGz9gRgbVofKV3AX44T25+lSaDsXvmN1wxFXNXBfl1Na+Qot6YiM+le04VRHaiR4XEsproR+3urU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(316002)(4326008)(54906003)(66556008)(6916009)(478600001)(186003)(66476007)(26005)(53546011)(66946007)(83380400001)(9746002)(5660300002)(8676002)(9786002)(2906002)(1076003)(8936002)(36756003)(2616005)(33656002)(86362001)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2E+wVdV9tDiUY1dwpXddwTM+NuQqrCHgvSaRSablkP8DzbjczY5C3M6jS/VpgkNsCW3N0Cm+f6UNKxbVsiMV+JBzU5tD7TNEw9BZGwv+Wsw2P7OgipzKL9z/crEsXe4P9WHib/1rVlDU2Qscpw2NONaHL9t0e1IqmvU63HUq/sKvX9LW6DsNMno+NhPaqnk9K/NXWrGSDIkGIhWZkI4MQyjw21R8auSH9O9bE5WBJG2sDCgclYsZyzNn53beKB0gKjMSLVC4QxXUjIOCSPE7X1LfsPbkuanUqOv2+0bjAI6bWaSSUZdGnYWbsPZ5nqyBUuBLg/sNLBkJrgzw5ThBZ2mhieQkkdGR/9i5Rk8cUDyEpXJNy99K56bVUI64DElAjyUz8Jgevy05W8YZgOz6uPI9M6CH97DH591E0D1VHIMZa597IcdAszmbw586U4gnwu6HlYUF7XAkzZtR8e59jMnfED/3e0JKO1Ea0D5KKBo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88762ee-d214-4ed2-c67d-08d80f0aa0e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 19:55:59.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2C6066mykd9bdb2hWB9aLheMuFSpDtOPQjzHOiCZX/uI583reRcairINwwdZ6CBdIvzsnqjdfZDPt2bSPOcgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:53:23PM -0700, Ralph Campbell wrote:
> 
> On 6/12/20 12:42 PM, Jason Gunthorpe wrote:
> > On Fri, Jun 12, 2020 at 12:35:24PM -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
> > > > In zap_pte_range(), the check for non_swap_entry() and
> > > > is_device_private_entry() is redundant since the latter is a subset of the
> > > > former. Remove the redundant check to simplify the code and for clarity.
> > > 
> > > That is highly configuration dependent.
> > > 
> > > #else /* CONFIG_DEVICE_PRIVATE */
> > > ...
> > > static inline bool is_device_private_entry(swp_entry_t entry)
> > > {
> > >          return false;
> > > }
> > 
> > The commit message might be a bit confusing, as it is not a subset, I
> > would say that device_private_entry alone is sufficient to tell if the
> > entry is private or not.
> > 
> > For the !CONFIG_DEVICE_PRIVATE case having it wired to false is
> > right.
> > 
> > Jason
> > 
> 
> How about the following message instead?
> 
> In zap_pte_range(), the check for non_swap_entry() and
> is_device_private_entry() is unnecessary since the latter is sufficient
> to determine if the page is a device private page. Remove the test for
> non_swap_entry() to simplify the code and for clarity.

Yes, that is clearer to me

Jason
