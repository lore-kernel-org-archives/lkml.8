Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ACEC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CD520870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p8Wwl+TR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p8Wwl+TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCFEO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:14:27 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:26081
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgCFEO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdGZK1M043VUAXFwrt7mZbDAURyW59AfhIAZaK830uE=;
 b=p8Wwl+TRJTvcA16geSlBiPW9bhZL+omovKjcft8+gGQsGafS6wBD01sNFRZVoiAYlMDF5b5Zqmgd7N0Nq7VV71jpZnjxJaJeBaDBOPAq/7QrssE0BDl9b3R0X7WDmiQ4w9o0ntWpcP7tU/g+jzQVBkid0aVN7MQK2opdhUs80QY=
Received: from DB8PR03CA0012.eurprd03.prod.outlook.com (2603:10a6:10:be::25)
 by DB6PR0802MB2214.eurprd08.prod.outlook.com (2603:10a6:4:82::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 04:14:20 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::2b) by DB8PR03CA0012.outlook.office365.com
 (2603:10a6:10:be::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Fri, 6 Mar 2020 04:14:20 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Fri, 6 Mar 2020 04:14:20 +0000
Received: ("Tessian outbound d1ceabc7047e:v42"); Fri, 06 Mar 2020 04:14:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c9dde48dfb3e92a2
X-CR-MTA-TID: 64aa7808
Received: from 11d069585b45.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 18866953-21F0-4712-864C-DD612C9DE2D0.1;
        Fri, 06 Mar 2020 04:14:15 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 11d069585b45.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 06 Mar 2020 04:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Box0GlS9s13Rh/amg1DXMIUpvZmRJKcnWitU1E70QHRkC5scTho7MT4D3+4XeKh8/mYbJAZDCMvnY0wUkeDW+n1RT/TF6Yi0BjRS54ZXo/pDiRTI/EcxyGOwIV5WwSqTr261Fj2zUNBa4nyBR/mwzlvAbWpvVR2PHFYdbPg6D4ayWy6Fs5UQXPfyP3MF7Tu7EPSvq23BVAAo1oncpiWNcWCQns4o1hVYGJ/+pAaKpqr7vtjlUpEmtLqQFrgwssgnxSnsDHC/pbwDl73xl+l/7fLE3gLwStsv6zwAUM+uCbnxouf/mhTTNX/rIwJv/KRsUA7SE2JJlwgv6FxQLeZn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdGZK1M043VUAXFwrt7mZbDAURyW59AfhIAZaK830uE=;
 b=XMY7MnSWaAyBMA9qdYWuvghnnhqn1614VoIudmIORPN8OlQp36gydM46Xx1cZgpqcYvfYH+XHDYW8q/hNyU22iaWGvaNlfFe4FDbmqtmwqVkG0TAkLiGKPiBnQsPXmR+55ZTggcgYoQr3eq+VYvs1RyIQUdxLsVa3roWdyOvnPfyOrcUANTisKOS18VECrTyVaFn6YpIXNu5wAQRKEidnWKdaTLc613vFehVw+iPV7YQ09JEOSs6s3cDUKhTkpFi5dW7FMfd3Y4sxjhsk6rGQHZGVe4JoxCxMQPUUFgsGx5LYZBr9P/81qCBAhrdQqOgAvH2BzLlCDvjc+5eHTszMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdGZK1M043VUAXFwrt7mZbDAURyW59AfhIAZaK830uE=;
 b=p8Wwl+TRJTvcA16geSlBiPW9bhZL+omovKjcft8+gGQsGafS6wBD01sNFRZVoiAYlMDF5b5Zqmgd7N0Nq7VV71jpZnjxJaJeBaDBOPAq/7QrssE0BDl9b3R0X7WDmiQ4w9o0ntWpcP7tU/g+jzQVBkid0aVN7MQK2opdhUs80QY=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4640.eurprd08.prod.outlook.com (10.255.27.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Fri, 6 Mar 2020 04:14:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::101d:3c1a:50cd:520]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::101d:3c1a:50cd:520%7]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 04:14:13 +0000
Date:   Fri, 6 Mar 2020 12:14:07 +0800
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
Subject: Re: [PATCH] drm: komeda: Make rt_pm_ops dependent on CONFIG_PM
Message-ID: <20200306041407.GA27096@jamwan02-TSP300>
References: <20200304145412.33936-1-vincenzo.frascino@arm.com>
 <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (113.29.88.7) by HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Fri, 6 Mar 2020 04:14:12 +0000
