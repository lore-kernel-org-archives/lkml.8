Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8656F208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tSonHfit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFQFec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:34:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgFQFeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:34:31 -0400
X-UUID: 282f662e3dfe49c896731f25cc10017e-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Bbt8y3TNU0+UzptSCtll+QC7nia8mpUm1Ua9AtI/usM=;
        b=tSonHfitkoLdQVGXS1FwEzcLik2YnyVxq8JHL29VOa+cOhvkZCKX1iCeD4fdGj2ca8wFjVtLfaEcEKQFi1GbCjMkbnIRPOkqazILARgywkS9tozDMBjImeVMiuNT91M5/jEX4Z5m4yiDXeJk0K6dEpoopXUybypI/v3HlVSMgIU=;
X-UUID: 282f662e3dfe49c896731f25cc10017e-20200617
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2126771182; Wed, 17 Jun 2020 13:34:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 13:34:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 13:34:19 +0800
Message-ID: <1592372060.4086.1.camel@mtkswgap22>
Subject: Re: [PATCH v2] usb: gadget: u_serial: improve performance for large
 data
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Date:   Wed, 17 Jun 2020 13:34:20 +0800
In-Reply-To: <20200617051422.GA1331778@kroah.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
         <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
         <20200617051422.GA1331778@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EF0DEE7F6D93BC783FEA22B064A2D9C2B297A884208A2D82E82201A07707A16D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDA3OjE0ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgSnVuIDE3LCAyMDIwIGF0IDEwOjQ2OjQ3QU0gKzA4MDAsIE1hY3BhdWwg
TGluIHdyb3RlOg0KPiA+IE5vd2FkYXlzIHNvbWUgZW1iZWRkZWQgc3lzdGVtcyB1c2UgVkNPTSB0
byB0cmFuc2ZlciBsYXJnZSBsb2cgYW5kIGRhdGEuDQo+ID4gVGFrZSBMVEUgTU9ERU0gYXMgYW4g
ZXhhbXBsZSwgZHVyaW5nIHRoZSBsb25nIGRlYnVnZ2luZyBzdGFnZSwgbGFyZ2UNCj4gPiBsb2cg
YW5kIGRhdGEgd2VyZSB0cmFuc2ZlciB0aHJvdWdoIFZDT00gd2hlbiBkb2luZyBmaWVsZCB0cnkg
b3IgaW4NCj4gPiBvcGVyYXRvcidzIGxhYi4gSGVyZSB3ZSBzdWdnZXN0IHNsaWdodGx5IGluY3Jl
YXNlIHRoZSB0cmFuc2ZlciBidWZmZXINCj4gPiBpbiB1X3NlcmlhbC5jIGZvciBwZXJmb3JtYW5j
ZSBpbXByb3ZpbmcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3Bh
dWwubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL3Vfc2VyaWFsLmMgfCAgICA1ICsrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBXaGF0IGNoYW5nZWQgZnJvbSB2MT8g
IEFsd2F5cyBwdXQgdGhhdCBiZWxvdyB0aGUgLS0tIGxpbmUgYXMgdGhlDQo+IGRvY3VtZW50YXRp
b24gYXNrcyBmb3IuDQo+IA0KPiB2Mz8NClNvcnJ5LCBJIGp1c3QgZm9yZ2V0IHRvIGFkZCBjaGFu
Z2UgbG9nLCBJJ2xsIHNlbmQgdjMgbGF0ZXIuDQoNClRoYW5rcyENCg0KQlIsDQpNYWNwYXVsIExp
bg0K

