Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED9C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4E24671
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iVh6xqYv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hY9vW/iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAPAZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:25:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36273 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgAPAZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579134354; x=1610670354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lojlN7w6bTnD4GHbi2ZtcM1bHOB/S+6l+otPG1zpjAI=;
  b=iVh6xqYv2OSlTZ8i3K6+3cNGXldzcsdJKwBdkPH8hSAaIW413dtbyztz
   MDnN4bd2Y9TG2mnYhR6/GeOOw7AoFqVgLoFDbj26zuF/+EzfkDMFvsRPU
   u70qyKBh4zIyDDIUCrwaHyGF/XmDrgXkTCc9vn5deapS9rG+E2qaKPb7h
   U3pXLnrkSxfSv52Pt3DDw2aJHcdTOjKfJFtedZsf+UIKoe1SfiimbQ0VT
   YTz1GbiteuCK0PKx3j0GZOc094LjR1/fi4A2pEWDa/3+FsbKLRh/TJCoq
   xXBy1+H/CTWCk1/ogr0fAOyYO0BVTqFbA7msBpjNzyXyhuE7NvaGaDItp
   w==;
IronPort-SDR: M3m7FjSuxvr2lfdNM3u0L2ePD+w8ovjL5fp4yXIBgg0jcq8+WzvlHOh2wOgZwMLyHvUzr+2SNy
 W9YJ8SHDCARjSIPnLkhy8EdkUz/dovTukELXOOyLFKZ+/8TnN4sTEAT55TVQA/Eg5KHt2swDDr
 7GqcMd3h0cNtYWKzs9CBdDow94j5/dFjTVwq/Usvo/bzcYBXFFMZryrstMUp4Qsve+PVZJaPEM
 BcW+aVZ/Wo+knjbphgF3Gyd3Ixh1kbR82nFRGtJsfGRhut8r7MIJsDSG+56Q4ONuTUc7o/8/k7
 5Z4=
X-IronPort-AV: E=Sophos;i="5.70,323,1574092800"; 
   d="scan'208";a="235410904"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2020 08:25:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzVHzJsgTj4skcmYylw4Dpc3RkTmMBn31FXwvelncMVtYq1kZynxPHtL8LrVF7Kx2+88UMQ/RzjhsNxpPA4S0S/jIm4GrsB/MrCb4iPM8Y+G8wVptJCiqnMI6aPtrHvsgKQXXSqEMV935cuwTCFQwUAJY/ZP8LgqI2QDcHmUJoRER+Rl+x9by56nMTN/6PJqEvjAjwkGvC8oVv+2DZcSOfGRK7F5MJNx9gesj/ZSxMzZH1Q4G8/rAi4sXdVIfozUI9LDXXKDc7Fhh7bHyQyE7Z7d30vf5Vp9ia+z5lGcHt9MeTrPmUzVEfCgiteGbGmDhl40mnIpeoO0X4ZamC9rVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lojlN7w6bTnD4GHbi2ZtcM1bHOB/S+6l+otPG1zpjAI=;
 b=j5jpHHPb89ZCEWcgJ51Y1cKtYFNBHRhh4plNeezJ3zaqe1WnEktRdiLC4KQbnoQSa6QevbH+Ee8hzYgzDEGQHs7qikmTNeA/2SnCqfHemd5wh4VUhVz7yOQ9HasR4Cp6GHsTesN/X0ZrXA1gaK6un9v3ZbGDjT7z91tFFP6/FeIuRbvu/BX5TffvnqUyIEcI7T5w7yFkI/zEw/th5AscecnFHGqeaIxT2vxJ/8UdeizvgI208htnHDphGMj2PXSUSHgRAazoOZ6xlL9sbMGC8KTu4EL77qTGgkH/C7OKLDLiS5YGmSN512Ov/cxyFJjzggG9IOcQj3yIhTMGe40pmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lojlN7w6bTnD4GHbi2ZtcM1bHOB/S+6l+otPG1zpjAI=;
 b=hY9vW/iBG9RzBRvvZudm5OSCCv3cI9k8n1HSXL3XY2MZiBE/w0JJFQuFKhPFKlauwqV7T0sU0IU6HEHPAY0ZrZ9aZ3B0zxueCkT4HD9FlExSGFUfbEUjSZM6VWymEddlwb68WRIMy2g5eBlAkvLG3cCxqQCTHrWs1gwogb/5ejk=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2169.namprd04.prod.outlook.com (10.166.207.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Thu, 16 Jan 2020 00:25:52 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014%12]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:25:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Yuehaibing <yuehaibing@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Topic: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Index: AQHVulgQExCdjuBytUKA1yv69qLf+qfLyO2AgAAnP4CAACbggIAfDJoAgAB7MYCAAPN8gA==