X-Originating-IP: [113.29.88.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 252230e0-c79e-451e-790e-08d7c184d869
X-MS-TrafficTypeDiagnostic: VE1PR08MB4640:|VE1PR08MB4640:|DB6PR0802MB2214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB22143B5169EFB8168B4731B7B3E30@DB6PR0802MB2214.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:277;OLM:277;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(66946007)(6666004)(316002)(6636002)(6862004)(4326008)(54906003)(8676002)(66476007)(33656002)(478600001)(66556008)(2906002)(1076003)(33716001)(81156014)(186003)(81166006)(86362001)(956004)(9686003)(52116002)(26005)(6496006)(55236004)(16526019)(6486002)(8936002)(966005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4640;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vlw2USzsPm7IND3S/XzQ+q3M3r5ayrcw4fj/D+VXVSFH0LXn6jQg1k5r+ysM2HNbuWtklaHy6eebjEZ+Hr1sQESi2WnAKHJryHiOH346oP099RTS63Dot3GLcKimNOMQEUtA9YhD07wYQ1d+p5JgZK3OTTZR/ATKQrt87vyXtDkFMAykCAQ9J3YtPqFE7pjhbe8vvjHK/FAKZhvKwwYbGQDN3brBQ5qW/bfZIN174gvL/o7AMZwl6PpBwyTBDOzzklzEDmEH1kzuZINXygyRG6uXPc9PUGfiX+5L3d0+ySRRPpzL1Vnb5q+Knjd/PNdEtWNHTFN3VUGcuddpczsfN4K4Pn0rioKi6gv4FRNFeEG02gQ/8aX7Lc5TO7MRhL0YEomWgHhJ+qvAqkzcaJY5H+T6ANAP34zEc2UxrZUJDPjQftn6MZZFqceYZ9MaDQUGQsd1/pbBPeEVALNPVQfsy2atJug3muIm8Gec0A6sURk=
X-MS-Exchange-AntiSpam-MessageData: Ko74YP0/H8prN/c2PEKqDP+SRo0SrqLXVQ9uia0A2TsiKAP8JxT8CHPE2Z1JxBWE1BMXOGuNim/7VWHHTy0FnIyJ2EyRkm1Lv5PHdquVQrcQhgMAUOB/GrIyC3DIomDAr+8cZJ+O/KW/uKXa2USiqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4640
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(8936002)(26005)(81166006)(33656002)(6862004)(6486002)(956004)(966005)(81156014)(6496006)(33716001)(336012)(8676002)(356004)(316002)(9686003)(4326008)(6666004)(478600001)(16526019)(2906002)(70206006)(5660300002)(26826003)(186003)(54906003)(86362001)(6636002)(1076003)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2214;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5adc120-25ac-4fdd-b723-08d7c184d405
X-Forefront-PRVS: 0334223192
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKDXUP4eC4zfNODb/p2QmYSVh9jQLvnDIVQCnzW574SpdMNTVR9yZs4Cw/D8jKx0SYCDOn2npnfPQXs4CCm/VKzzti5SGbYHKS1Fwo3pa6X57oz3XSdhAL4S7IDLlU66i5BmABYErR+qXjgw2xckCYOiVJdTxNWnWb3/OMIXr+IdsbfxJ+hnjB+CrPulsfzXHVOqvqQCjskSyxuY6TwWK24K29u8TftSYXY886Pe7PlL6nvxEC613ukO8MHGYrTRk3/lACYEpB63ez0LZOumeG103R3Fjangt7Cz+cMedgI39UerjfLpdmnnfnKYvWFdRi4bpGHK+KYHV+KVBtD9WKyMM66MLzPSaYlVa4NiINhHxgLxLNmG9r2GVxYSOl2k9pHupEZIIUBQsmUN+pcboiMVrzgPVbLcs8LnG8gWgSn4eUprM3VbAuQo9Z3qgAh189pGq2G3mfCHzsgChAl7p4H6O+fbGCAYNk/ccDCNizU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 04:14:20.6689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252230e0-c79e-451e-790e-08d7c184d869
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:42:55AM +0800, Liviu Dudau wrote:
> On Wed, Mar 04, 2020 at 02:54:12PM +0000, Vincenzo Frascino wrote:
> > komeda_rt_pm_suspend() and komeda_rt_pm_resume() are compiled only when
> > CONFIG_PM is enabled. Having it disabled triggers the following warning
> > at compile time:
> > 
> > linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12:
> > warning: ‘komeda_rt_pm_resume’ defined but not used [-Wunused-function]
> >  static int komeda_rt_pm_resume(struct device *dev)
> >             ^~~~~~~~~~~~~~~~~~~
> > linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12:
> > warning: ‘komeda_rt_pm_suspend’ defined but not used [-Wunused-function]
> >  static int komeda_rt_pm_suspend(struct device *dev)
> > 
> > Make komeda_rt_pm_suspend() and komeda_rt_pm_resume() dependent on
> > CONFIG_PM to address the issue.
> > 
> > Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> > Cc: Brian Starkey <brian.starkey@arm.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>

Hi Vincenzo:

Thanks for the patch.

and Vincenzo & Liviu, sorry

Since there is a patch for this problem already:
https://patchwork.freedesktop.org/series/71721/

And I have pushed that old fix to drm-misc-fixes just before I saw
this mail. sorry.

> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Thanks for the patch, I will push it into drm-misc-fixes tomorrow.
> 
> Best regards,
> Liviu
> 
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > index ea5cd1e17304..dd3ae3d88687 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > @@ -146,6 +146,7 @@ static const struct of_device_id komeda_of_match[] = {
> >  
> >  MODULE_DEVICE_TABLE(of, komeda_of_match);
> >  
> > +#ifdef CONFIG_PM
> >  static int komeda_rt_pm_suspend(struct device *dev)
> >  {
> >  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> > @@ -159,6 +160,7 @@ static int komeda_rt_pm_resume(struct device *dev)
> >  
> >  	return komeda_dev_resume(mdrv->mdev);
> >  }
> > +#endif /* CONFIG_PM */
> >  
> >  static int __maybe_unused komeda_pm_suspend(struct device *dev)
> >  {
> > -- 
> > 2.25.1
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
