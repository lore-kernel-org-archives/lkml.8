Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66FF20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PgylrWXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHKA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:27:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:18268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHKA1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:27:53 -0400
IronPort-SDR: RfyLw9LOYLwxPugF6SH0ZvzlpcOYAPjmZ0xIGXZFH1K3PEcu7scOyputaDzGgRYPRF5gosbgzp
 o26AVxEeSS4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141256649"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="141256649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 17:27:52 -0700
IronPort-SDR: CVRk1xVlYd6goT8ZWUmGZejHjMVVLm/YyRZzwNRsnqwd2t1sY1EX1vJWu96arTK+7D/FFOEeUF
 AjxdM0IwfwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="368795537"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2020 17:27:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 17:27:50 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 17:27:50 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 17:27:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 17:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUvWsBpg8vbcvtxXQLULltkXJll33pWl38lJrjYnBmGRJzBso2ut8CyIqh7m8q017XnOjJZLR9E0QEQrien+vL1Mi3QsSzapVFGnDG0NpTSgEj4mJ82cH0/0tEINNy0N5sqomZN7K/BZH/K1DpPHhs7a03nM3p8eTFb8sMG8AQBRFOCymFgS+JPJau4FyFaMkw6pxVKaMR+PTjUonyWXIXCAUgZ53u8S+t34QOZBqJ99I+pej1fS+QpICzAl0h1uNUu5DweuU7R1yax+GqpA/BwHP/XKeGCx0FbG7EJTie4FylhgSzd7qvpPrV58wmh/7Zyv1NwNBU3R2Yjq01BDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niQNXfJBHMjqAuv3eSo5cYl3UmKVQWUtyC+SMGNOHF8=;
 b=bcKe4Wl2c1tO5tBNeQshyUW1zw94/igzC1/pmM2HKZ5tbCWChufiOKADe5+IfNIoDz4WN1K+WE40IOyAOJbcdhS5zPB6h0lNBNmpWGxaWG/jxk/qxZllInmbQAL1OOTkmk/K7TsJmh5LnjRIOxLAlagCoEnCXXu5IlVv9hlamHkWp8BVorprQu4dQuqUj3DNnIlZcfbraYsUGLJt2nWZGM/IkfKKPjiSF+jSVlIno8+plRmZtVISy/yuWG/B94FFJtBk+v1gBgAGm+GZUi3jg06pXuvSWLXChZlDZJtpFUu5/J6Atw75bHTpPZVFff5gxN29kOTHvjA16fgp7hQjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niQNXfJBHMjqAuv3eSo5cYl3UmKVQWUtyC+SMGNOHF8=;
 b=PgylrWXIZrc8+9uwqRhqzISdG8hEH9Tbuk5zEl4SeG0LyB3O8y0HSnQqtcU5DkiBHwC409WbBQ25i0D54F3V2h1MuvAmsSZeyiSZuUcmyrWAsGcK5Jz9TsegdCoJcDWmH1lUJqaAiIT3rLcSOVl5xlEYTXEbQKiHPuTaCH8Jnqc=
Received: from MN2PR11MB4064.namprd11.prod.outlook.com (2603:10b6:208:137::18)
 by MN2PR11MB3965.namprd11.prod.outlook.com (2603:10b6:208:13c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 00:27:42 +0000
Received: from MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935]) by MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 00:27:42 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkp <lkp@intel.com>
CC:     Johnny Chuang <johnny.chuang@emc.com.tw>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Subject: RE: [kbuild-all] Re: drivers/input/touchscreen/elants_i2c.c:859:45:
 warning: Clarify calculation precedence for '&' and
Thread-Topic: [kbuild-all] Re: drivers/input/touchscreen/elants_i2c.c:859:45:
 warning: Clarify calculation precedence for '&' and
Thread-Index: AQHWbEFY4LHhgVzd60ew2gUPhjRIW6kyE3Yg
Date:   Tue, 11 Aug 2020 00:27:42 +0000
Message-ID: <MN2PR11MB4064AF159BCBC162DEC6A6FDE5450@MN2PR11MB4064.namprd11.prod.outlook.com>
References: <202008020615.7WF7Tnj9%lkp@intel.com>
 <20200806223105.GJ1665100@dtor-ws>