Date:   Thu, 16 Jan 2020 00:25:52 +0000
Message-ID: <20200116002551.oq7hxzyiazppalsb@shindev.dhcp.fujisawa.hgst.com>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
 <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
 <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
 <0aea7754-2114-cc78-3453-bc608bacd45a@huawei.com>
In-Reply-To: <0aea7754-2114-cc78-3453-bc608bacd45a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5a5b47c-b690-4546-df4c-08d79a1aa4f1
x-ms-traffictypediagnostic: CY1PR04MB2169:
x-microsoft-antispam-prvs: <CY1PR04MB2169AB8CE3979E306D260691ED360@CY1PR04MB2169.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(5660300002)(53546011)(6506007)(8676002)(54906003)(66446008)(64756008)(86362001)(26005)(66946007)(71200400001)(81166006)(2906002)(66556008)(66476007)(8936002)(6486002)(186003)(6916009)(76116006)(316002)(6512007)(4326008)(9686003)(478600001)(1076003)(44832011)(91956017)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2169;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEIC+d7A6oy78TsAzsnimnrbPGASAZ0BggBvQF0SmaMEwuC0b5+yMwETKHy/0Mut5qSIldncySjZJYEcJ84Z9C/2kt8YlcVIZE9qGIIc48Zt0dcS2MLZ+2+fB/dKINIAa/zWbGwKtJEqwZLuwtaEQT/sg9QWxLx4UmZmMzHHHf3hIhqgHua+T6XlKRhBSwVXXR+VrnKrGZdF7QUhAmJ8iDrYI+zIPfMPW+mf2nRc6HwH83k+0v9ZGN26ABUvzyQltNVX785LvIdSThKalq3Nv/D+s0cF3Zih5rBeL3YOliMdwya17j4SCBLbqTm+sxN3XJ0r6+0mpyQMNBdS/q7w8DJkGwi1cBk7Ct4i7yBXbddmq7Kd9OOk9+EBQ0XnpSu6346iQ2w4xihhC1yINrE8Rxb4zu4NV4bigFWql8kE7gnJFzdlgcMs2wbX+QeqYXr2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7ABFD392685E8468F3FB9E7BA2D6DC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a5b47c-b690-4546-df4c-08d79a1aa4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:25:52.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ria/9qiXo+nlujZ2L2i/2C+1RxvbPEAEQHtmbvKA5kRqRi0x+6/Sc/2bwuB4ejqNCgmO77hDtFi0OJjwffz5/s/ucG5sUIp5QPrGci/6glQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 15, 2020 / 17:54, Chao Yu wrote:
> On 2020/1/15 10:33, Shinichiro Kawasaki wrote:
> > On Dec 26, 2019 / 17:24, Shin'ichiro Kawasaki wrote:
> >> On Dec 26, 2019 / 14:05, Yuehaibing wrote:
> >>> On 2019/12/26 11:44, Chao Yu wrote:
> >>>> On 2019/12/24 20:43, YueHaibing wrote:
> >>>>> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> >>>>> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not u=
sed [-Wunused-but-set-variable]
> >>>>>
> >>>>> It is never used since commit 362d8a920384 ("f2fs: Check
> >>>>> write pointer consistency of open zones") , so remove it.
> >>>>
> >>>> Thanks for the fix!
> >>>>
> >>>> Do you mind merging this patch to original patch? as it's still
> >>>> pending in dev branch.
> >>>
> >>> It's ok for me.
> >>>
> >>
> >> Thank you for this catch and the fix. Appreciated.
> >=20
> > I have merged YueHaibing's change to the write pointer consistency fix =
patch
> > and sent out as the v6 series. Thanks again for finding out the unused =
variable.
> >=20
> > I was not sure if I should add Chao Yu's reviewed by tag to the patch f=
rom which
> > the unused variable was removed. To be strict, I didn't add the tag. Ju=
st
> > another quick review by Chao will be appreciated.
>=20
> Thanks for the revision. :)
>=20
> I guess Jaegeuk can merge that kind of fix into original patch, and
> meanwhile keeping old Reviewed-by tag in that patch.

Yeah, my action looks too much for this fix. I saw the fix merged to the co=
mmit
in Jaegeuk's dev branch. Thank you Jaeguek.

--
Best Regards,
Shin'ichiro Kawasaki=
