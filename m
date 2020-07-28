Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34545207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XexPPLAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG1G7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:59:54 -0400
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:7009
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbgG1G7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVG2i8c5oDcyr4J641x06PEKRM4h6ufeSzgz+RHYLzGhoV24lv1UMqUGvjlo6Ku7ev4GbYLCQDOoEYDXBmJgnOlX8XR6sdB0/Dt+zZ4FJ5jR01CzIvvi6XEWYCsRGE+boa9oPa3sqZJvEhSb1k2hH6qOq58TAVU/L5Uy3Ils+zr/1w7NhliHuc+CTKoW/Vw3JpuHvyPMB/t7LdKAiEpbKgus3q/VAuJHMyoR+XubTvyUNWh9Iyy5b61a+F5M2Zr97cvhk6C9YZqjyB4oS3EN3N2cyq9Mi+FVi3d6gF2pX0Had3OfX3HMW+ZL83iHceGGuXdAwPZk0GNTg+uFl65AuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0lDeGuhk9sZmuZKvtQ9mKtqCeCjJ026FdDejv2PFRM=;
 b=L6BdMFbzF8NoLYI/PoDeSJ1P59N3E/2DMdgc0GpGdTkQboJTk/7LNloedXOdVDAnFi/6CgIvS+Dot0BHQq1HYEXRRywy0+0gljCVhW3KmGytJ7Egdb4UiFUf/KOD8GH14uKh5Yrlfq0L78tYqp18GopfkJhC1Oy1tmVjGU/aPD0ukXb3RcgMwNikyV7n1U+uV8WLdDn4aAZHLrv8r+bKkUcaQ2fXp8Qd6MJy6NY4REPNDr5aapfkKxqXs6zlSqj0HcJq8ow/cszNaN5Ip5OmuJVP/ATchYLAojfinDzo/LIf6YBH3d51fDJ5Hi9KjAclIIe6jFZjh2qjApLNY0FzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0lDeGuhk9sZmuZKvtQ9mKtqCeCjJ026FdDejv2PFRM=;
 b=XexPPLAgr1M9Ny5gvSxlhe4NVqFmxyWP/NfeMV0m+BM1F5Ftj2MlSW5WLAmQSFDaxxUmOoK6VVhNo0jtb+jSu6NnLBZConoVvN0WgvdlaOaG1Nwj5ueEKyJn0tmyudCXpFPc/kmV4mhnR18Z1nHHJ+u3/xH2HTUmnA80x3JEkJg=
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8)
 by DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Tue, 28 Jul 2020 06:59:50 +0000
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::213d:5180:d4b:467b]) by DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::213d:5180:d4b:467b%10]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:59:50 +0000
From:   "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: RE: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Thread-Topic: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Thread-Index: AQHWZCbm+DcS7P+G90ayphwZlFTok6kbjasAgAAKsoCAAPTPkA==
Date:   Tue, 28 Jul 2020 06:59:50 +0000
Message-ID: <DM5PR1201MB01393D93D69F1552408BFE79E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
 <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
 <20200727160941.GE6275@sirena.org.uk>
