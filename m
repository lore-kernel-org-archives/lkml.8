Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E609B20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oMVZsaxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgHYChK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:37:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:28116 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgHYChJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:37:09 -0400
IronPort-SDR: kD/jamVMAzav5gAu6wqYXd4Ou4VynF8P+HhL20prQJQhP4AA42XwU4YTsc+FK3SpeLRtkA3MjZ
 z8qRM+3ipmHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174066688"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="174066688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:37:08 -0700
IronPort-SDR: lRbxYlDXTh7p8TXpnmqXQRgnHkHeCT/0bSnIPGF1LkTUzmUlm/5Aikox+PDp8LebPWTIXEtdyH
 Pm9XvzkrLEDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="336356434"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2020 19:37:07 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 19:37:07 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 19:37:07 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Aug 2020 19:37:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 19:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc4SuPsaQrVNZgtG+L6txmTwr1pASyi55yMPHR53/WLPLlWpgqKzxnDC/BgqR2g/5gWETgXEjB2x9NCjPUcmMt/YRabjP7q8VAmTBOEjMom2CKtab7XUst82ucJUAaov3ldJvlZf1Od2MPjX1x6kTeXZX6amj5lalzPsn8y+Tt1RnBsk4nSbKaGUK2p0nimTgpOF3Ov0J847kHqtm2NvWWmf/MIp6cOW2xHYvlbp1JIGRzjSphZTveDIvpgbZBYJhLFPykBTKspFeDcWMTqdQ5bfrFhV5E++IX1a7bkkoMzSjuIKUDduqn5BoKLjbslKfCsC32eLikix/IrReZFNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5vvuBP6SMhPE8aXBDJU4iZ0XfY1Lz7PV53x2Ah88QQ=;
 b=mFpsRvuOM7MuGAkDg14ET8eFpsLNjQOfMcaYbal5LaU1OLgj8zdRwCXX1CfEgAPQmgecjCrR8OoWSnt6uym7KxijzmRejVqzxcdTnom2GULV13Kfhs0Ah3D0b5kLj1NEGrZY4sw3DraBVf4rKd2puQ2ICAYN3Eu80zV1u4FBKMGCvx8Nv2bzTZUePS/bse9gO9g8muNWpfmJ1X2LgQStH41Xk5Yd3JCyjKSwKFmGNeV/D2RjdDLPGppY0Zz5NGYG7f55PwtsQ9UHTWzEpgP0Wj9gSfCrAzpg2WfiO0dV48i3Z4mV9yQiNhiDzNgQVdrl2Y/PTpLMmDJLOuh+Hb27xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5vvuBP6SMhPE8aXBDJU4iZ0XfY1Lz7PV53x2Ah88QQ=;
 b=oMVZsaxS121IwOA7fRfqukFuqHOw9S8p4PRTjrqTA5ZnbK/EAgcaXAG/2BXF6Wx7YnWJdJuuX9Y6ROf4Svb9P7/YcHyyPIpooWv+KpUvVWVYZly4HTXJFBpb8njPw4AVY2Q3V+nB7C1pzo1qZeeGRgUR4egF1MCNjRPl1qPyYx4=
Received: from MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 02:37:05 +0000
Received: from MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00]) by MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00%6]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 02:37:05 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Johan Hovold <johan@kernel.org>, lkp <lkp@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] Re: drivers/greybus/es2.c:439 message_send() error:
 double unlocked 'es2->cport_out_urb_lock' (orig line 417)
Thread-Topic: [kbuild-all] Re: drivers/greybus/es2.c:439 message_send() error:
 double unlocked 'es2->cport_out_urb_lock' (orig line 417)
Thread-Index: AQHWefx94ijqU7+QqUmZbzmWYzxWpalIHUDQ
Date:   Tue, 25 Aug 2020 02:37:04 +0000
Message-ID: <MWHPR11MB1613967593B79A01BE785F03E5570@MWHPR11MB1613.namprd11.prod.outlook.com>
References: <202008140324.LLig4g2M%lkp@intel.com>
 <20200824095342.GF21288@localhost>
