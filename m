Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB43EC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4924671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="irhVHLsX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N6zjT+y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOCdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:33:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60984 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgAOCdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579055610; x=1610591610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gyGLhBXlOVb74kkFm3YuptdbEXFgkQ7f0XQco2ZOrho=;
  b=irhVHLsXGD9C3GLsm4/rJ5HBxF5NX/8dCY51jtskuWM8mVk1UHW5nsjY
   xIBg/f0J0M65P/jfsrP8iT9bLtP9JVYbg+4zsUMUDpRF+6SyEqy+ByJUY
   wb57Wb43NW/UlbcJCN+pyOdgBCawIebiIz7uLL8kNzKJpU341zMxnS6G4
   yo13529quToMpMkeKGLt4/znL4SlwvSsnh8hYMbf6o1YQBfWZLMWYfWto
   Vo+ny7KCPQglCkQJTC5sNFSXZIQ6yl0dNpMrfe49dhrg/feFCahueXafz
   vrp1x/y7WaQH38F0M2wlaimeihx8DpQ6nAc9CD3uDX0WDQ6E3ONYh/JqL
   Q==;
IronPort-SDR: vnqB2gez3U2mI1uMe/5jB2TFUQ9H8d4bRqg8HhCv8FE26x0wfehyRHm9acPzncyT37uPfU0QYB
 1bC4tnn4FylcRkYnsIZrgLhVvUw1SOIMvuyuypvjHPXA7c1wpfDu5BgaC+Ki4roIp7irLLODBy
 AdTvJ4kzj5Agz8I9J51wmzZvmuyVPyxektVKnyE1SGZNfJHoQ98AnR79xP3jTTb1BuEhCQN1Rt
 S1HfsY78/kb9obOmhicRC/Uc8dx1fSliBARE7B6Za+YPLhJKpBnAE8u/XfCBHw2bdNqdjLcDXP
 LX8=
X-IronPort-AV: E=Sophos;i="5.70,321,1574092800"; 
   d="scan'208";a="129009968"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2020 10:33:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDwcHxnTLzCkwXivdpDQQO7QgPwLWRH+CboKZ3ZsLuBsXWeCJPD1/wePa2y/R78VGeyBrbXu/RCnsu0KnDFuYJ7fVNyzb9Hz247wXZgi/uoxD4p5kWIg7en/YSoMavRpS935zOQo+yPW+zGS3XvokLxX6wBUm25AUZuUu6gvqo0PFtHsdttnKNtdb4OD0aHdDH/mt+yPnAVYeo4w/oykaN9AdLDk7ylmngrWiiP9VG+HkeVPKc8JylJMoxGCT0+53V4lZsxYKJOyvnHSA30m4gSWDMdDwqwsZbn3iS253pYU7l+lQKreN74XeSBXdR+knKeqG/98Ng06SJzMnGneSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyGLhBXlOVb74kkFm3YuptdbEXFgkQ7f0XQco2ZOrho=;
 b=Kc2JCLwyXm9N/efxxNPBHYet1JovcFbhNqjglmJ2LO8vQHF7qwsjvhm19zSxMv9v5FXu9FAxfI6moBGZDiSQWmzFT9csjb0miyP7W6ToylSt2K7Ly/6Gt4qcLsoAVUnNNytj0gnl6eh0eBGTjRd7uN4f33VCrc/ezqKiMKe4dMd19ROZMhccWHoOfTdvLh1B1sEm+yvDYlpEjHBtFQk7ZVbHlVSjiNJOwZYVs3PugEqxNfoCaPjFlvfH5cMNS0970Wh671WNHhNI0CAlEmhZ0lFXsL2ujL5mTu9v7+UKTXbLnSSzsAKkeMvudoux3vPCfMNOdbVCf4VZLMxV6Dt0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyGLhBXlOVb74kkFm3YuptdbEXFgkQ7f0XQco2ZOrho=;
 b=N6zjT+y6QjrWCABhr62Tjnvt7GoJTjy87JLSltpCDVpY1KR3ouqZMBxxfJ3yZ1cqO94VAgdXDRCWWDkOCDb+pnxWpnZ0tlHVyjLkPXN1fsp14v041k3hU4m45CQvs8Wp8nm6ROVLeFtu9zB3J2g9lCJkkOAXIce1D2lxH392lYQ=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2266.namprd04.prod.outlook.com (10.166.207.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 02:33:29 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014%12]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 02:33:28 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yuehaibing <yuehaibing@huawei.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Topic: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Index: AQHVulgQExCdjuBytUKA1yv69qLf+qfLyO2AgAAnP4CAACbggIAfDJoA
