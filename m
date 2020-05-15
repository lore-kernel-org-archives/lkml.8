Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D81C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740CD206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gnu6BnKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEOQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:20:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40565 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgEOQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:20:15 -0400
X-UUID: cb4ebb84f2be4272bb1d3a1d06bf0b75-20200516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=daT5vIjMMWKHxeEq35Hg3A5bQddsffUWP1nkfOQhP6s=;
        b=gnu6BnKSdmTStfX/P09VcThW+EUE3y4Z1paN2zromqco3UYPQuJtgzn0olhgqNNqQBIN4gUl02xHN+H9SQdZHW5wy4/DwSHjsGvRs+eraYt8dKHfbncVCNdJqfkytYgjSKXflUAQt6pjl/tlauw0qQHuWYwVtRPNImfMhnX/ZcU=;
X-UUID: cb4ebb84f2be4272bb1d3a1d06bf0b75-20200516
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1911322180; Sat, 16 May 2020 00:19:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 May 2020 00:19:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 May 2020 00:19:43 +0800
Message-ID: <1589559587.28571.0.camel@mtksdaap41>
Subject: Re: [PATCH v8 2/3] drivers: input: keyboard: Add mtk keypad driver
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Marco Felsch <m.felsch@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Fengping Yu <fengping.yu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 16 May 2020 00:19:47 +0800
In-Reply-To: <20200515114044.GR185537@smile.fi.intel.com>
References: <20200515062007.28346-1-fengping.yu@mediatek.com>
         <20200515062007.28346-3-fengping.yu@mediatek.com>
         <20200515093016.rw5bmvoumgzvkqrc@pengutronix.de>
         <20200515114044.GR185537@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 504A2C560B75F9C0E94BF133E726E79914057E37B5687E4BA8C310B10E096B912000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDE0OjQwICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIEZyaSwgTWF5IDE1LCAyMDIwIGF0IDExOjMwOjE2QU0gKzAyMDAsIE1hcmNvIEZlbHNj
aCB3cm90ZToNCj4gPiBPbiAyMC0wNS0xNSAxNDoyMCwgRmVuZ3BpbmcgWXUgd3JvdGU6DQo+IA0K
PiAuLi4NCj4gDQo+ID4gPiArCWRlcGVuZHMgb24gT0YgJiYgSEFWRV9DTEsNCj4gPiANCj4gPiBQ
bGVhc2UgZHJvcCB0aG9zZSBkZXBzIGFuZCBpbnN0ZWFkIHVzZToNCj4gDQo+ICsxDQo+IA0KPiA+
IGRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyAmJiBBUk02NA0KPiANCj4gSSB3b3VsZCBnbyBldmVu
IGZ1cnRoZXINCj4gCWRlcGVuZHMgb24gKEFSQ0hfTUVESUFURUsgJiYgQVJNNjQpIHx8IENPTVBJ
TEVfVEVTVA0KDQpQbGVhc2UgZHJvcCBBUk02NC4gVGhpcyB3b3JrcyBmb3IgMzJiaXRzIFNvQyBh
cyB3ZWxsLg0KDQpKb2UuQw0KDQoNCg==

