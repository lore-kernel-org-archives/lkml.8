Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5312FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AFB21D95
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gc17d/8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGNDRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:17:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48685 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726432AbgGNDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:17:22 -0400
X-UUID: dba73c94afad45db8ff4fc0d49e5742a-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vkbJ6uCn0JxjPLqJVD77fWqRVEpiv14ICWliAnIqR0w=;
        b=gc17d/8Pwm+3lzafiI0De7JYtk+jqqYgf+90LqgclnCeSOllB8gzVsgbb7ElcNxcIAAZ5PNZDbKq3OMrDNsSgnnLMo9QZM/P5TuP6Iku8dMoQ7ZEvS8Fscna6PuPMQU1haz6wQuWC67ZQgexcVuj1xR7F2jp3NlkIcIsGfGb6ZM=;
X-UUID: dba73c94afad45db8ff4fc0d49e5742a-20200714
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 688147385; Tue, 14 Jul 2020 11:17:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 11:17:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 11:17:12 +0800
Message-ID: <1594696632.26207.12.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] dt-bindings: devapc: add bindings for mtk-devapc
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Tue, 14 Jul 2020 11:17:12 +0800
In-Reply-To: <a0a58181-525c-f7a3-4385-d778a113d60c@gmail.com>
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
         <1594285927-1840-2-git-send-email-neal.liu@mediatek.com>
         <a0a58181-525c-f7a3-4385-d778a113d60c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D48AE92DC10F63DF7DB13051FB714DFD25AD5A2EB628FAF8B4EBE6654AEED5A52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTEwIGF0IDE4OjQxICswODAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDkvMDcvMjAyMCAxMToxMiwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gQWRkIGJp
