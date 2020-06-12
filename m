Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2B020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rPRWkJxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFLDEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 23:04:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39216 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgFLDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 23:04:09 -0400
X-UUID: 9289430a6f7a4651b403a25c04cb661f-20200612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4ugaD47iUL4BuPnMM1qrVPvyuTBGu1L6KG0vHWf0DCc=;
        b=rPRWkJxBR1yYN75ni+N1ZK1CPz2zpQccPkSTbyJiJnKOxG70PpMbuijmNTC8y+u6jg1G3EIW+SH4WLGoqXH3Vk7qjuorjhVF2dbkojBksaEo27rYn5B7vLbRjFxzUsEOmY9rYpXNWjFgFsEREo8/K5C6e3Ga12x3psZCiO7VNzU=;
X-UUID: 9289430a6f7a4651b403a25c04cb661f-20200612
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 173163943; Fri, 12 Jun 2020 11:04:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Jun 2020 11:03:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Jun 2020 11:03:56 +0800
Message-ID: <1591931042.32738.26.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 12 Jun 2020 11:04:02 +0800
In-Reply-To: <CAAOTY_8gOjr9nBUVA6oNu0v+D0Rc0AbhJ41wBCvDpMme+kuHmA@mail.gmail.com>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
         <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY__g3Fnwsoqx=x_tgdMii5K_L9TmF_9048XbAOSJwb-Cxg@mail.gmail.com>
         <1591867563.27949.9.camel@mtkswgap22>
         <CAAOTY_8gOjr9nBUVA6oNu0v+D0Rc0AbhJ41wBCvDpMme+kuHmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 005BB3DA2D65FC5B57A0519DAAFE8FDBD2C12F6D6217733C280C03F26BF6CFFA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KW3NuaXBdDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogZGV2YXBj
