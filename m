Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62642067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qaVfTWUQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F3y0EjPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFCWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:34:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15517 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgFCWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591223678; x=1622759678;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=S+7tQQLKiE1NMaEu0us5Bre+bQi9UrnEfPbpkfRElwA=;
  b=qaVfTWUQNJZQJ5ELxbgN6t0g5qSe/RaaaRoI5Zslb7ySTKACl2zoNaZW
   gc8+hCH7O9XkxASBNgHc631isj9tXJYPGPUqPsWqaDBThnEuw9Uvx4kph
   8LCDuhrmBLeDtwnQh3lPpL1aRIdBn4Av3SNlklK/CDGBC+T6/Jwxq3wWD
   scGFsYw/DYHqVX8+Lwlz5idpYfKJWOm8NHZ+rExkRXRlZZeUr02BPyD6i
   80FWSbn05D7eYP5aH/y5V9MsSLyVIHcJNLxLGmBE75iyfw5VVBMO4q8Ai
   Y/UeKLZRV5ibuWXThgnh2hcS1JWBHLv1I5VmXQg3C5yK8Ha3yJac2wrzU
   A==;
IronPort-SDR: lJybmMA+phi2oLLNFz9S82RUX+hRcTuWy8/vroKGkqVvE+rTOTMg25gUJgwwePhDJutxmPsZNo
 oN0hMerGaK1pdsCbrpl1E7gRrf95ss7EZVP4WwlvGV8TSuNSbcnIBkV7DSy1kr2NuCGTDmpf2l
 02C3JPswbbMHDZTpR8BE6wmydhgGPUm2M1IxUY3ZJueUpGe6iKwfQ6cCxEDA/5fB8G5D6eELCp
 CJ5rMPPfW3KSXznOGi5AmQCAOUD4ZUj4z1rMLkYNZou2/MNvO9SbbV2WXcjP9zNYvVw9Yz7JuE
 7xE=