In-Reply-To: <20200727160941.GE6275@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9aa82977-d922-4132-87b5-683ef987f072;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T06:45:55Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [124.123.114.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bb3b1ed-55ce-4d2d-5cc0-08d832c3d29e
x-ms-traffictypediagnostic: DM5PR12MB1500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1500EE8EBECEEB05F886CA92E7730@DM5PR12MB1500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VTvR+ydbKb0gkf9QMjYLLxc3PJKpIw365pnldwfbCpuEnA9YAGBQwmJVY9RJVxnegSzaZx9dF5M4Jivys17rhmN8VksYe4cQATRDdl+fBrdJqCgMhpQo+fLO5IzTAmmOlX/sUJhy8XFoB30YQaLaflobPHK6TQpxk6m516q2t+V/DSEgXCbyZE03haV8/x9YYPa+dqUTQVtiJQsC/4JQNR6WNUdzsg5xUvW2d1R7Pd4APJ6mYd9+ZLXhAasqvddNBOcd9oPqVKfiH/60xxt1bibXh/85mNhN99RKdzuSxuk5u7RE615EnQ9rvidrpYJwiHG6RQ8vAyeSHOE7gGRQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0139.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(76116006)(86362001)(83380400001)(55016002)(7696005)(26005)(53546011)(8936002)(6506007)(9686003)(478600001)(33656002)(8676002)(54906003)(5660300002)(316002)(4326008)(186003)(52536014)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2aNVSRRBJq8xS+apKQ2JEIoj0wb/m6/VkqVASypk5VZptonMjnbgftACTQPVRO9FZdA13zSWEj5iJeBemTkd7rjyyhwbEGpELVfdf2FoUTJjxWoHu7+QVGKEfvFRTV7aDM0NfqCMysiSdM6FzYVPJcjJ3lLYpsftDaGvQzLGwdxwcUVuz/tHYqLQu0mikUUOLtfWRDQBAWthfJzGWF3ZYevrb6uaaY45MHgTXmTis0uyNkP7iRin2Uq+7pNMpFf53/AigU0Srbn+zpx07TuMQd3j9QtghsT6YJF+ikdgC/fttNNztXX6W9I6MkwV0iPzVpRxGDh7TDRuV/ylBHqB81pSotwD+zd7aZCliHo3gEymL70f8zf66uA/kXS8BEge0YyID3QrE1auaabFXtdMYWZOR0aibHqRf0mKUGBHP/iKfFDcKmZbpeoNsmD4WHSH2j9/qfu9awlf1N5icdR79OWzTCCq9QvohyCnFuGLPRKK151VlHmuNKDAo6lZ1KBA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb3b1ed-55ce-4d2d-5cc0-08d832c3d29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:59:50.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEX7BpN8kJSmHZMfN2ybtnWSYPaZKnVH/Z6N7mEGrvoo+QGgILRcLMlrb6uIpX8/v6MEy3WLV+ZkHgAvhZukAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

So Actually for rt5682 codec Now in 5.8 there are three flags :
SND_SOC_RT5682
SND_SOC_RT5682_I2C
SND_SOC_RT5682_SDW

But till 5.7.8 we have
SND_SOC_RT5682
SND_SOC_RT5682_SDW

So in our design we were using SND_SOC_RT5682 which build snd_soc_rt5682.ko
Creates the respective codec_dais as defined in that .ko

If we use SND_SOC_RT5682_I2C we get snd_soc_rt5682_I2c.ko , it is not creat=
ing the expected codec_dai links.

As there are three flags defined in codecs, I expect that previous one whic=
h we were using(SND_SOC_RT5682) is not a wrong flag and I expect to use
SND_SOC_RT5682 as it is still available.

Thanks,
Vishnu


-----Original Message-----
From: Mark Brown <broonie@kernel.org>
Sent: Monday, July 27, 2020 9:40 PM
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: RAVULAPATI, VISHNU VARDHAN RAO <Vishnuvardhanrao.Ravulapati@amd.com>; m=
oderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM... <alsa-deve=
l@alsa-project.org>; Arnd Bergmann <arnd@arndb.de>; open list <linux-kernel=
@vger.kernel.org>; YueHaibing <yuehaibing@huawei.com>; Takashi Iwai <tiwai@=
suse.com>; Enric Balletbo i Serra <enric.balletbo@collabora.com>; Liam Gird=
wood <lgirdwood@gmail.com>; Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; D=
eucher, Alexander <Alexander.Deucher@amd.com>; Agrawal, Akshu <Akshu.Agrawa=
l@amd.com>
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt568=
2

On Mon, Jul 27, 2020 at 10:31:24AM -0500, Pierre-Louis Bossart wrote:
> On 7/27/20 9:58 AM, Ravulapati Vishnu vardhan rao wrote:

> > changing SND_SOC_RT5682_I2C to SND_SOC_RT5682 because, This flag
> > which was previously set as SND_SOC_RT5682 used to build rt5682
> > codec driver but by changing into SND_SOC_RT5682_I2C is preventing
> > to build rt5682 codec driver and machine driver fails to probe.So
> > Reverting the changes.

> The split between I2C and SoundWire means you have to choose the I2C
> or SDW mode. Selecting the common part looks very strange.

Right, and I can't understand the commit message at all.  What's the actual=
 issue here and how could this fix it - in what situation wouldn't you need=
 one of the bus modules?