Date:   Wed, 15 Jan 2020 02:33:28 +0000
Message-ID: <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
 <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
In-Reply-To: <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 339d4532-60f2-484f-4d8f-08d799634e3a
x-ms-traffictypediagnostic: CY1PR04MB2266:
x-microsoft-antispam-prvs: <CY1PR04MB226602172B91432F32DA7675ED370@CY1PR04MB2266.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(6506007)(53546011)(26005)(8936002)(2906002)(4326008)(86362001)(71200400001)(186003)(5660300002)(64756008)(66446008)(81156014)(81166006)(91956017)(8676002)(66476007)(76116006)(66556008)(6486002)(9686003)(44832011)(1076003)(6512007)(316002)(54906003)(478600001)(66946007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2266;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a05beRjcdketrd9c2Uosu9qCxhtPRdn9deMY8zPPRJ3fscg+zE4KIQYtp+wk42f9vg1dTyh5YgBDP7+KWFD9VvxqqRf4fIbwrysaFHrQY78tuz3RFZhKdV+5DeCWw7tKlt7HU3YyrVTTO7UeXplABU+PBvIXqJR/sn1JXyaLdQrJ+KhoDA2Jziyg5EpDsLVI/MIVvbq4T26WPIkTffAbTR6Me2VsOkmevn2IHeeO5Qc/mxEustQr00QcIJN05ifTp5g2oxuWtisQYmg7kbpT1I1YDNkLU/l6RsBj95tfTJq4Ml3IqptCd8+5YiUtfU26m/i2pySeXPBZPEPUC5SvMaj8PviC5cwE0ld5Z3m3pEh21uDoI2sQfQ1o8EQrqtjG3LH6oC9KLk7UCHHdyJUDt5xp6ypggkrOQKum2+h18/SDStYqMBf+CFLewFjXfmco
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <564B674AF41E8540BE93E33C34484B50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339d4532-60f2-484f-4d8f-08d799634e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 02:33:28.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QX7kIdKKvuHxnFfJPEjEjq/4Ho6rlRO4ZKQA+q2xZdrvakFen2i9VUN1Hd6xTTSbE17q6EdrUNMZ+bkOlwkxO9CfFkAo8rzBR7rVx0DmRs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 26, 2019 / 17:24, Shin'ichiro Kawasaki wrote:
> On Dec 26, 2019 / 14:05, Yuehaibing wrote:
> > On 2019/12/26 11:44, Chao Yu wrote:
> > > On 2019/12/24 20:43, YueHaibing wrote:
> > >> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> > >> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not us=
ed [-Wunused-but-set-variable]
> > >>
> > >> It is never used since commit 362d8a920384 ("f2fs: Check
> > >> write pointer consistency of open zones") , so remove it.
> > >=20
> > > Thanks for the fix!
> > >=20
> > > Do you mind merging this patch to original patch? as it's still
> > > pending in dev branch.
> >=20
> > It's ok for me.
> >
>=20
> Thank you for this catch and the fix. Appreciated.

I have merged YueHaibing's change to the write pointer consistency fix patc=
h
and sent out as the v6 series. Thanks again for finding out the unused vari=
able.

I was not sure if I should add Chao Yu's reviewed by tag to the patch from =
which
the unused variable was removed. To be strict, I didn't add the tag. Just
another quick review by Chao will be appreciated.

--
Best Regards,
Shin'ichiro Kawasaki=
