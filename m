Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1651C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88569206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xC5XG7wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRGze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:55:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:4046 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHRGzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:55:33 -0400
IronPort-SDR: l5inDPIqLywGBiC2onxxXGt0TuEQnE2aBsQnN9vc0Eam1hEb3Hd6M2/8jbjEN/iF07P9q0MwnR
 TRF+wYQvca4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134911872"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="134911872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:55:31 -0700
IronPort-SDR: mupB0hZ6tOkcr2+Qy/L/Wi/2FO9WGhIbB+Ir/jA+k9yT+HqkFJ72G8RLSLeS0dJwdo8T61azuK
 RjkbzgtmvaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326644146"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 23:55:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 23:55:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 23:55:29 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 23:55:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 17 Aug 2020 23:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIWomMd9m7d8C0mNnIEX+9pT7Oxpij7GiBJMfo1GlG9wIfw+tDfLGKrKbHu5q4zS6CSQLAVMqG8S7L5f3JbQBQL0V+4zRkXGDXmpFNTxyCJ3FXwW1lIRAykHVoI1WEmIhr5Oqte6araT8IIubigcG9XKFpZl9PJhcOGr32UFd5jf2UjKTuwZSUujtyBNbqu5r1FBHw+XL9SaVsSwS79QFjscoJKq/FhxWXUPdLWuZ/w8eCWAJZrSRsQwkJvx3fqn+eA62br1ZH0hh4uWCW19x+sJicX3bFiH0/pNIXRvsLPme1X9ZzUVt9B5YgdoBytAS8DeYvWL/i+hcpj9pbw7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0rfpY1Gd3+dxQjcUOVY0k8p5BtigtSS0qhXW6PIwak=;
 b=SRJLPivqNwxIY0YOOIO+zLrozbu2m8QW+cSDu+DU3qqCFmmfBaTPZa8p4OzaQNhOtQemk3Ak+qlvWptsXxK6fs7X2gQJZm40MCE68p+8snUy8dNodTvbDN2YZ6Y2zCwscQw09lfPnnq4cIaxL2rc6M+0xEKSXLsBA3VSEpqTzMkaxt6lvpH3WzzSCbbIM09gLuemLroIAwltBIXH4MeagDsOi6rcupzPQ7UhmT2k1FI7Beq4lXqbR7yA29QR4RxNXci27EGUyWhNRIGj5thWU8fhVdYwZlrwt38+WE6Lz/36A8h+YaNxnYIsfowMIZrUmIS7sDGdOCJJvgGzGByMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0rfpY1Gd3+dxQjcUOVY0k8p5BtigtSS0qhXW6PIwak=;
 b=xC5XG7wyTd0KGzchpyVwmXI3At+HAJH0VRhx2LVS11S3V8e29R8m9UgMENcKeoDhSeNGLd6BHtXcvqC5GdCfoTSptOqbsJXdHUdWq7bYNutfowKgWHCHwErZZA1vXQblLIGAPKo15n6xAYHne/Q35Q+BJ6Y6f/6hqN2/ZPGC3IY=
Received: from MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21)
 by MWHPR1101MB2077.namprd11.prod.outlook.com (2603:10b6:301:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 06:55:23 +0000
Received: from MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00]) by MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00%6]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 06:55:23 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        lkp <lkp@intel.com>
CC:     Hyun Kwon <hyun.kwon@xilinx.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: RE: [kbuild-all] Re: drivers/dma/xilinx/xilinx_dpdma.c:1172
 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig
 line 1170)
Thread-Topic: [kbuild-all] Re: drivers/dma/xilinx/xilinx_dpdma.c:1172
 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig
 line 1170)
Thread-Index: AQHWcDHV3z0s7FSfcUeuCnrdc6Vs7qk9eLEQ
Date:   Tue, 18 Aug 2020 06:55:23 +0000
Message-ID: <MWHPR11MB161363A9420049706DEBB450E55C0@MWHPR11MB1613.namprd11.prod.outlook.com>
References: <202008120657.drkFgIsC%lkp@intel.com>
 <20200811225006.GF17446@pendragon.ideasonboard.com>
