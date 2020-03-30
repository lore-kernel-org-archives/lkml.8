Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88308C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4626720774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="I52Ki4lK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgC3UIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:08:32 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:34126
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgC3UIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhoydvI5lwMczAIfCZ13eJp3D0Sd4Ptnh2dvhxGyU5CJ51AtbKrMqYse7mwJjcfPF3k9SpJ8qUzR2pqsN5OKRMrHGBiB0uma68KZq0kDFFPWE9ZSWP0M2VNvG47qQuGWxO3vOKwATCcEZDSPRtna5rn7DstJN0N9Hw3Iju+iRnTcDj+Cx6oQTIeolc2E32RsvhDOJu5IqD2xyuBT/cI9XVqyC+j0QjKtnlHDPfz/Nk1aAopVLvjNvuf+D/fBxBQIhxmK+dTFShRdwSROaSly4mkFGdEJKw9+WxjrvMGYCcoqLvWlEmxnkNayDtLW1srnDhYcGuJrOq7plx3cTrm/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5BjwPCiRstZaqzjNSb0e5joqVf4SxO7dPJadjMTNXs=;
 b=VcsnlAed3rSKBHaA9QWOtbXa3yO4hkLMY8hO5DYwsNlYftQiIP3x4FEO9Wr9QugOnM62uVAJpok5o36U+XEIsSnlZ8sUEHNc+3Y6MscmKJdAs1gSd25SaZK69Wl2MZVPPImi6kdy3Y7IBaUSYGUfOgHvKiOfvIyNmTlJD9dxp0EOE9zXZN5ltlk56ObZop1Wndqi86i7aL0w0rIt4z+gHmLSbOhqbWrzIcVMbii4kwgqFHDRKGfZkMZ43PPuD5VbEyaJBwqTmFssHkJWtCTlJvw7/JBY5Heioi88PJpncTuvOw0FJc9aBO+36DkCfrkTDRurMb3G44FS8TeMnoHa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5BjwPCiRstZaqzjNSb0e5joqVf4SxO7dPJadjMTNXs=;
 b=I52Ki4lKgkxpFWt3cP9vKWxof9L9cpSSMvuWtpWZXxtLeZiafJA4WgI/QvGg1ak4b4JBdjCdpuirxr2zPxfY1f67uKLNHo+TiruwmZ/Fer9TxkaY1Mf/jMhwGhE8MrlY9juhjhi2NHkMBh/H+8vX9MUsJE2mUM2Tv3mRz5ihi5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5630.eurprd05.prod.outlook.com (20.178.122.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 20:08:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 20:08:27 +0000
Date:   Mon, 30 Mar 2020 17:08:23 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [GIT PULL] Please pull HMM changes
Message-ID: <20200330200823.GH8514@mellanox.com>
References: <20200330175748.GA32709@ziepe.ca>
 <20200330195403.GA35797@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330195403.GA35797@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 20:08:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jJ0hr-0006Y8-D2; Mon, 30 Mar 2020 17:08:23 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08de9277-ed3b-4473-be76-08d7d4e61ba5
X-MS-TrafficTypeDiagnostic: VI1PR05MB5630:
X-Microsoft-Antispam-PRVS: <VI1PR05MB56300A2D037D248ADB516DFECFCB0@VI1PR05MB5630.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(54906003)(36756003)(81166006)(478600001)(33656002)(81156014)(6916009)(2906002)(8676002)(316002)(86362001)(8936002)(52116002)(66476007)(66946007)(966005)(66556008)(186003)(26005)(2616005)(1076003)(9786002)(4326008)(9746002)(5660300002)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfgZL8jquE0fC5cCZMk3SHQWE6dFT/TFX3Sjvn1okKcaCv7gCI4epGXWrTYYm6wmXkdKAB5DRie2p9MlcY/n9ovmjz0SCS5VtKaJ37QyvTsb7f97P5Pp6rP6NZjQ6JsnWs/kzzhoYf3rP95u/dxLDZU1n8DK8En0VjsC2nxIjkHYcv9MbHwE5os/zzBYBkt6v1Nt23usC9HgKdoJWuRbcTkFa+HGpWvZmmf6f0+DMHass1VFENGDXi7D/6NuJyw9gS2UfSftaxmdCnYuZ+JV1FeSHPQ5kjBwu6JbJ1vALtrgNWYLmcu8488TJLBgk74tOZEoM3UNOU15DSTQ5InQsnXCcauQmFe1zCil8qT3R+7hGqic/P9atbytjfmIqdGKvDVo8lOrASVEtfmYOwOQ6ft31AEZnBoRrgKVT+g4LYnaYsufxNF1AUSEc190rEuWLMqiAqeGK8O1GfnCyJ8meW3tPGxq12aoo7EIbP0eQAGJLCjTZKwpYTTM2fdp/0Jf3XpVTInNUzIKt7nrgdkpvVzjurLRxgwh057+CoTuUlqRr/xkIhvsjzoKvPr7XCuKWhHCzq/LJyFUNtNDmcGvyA==
X-MS-Exchange-AntiSpam-MessageData: DYRoQed6NqfAUMXcMMc1uFcXDbS1DfZ8jHiPXjoUu1PHsX9RwPbn1E18OanipKySPk2zJ6JAyupko2m8K805ukYCE7A/tZPYNZG7dVcr53Ra+RNisQDD70vkp4f2cGq8huvRWOHL3xTFOzB0iQg8ew==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08de9277-ed3b-4473-be76-08d7d4e61ba5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 20:08:27.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPhNAcbBPEsujXcRZIYPvlyycuJWCGqMoEZAGtM+mm4zTlY7UHvngbg8uPg2eUGlfUjwtjeoNR3VeSCG3rt/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:54:03PM -0700, Nathan Chancellor wrote:

> > Jason Gunthorpe (17):
> >       mm/hmm: add missing unmaps of the ptep during hmm_vma_handle_pte()
> >       mm/hmm: do not call hmm_vma_walk_hole() while holding a spinlock
> >       mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
> >       mm/hmm: add missing call to hmm_range_need_fault() before returning EFAULT
> >       mm/hmm: reorganize how !pte_present is handled in hmm_vma_handle_pte()
> >       mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on requested valid pages
> >       mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling
> >       mm/hmm: do not check pmd_protnone twice in hmm_vma_handle_pmd()
> >       mm/hmm: remove pgmap checking for devmap pages
> >       mm/hmm: return the fault type from hmm_pte_need_fault()
> >       mm/hmm: remove unused code and tidy comments
> >       mm/hmm: remove HMM_FAULT_SNAPSHOT
> >       mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
> 
> This patch causes an error on arm32 all{mod,yes}config because pmd_pfn
> is only defined when CONFIG_ARM_LPAE is set, which is a dependency of
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE and CONFIG_TRANSPARENT_HUGEPAGE.

Oh! I'm again surprised 0-day did not catch on to this. linux-next
surely would have, but things got there later than I would have
preferred due to the world being upside down right now :(

> https://elixir.bootlin.com/linux/v5.6/source/arch/arm/include/asm/pgtable-3level.h#L236
> https://elixir.bootlin.com/linux/v5.6/source/arch/arm/include/asm/pgtable.h#L29
> https://elixir.bootlin.com/linux/v5.6/source/arch/arm/Kconfig#L1579
> 
> No idea how to rectify that but thought I would let you know.

I'll just drop the patch. Next cycle we can add some comment here as
this requirement is a hard to notice.

The for-linus-hmm tag is updated now to reflect this.

Thanks a lot,
Jason
