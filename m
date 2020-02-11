Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72663C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273A0206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/hs2xrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBKX4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:56:06 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:10560
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbgBKX4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:56:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUUPMkkfXxhAy6rkhb9niDb4FrVk8Up3PGWsH+a5rbMIDH0Sc0ZZCDISZzYv2fOWylrhS8ukCMGJeRNK7cN8XjzzCi+5AQrqdblMZwGZ/BnqaAwpqwKvh7SzsCr38FrJ9yxEZ3ir2TauJgf2ogpY2Ogy4dPn9ryMS6xdtubjidf30V3vrbXP3+cTm/6VNViHyhqapaKwZmgDnHvt27UtnJUSLQ6f5WQH1hcHXcpCncjmOlCNFi/52fCxVSQpIAkaLflmby6O8iYO9KTXgrB+tbOj+jkwyp8zOLRQBZomvhwGtg/IHZ3l8kYjlD3rU03TuAFlBox8Bxi2ig8bFgkCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrScfj5oSK92dcySCablajZXmZL3F5YvZAAJ9pHalQ=;
 b=gU5FIcl6Tn8IiJIUjXw9qROPbgI9jyJTvKDCLZFS/iT1Zl9turDoskIybwafDP8giW7j9YlwPtSsOf/DV1ES8/2NCynRDZ+jGD3iLYz+WfGXTEfcEep9s+YV978UNRVEAjZzgtQDKJ9f6gs1EwLC4/krhGQpvVNXURWEQJYwqo4IrnCbeh4KTiPpxMK1uCQ3Z9K+O8mL/vIleehtcU+qal1hzT3cf1upP7balS9RXYOWqNaKQwxemV/mLDyL3B2OYOS3wF4ode+Pygo+DkOKgfDrxFJy/wrlUsI86hTDUL0iBbk3ez4G4/cJrm51ecGRJ/lfUFhu/db1j0MpKQfDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrScfj5oSK92dcySCablajZXmZL3F5YvZAAJ9pHalQ=;
 b=g/hs2xrfomDv/qNqZTx/SgLqEYv5eaTUMGwUYOT2IgqUA7QfCRwBZ0c9Ydb3oK0Db7nmIBF2OaJtiPh0f9HWvqdrdd8UyHfW6wpIQjrOg98o9b1E0jmSgZ1zKMUtoHiPmpVL37xYdNlbO/AjIKVVMekO9hA1XDJf+VHt6K4VzGw=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6670.eurprd04.prod.outlook.com (20.179.233.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 23:56:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 23:56:01 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Thread-Topic: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Thread-Index: AQHV4TQ+rYAmxRjidEu7CIluqOuss6gWqE4AgAABt3A=
Date:   Tue, 11 Feb 2020 23:56:01 +0000
Message-ID: <VE1PR04MB6687C1D26EF252554E8831AE8F180@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
 <20200211234536.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20200211234536.GK25745@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e6c1a86-82a7-420f-6428-08d7af4df2e9
x-ms-traffictypediagnostic: VE1PR04MB6670:
x-microsoft-antispam-prvs: <VE1PR04MB667081197ECDBC5C6B8A0A9E8F180@VE1PR04MB6670.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(186003)(8936002)(45080400002)(26005)(54906003)(4326008)(8676002)(6506007)(53546011)(6916009)(5660300002)(966005)(71200400001)(7696005)(81156014)(81166006)(64756008)(2906002)(66946007)(66556008)(316002)(66446008)(66476007)(76116006)(33656002)(9686003)(52536014)(478600001)(55016002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6670;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztammonGeAXeH6VfVfI75OVV9Khhg2PnA3qnNZF+hE2F7C+nYU5c3qHBwovwo3EAkNvDrS3XCkdBEK3VNdPs0kvzD/zbThOvKYKNlamYeNp27s5RpVXMGO1OQ9e3knO9Maq5Uk1CV4IkmN2g5DNGr8nMRdVLqVFccM7LFwOk+tjX/P9NCKouBFC4EAFxJhJNKiEDZWuvmmCGmOTD6EoPXNDlzu9SbHVETrl1Ixom8hIhoTGYiHvqAln1dz+s8HxDp4/DaQF1ZrCeeJZRyJkfMqWtr22MV6n2Jm0eEpRvfklhQZl03S2DTD6jgR4iWzeqhNUwhuevdc9WG+5Fx8+NEzctWmZTq0PHAbbndLLkg4FPXqHyHV66bSJMZ90yFuFkErGTYRwmxSGEkHKmIY0B2VNuaRTNSCA32b+bJJxLTd+wVZ59TGUpZKbudi+G2RLdyf9OPOzD70otFnBPnCJQHilfasF2IYzkUkrhVFN0JCIrhGpdlU+jV+nYUdvMLa9Q0liP5L5J/99b+O4SyUr2dLMZCdoSnAdZ7+7DHNtxXB24/dHrEhUedT9A1b65NvLxy/adWqUVZxRXp6bs1kcQxErwSbyLpFYvCpDYk51EtdDscWa5ffkdeGGQ0s/YAepm
x-ms-exchange-antispam-messagedata: BkORNlyxH41qiXXhcidUxmJcBMdv7dGvLWU1860RdsTyfCzN2K55PQr0tIPa/MuAZ2vxF22Atih2FtmHoW2vPH1KE2iIaDc1oKaOuGfvNjbQH1MeRuy+IeflSg5zfhAlxHuTe41KZj2Q8eAefX27dg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c1a86-82a7-420f-6428-08d7af4df2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 23:56:01.7639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyxPkrevjxiisfczejcN9OmIDRHs9h1T+fof3GyEwX9KTL+/ZGmKR8vlU4OVFMFINhz/uNVzF3shhcjZyMygkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Tuesday, February 11, 2020 5:46 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Joerg Roedel <joro@8bytes.org>; Will Deacon <will.deacon@arm.com>;
> Robin Murphy <robin.murphy@arm.com>; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] iommu/arm-smmu: fix the module name for
> disable_bypass parameter
>=20
> On Tue, Feb 11, 2020 at 05:36:55PM -0600, Li Yang wrote:
> > Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a
> > module"), there is a side effect that the module name is changed from
> > arm-smmu to arm-smmu-mod.  So the kernel parameter for
> disable_bypass
> > need to be changed too.  Fix the Kconfig help and error message to the
> > correct parameter name.
>=20
> Hmm, this seems to be a user-visible change - so those of us who have bee=
n
> booting with "arm-smmu.disable_bypass=3D0" now need to change that
> depending on which kernel is being booted - which is not nice, and makes
> the support side on platforms that need this kernel parameter harder.

I agree.  Probably a better fix is to update the Makefile to change the mod=
ule name back to the original one.

Regards,
Leo

>=20
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  drivers/iommu/Kconfig    | 2 +-
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> > d2fade984999..fb54be903c60 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -415,7 +415,7 @@ config
> ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >  	  hardcode the bypass disable in the code.
> >
> >  	  NOTE: the kernel command line parameter
> > -	  'arm-smmu.disable_bypass' will continue to override this
> > +	  'arm-smmu-mod.disable_bypass' will continue to override this
> >  	  config.
> >
> >  config ARM_SMMU_V3
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index
> > 16c4b87af42b..2ffe8ff04393 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq,
> void *dev)
> >  		if
> (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> >  		    (gfsr & ARM_SMMU_sGFSR_USF))
> >  			dev_err(smmu->dev,
> > -				"Blocked unknown Stream ID 0x%hx; boot
> with \"arm-smmu.disable_bypass=3D0\" to allow, but this may have security
> implications\n",
> > +				"Blocked unknown Stream ID 0x%hx; boot
> with
> > +\"arm-smmu-mod.disable_bypass=3D0\" to allow, but this may have
> > +security implications\n",
> >  				(u16)gfsynr1);
> >  		else
> >  			dev_err(smmu->dev,
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flist=
s
> > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C0
> >
> 1%7Cleoyang.li%40nxp.com%7Cf2f7f3c7c8fa4df0fb0608d7af4c84d1%7C686ea
> 1d3
> >
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637170615487429054&amp;sdata=3D
> NO4VZ1
> > sSMKyeXiL%2BUc5K6gIW5Uld%2BRsGAICLgI2nnd8%3D&amp;reserved=3D0
> >
>=20
> --
> RMK's Patch system:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .armlinux.org.uk%2Fdeveloper%2Fpatches%2F&amp;data=3D02%7C01%7Cleoy
> ang.li%40nxp.com%7Cf2f7f3c7c8fa4df0fb0608d7af4c84d1%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C637170615487429054&amp;sdata=3DeMRT
> wZGZPeq3DvkBwjBjGbsS1Qsy3LYMnjH%2B9FJm2aE%3D&amp;reserved=3D0
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s
> up According to speedtest.net: 11.9Mbps down 500kbps up