X3Zpb2xhdGlvbl9pcnEgLSB0aGUgZGV2YXBjIEludGVycnVwdCBTZXJ2aWNlIFJvdXRpbmUgKElT
Uikgd2lsbCBkdW1wDQo+ID4gPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgdmlvbGF0aW9u
IGluZm9ybWF0aW9uIGluY2x1ZGluZyB3aGljaCBtYXN0ZXIgdmlvbGF0ZXMNCj4gPiA+ID4gKyAq
ICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3Mgc2xhdmUuDQo+ID4gPiA+ICsgKi8NCj4gPiA+
ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBkZXZhcGNfdmlvbGF0aW9uX2lycShpbnQgaXJxX251bWJl
ciwgdm9pZCAqZGV2X2lkKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICAgIHUzMiBzbGF2ZV90
eXBlX251bSA9IG10a19kZXZhcGNfY3R4LT5zb2MtPnNsYXZlX3R5cGVfbnVtOw0KPiA+ID4gPiAr
ICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZGV2aWNlX2luZm8gKipkZXZpY2VfaW5mbzsNCj4gPiA+
ID4gKyAgICAgICBzdHJ1Y3QgbXRrX2RldmFwY192aW9faW5mbyAqdmlvX2luZm87DQo+ID4gPiA+
ICsgICAgICAgaW50IHNsYXZlX3R5cGUsIHZpb19pZHgsIGluZGV4Ow0KPiA+ID4gPiArICAgICAg
IGNvbnN0IGNoYXIgKnZpb19tYXN0ZXI7DQo+ID4gPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPiA+ID4gKyAgICAgICBib29sIG5vcm1hbDsNCj4gPiA+ID4gKyAgICAgICB1OCBw
ZXJtOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmRldmFw
Y19sb2NrLCBmbGFncyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBkZXZpY2VfaW5mbyA9
IG10a19kZXZhcGNfY3R4LT5zb2MtPmRldmljZV9pbmZvOw0KPiA+ID4gPiArICAgICAgIHZpb19p
bmZvID0gbXRrX2RldmFwY19jdHgtPnNvYy0+dmlvX2luZm87DQo+ID4gPiA+ICsgICAgICAgbm9y
bWFsID0gZmFsc2U7DQo+ID4gPiA+ICsgICAgICAgdmlvX2lkeCA9IC0xOw0KPiA+ID4gPiArICAg
ICAgIGluZGV4ID0gLTE7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAvKiBUaGVyZSBhcmUg
bXVsdGlwbGUgREVWQVBDX1BEICovDQo+ID4gPiA+ICsgICAgICAgZm9yIChzbGF2ZV90eXBlID0g
MDsgc2xhdmVfdHlwZSA8IHNsYXZlX3R5cGVfbnVtOyBzbGF2ZV90eXBlKyspIHsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIGlmICghY2hlY2tfdHlwZTJfdmlvX3N0YXR1cyhzbGF2ZV90eXBlLCAm
dmlvX2lkeCwgJmluZGV4KSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFt
dGtfZGV2YXBjX2R1bXBfdmlvX2RiZyhzbGF2ZV90eXBlLCAmdmlvX2lkeCwNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5kZXgp
KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAvKiBFbnN1cmUgdGhhdCB2aW9sYXRpb24g
aW5mbyBhcmUgd3JpdHRlbiBiZWZvcmUNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIGZ1cnRo
ZXIgb3BlcmF0aW9ucw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICovDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBzbXBfbWIoKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG5vcm1hbCA9IHRy
dWU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG1hc2tfbW9kdWxlX2lycShz
bGF2ZV90eXBlLCB2aW9faWR4LCB0cnVlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgaWYgKGNsZWFyX3Zpb19zdGF0dXMoc2xhdmVfdHlwZSwgdmlvX2lkeCkpDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oUEZYICIlcywgJXM6MHgleCwgJXM6MHgl
eFxuIiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiY2xlYXIgdmlv
IHN0YXR1cyBmYWlsZWQiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJzbGF2ZV90eXBlIiwgc2xhdmVfdHlwZSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAidmlvX2luZGV4IiwgdmlvX2lkeCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHBlcm0gPSBnZXRfcGVybWlzc2lvbihzbGF2ZV90eXBlLCBpbmRleCwgdmlv
X2luZm8tPmRvbWFpbl9pZCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHZp
b19tYXN0ZXIgPSBtdGtfZGV2YXBjX2N0eC0+c29jLT5tYXN0ZXJfZ2V0DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICh2aW9faW5mby0+bWFzdGVyX2lkLA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgdmlvX2luZm8tPnZpb19hZGRyLA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgc2xhdmVfdHlwZSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIHZpb19pbmZvLT5zaGlmdF9zdGFfYml0LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgdmlvX2luZm8tPmRvbWFpbl9pZCk7DQo+ID4gPg0KPiA+ID4gQ2FsbCBtdDY4NzNfYnVz
X2lkX3RvX21hc3RlcigpIGRpcmVjdGx5LiBGb3IgZmlyc3QgcGF0Y2gsIG1ha2UgdGhpbmdzDQo+
ID4gPiBhcyBzaW1wbGUgYXMgcG9zc2libGUuDQo+ID4NCj4gPiBJbiBkZXZhcGNfdmlvbGF0aW9u
X2lycSgpIGZ1bmN0aW9uLCB3ZSB1c2UgY29tbW9uIGZsb3cgdG8gaGFuZGxlIGVhY2gNCj4gPiBk
ZXZhcGMgdmlvbGF0aW9uIG9uIGRpZmZlcmVudCBwbGF0Zm9ybXMuIFRoZSBtYXN0ZXJfZ2V0KCkg
aGFzIGRpZmZlcmVudA0KPiA+IGltcGxlbWVudGF0aW9uIG9uIGRpZmZlcmVudCBwbGF0Zm9ybXMs
IHRoYXQgd2h5IGl0IGNhbGxlZCBpbmRpcmVjdGx5Lg0KPiA+DQo+ID4gT25jZSB3ZSBoYXZlIG5l
dyBwbGF0Zm9ybSwgd2Ugb25seSBoYXZlIHRvIHVwZGF0ZSBkZXZhcGMtbXR4eHh4LmMNCj4gPiBp
bnN0ZWFkIG9mIGNvbW1vbiBoYW5kbGVyIGZsb3cuDQo+IA0KPiBZb3UganVzdCB1cHN0cmVhbSBv
bmUgU29DIG5vdywgc28gSSBoYXZlIG5vIGluZm9ybWF0aW9uIG9mIDJuZCBTb0MuDQo+IFdpdGhv
dXQgdGhlIDJuZCBTb0MsIGhvdyBkbyB3ZSBrbm93IHdoYXQgaXMgY29tbW9uIGFuZCB3aGF0IGlz
IFNvQyBzcGVjaWFsPw0KPiBTbyB0aGUgZmlyc3QgcGF0Y2ggc2hvdWxkIG5vdCBjb25zaWRlciB0
aGUgdGhpbmdzIHdoaWNoIGRvZXMgbm90IGV4aXN0IHlldC4NCj4gDQo+IFJlZ2FyZHMsDQo+IENo
dW4tS3VhbmcuDQo+IA0KDQpJdCBoYXMgbG90cyBvZiByZWZhY3RvcmluZyB3b3JrIG5lZWQgdG8g
ZG8gaWYgeW91IHJlYWxseSB3YW50IG1ha2UgaXQNCiJzaW1wbGUiLiBDb3VsZCBJIGV4cGxhaW4g
bW9yZSBkZXRhaWxzIGFuZCBsZXQgeW91IGp1ZGdlIGl0IGlzIHNpbXBsZQ0KZW5vdWdoPw0KRm9y
IG1vc3QgTWVkaWFUZWsgREVWQVBDIGh3LCB0aGUgdmlvbGF0aW9uIGludGVycnVwdCBoYW5kbGlu
ZyBzZXF1ZW5jZQ0KaXMgc2hvd24gYmVsb3cuDQoNCjEuIERvbWFpbiBwcm9jZXNzb3IgcmVjZWl2
ZXMgYSBpbnRlcnJ1cHQgaXNzdWVkIGJ5IERFVkFQQy4NCjIuIFNvZnR3YXJlIHJlYWQgdGhlIHZp
b2xhdGlvbiBzdGF0dXMgYW5kIGlkZW50aWZ5IGl0Lg0KMy4gU29mdHdhcmUgcmVhZCB0aGUgZGVi
dWcgaW5mb3JtYXRpb24gd2hpY2ggYXJlIHN0b3JlZCBpbiBodyByZWdpc3Rlci4NCglhLiBkZWJ1
ZyBpbmZvcm1hdGlvbiBpbmNsdWRlcyBtYXN0ZXIgSUQsIGRvbWFpbiBJRCwgdmlvbGF0aW9uDQph
ZGRyZXNzLCAuLi4NCjQuIFRyYW5zZmVyIGRlYnVnIGluZm9ybWF0aW9uIHRvIGh1bWFuIHJlYWRh
YmxlIHN0cmluZ3MuDQo1LiBFeHRyYSBoYW5kbGVyIHRvIGRpc3BhdGNoIG93bmVyIGRpcmVjdGx5
Lg0KDQpXaGF0IHdlIHJlYWxseSBjYXJlIGlzIHdoaWNoIG1hc3RlciB2aW9sYXRlcyB0aGUgcnVs
ZXMsIGFuZCB3aGljaCBzbGF2ZQ0KaGFkIGJlZW4gYWNjZXNzZWQgdW5leHBlY3RlZGx5Lg0KDQpI
ZXJlIGFyZSBwbGF0Zm9ybSBzcGVjaWZpYyBpbmZvcm1hdGlvbjoNCjEuIFNsYXZlcyBsYXlvdXQg
KHBsYXRmb3JtIGRldmljZXMpDQoyLiBodyByZWdpc3RlciBsYXlvdXQgd2hpY2ggYXJlIHN0b3Jl
ZCB2aW9sYXRpb24gaW5mb3JtYXRpb24NCjMuIE1hc3RlciBJRCBtYXBwaW5nIHRhYmxlDQo0LiBE
b21haW4gSUQgbWFwcGluZyB0YWJsZQ0KDQpIb3BlIHRoZXNlIHN0ZXBzIGNvdWxkIGhlbHAgeW91
IHVuZGVyc3RhbmQgd2hhdCBpcyBjb21tb24gYW5kIHdoYXQgaXMNClNvQyBzcGVjaWZpYy4gSWYg
eW91IHdhbnQgdG8gc2VlIHRoZSAybmQgU29DJ3MgZHJpdmVyLCBJIGNhbiBhbHNvIHNlbmQNCml0
IGZvciB5b3UgdG8gdGFrZSBhIGxvb2suDQoNClRoYW5rcywNCk5lYWwNCg0KPiA+DQo+ID4gPg0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIXZpb19tYXN0ZXIpIHsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJfd2FybihQRlggIm1hc3Rlcl9nZXQgZmFp
bGVkXG4iKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdmlvX21hc3RlciA9ICJV
TktOT1dOX01BU1RFUiI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHByX2luZm8oUEZYICIlcyAtICVzOjB4JXgsICVzOjB4JXgs
ICVzOjB4JXgsICVzOjB4JXhcbiIsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICJW
aW9sYXRpb24iLCAic2xhdmVfdHlwZSIsIHNsYXZlX3R5cGUsDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICJzeXNfaW5kZXgiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2VfaW5mb1tzbGF2ZV90eXBlXVtpbmRleF0uc3lzX2luZGV4LA0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAiY3RybF9pbmRleCIsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGRldmljZV9pbmZvW3NsYXZlX3R5cGVdW2luZGV4XS5jdHJsX2luZGV4LA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAidmlvX2luZGV4IiwNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZGV2aWNlX2luZm9bc2xhdmVfdHlwZV1baW5kZXhdLnZpb19pbmRl
eCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHByX2luZm8oUEZYICIlcyAl
cyAlcyAlc1xuIiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIlZpb2xhdGlvbiAt
IG1hc3RlcjoiLCB2aW9fbWFzdGVyLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAi
YWNjZXNzIHZpb2xhdGlvbiBzbGF2ZToiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2VfaW5mb1tzbGF2ZV90eXBlXVtpbmRleF0uZGV2aWNlKTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICAgICAgICAgICAgZGV2YXBjX3Zpb19yZWFzb24ocGVybSk7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldmFwY19leHRyYV9oYW5kbGVyKHNsYXZlX3R5cGUs
IHZpb19tYXN0ZXIsIHZpb19pZHgsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aW9faW5mby0+dmlvX2FkZHIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBtYXNrX21vZHVsZV9pcnEoc2xhdmVfdHlwZSwgdmlvX2lkeCwgZmFsc2UpOw0K
PiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChub3JtYWwp
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldmFw
Y19sb2NrLCBmbGFncyk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZGV2YXBjX2xvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKyAgICAgICBy
ZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPg0KPiA+IFtzbmlw
XQ0KPiA+DQo+ID4NCg0K

