Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851D3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="fwhDLsvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgFHNvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:51:19 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:22437
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbgFHNvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:51:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGYOx3yQ508GbTOScCvT62Rn1EofdMTkEipRnO3OiROOc46Ouhh72h9hwCIk/XZW6BCIAQdGIx5J6mgtYBp5TmzNhQJxWMOyeHqEmdr6VuZQKRi/ofKaDr+LZOiN5crd3tg0xvEZCIEYG7nEzDJcjgXJbZu3w+DbZ6pC2zRRWjuQxCTP+VGgHedqyRcHFFVI13Z9QQ2Xtsfrn8WvLuyA/kAi6RSYjOkUK2XVK0SMm0LPcfD77cweo96zbtaxyqrVy9LoKu9PAwsz9m4Aq+CH1h3ZY3IQocZqJzcwD7ch70mk0WcZw63OZ/LuZC8J7fTlKBMFvojivAr00UL3jDbVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jRfcpo2uzXqv9Ncr8Z6hQ9H9U/Xc3fkNqZj8OKK2Vs=;
 b=Zf13AiuZ0+3v9SJS4N38w2LGAR6YDVBjmtkke4WpYuLpUI7czcy3U+zGLb9mqKn7ibduh2Nzx8SqxS77nHuc8fVTtbBuATljgeU8Sf+zKr/js+6u14LQXKAj1GQ9m1m5+Pui/LElQCsdpLbFF1YxnJNZM5puyNcrm6Zm7sNgHiNjLbdFdWM7jlYfFANvVPBLXRVPSR6My/+d38zPJ8MCmp493h93PPwl4+fdVL0sIYJxm5TrY5hMxa6uYDIgXjAfRENGgGqJUBTYCUvKsayxS3Et3v+X5dIUX2GUWSwTlqrpTXotc0pSebGV/LYRcTwqAWjAQnWUVbHeg7u69qGSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jRfcpo2uzXqv9Ncr8Z6hQ9H9U/Xc3fkNqZj8OKK2Vs=;
 b=fwhDLsvFtz39jZfCT6D7qoMb4QS+4hPeTEacysKGzdxmxbrd9S6Rub+WKjvIJBRvcTHDz1VsNOTqMBL19itEoCcRg471+HXh7F5rqV24zxrZrrY9XRh7R8dfpH8ajfB88VL/puiq2Q9dl8hNtzj+pDxz83QpITIstZgYd+JNSek=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3086.namprd11.prod.outlook.com (2603:10b6:805:d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 13:51:16 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::c504:2d66:a8f7:2336%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 13:51:16 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/staging/wfx/main.c:47:14-21: ERROR: PTR_ERR applied after initialization to constant on line 42
Date:   Mon, 08 Jun 2020 15:51:11 +0200
Message-ID: <3809731.WTu3NreGyd@pc-42>
Organization: Silicon Labs
In-Reply-To: <202006082104.YV2sJc5i%lkp@intel.com>
References: <202006082104.YV2sJc5i%lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN6PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:805:de::15) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (2a01:e35:2435:66a0:544b:f17b:7ae8:fb7) by SN6PR05CA0002.namprd05.prod.outlook.com (2603:10b6:805:de::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.9 via Frontend Transport; Mon, 8 Jun 2020 13:51:15 +0000
X-Originating-IP: [2a01:e35:2435:66a0:544b:f17b:7ae8:fb7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c7f165-e90e-4d0b-9355-08d80bb30372
X-MS-TrafficTypeDiagnostic: SN6PR11MB3086:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3086408DE9E7C20DCF19787B93850@SN6PR11MB3086.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI724tyXtptwi/DPa2MYr5bMnMNbtlWPgWDxCCBZ6rAF8DxvEQNEikQOejMi0F4TBVoT/KURxaL0KKqZtXZ1h11hZ8Dk9yRI36M5RYrxoJx9oZ4QhzkUZTaQ+DHDV29xFzVC2ERHZ8E3RT/QKiaHSK2Ynt1Wx4Aty6t9oDKUgaJC3mnpZranTeZ17c2P6liE0pPcSSog1s1fZ+F77yGp8PYiRa6/vP9VtxDvxBj33YoQZ7qw9abmccA+pIvz4L49e/Moz2eoEIRYFypYoERih/4Zf+rPmpoNORbIm/HNzYcUDJGBjBrszQovyKsKuPp08vqqZ+df7yI4H4wOArGTw1+gRInh0S5DFiudoJCLj4lXb6WU7moO2lShLqzx8kgpoYufvaOR+Qz4zY3PicOJViCemmmJfqHu5LDYe9DmMO7eQ3njDVi7yVLFieak+nnnt2H08YoPJrJ+a0cNLxJpEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(396003)(346002)(366004)(376002)(83380400001)(33716001)(66574014)(8936002)(6486002)(316002)(5660300002)(2906002)(6512007)(9686003)(8676002)(4326008)(66946007)(6666004)(86362001)(6506007)(6916009)(52116002)(66476007)(36916002)(16526019)(186003)(478600001)(966005)(66556008)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SsM8RCWkAE3ibepw8dKESXwbDMKNUZryBSB04NxhnC9+YAW0muR9MLUGRgPN8Ao9YleHURRJygpnDJ2XAFm2EIzL0z8kr3DrTpbuKbC+6j9CqRRpBV9kaUekJmGKDmTzjISccmjzzQUaRyERwd+tl62XJPb5eQzPhwBodjAQDMgzxIXclq5n8bLwRuqISjS99PIyZeEbfGqtVf9QIxmMjgiACKEoFQku+d1+zZbK1hJerXPQGmWDOYb5yD0LnTHm5HytTXgbm0sMdhsjw/7OnAioPuMznbB6zuQ2x6LqksGyyrzBfIz+1FA9ODucXSHB6LQ6fE5BBEWhUq4Lwf3DFYojBbEc2yPtIy5YKmMG0NBht7S0lVv3NrdOygQpP2QBtAUKXVk9z1aIL/Yc2lalC9FUWEUA2wtVSBsUsvIYun0pz+puofZrMgnhI/NB8AugehpfKVQp374V6BIxsQW0hj2QimHRIAGuH56CLZe3YjQwZ2jyTmFuAm1AurXcBH18T7vzEDQvfcAzjadcCdRlijMg3mgQP9AhTrBIFwZIXag=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c7f165-e90e-4d0b-9355-08d80bb30372
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 13:51:16.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEkmv5PP3m7+Z+fw66tonUv/w/+4SB07LvaWPzqYTrp6tlCHq6r9YX+EkJlZS9w+bSZR7QsDbWxeInzIDaoZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 8 June 2020 15:31:36 CEST kernel test robot wrote:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   af7b4801030c07637840191c69eb666917e4135d
> commit: 0096214a59a72b3c3c943e27bd03307324d3ce0f staging: wfx: add suppor=
t for I/O access
> date:   8 months ago
> config: i386-randconfig-c024-20200607 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> coccinelle warnings: (new ones prefixed by >>)
>=20
> >> drivers/staging/wfx/main.c:47:14-21: ERROR: PTR_ERR applied after init=
ialization to constant on line 42
>=20
> vim +47 drivers/staging/wfx/main.c
>=20
>     30
>     31  struct gpio_desc *wfx_get_gpio(struct device *dev, int override, =
const char *label)
>     32  {
>     33          struct gpio_desc *ret;
>     34          char label_buf[256];
>     35
>     36          if (override >=3D 0) {
>     37                  snprintf(label_buf, sizeof(label_buf), "wfx_%s", =
label);
>     38                  ret =3D ERR_PTR(devm_gpio_request_one(dev, overri=
de, GPIOF_OUT_INIT_LOW, label_buf));
>     39                  if (!ret)
>     40                          ret =3D gpio_to_desc(override);
>     41          } else if (override =3D=3D -1) {
>   > 42                  ret =3D NULL;
>     43          } else {
>     44                  ret =3D devm_gpiod_get(dev, label, GPIOD_OUT_LOW)=
;
>     45          }
>     46          if (IS_ERR(ret) || !ret) {
>   > 47                  if (!ret || PTR_ERR(ret) =3D=3D -ENOENT)
>     48                          dev_warn(dev, "gpio %s is not defined\n",=
 label);
>     49                  else
>     50                          dev_warn(dev, "error while requesting gpi=
o %s\n", label);
>     51                  ret =3D NULL;
>     52          } else {
>     53                  dev_dbg(dev, "using gpio %d for %s\n", desc_to_gp=
io(ret), label);
>     54          }
>     55          return ret;
>     56  }
>     57
Hello,

This warning seems to be a false positive (the variable "ret" is affected i=
n
all branches of the if/else).


--=20
J=E9r=F4me Pouiller