X-IronPort-AV: E=Sophos;i="5.73,470,1583164800"; 
   d="scan'208";a="139143251"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 06:34:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjYAW+DeYYOCJTPaDtJnbqUAnv58FWQxgnhXKykg9Er55IcHTxN3h1xCj1WK/i3VcnLhBoXfvGvoJbDvmFvIhDn6lM1y+aCe3nREWE8GO9VuaRm7O/f/Y5w/GrG+WJPWdB3FRGoM+RYuhPIwvorl5ANC1ngtV9x2bfO+QMhGb2xzgApIStsJ8KqVXSMDxFPePGWd+KrSNg+WJnN56zI5JQ/LvLKOVzDcTH8SnxqX5c98SNP2PtBEJo+jQ/AZsowPNgquRYrHB3chQLaiTrQacD7yvGnYFzfKz1IQZiENaOLuru7hFozUqiGA34CuUMad/KOBqhRCp/TekrPXkJwWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZhYxQFvjYucjwkI+OTGTlww1kQV47s0QZMA8BeQ8zc=;
 b=BHGrqsmtdfX4JjxlrFPQ073TPDIi1+0Tp2b/xIQ9Hh/rLBnEKdEipq61JeQOuV2gF/gbf5rkgjVXyM1MUktHgcStSEqFrtTwurdkMIjS0hIIjo5kjAt5vP4Nr2jgVrV1yP91hYjSyPW7E6jqvSujaI8IkB7prNWDTCHemEPmycFj3DYtYZpFajeT5HcSUEOZKdkFScbilLWff4nNLBNrDaAqV6/J6GfEN03snVGoLbh/RpZlNUk5UEKYpnNcSKOQB1JWmCvPmUx1VISegoePkxjgjcsPtbAujkTucA2W6OUWJF4C7yrT4a2X/JyFpXtS5UtH87YtP+GNKQWnuASaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZhYxQFvjYucjwkI+OTGTlww1kQV47s0QZMA8BeQ8zc=;
 b=F3y0EjPDz1xtTzdeb9Eg+Az3rrS2S8cQ2BOhVTr25dz3804oQPVN/ip/3Mv9yD9IeiooXx51PgwYaZytpC7KdWXcm2ikU64ujDjbouizx8FtheW50JES1HGzJDuqy2/9bON8TH5RU/WGFW1vXJDOzqV3u6hffmLSIArc0qDety4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4792.namprd04.prod.outlook.com (2603:10b6:a03:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 22:34:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 22:34:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     kernel test robot <lkp@intel.com>, "Jan, Kara," <jack@suse.cz>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type in
 assignment (different address spaces)
Thread-Topic: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type
 in assignment (different address spaces)
Thread-Index: AQHWOZq0JeGPDjwwNk2lvn18OjkZKw==
Date:   Wed, 3 Jun 2020 22:34:34 +0000
Message-ID: <BYAPR04MB496578B5C8F42E1639F56D8A86880@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <202006031903.CiDVFCgm%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcad22f8-9cf4-4957-1a15-08d8080e4a82
x-ms-traffictypediagnostic: BYAPR04MB4792:
x-microsoft-antispam-prvs: <BYAPR04MB479223346AA64393371E9FD786880@BYAPR04MB4792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbJmln0pfRCGHpzUAKanX2lksuvlyLLJ2yh1G+JfbdGf1qhiMcMMvxTW3WS2eosEv/2BuBiKgz0kYjfyNieQOeMm9Qo7NAQSErkzD2FfUFD6vym9UPVYj8fs6Tu663fBjKHsYWp5zjkZyGSc9x/S+tkXBvkokZ2QHIEcBQ2qDzdgv+ucaHiVaCXDn3KnGrubix7T9KivmZrQV1eKvfkFBtAeQJXtZ4s40ZUR/vXaNG5plN1wFhCjGXJu+pwfbe1xd4pVezQH0Ok6oFc7QvA2V2xqId8GtSeYf/U0HlzMi9WCe6KDVSyDan6QDhtGMAC4e5vbGSq+wk7yB6MqOykoHmsOJiOtUdmx3RXAHjzqBKbJPHndFT+PJwv+Z7qjpN0LZa2HpVC67TUC95djDESFGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(66446008)(64756008)(66946007)(66476007)(54906003)(66556008)(76116006)(4326008)(71200400001)(52536014)(186003)(6916009)(55016002)(2906002)(7696005)(316002)(4744005)(33656002)(53546011)(26005)(5660300002)(8936002)(478600001)(86362001)(9686003)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PkErdIyQ+3I9OA6s6jLG23kD90OHxKTQ85we2oX0ALE+m0Y1Ypuzjf7Yq8pWyBZD94V+ZmWFxZXnjgUzpQyxEsUZTthl/dgGu7DSt2a3ksjqyNXPAYWOSq1lQjHU/mzAkxNJwVEnD8URB+LAlU5eVBd97f+NGmCftsqHkIFxImjdSgRPIOGm7cGN3xfoPqSHXurHkGkDn/HogqCl2EjuWUHK/00GbAtlsHIh5YhQ2zJj4QcozWxY3cXOR0WGouXtEGh0iVgRDbPDGZSKlcqQZF3hBDUrJeB5bG+wW1lzXiXxOovDx+6SHNwcYriqwJmd8CaH6ZRNfQhf7kziPGlgubIoZ9RGHd5MErRu8ZGHxGoHvb/n8mqzWF4dxU5cevI2ukN31ztfqMtHwIwJ0DoXasgL50Yzif5wmKtvIISK7ydcsS1WU3FJS2hBi1dLdXFyR61wS6wopNfN2yw0e9SgpYWVsnwz1gv7S4DkxkIooA0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcad22f8-9cf4-4957-1a15-08d8080e4a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 22:34:34.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7y8wys5AsxKp2eP3MdiyMRKWUlUVYpSBuloAxZ70AUILM7zXbJar7EIDIBDtceQMi0113eZm3Pfjl6yfzVlawE+UcAUma7bXZ0ivkVSdOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,=0A=
=0A=
On 6/3/20 4:32 AM, kernel test robot wrote:=0A=
> tree:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  =
master=0A=
> head:   d6f9469a03d832dcd17041ed67774ffb5f3e73b3=0A=
> commit: c780e86dd48ef6467a1146cf7d0fe1e05a635039 blktrace: Protect q->blk=
_trace with RCU=0A=
> date:   3 months ago=0A=
> config: arc-randconfig-s031-20200603 (attached as .config)=0A=
> compiler: arc-elf-gcc (GCC) 9.3.0=0A=
> reproduce:=0A=
>          # apt-get install sparse=0A=
>          # sparse version: v0.6.1-244-g0ee050a8-dirty=0A=
>          git checkout c780e86dd48ef6467a1146cf7d0fe1e05a635039=0A=
>          # save the attached .config to linux build tree=0A=
>          make W=3D1 C=3D1 ARCH=3Darc CF=3D'-fdiagnostic-prefix -D__CHECK_=
ENDIAN__'=0A=
> =0A=
> If you fix the issue, kindly add following tag as appropriate=0A=
> Reported-by: kernel test robot<lkp@intel.com>=0A=
=0A=
I think Jan has sent the patch to fix the rcu and I've sent out the =0A=
series to fix the rest of the issues.=0A=
=0A=
Can you please let me know how can we proceed with the series so that=0A=
we can stop these emails ?=0A=
