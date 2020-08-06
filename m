Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4DF21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aKVvTF3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHFXog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:44:36 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:64789
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgHFXog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6RN0j/oLTCa4/YwunqJgfdbxy3sEA+jWtm0DUbBa20Pv6dAA/tAh4ObuJsVycd/ZsXamqJL8Go/72oGmWaLBkZZHGmuhRBUcbOilf4H0W1IUBGpUY6EaL9VNTqhd6tm/zVzc6k+3gaGKXrZNCIdtlsuKDPEZAE0PyvYsMH9jwzbMr59v719TCkqUnB5L3AzUjDjx2b1hfpQanO/zjHFM4ANIteA3d8MaI9O4rBHIself/B3hsJmPp23u3DBoWgrOVRRJiGwM9V3cHCKWCdfuiK/mWzU1KDvWD0Zye5PMLFwbwaeGs0lBflZXvu3lkzMJTa6X/fqv46+qNoZqWViEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUbkFLlQ9431637+XYpeG5sAsoAaxSeAVPd61Nk/mIo=;
 b=AH9sSqJbVQeTnj23wDAHl0+/O/SFa5Ux6cxYvphYk3M1imq6Ggq9oLP/czZZu++9m6/jzCIxdTfwzJdkTUkqrX/lCrjUa4WVZUhoosc1/t0CmvGZyMB0X48J/Z+wzz9d//FYOI1NuxkuXeOEDpIJ0h2k2YeVrtkRSFCmFG3CGGUZJUgkZbTIGxnPe1EeHhEHWvCa06xpdgWsOBudX+Lmtibv8hhHBk3KcvviAlbXSQBoUGTmI9Q2Ix84MKO/9au4U3W8f3FTxAZdl3Wm9zW+O6NE3PklqSFuJUUklV8IPyMCT4P7f1EjpBNvlkDe3my5uwmPKLO6KOOwlsD3heiPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUbkFLlQ9431637+XYpeG5sAsoAaxSeAVPd61Nk/mIo=;
 b=aKVvTF3y8DnV+3w5wyZvfPV41PkNKjzLQh2l7vysYH46UFwxFG2+A5GyxPxVDB/OyMJUFoQ6VUx8SDHoPUuPrezXqKMtPWkPvhGLMjl3RSGuxwoDEj9/DTsKU0sil0kwUm+TntC4OS0ptmH2vA9Ws/aIV9QSWUtlRdToDv44YQs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0502MB3837.eurprd05.prod.outlook.com (2603:10a6:803:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 23:44:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::10b0:e5f1:adab:799a]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::10b0:e5f1:adab:799a%4]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 23:44:31 +0000
Date:   Thu, 6 Aug 2020 20:44:27 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/migrate: fix migrate_pgmap_owner w/o
 CONFIG_MMU_NOTIFIER
Message-ID: <20200806234427.GR19097@mellanox.com>
References: <20200806193353.7124-1-rcampbell@nvidia.com>
 <a093b5ed-4ea6-7e02-f9da-19799f3cd59a@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a093b5ed-4ea6-7e02-f9da-19799f3cd59a@infradead.org>
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:256::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.7 via Frontend Transport; Thu, 6 Aug 2020 23:44:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1k3pYh-004XGF-8c; Thu, 06 Aug 2020 20:44:27 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56c3b674-82c9-48d5-151a-08d83a62aa50
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3837:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3837CB650A65D79DD232B64CCF480@VI1PR0502MB3837.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfwD3YzH6r1n7LzVw91vDI2w2wn2WJBYbLm/pMTnPdyImDr4l55SbHvZdkiwy+msDwZoXyscfvAr+2GB9OToTlxqnZLGUh79xmAuKf1HiNuqcm+OHiklDQJh9xPCEp5pfPz+gWoODpNDO+8qKqMvTUCIaXHyrdjy/PWwYkySI1tbkcfii8d776Xdp46syEVbaeITSGpsp1RETreUYS3skHb7qVg6CjZUxw+P/nI5bM6AWlTJRLn2HD9zXbFPNkGIISdFN55zxUyKvk6QpG9CYC5RkvaPUOcm5o8I5LvyNcWBin+lBqGztmhDhH8hcdO+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(5660300002)(83380400001)(66946007)(2616005)(1076003)(86362001)(66476007)(4744005)(36756003)(66556008)(9746002)(2906002)(53546011)(316002)(8676002)(8936002)(54906003)(26005)(426003)(478600001)(186003)(9786002)(4326008)(110136005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OpuWTCAQbLQw2XqJB6iXt0BktiDdPtNu+Xi7H3r45ksXNoQfy7SGSlEfSkflaeWWZL1YQOX4Br+oUZa7/WM/KoDkFliXjppsougZrONNpFlWvw0mQV791vKaGa6hXrHbbUwDHadjUtYs/23FmS0cHpvWnJXvWjwlK1sBaP6p3TDpGtAUZZ5HDDBC7WIc7STws1xIc+2RE9xHM65DdKTna28AjJSwmNYoAdnexig8vwzshnMDC4s/4bWP7LzeWgyMNZEw2VhqFZtYMvwU+bMr7OgOeL7dURyx03nj4nQepHTQ0tn/JiwkAV1vDekP3D8ERxljFW6wH3BdflbdGooqzKrQmDzkEfm17+ddcO1sh7/INg26HfIYuXXXncTZerx+Y5pVpKUH1FcTgmuDsFFip+hN7OhQibEOjZZ2PlUMunZxCit94rj41niqG8rBYOSCm8vXYYqnvZl3/+bH07ZNCRGmSDGVOmY+Nnhv9x9ta4OAXUpFGp1SnMgyxkxEccIpSYtFjVX8y8iJszHXZVEOJMF/Tbn6Xf1Q52qSFDFUhRi2fWOQOC3sG03adBPuKceRsZsI/GZZhff1lfxdGof36yibOIAVDytNwj2qmE3PoF8kVHWRazIv48kaVp3Qowm+XPcAjaKC7c9/ThT0jlYlTg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c3b674-82c9-48d5-151a-08d83a62aa50
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 23:44:31.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEVKqcOQWixnCfOzfX0QQRn2YRxj6e3KeM9qAUJ6YIGJXJN16PXqNQUJcCsoa1TPMKXNVsa2AaKAcRIAlRSedQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3837
X-MS-Exchange-Transport-Forked: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 04:39:58PM -0700, Randy Dunlap wrote:
> On 8/6/20 12:33 PM, Ralph Campbell wrote:
> > On x86_64, when CONFIG_MMU_NOTIFIER is not set/enabled, there is a
> > compiler error:
> > 
> > ../mm/migrate.c: In function 'migrate_vma_collect':
> > ../mm/migrate.c:2481:7: error: 'struct mmu_notifier_range' has no member
> > named 'migrate_pgmap_owner'
> >   range.migrate_pgmap_owner = migrate->pgmap_owner;
> >        ^
> > 
> > Fixes: 998427b3ad2c ("mm/notifier: add migration invalidation type")
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I thought it spent enough time in linux-next and for 0-day to catch
things like this, but I guess I was wrong.

Linus has already merged the hmm pull request.

Andrew Morton: Can you pick this fix up to forward to Linus?

Thanks,
Jason
