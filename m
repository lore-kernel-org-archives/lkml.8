Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBD4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q4WIfbM6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ByZkHP3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgENGZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:25:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19984 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgENGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589437504; x=1620973504;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i7AN38q5pRlVPFTkOzgDYjOWI0o6MINPdPG6c4XPMSI=;
  b=q4WIfbM6MV76J4bCqZ7dJw7zbf1jhziGljPcToFKyzFE9Hx+NArjIDhH
   6nTLySbMkjktiwZmSHIXhLQJGTryd7iMyiPHvDJRMrAVrKmddUkcYoWEe
   f1WbGhka63s/3pf6+ZyLaDQcPtSvV1jEUvVv/WNyweFLtUiuhfHiKJdNz
   V8TIT72IkNToedMmmGbjUXldtTkiK6zTJfa07sv9O/4xKE635KIiKPfHH
   RQXWzFqxY4MMzLqeXioT9gPG8iMl4HWG97MxJPmuuHxn9juYHHvxYkmlB
   u1udWR14Rlc9kZF9x9PE8LphHe7PbbvUHHrpRxg6QAdw8g/dx+2tGZhR+
   w==;
IronPort-SDR: LBZMWkWw3Sk0sbCxJxJ04h3CCAQjah7YsLyZjKZTGP5WtzzXOaQvJgio0e/oT1f1C9z+9PXeGp
 sjeezuWnrjrp4na1ZTW+T7zazq2z3qkyJatkZ5TeucMJp2DW3TLrXt4jXD+HXo8HrqV7Y0iO6v
 ei4tp33V1ycDjdDs9JN1+1Rs+39nOegEo/tsWfWeY6515QHX1mdRzzAQXrSwz5NUVjCn32kzdF
 OUewVm93cgKzbxsNiZSwuSpeMIW97sdgmxnM/feFgIOls/Ne/fgBq43y2i2VJzsDCVOkLl1//N
 GlI=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; 
   d="scan'208";a="141997274"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 14:25:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Alj9c7M4t0MH1pe5LiIURs6Aoe0ntB5Y6LIAHWSTNztKPdqou4Jk9QWBygt493G4OawTEylupKL7hTZ0aECAfYf3pd0kEvhyzgKv9ymElKwWEOolRoGP9RvB5mQS0t2lA0FfPPDduz5KWYlyPv/e3h/42mwnf9HyNMXio6eD3MoiHn0o8OFxSFhePFHJihoN49zne5IezEdOdryKm4CB9637Hh68g+eIE8xHRZKitkTffPkOoY/WQaWLtZBgVaJZCZ02uusfHiyXa7MUYXl3IzQmb+jKL1mDptRFn2DXLuL+UuYPbHbsjgjH4uKL96PaTCPBpa7EH/jaUoZ5zdpaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taVPfqp3E8qSTozoiVoKTd1XE5kIhs3SCxtjwNbgg4k=;
 b=GOPUJlnHBc/C59Y7dZ8g9FX5QrBYp5cN+2rrHcAyMcK2WNnG5t4l2tzNT5BiUBnR5bh1o2OhDyf5RdWWxtXjMoBDCD6tR3ol6H3wHVvTBm+23Cs/d3tHqdjSSJYUvJtEi0r+axnYVGiO+zOhIyY6878Xo4oo4Z90N/J71e0kU5ITYCvdgLNNLhjBhHmduQPZKbsRRr7W2K5ZyM+iHmW2sEK7zyfQ6UjzsPc6jeAMGHBEFzC3nG07hFW34wkZJoWd/T1usUfJbxzdmf72VkId8ROPWwiwhbtTysIhNcyEXpahWPZLHlojVkXmqtPEVLfUBXXZyrpN3dZq+feNoqOpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taVPfqp3E8qSTozoiVoKTd1XE5kIhs3SCxtjwNbgg4k=;
 b=ByZkHP3wSpldyrv7HdP8IQFngHh9W+4IavoQUBx0ujnRWykYWSL7QLwDOIkltnjrXii9aKDdkrDq6XafMR8X36D0fEH2k32BC4IqndIGsxgESwOB5/rlGfgtJ4NXkS1ndX6ykG5Q5jaMmsPZuHFmN+kV5DIH0X+PSXX+O19rdB4=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6568.namprd04.prod.outlook.com (2603:10b6:a03:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 06:25:02 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 06:25:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH] dm zoned: Avoid 64-bit division error in
 dmz_fixup_devices
Thread-Topic: [dm-devel] [PATCH] dm zoned: Avoid 64-bit division error in
 dmz_fixup_devices
