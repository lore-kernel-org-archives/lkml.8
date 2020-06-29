Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E50C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98EF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ji6sqIqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgF2Bsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:48:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:33625 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726395AbgF2Bsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 21:48:38 -0400
X-UUID: ce063a1b2abb40eeb860e311d74ab731-20200629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mHQn5XmDpgJs5qFDU8hAACPxe8v4rKbaKOCTw7e63mM=;
        b=Ji6sqIqUTPA68GxFSNlWWD8pZs/dENeDEu/2rW7Rf0MulW5RrY45t52jr3dBN73HgBt8upnpGaC0mFpRxH3n3V1NvtzI6qtn59zwk7czEJyrZPW7/b3o545nR0PLz+ukHs5D6GHwCFZv1ol5Pbny8MiMrthNpu2FL55+6UI5Ayc=;
X-UUID: ce063a1b2abb40eeb860e311d74ab731-20200629
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1365511381; Mon, 29 Jun 2020 09:48:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Jun
 2020 09:48:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Jun 2020 09:48:29 +0800
Message-ID: <1593395293.3798.3.camel@mhfsdcap03>
Subject: Re: usb: mtu3: Checking initialisation of the variable
 =?UTF-8?Q?=E2=80=9Cmep=E2=80=9D?= in two functions
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "Colin Ian King" <colin.king@canonical.com>
Date:   Mon, 29 Jun 2020 09:48:13 +0800
In-Reply-To: <8efdb7aa-1188-e94a-3075-ab1dd30768bb@web.de>
References: <8efdb7aa-1188-e94a-3075-ab1dd30768bb@web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 762530C185AC44AB10E0841002A5BE6820B6CDB3BFA860D26BD2569CB5C9AB4A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiBTYXQsIDIwMjAtMDYtMjcgYXQgMTQ6MjggKzAyMDAsIE1hcmt1cyBFbGZyaW5nIHdy
b3RlOg0KPiBIZWxsbywNCj4gDQo+IEEgc291cmNlIGNvZGUgYW5hbHlzaXMgYXBwcm9hY2ggYnkg
dGhlIG1lYW5zIG9mIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQ0KPiAoQ29jY2luZWxsZSBz
b2Z0d2FyZSkgcG9pbnRlZCBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgb3V0IGZvciBmdXJ0aGVy
DQo+IGRldmVsb3BtZW50IGNvbnNpZGVyYXRpb25zLg0KPiANCj4gVGhlIGZ1bmN0aW9ucyDigJxt
dHUzX2dhZGdldF9lcF9zZXRfaGFsdOKAnSBhbmQg4oCcbXR1M19nYWRnZXRfZXBfc2V0X3dlZGdl
4oCdIGNoZWNrDQo+IGF0IHRoZSBiZWdpbm5pbmcgaWYgdGhlIGlucHV0IHBhcmFtZXRlciDigJxl
cOKAnSBpcyBhIG51bGwgcG9pbnRlci4NCj4gVGhlIGVycm9yIGNvZGUg4oCcLUVJTlZBTOKAnSB3
aWxsIGJlIHJldHVybmVkIHRoZW4uDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvdXNiL210dTMv
bXR1M19nYWRnZXQuYz9pZD0xNTkwYTJlMWM2ODFiMDk5MWJkNDJjOTkyY2FiZmQzODBlMDMzOGYy
I24zNzENCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuNy4yL3NvdXJjZS9k
cml2ZXJzL3VzYi9tdHUzL210dTNfZ2FkZ2V0LmMjTDM3MQ0KPiANCj4gQ2FuIGl0IGJlIG5pY2Vy
IHRvIGFzc2lnbiB0aGUgdmFyaWFibGUg4oCcbWVw4oCdIG9ubHkgYWZ0ZXIgYSBzdWNjZXNzZnVs
IGNoZWNrDQo+IGluc3RlYWQgb2YgYW4gaW5pdGlhbGlzYXRpb24gYmVmb3JlPw0KWWVzLCBJJ2xs
IGZpeCBpdCwgdGhhbmtzIGEgbG90DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQo=