In-Reply-To: <20200806223105.GJ1665100@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e1df7e-8f1d-4136-a357-08d83d8d5cb4
x-ms-traffictypediagnostic: MN2PR11MB3965:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3965CF5A8DEDFACBFABC434CE5450@MN2PR11MB3965.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:39;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3kYHjNaN6BIHsXqOW5OUf0PkoElannKC/1gvApHsfTWO+B2sG+g9+CvnVJ+DlLZ+Zh2UUYyIcvbmHVjul6D/uOnAKYNgYXeNUOBBjA3JDd+Xzt+miJW4N8MQJKkTnWIlPx7dF+QQvEM9KkK2s3kuc73w8mEj9R+o5mhD08cKd5GdhM+iMAjR0QX4binl+5mSrTfiiRwQoPgXAzY5TgmA3xSRxjAKMIilvbLiCPZ97W+BCpTufEOCU9w5bTm7ADrAwT+ZMWVfxJHvsVbhChBmZ7d5Bj6pn+ZDjF8IlcFfKtjqKmYWMiea0H5Fqm+cJSA2fCK6qqo8EtVUQPpLdOEUg+U9RClxEbWWE7w69YW7NGIQPDI8tku4V3SapZlP1o7mB++eM7f7z5vAPbg2+7dPgKXGws2QTPSCdxT3bMoQCMu5+6ck2TJltYLkzVNMRJBGe6GQ2q0bNofd057Q8ROeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(7696005)(66446008)(6506007)(4326008)(5660300002)(33656002)(76116006)(66946007)(64756008)(66476007)(66556008)(52536014)(186003)(26005)(71200400001)(6636002)(2906002)(83380400001)(86362001)(110136005)(54906003)(8676002)(966005)(9686003)(55016002)(478600001)(8936002)(316002)(70780200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EbsHYqa2r46Igt9ihgK4e2fVpuh/cmQp5kHHluOtfLXrAqEsuwjem9aYV17nElVYf5spgtkDxxJaw9hmyuhCYbCrUyH0g6Y5Pezipghn3BzRq+/qooqIVOHQNTYDXGY7eSAk3WaG/6GzadAt09iKFi4s6w/w1M9fwRBqivfMJwCyPurn+P5JF6Ipbe5DawGtEM0P8jQQRxmOAWhEp7aabznIXdXgJwFxbjy/miOgu9I7YjVyTWl2Hdcx3XfvLQKgwQOAdRVKxKbBvRWsNvrKUsx5IRE9cPChG9WW9T5PdtRmPfgLqaCBKqLrztmDMYCe0dGcIdlJgB9iEiYKmfmOSSLe/9UdQRhx3r+14jiRqqQjwKO7rGgJwSDKORTtxR6e4bDZ6wJyrDSyPQKFQS28wF7Oq6c98EG0CqLz+l4gSUuBOQIeyo9jPRsNVqc441Bbnkh1FZ44KbaGLRybvJtdRTB7F+vd8mBQ5j3e9suPu2yMTcBdztYw0sIx/wpUc8sTAAastQROGpwH/4U7JLuYs3/DjeQ9MOijy+zZOOsH+F2hOFtOSgSHlACDZ31CNjaGD3Lj/Zn3D8bed5kRnxM+cW3G1QrIuiaky2HuJ8AlCgUT8/eS4fKQkRNvMnF8g19jrjfyG7wGw2KuH0AKQeW+OQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1df7e-8f1d-4136-a357-08d83d8d5cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 00:27:42.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQT3NEvXXgB1zCK08DCN4ZGzlfdNsF39SQSnqNEKNeqbx7RBAqW04GUtwDkqkj0eFZvX13DNDQlBPQ5Z/HDIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3965
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B7=1B$BF|=1B(B 6:31
>To: lkp <lkp@intel.com>
>Cc: Johnny Chuang <johnny.chuang@emc.com.tw>; kbuild-all@lists.01.org; lin=
ux-
>kernel@vger.kernel.org; Peter Hutterer <peter.hutterer@who-t.net>
>Subject: [kbuild-all] Re: drivers/input/touchscreen/elants_i2c.c:859:45: w=
arning:
>Clarify calculation precedence for '&' and
>
>On Sun, Aug 02, 2020 at 06:18:19AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   d52daa8620c65960e1ef882adc1f92061326bd7a
>> commit: f27ad8932725f8dd0cd1a46763de4a40377b1ae6 Input: elants_i2c -
>support palm detection
>> date:   4 months ago
>> compiler: xtensa-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>> >> drivers/input/touchscreen/elants_i2c.c:859:45: warning: Clarify
>> >> calculation precedence for '&' and '?'. [clarifyCalculation]
>>     tool_type =3D buf[FW_POS_TOOL_TYPE] & BIT(0) ?
>>                                                ^
>
>No, there is no need to clarify precedence as it is already clear.

Thanks Dmitry. We will ignore this warning type. Sorry for the noise.

--Hui

>
>Thanks.
>
>--
>Dmitry
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
