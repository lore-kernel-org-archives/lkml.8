Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834EEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E14820658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OhX78rn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHRHBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:01:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:50911 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgHRHBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:01:17 -0400
IronPort-SDR: PWmGuT7SdGIU/yrpQIeRPic3962FNFL0Bs0nfERKTWBCj0JqDEBq4uLOMiwaoWIiq4x681Pp5w
 dMYRYisYvcxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154111649"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="154111649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 00:01:11 -0700
IronPort-SDR: m3mkSkCpbjzAY8hxYgOPiYcHhw2hEvofD643W9CtUicrjLvBK7c+V8G1xETpEXp8aQwp9cVrbV
 JDRcmuZNwpkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="279324790"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 00:01:11 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 00:01:10 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 00:01:10 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Aug 2020 00:01:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 18 Aug 2020 00:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBmjtOVdkxWVRJcNkXRA2QjyJyW9SkB0vMtnn+OVRctG6LAv4+IiF+uQC7v49h/e5XvLGgZU8VaLMJacIUu0LVrURsfUA+lqAMHolSia0eX1aIT9oYJNlvr7yfLcnliD225yPGi+EOk2RKYTNFLs/07/YGfFVJu1n2ldastVUAzll/E7YuPI0nWtx87PY+0qA5iZIZl5ZkSbvaedTBPGPwM6tHEj66SPFufXhnCDrlQ5Ldf1KMLlZdgrBqu16ZC60dLAKKhX3j1iAn0Oz0zdPoFDFk1tbzIfDuuM9M7BU7j+Jn978KB5MitG+zGQ5ZL0P10jfNY4n2TfdQ/MCcA7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhweSSlKFCKzcpF1Go3IhBwhrAAebPx/Sx6qF2Po3M=;
 b=E3Jz/q6qnK/oenuy26ajVDzhAQYpaUyqqEn15XsFOAx0b33Nf/Gx3QJNTF080QvBrCOisZxkKBEeXQFYyttG5a+MJDQOynumSBAwW9g52+4oblSLPYovg1e6qMwsiw7zpMIab1in7YdQnXUfheYoRqjK6uxzGBosBVy5eQK5MKGg24GL3trzTnOjPMQY0nJ/d6cBa322ewmcRBRcjTwsT4BQeHLw9s+UAfOvHAx9rQ42uOa8FOeJp1VQiO+noSy4TBde1LyzSD8sxUUWXW/+TiNP9ZjzQ3zkY/5yvZV4DvEahQ28mJV2DDKbs0gQ/RzifnXNvGLIDT59BkROY9rrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhweSSlKFCKzcpF1Go3IhBwhrAAebPx/Sx6qF2Po3M=;
 b=OhX78rn+sgEDK8X3e58yzwQoaUxB5VkWiQxW+7gBB6x/Rlrwi3izV/hDAg4GVH7TwFhsPZhAHPir0FaXtzbNDPSTxhVCS/2mqC32NGm6xCeTMbuTO69Qz0yIytvySyhfAkzU+Veqgzb1RKXQ/vPawhswr034y/291ui4pNXt3R8=
Received: from MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21)
 by MWHPR11MB0078.namprd11.prod.outlook.com (2603:10b6:301:67::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 07:01:00 +0000
Received: from MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00]) by MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00%6]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 07:01:00 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, lkp <lkp@intel.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] Re: drivers/vhost/net.c:1010
 vhost_net_rx_peek_head_len() error: double unlocked
 'sk->sk_receive_queue.lock' (orig line 1002)
Thread-Topic: [kbuild-all] Re: drivers/vhost/net.c:1010
 vhost_net_rx_peek_head_len() error: double unlocked
 'sk->sk_receive_queue.lock' (orig line 1002)
Thread-Index: AQHWbxKepQkVASIWYUe4twSsrm/XSak9fIFw
Date:   Tue, 18 Aug 2020 07:01:00 +0000
Message-ID: <MWHPR11MB161364B47AF529EB61BDA348E55C0@MWHPR11MB1613.namprd11.prod.outlook.com>
References: <202008081502.F9nEsAf6%lkp@intel.com>
 <20200810083313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200810083313-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c5584a1-928b-487a-31e2-08d843447716