In-Reply-To: <20200824095342.GF21288@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87c6c889-91c9-423e-d2d7-08d8489fc125
x-ms-traffictypediagnostic: MW3PR11MB4634:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4634D291B8D076884CA16AC6E5570@MW3PR11MB4634.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDeFlFb2+B55uFuC61fcTjl4TPXJggzkgzJen0LJqU6YTpSzvIsl78JzYv1kl3lqupyz+IItIGAZn9rRwIvkiFZ1Z/gNh0B5ya/u8jNmXFohjMGBo3wSfiKHAn+8K0G64GF7KnnoMmgBKwQRAc343+ChWtbq5Z9Ab0ENnrmDz3iDAg0saybA8wyUclvgF0d2y/NJ0JEcmm9txHG5uUtVx9VD7VK/ruOkvgJUol+Ej3rWQ3pEQ7EUHXgnvpHFiw+nIWo6wWWkvF5ENQNznYlCX2/QMwL5GAfAVQtEegyAd9wvH/RzP3di1BOUaFTzs9AJckAQv6KdgojWNeV9LobWiorYVe32kfy9O/qI13VtmA40B6Ba0Hu7hINHqZ/VKjqnxu/uzxaA2XG322d7E8vrNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(4001150100001)(33656002)(71200400001)(83380400001)(8936002)(9686003)(6506007)(966005)(478600001)(55016002)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(7696005)(6636002)(15650500001)(5660300002)(316002)(8676002)(54906003)(2906002)(86362001)(52536014)(26005)(4326008)(186003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MtYEcNqYQoVsRImpbhe2oeEeam9296YqEs0Txp4n3lFVX882amQ7GV3TQI1eKbn4uWqotcC3CAXE3xkMeXruHyqbyqs5SrtmZV/UtC8niZ356249iZl5tNNz6hXruYyhGWkFrjZlZkDvaFa9KzM5Meclhn3a/RQNjjf0ufKyc+Ef4aG5U98hxwzK7+CYp6X4YCuqeFXhznk6CkTxX2cnec+5A16aYPBOcegnNPM+rUPNUYfoXXHJ6I8jA5bBkKKi3JfG1QB87JhOrKo+1MKRoXFuqslN+nzdEsw5UrJkps2xxDO26MSS0VbP50WXcpK3kziKdc8sNTge+D+X32gd4E0CFZy9N9DEqS7aNiHZ+RQOdA80bUVuzOGEmDBm/pC0TxC9BYgD8ipBgFmP0gFD2zCmis95QVyj6nQqfVRTNHQ5LHa20lTmmKkixCI6Fyxj+r20JcBumWy2wJPQ3Jxm11fzWFaqLzk2Mo1I7lNzv2UloMTzkkZT/Sbx9Tl5sSUdtjco1GFrj5mb9TpLT54vntuD1hFxFYkWeuS1eOOUZyDgrNrDzgzTsf9qVtBOm6Vblv0YOv5MJeA0Mmp6cmjL8BpOv8gX9/5Vh6lCZ3XOLYNeVrI2dG1w5nc+yn61cuhJmTGF2L6d0wICEHgoS55DRw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c6c889-91c9-423e-d2d7-08d8489fc125
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 02:37:04.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fYAv2gtzlsMWcDmq2qjHr8h9y9AS0BA+TZG/3LG3U80KX+Icdc1zkQqO6Vc9Mp+KpPhkJfMGRySGzQp1cVEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Johan Hovold <johan@kernel.org>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B24=1B$BF|=1B(B 17:54
>To: kernel test robot <lkp@intel.com>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; kbuild-all@lists.01.o=
rg;
>linux-kernel@vger.kernel.org
>Subject: [kbuild-all] Re: drivers/greybus/es2.c:439 message_send() error: =
double
>unlocked 'es2->cport_out_urb_lock' (orig line 417)
>
>On Fri, Aug 14, 2020 at 03:26:27AM +0800, kernel test robot wrote:
>> Hi Greg,
>>
>> First bad commit (maybe !=3D root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   dc06fe51d26efc100ac74121607c01a454867c91
>> commit: b81beec9cb2d586412c7166c893894930f19965e staging: greybus:
>move es2 to drivers/greybus/
>> date:   12 months ago
>> config: x86_64-randconfig-m001-20200813 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> New smatch warnings:
>> drivers/greybus/es2.c:439 message_send() error: double unlocked
>> 'es2->cport_out_urb_lock' (orig line 417)
>> drivers/greybus/es2.c:879 cport_out_callback() error: double unlocked
>> 'es2->cport_out_urb_lock' (orig line 871)
>> drivers/greybus/es2.c:1018 arpc_sync() error: double unlocked
>> 'es2->arpc_lock' (orig line 992)
>>
>> Old smatch warnings:
>> drivers/greybus/es2.c:441 message_send() error: double unlocked
>> 'es2->cport_out_urb_lock' (orig line 439)
>
>None of these warnings make any sense. Is the robot drunk?
Hi Johan,

It is a false positive. Please kindly ignore.
There was a bug in robot that sent unconfident reports out directly and has=
 been fixed. Sorry for inconvenient.

Best Regards,
Hui
>
>> vim +439 drivers/greybus/es2.c
>>
>> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>385
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  386  /*
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>387   * Returns zero if the message was successfully queued, or a negative=
 errno
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>388   * otherwise.
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  389   */
>> 2537636abae5b81 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-11-
>03  390  static int message_send(struct gb_host_device *hd, u16 cport_id,
>> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015=
-04-07
>391  			struct gb_message *message, gfp_t gfp_mask)
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  392  {
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>393  	struct es2_ap_dev *es2 =3D hd_to_es2(hd);
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>394  	struct usb_device *udev =3D es2->usb_dev;
>> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015=
-04-07
>395  	size_t buffer_size;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  396  	int retval;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  397  	struct urb *urb;
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>398  	unsigned long flags;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  399
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  400  	/*
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  401  	 * The data actually transferred will include an indication
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  402  	 * of where the data should be sent.  Do one last check of
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  403  	 * the target CPort id before filling it in.
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  404  	 */
>> 144670c2ae3f9b4 drivers/staging/greybus/es2.c    Fabien Parent      2015=
-09-02
>405  	if (!cport_id_valid(hd, cport_id)) {
>> 100e90000840741 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-12-
>07  406  		dev_err(&udev->dev, "invalid cport %u\n", cport_id);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>407  		return -EINVAL;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  408  	}
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  409
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  410  	/* Find a free urb */
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>411  	urb =3D next_free_urb(es2, gfp_mask);
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  412  	if (!urb)
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>413  		return -ENOMEM;
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>414
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>415  	spin_lock_irqsave(&es2->cport_out_urb_lock, flags);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>416  	message->hcpriv =3D urb;
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>@417  	spin_unlock_irqrestore(&es2->cport_out_urb_lock, flags);
>
>How is this a double unlock?
>
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  418
>> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>419  	/* Pack the cport id into the message header */
>> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>420  	gb_message_cport_pack(message->header, cport_id);
>> 491e60d63fde0a9 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-04-07
>421
>> 821c620afa1ad29 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>422  	buffer_size =3D sizeof(*message->header) + message->payload_size;
>> 491e60d63fde0a9 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-04-07
>423
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  424  	usb_fill_bulk_urb(urb, udev,
>> 606addd2847ccc5 drivers/staging/greybus/es2.c    Alexandre Bailon   2015=
-06-
>15  425  			  usb_sndbulkpipe(udev,
>> 403074b50b66f1a drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016=
-
>08-17  426  					  es2->cport_out_endpoint),
>> 821c620afa1ad29 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>427  			  message->buffer, buffer_size,
>> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015=
-04-07
>428  			  cport_out_callback, message);
>> 977e209ab41073d drivers/staging/greybus/es2.c    Alexandre Bailon   2015=
-08-
>31  429  	urb->transfer_flags |=3D URB_ZERO_PACKET;
>> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016=
-06-03
>430
>> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016=
-06-03
>431  	trace_gb_message_submit(message);
>> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016=
-06-03
>432
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  433  	retval =3D usb_submit_urb(urb, gfp_mask);
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  434  	if (retval) {
>> 05e3095563670ab drivers/staging/greybus/es2.c    Viresh Kumar       2016=
-06-23
>435  		dev_err(&udev->dev, "failed to submit out-urb: %d\n", retval);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>436
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>437  		spin_lock_irqsave(&es2->cport_out_urb_lock, flags);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>438  		message->hcpriv =3D NULL;
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>@439  		spin_unlock_irqrestore(&es2->cport_out_urb_lock, flags);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>440
>> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015=
-10-27
>441  		free_urb(es2, urb);
>> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015=
-06-13
>442  		gb_message_cport_clear(message->header);
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>443
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>444  		return retval;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  445  	}
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015=
-
>01-21  446
>> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015=
-07-01
>447  	return 0;
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman
>> 2015-01-21  448  }
>> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman
>> 2015-01-21  449
>>
>> :::::: The code at line 439 was first introduced by commit
>> :::::: 4b1d82047ebbb108e9961fffd51f8ccd54459221 greybus: es2: rename
>> es2 data structures
>>
>> :::::: TO: Alex Elder <elder@linaro.org>
>> :::::: CC: Greg Kroah-Hartman <gregkh@google.com>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>Johan
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