In-Reply-To: <20200811225006.GF17446@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ba7835-856a-43f0-1722-08d84343ae1b
x-ms-traffictypediagnostic: MWHPR1101MB2077:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2077C935D74A7A8523F06C3FE55C0@MWHPR1101MB2077.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBjgMLcaDOs3zyY+m1veMjAMAtTY+HtQEiBsXZiv+e/3yX0rRJnz1G9zMEhvUMU5uv3SZ7Gf23As03yuDuVQIywNaBgxQCvGb4V63rrEOgjBp3fze3iRr7avLWmNAFWQ9AjRn0nbaPH2udrvnPHUIDxlM8ZGJGmfmZ1Az2XPdxtdXX6tgYn5xUpmVQfYYBufzcig1rmNeW1erih59hEx82hQzb3SlMED3ShgDbjiasIcVm3Y+uACg7LudOajACVEPckvjuoGcailroN6RdizCrwHhcUqbPHEFO7vP6EBb/169hVzmywwEX0YlE5Yky+5a+8CkeIYZPcNA5EgFO+05/hCU4DVRTdcZvBeEz30FzqfYu9bMxRwQs0k1RHhaOMXOKVU/eSG1x27Ssvksi5OrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(186003)(7696005)(2906002)(8936002)(26005)(64756008)(71200400001)(52536014)(76116006)(66446008)(478600001)(54906003)(6506007)(110136005)(55016002)(66556008)(966005)(9686003)(66476007)(66946007)(86362001)(6636002)(8676002)(316002)(4326008)(33656002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HLXWEyt6NrSyWqu5a5/ZXuILzwi9Yd1o6zXSCLosEkyOtN/pkV1Qhiup5RlknRGRGzBeLmq/BCTqEphmCHg5AEC8CqhKg55LtGb987cdKBlTOIRUpICVu61CgSsEqo0ZT7E21aTGpf6YKFJZORiBuNfOZ0ZX23B6wsj8k4rbfik8vXDhl357fWB7zCPTLEN01vaunbreMR0Bz63jgBhLtCHXcv10QEMntY52Am8dn2gxNRQsoA0yX2kbBKvRxTS99QUdCKPeMLTE1nVconcgsL7imP4+m6fD5hro1/Xsklo/0yWtdeIrhArxx3BR5iKL/MpadbkIZ7quZ4Sma8PrxvnL1DbYpLAJRxu3vJmy0RgX0avuMWw39CGjHnl49PiS5fd4i3q9tofioLpBy46iKh7gCmHj0y8+HjpgVF2HCtoOlr3mGNhBe4WQc+pO07O1g3PfwRPlBtNnPkz8sHJuBqIIHBAu4hzyt8Tlgfgfa+NzUoNRCFf4AWmR+Huc+Xyz9XPviMhaddhdIoF3YXAwpkirZkOD0qFw/N6ssEu0E/uSlssv3+a8S3K/9KOL/txUAJzDT/JZWeC+JxGESujM9pcGxZ4NXrNVYhTTEiRhePbeRKrR+vBOnmw7sz6u+yDKNavgRDuXml3idM6Rvh+h9w==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ba7835-856a-43f0-1722-08d84343ae1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 06:55:23.4626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2xDQwhV+09fka3H+Rqb8wbw4RZXLjNM4FtQoFcy0BUKoM7gdXH0il/v+bTFW9MMmV90fPiEk+8pM8tXkK6rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2077
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B12=1B$BF|=1B(B 6:50
>To: kernel test robot <lkp@intel.com>
>Cc: Hyun Kwon <hyun.kwon@xilinx.com>; kbuild-all@lists.01.org; linux-
>kernel@vger.kernel.org; Vinod Koul <vkoul@kernel.org>; Tejas Upadhyay
><tejasu@xilinx.com>; Michal Simek <monstr@monstr.eu>
>Subject: [kbuild-all] Re: drivers/dma/xilinx/xilinx_dpdma.c:1172
>xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig=
 line
>1170)
>
>On Wed, Aug 12, 2020 at 06:37:59AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   c636eef2ee3696f261a35f34989842701a107895
>> commit: 7cbb0c63de3fc218fd06ecfedb477772a4d12f76 dmaengine: xilinx:
>dpdma: Add the Xilinx DisplayPort DMA engine driver
>> date:   4 weeks ago
>> config: h8300-randconfig-m031-20200811 (attached as .config)
>> compiler: h8300-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> smatch warnings:
>> drivers/dma/xilinx/xilinx_dpdma.c:1172 xilinx_dpdma_synchronize()
>> error: double unlocked 'chan->vchan.lock' (orig line 1170)
>
>Unless I'm mistaken, this is a false positive. I'd appreciate if someone c=
ould check
>if I'm missing something obvious.

Please ignore this report. It is a false positive.=20
We have changed the rule to avoid send out this warning type directly. Sorr=
y for inconvenient.

Best Regards,
Hui

>
>> vim +1172 drivers/dma/xilinx/xilinx_dpdma.c
>>
>>   1140
>>   1141	/**
>>   1142	 * xilinx_dpdma_synchronize - Synchronize callback execution
>>   1143	 * @dchan: DMA channel
>>   1144	 *
>>   1145	 * Synchronizing callback execution ensures that all previously i=
ssued
>>   1146	 * transfers have completed and all associated callbacks have bee=
n called
>and
>>   1147	 * have returned.
>>   1148	 *
>>   1149	 * This function waits for the DMA channel to stop. It assumes it=
 has been
>>   1150	 * paused by a previous call to dmaengine_terminate_async(), and =
that
>no new
>>   1151	 * pending descriptors have been issued with dma_async_issue_pend=
ing().
>The
>>   1152	 * behaviour is undefined otherwise.
>>   1153	 */
>>   1154	static void xilinx_dpdma_synchronize(struct dma_chan *dchan)
>>   1155	{
>>   1156		struct xilinx_dpdma_chan *chan =3D to_xilinx_chan(dchan);
>>   1157		unsigned long flags;
>>   1158
>>   1159		xilinx_dpdma_chan_stop(chan);
>>   1160
>>   1161		spin_lock_irqsave(&chan->vchan.lock, flags);
>>   1162		if (chan->desc.pending) {
>>   1163			vchan_terminate_vdesc(&chan->desc.pending->vdesc);
>>   1164			chan->desc.pending =3D NULL;
>>   1165		}
>>   1166		if (chan->desc.active) {
>>   1167			vchan_terminate_vdesc(&chan->desc.active->vdesc);
>>   1168			chan->desc.active =3D NULL;
>>   1169		}
>> > 1170		spin_unlock_irqrestore(&chan->vchan.lock, flags);
>>   1171
>> > 1172		vchan_synchronize(&chan->vchan);
>>   1173	}
>>   1174
>>
>
>--
>Regards,
>
>Laurent Pinchart
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