x-ms-traffictypediagnostic: MWHPR11MB0078:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB0078EDD8E85CC0D38AB6C76EE55C0@MWHPR11MB0078.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYJgTjE09E0KAwHzjdBbwBMvax/7Jc1A2DSh2ZGIEcdqwUkmd4kSkm6pQvir5spXoZOj7AjngeJfDDFwLwqY+3O6PN29VtpCryrST7wKKGLk/h+XQmDlC7YjEFQ2KqL8yF9HaH2UBW4XMHB1UNpu6OywjvgSWiPqea0BY58Klm4TvxGqTbw8mIFPNJXXBa4vngIJZbU4aMr14j5f100fYXa76GnWfad4cVUf0lwVuNU3Q9Me3YCDewUkWGsZxt8ezYDn5rEpoP90ghzFZrfbOPqPeCxrZnO6jXSw+TGipjvThkFdx53W8lL3FG/YdPI0K2oIAlX9K2WHCztdqe/dhVa2JOuwIychsM8Bjgamp4d8H+O50I39hxGNlIZz7k72uWUjEz0krHVknT1VCxw80w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(66446008)(64756008)(76116006)(52536014)(66556008)(5660300002)(2906002)(66476007)(33656002)(66946007)(6636002)(26005)(86362001)(186003)(8676002)(55016002)(316002)(7696005)(71200400001)(9686003)(83380400001)(478600001)(6506007)(110136005)(8936002)(54906003)(4326008)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EetKbrgq0l8NZutdwrn3ZCD2ZsuEhtzOs725IYLOdFqjdEF5GPbIT0ZiiD6k6EqYko8ibxTlnOw00cgWdRGHmD+ucqWipzl9TzqhAjkjzECav/EdHDLB3qjyCok4APaDtlIJyZHzxHNz68zE5b0UMLeCMYsxKYEmQkBapmOXoLMMtV+vo+6M2q6NVC/lxCtn95vHTu9c5O5IPSCB876izhqHrJHao8hLJlw+MoD85zdGI5xChI4YPZsiZR/bRysFh0nGIGvA4LmSpSp6fj2vytsbEYSQWp2xBo3okD+MYfePDfPjhyNDKatXGhDJv33yKgWEko33McCE3vBKpRjIKENHurB5KjCOALaryXfZ5kGxB8Y54708UGitrDCE21pZBudJkky7vZt3d3/acFzziy69dEX1Tn64Pm/5YAg/h/m+9qWlkd6YHu9vrcLQLXOkq3LPyWZ2BVi9jGh+wcfS//lJw8wZ6BFwaqQ4SskGJw9VNnaRq/T2TsluPMKQj6I8RH9uNHeNIXzjt1s5XHBMFlQNHavRzqbG6Qc6NhfpEh+WNfNnTvGqg1yd3kAuHfvA8ailq6z/xF1CitE71qB0hHvzOaI41Zoe7rQrNfrjW9vBCP6BKhnZAFBG/v+qddbQENNGmpObMmCXRTBuDx+LZg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5584a1-928b-487a-31e2-08d843447716
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 07:01:00.7265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgzKB9QTp83mPdAlefceI8CG04CEkTHiT53b8/bDNI7cKmyNl646nytvBrCNtzNMQar3e5JZZh9T6VPSG+qTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0078
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Michael S. Tsirkin <mst@redhat.com>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B10=1B$BF|=1B(B 20:34
>To: kernel test robot <lkp@intel.com>
>Cc: Jason Wang <jasowang@redhat.com>; kbuild-all@lists.01.org; linux-
>kernel@vger.kernel.org
>Subject: [kbuild-all] Re: drivers/vhost/net.c:1010 vhost_net_rx_peek_head_=
len()
>error: double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
>
>On Sat, Aug 08, 2020 at 03:37:07PM +0800, kernel test robot wrote:
>> Hi Jason,
>>
>> First bad commit (maybe !=3D root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
>> commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost
>and vringh kconfig
>> date:   4 months ago
>> config: arm-randconfig-m031-20200808 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> New smatch warnings:
>> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double
>> unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
>> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double
>> unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
>
>Weird. Can't figure out where the double unlock is ...
Please ignore this report. It is a false positive.=20
We have changed the rule to avoid send out this warning type directly. Sorr=
y for inconvenient.

>
>
>> Old smatch warnings:
>> drivers/vhost/net.c:1528 vhost_net_set_backend() warn: passing a valid p=
ointer
>to 'PTR_ERR'
>
>this stumped me too...
Ignore this one too. It is old warnings.

Thanks,
Hui
>
>> vim +1010 drivers/vhost/net.c
>>
>> 8dd014adfea6f17 David Stevens   2010-07-27   994
>> be294a51adfc1e1 Toshiaki Makita 2018-07-03   995  static int
>vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>> be294a51adfc1e1 Toshiaki Makita 2018-07-03   996
>	      bool *busyloop_intr)
>> 030881372460654 Jason Wang      2016-03-04   997  {
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03   998  	struct
>vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03   999  	struct
>vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
>> 6369fec5be0aad4 Toshiaki Makita 2018-07-03  1000  	struct vhost_virtqueu=
e
>*rvq =3D &rnvq->vq;
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03  1001  	struct vhost_virtqueu=
e
>*tvq =3D &tnvq->vq;
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1002  	int len =3D
>peek_head_len(rnvq, sk);
>> 030881372460654 Jason Wang      2016-03-04  1003
>> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1004  	if (!len && rvq-
>>busyloop_timeout) {
>> f5a4941aa6d190e Jason Wang      2018-05-29  1005  		/* Flush
>batched heads first */
>> 09c3248938c3e3b Jason Wang      2018-07-20  1006
>	vhost_net_signal_used(rnvq);
>> 030881372460654 Jason Wang      2016-03-04  1007  		/* Both tx vq
>and rx socket were polled here */
>> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1008
>	vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>> 030881372460654 Jason Wang      2016-03-04  1009
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1010  		len =3D
>peek_head_len(rnvq, sk);
>> 030881372460654 Jason Wang      2016-03-04  1011  	}
>> 030881372460654 Jason Wang      2016-03-04  1012
>> 030881372460654 Jason Wang      2016-03-04  1013  	return len;
>> 030881372460654 Jason Wang      2016-03-04  1014  }
>> 030881372460654 Jason Wang      2016-03-04  1015
>>
>> :::::: The code at line 1010 was first introduced by commit
>> :::::: 28b9b33b983f4de3ce9e660e3efe1e08adabf779 vhost_net: Rename
>> local variables in vhost_net_rx_peek_head_len
>>
>> :::::: TO: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> :::::: CC: David S. Miller <davem@davemloft.net>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