Thread-Index: AQHWKbhmdVnJ21yeQka+Xv+gMgyG9Q==
Date:   Thu, 14 May 2020 06:25:02 +0000
Message-ID: <BY5PR04MB690080527BC91E2DC9EDF0BBE7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200513084521.461116-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6021e490-5272-439a-2754-08d7f7cf8900
x-ms-traffictypediagnostic: BY5PR04MB6568:
x-microsoft-antispam-prvs: <BY5PR04MB65688C47E1AD929235A1DEA7E7BC0@BY5PR04MB6568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:162;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5JIUI8vJPb/NQ4Wcl2qTNr2TGsk68q1ybhBqEIh3myA3jvlfkw0LXUP2gLIvK2HABstf7vobpbPPRClyldW3klEOLa3gAfUCx/5GmkR4IK5R6La5T+dWLJPyfYwiEWv7jOti6gfOsdVShKWdl6jdnMhgyVtVZK53+kkCxW2YXH90GTFN6csYHfG8aXbJL5tLKSFnehaPlkyDjXmw9UsDvP0//lcU4sVnS91y+T9ZK+kva/VR3vW9S83b4FC21Bg+ikB7iDpp3GMyClayncfe+TtESlIhXqpxB70lzME7hwQcTuD2NdHnDDdx6rfdqilB6WTycttHC6EnZHujYonKOASVrXfqSolJLbiZ90rtbUxP/5o0Ym1HUr0mVA1J+KSX+uGZjouesUsUlKMU6fUsWpbArAryNwhiOdPXNMUHt+U8mSL2QmDNKmxSUvlGwe8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(55016002)(186003)(64756008)(110136005)(66946007)(2906002)(76116006)(316002)(66446008)(86362001)(5660300002)(66476007)(8676002)(66556008)(6506007)(7696005)(4326008)(71200400001)(33656002)(26005)(53546011)(9686003)(478600001)(54906003)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oTpTYmZGfKJTEqP0QZmlzksQo0eTsutAHdbVg1l7JpbJzYo7mLb7jsWgcpdg2OdKmQIaDWKrk0vuh4zriONWUSn9dJpDQJPl6lzzBI6gDTCqYhaxL5NUf3RKiVHbzeGe0oGn+CV6aWA6uTbxCwHfOYP2ZmASZkoAXOPYU1+ttgTpTSx20DUcdaKvTb5H279/jZDSry8nS6v+3B01Eh8WDaZAWtH5MuhbcfdsFUkUNu2Se+4eFz6nEweEMZzt5YMS0QXuGYx+IxNLgDLnt/C4hfMZZ7Qd6n1oXjMHq/3zSHP2ZgkUPrGUGND/s8hCNY8+q66zO2t1qq/eH35as0GVS6IC/3ufPsFFQ/cmcIAThXGdUyj2qexELIRDwc5DNK2gUcbvbUKVnRcV3XrF0m4yCFYAGa4MFHdJRyX0TCKZQG6fTLM1MYRygBqB3/xUSiO0z0i2Uqa4XHyjBUn/SCgTA+8x3ZF0X0AndytFmj5UpPkC3ldhB8NHQCHBkaNhiPfT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6021e490-5272-439a-2754-08d7f7cf8900
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 06:25:02.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YlOpcy2KDbyuWEcI9igUkS+WmsGogclIOcWGtF3jH1B0PaIKhUz5FH1qznN9IaBSA7vv5ZAhkh2H3Qs/L9fag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/14 14:07, Nathan Chancellor wrote:=0A=
> When building arm32 allyesconfig:=0A=
> =0A=
> ld.lld: error: undefined symbol: __aeabi_uldivmod=0A=
>>>> referenced by dm-zoned-target.c=0A=
>>>>               md/dm-zoned-target.o:(dmz_ctr) in archive drivers/built-=
in.a=0A=
> =0A=
> dmz_fixup_devices uses DIV_ROUND_UP with variables of type sector_t. As=
=0A=
> such, it should be using DIV_ROUND_UP_SECTOR_T, which handles this=0A=
> automatically.=0A=
> =0A=
> Fixes: 70978208ec91 ("dm zoned: metadata version 2")=0A=
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A=
> ---=0A=
>  drivers/md/dm-zoned-target.c | 5 +++--=0A=
>  1 file changed, 3 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index ea43f6892ced..9c4fd4b04878 100644=0A=
> --- a/drivers/md/dm-zoned-target.c=0A=
> +++ b/drivers/md/dm-zoned-target.c=0A=
> @@ -803,8 +803,9 @@ static int dmz_fixup_devices(struct dm_target *ti)=0A=
>  =0A=
>  	if (reg_dev) {=0A=
>  		reg_dev->zone_nr_sectors =3D zoned_dev->zone_nr_sectors;=0A=
> -		reg_dev->nr_zones =3D DIV_ROUND_UP(reg_dev->capacity,=0A=
> -						 reg_dev->zone_nr_sectors);=0A=
> +		reg_dev->nr_zones =3D=0A=
> +			DIV_ROUND_UP_SECTOR_T(reg_dev->capacity,=0A=
> +					      reg_dev->zone_nr_sectors);>  		zoned_dev->zone_offset =3D reg=
_dev->nr_zones;=0A=
>  	}=0A=
>  	return 0;=0A=
> =0A=
> base-commit: e098d7762d602be640c53565ceca342f81e55ad2=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