bmRpbmdzIGZvciBtdGstZGV2YXBjLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lYWwgTGl1
IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgICB8ICAgODIgKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRp
YXRlay9kZXZhcGMueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uZjA4MjQzZQ0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gQEAgLTAsMCArMSw4MiBAQA0KPiA+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyMgIyBDb3B5
cmlnaHQgMjAyMCBNZWRpYVRlayBJbmMuDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiAr
JGlkOiAiaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3ITFU
d1NyaVV0WFUyWmpYZFprTE9EZ2R1QlpZRHRHMjNpeDNqUnhxdk4zYmRmVjI5TWFLMEZVWjVPckR1
N1ZEQnEkICINCj4gPiArJHNjaGVtYTogImh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdN
ZzBBUmJ3ITFUd1NyaVV0WFUyWmpYZFprTE9EZ2R1QlpZRHRHMjNpeDNqUnhxdk4zYmRmVjI5TWFL
MEZVWjVPck5HMm9lY3IkICINCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBEZXZpY2UgQWNj
ZXNzIFBlcm1pc3Npb24gQ29udHJvbCBkcml2ZXINCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8
DQo+ID4gKyAgTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVzdFpvbmUgc2VjdXJpdHkg
c3VwcG9ydCBhbmQgZGF0YQ0KPiA+ICsgIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJv
bSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQo+ID4gKyAgVGhlIHNlY3Vy
aXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3IgZnVy
dGhlcg0KPiA+ICsgIGFuYWx5c2lzIGFuZCBjb3VudGVybWVhc3VyZXMuDQo+ID4gKw0KPiA+ICtt
YWludGFpbmVyczoNCj4gPiArICAtIE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVt
Og0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10Njc3OS1kZXZhcGMNCj4gPiArDQo+ID4gKyAgcmVn
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBiYXNlIGFkZHJlc3Mgb2YgZGV2YXBjIHJlZ2lz
dGVyIGJhbmsNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogQSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgZGVzY3Jp
cHRpb246IENvbnRhaW5zIG1vZHVsZSBjbG9jayBzb3VyY2UgYW5kIGNsb2NrIG5hbWVzDQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGRl
c2NyaXB0aW9uOiBOYW1lcyBvZiB0aGUgY2xvY2tzIGxpc3QgaW4gY2xvY2tzIHByb3BlcnR5DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBtZWRpYXRlay1zbHZfdHlwZV9udW06
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogTnVtYmVycyBvZiBzbGF2ZSB0eXBlIGluIG1lZGlhdGVr
IHBsYXRmb3JtDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiANCj4gVGhpcyBzaG91bGQgZ28gaW4g
dGhlIERUIGRhdGEsIGhhdmUgYSBsb29rIGZvciBleGFtcGxlIGF0Og0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMqTDE4NDJfXztJdyEhQ1RS
TktBOXdNZzBBUmJ3ITFUd1NyaVV0WFUyWmpYZFprTE9EZ2R1QlpZRHRHMjNpeDNqUnhxdk4zYmRm
VjI5TWFLMEZVWjVPckdJWDY0cHYkIA0KPiBhbmQNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jKkwxNzc3X187SXchIUNUUk5LQTl3TWcwQVJi
dyExVHdTcmlVdFhVMlpqWGRaa0xPRGdkdUJaWUR0RzIzaXgzalJ4cXZOM2JkZlYyOU1hSzBGVVo1
T3JGTjcwYXZfJCANCj4gDQoNCk9rYXksIEknbGwgdHJ5IHRvIGZvbGxvdyB0aGlzIGV4YW1wbGUu
DQoNCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWstdmlvX2RiZ3M6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogVGhlIG1hc2sgYml0IGFuZCBzdGFydCBiaXQgb2YgZGV2YXBjIHZpb2xhdGlvbiBkZWJ1ZyBy
ZWdpc3RlcnMNCj4gPiArICAgIG1heEl0ZW1zOiA1DQo+ID4gKw0KPiANCj4gc2FtZSBoZXJlDQo+
IA0KPiA+ICsgIG1lZGlhdGVrLXBkc19vZmZzZXQ6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhl
IG9mZnNldCBvZiBkZXZhcGMgcGRzIHJlZ2lzdGVycw0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4g
DQo+IHNhbWUgaGVyZQ0KPiANCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MN
Cj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBtZWRpYXRlay1zbHZfdHlwZV9udW0NCj4g
PiArICAtIG1lZGlhdGVrLXZpb19kYmdzDQo+ID4gKyAgLSBtZWRpYXRlay1wZHNfb2Zmc2V0DQo+
ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ2Nzc5LWNsay5oPg0KPiA+ICsNCj4gPiArICAgIGRldmFw
YzogZGV2YXBjQDEwMjA3MDAwIHsNCj4gPiArICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDY3NzktZGV2YXBjIjsNCj4gPiArICAgICAgcmVnID0gPDB4MTAyMDcwMDAgMHgxMDAwPjsNCj4g
PiArICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0K
PiA+ICsgICAgICBjbG9ja3MgPSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9ERVZJQ0VfQVBDPjsN
Cj4gPiArICAgICAgY2xvY2stbmFtZXMgPSAiZGV2YXBjLWluZnJhLWNsb2NrIjsNCj4gPiArDQo+
ID4gKyAgICAgIG1lZGlhdGVrLXNsdl90eXBlX251bSA9IC9iaXRzLyA4IDwxPjsNCj4gPiArICAg
ICAgbWVkaWF0ZWstdmlvX2RiZ3MgPSA8MHgwMDAwRkZGRiAweDA+LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIDwweDAwM0YwMDAwIDB4MTA+LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIDwweDAwNDAwMDAwIDB4MTY+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIDwweDAwODAwMDAwIDB4MTc+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIDww
eDBGMDAwMDAwIDB4MTg+Ow0KPiA+ICsgICAgICBtZWRpYXRlay1wZHNfb2Zmc2V0ID0gPDB4MCAw
eDQwMCAweDkwMCAweDkwNA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4RjAw
IDB4RjEwIDB4RjE0IDB4RjIwPjsNCj4gPiArICAgIH07DQo+ID4gDQo+IA0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBt
YWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1tZWRpYXRla19fOyEhQ1RSTktBOXdNZzBBUmJ3ITFUd1NyaVV0WFUy
WmpYZFprTE9EZ2R1QlpZRHRHMjNpeDNqUnhxdk4zYmRmVjI5TWFLMEZVWjVPck9YU0oyX1ckIA0K
DQo=

