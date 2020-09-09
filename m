Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1488C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665EC21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QytEleZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIIGbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:31:10 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728207AbgIIGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:31:08 -0400
X-UUID: 71b1abeb667c49e59c727895021575c2-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JRmS+Rddtawmdb1bnP2xpsxYN54O6rMXuvtiqbfKfLo=;
        b=QytEleZ4M4moUN0N+GfKbubyBnl5b8Yz8ePoJvE2sMp43q/9DXuYJKhe3KoCPKP7CUV5DlqjJ+STs7/5nDGJXBo2ygN069+H5FESzL0cfKOKaso3Nv4BuTLubnXbgmdHmeiOemiZ4f3uxOBr4IGKgX9DCC+C+Wpywaov+zFjep4=;
X-UUID: 71b1abeb667c49e59c727895021575c2-20200909
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <lina.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1374877360; Wed, 09 Sep 2020 14:31:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 14:31:00 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 14:30:52 +0800
From:   mtk81216 <lina.wang@mediatek.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        mtk81216 <lina.wang@mediatek.com>
Subject: [PATCH] xfrm:fragmented ipv4 tunnel packets in inner interface
Date:   Wed, 9 Sep 2020 14:26:13 +0800
Message-ID: <20200909062613.18604-1-lina.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 28A797D652C815631E838A980E70E34EDB787ADC3B5937A78B64C08AC550A8AC2000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gZXNwJ3MgdHVubmVsIG1vZGUsaWYgaW5uZXIgaW50ZXJmYWNlIGlzIGlwdjQsb3V0ZXIgaXMg
aXB2NCxvbmUgYmlnIA0KcGFja2V0IHdoaWNoIHRyYXZlbHMgdGhyb3VnaCB0dW5uZWwgd2lsbCBi
ZSBmcmFnbWVudGVkIHdpdGggb3V0ZXIgDQppbnRlcmZhY2UncyBtdHUscGVlciBzZXJ2ZXIgd2ls
bCByZW1vdmUgdHVubmVsbGVkIGVzcCBoZWFkZXIgYW5kIGFzc2VtYmxlDQp0aGVtIGluIGJpZyBw
YWNrZXQuQWZ0ZXIgZm9yd2FyZGluZyBzdWNoIHBhY2tldCB0byBuZXh0IGVuZHBvaW50LGl0IHdp
bGwgDQpiZSBkcm9wcGVkIGJlY2F1c2Ugb2YgZXhjZWVkaW5nIG10dSBvciBiZSByZXR1cm5lZCBJ
Q01QKHBhY2tldC10b28tYmlnKS4NCldoZW4gaW5uZXIgaW50ZXJmYWNlIGlzIGlwdjQsb3V0ZXIg
aXMgaXB2Nix0aGUgZmxhZyBvZiB4ZnJtIHN0YXRlIGluIHR1bm5lbA0KbW9kZSBpcyBhZi11bnNw
ZWMsIHRoaW5nIGlzIGRpZmZlcmVudC5PbmUgYmlnIHBhY2tldCB0aHJvdWdoIHR1bm5lbCB3aWxs
IGJlDQpmcmFnbWVudGVkIHdpdGggb3V0ZXIgaW50ZXJmYWNlJ3MgbXR1IG1pbnVzIHR1bm5lbGVk
IGhlYWRlciwgdGhlbiB0d28gb3IgDQptb3JlIGxlc3MgZnJhZ21lbnRlZCBwYWNrZXRzIHdpbGwg
YmUgdHVubmVsZWQgYW5kIHRyYW5zbWl0dGVkIGluIG91dGVyIA0KaW50ZXJmYWNlLHRoYXQgaXMg
d2hhdCB4ZnJtNl9vdXRwdXQgaGFzIGRvbmUuIElmIHBlZXIgc2VydmVyIHJlY2VpdmVzIHN1Y2gN
CnBhY2tldHMsIGl0IHdpbGwgZm9yd2FyZCBzdWNjZXNzZnVsbHkgdG8gbmV4dCBiZWNhdXNlIGxl
bmd0aCBpcyB2YWxpZC4NCg0KVGhpcyBwYXRjaCBoYXMgZm9sbG93ZWQgdXAgeGZybTZfb3V0cHV0
J3MgbG9naWMsd2hpY2ggaW5jbHVkZXMgdHdvIGNoYW5nZXMsDQpvbmUgaXMgY2hvb3Npbmcgc3Vp
dGFibGUgbXR1IHZhbHVlIHdoaWNoIGNvbnNpZGVyaW5nIGlubm5lci9vdXRlciANCmludGVyZmFj
ZSdzIG10dSBhbmQgZHN0IHBhdGgsIHRoZSBvdGhlciBpcyBpZiBwYWNrZXQgaXMgdG9vIGJpZywg
Y2FsbGluZyANCmlwX2ZyYWdtZW50IGZpcnN0LHRoZW4gdHVubmVsbGluZyBmcmFnbWVudGVkIHBh
Y2tldHMgaW4gb3V0ZXIgaW50ZXJmYWNlIGFuZA0KdHJhbnNtaXR0aW5nIGZpbmFsbHkuDQoNClNp
Z25lZC1vZmYtYnk6IG10azgxMjE2IDxsaW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5j
bHVkZS9uZXQvaXAuaCAgICAgICAgfCAgMyArKysNCiBuZXQvaXB2NC9pcF9vdXRwdXQuYyAgICB8
IDEwICsrKy0tLS0tLS0NCiBuZXQvaXB2NC94ZnJtNF9vdXRwdXQuYyB8IDM3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9pcC5oIGIv
aW5jbHVkZS9uZXQvaXAuaA0KaW5kZXggYjA5YzQ4ZDg2MmNjLi4wNWY5YzY0NTRmZjUgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL25ldC9pcC5oDQorKysgYi9pbmNsdWRlL25ldC9pcC5oDQpAQCAtMTYz
LDYgKzE2Myw5IEBAIGludCBpcF9vdXRwdXQoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3Qgc29jayAq
c2ssIHN0cnVjdCBza19idWZmICpza2IpOw0KIGludCBpcF9tY19vdXRwdXQoc3RydWN0IG5ldCAq
bmV0LCBzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpOw0KIGludCBpcF9kb19m
cmFnbWVudChzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYg
KnNrYiwNCiAJCSAgIGludCAoKm91dHB1dCkoc3RydWN0IG5ldCAqLCBzdHJ1Y3Qgc29jayAqLCBz
dHJ1Y3Qgc2tfYnVmZiAqKSk7DQoraW50IGlwX2ZyYWdtZW50KHN0cnVjdCBuZXQgKm5ldCwgc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KKwkJdW5zaWduZWQgaW50IG10dSwN
CisJCWludCAoKm91dHB1dCkoc3RydWN0IG5ldCAqLCBzdHJ1Y3Qgc29jayAqLCBzdHJ1Y3Qgc2tf
YnVmZiAqKSk7DQogDQogc3RydWN0IGlwX2ZyYWdsaXN0X2l0ZXIgew0KIAlzdHJ1Y3Qgc2tfYnVm
ZgkqZnJhZzsNCmRpZmYgLS1naXQgYS9uZXQvaXB2NC9pcF9vdXRwdXQuYyBiL25ldC9pcHY0L2lw
X291dHB1dC5jDQppbmRleCA2MWY4MDJkNTM1MGMuLmY5OTI0OTEzMmE3NiAxMDA2NDQNCi0tLSBh
L25ldC9pcHY0L2lwX291dHB1dC5jDQorKysgYi9uZXQvaXB2NC9pcF9vdXRwdXQuYw0KQEAgLTgy
LDEwICs4Miw2IEBADQogI2luY2x1ZGUgPGxpbnV4L25ldGxpbmsuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvdGNwLmg+DQogDQotc3RhdGljIGludA0KLWlwX2ZyYWdtZW50KHN0cnVjdCBuZXQgKm5ldCwg
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KLQkgICAgdW5zaWduZWQgaW50
IG10dSwNCi0JICAgIGludCAoKm91dHB1dCkoc3RydWN0IG5ldCAqLCBzdHJ1Y3Qgc29jayAqLCBz
dHJ1Y3Qgc2tfYnVmZiAqKSk7DQogDQogLyogR2VuZXJhdGUgYSBjaGVja3N1bSBmb3IgYW4gb3V0
Z29pbmcgSVAgZGF0YWdyYW0uICovDQogdm9pZCBpcF9zZW5kX2NoZWNrKHN0cnVjdCBpcGhkciAq
aXBoKQ0KQEAgLTU2OSw5ICs1NjUsOSBAQCBzdGF0aWMgdm9pZCBpcF9jb3B5X21ldGFkYXRhKHN0
cnVjdCBza19idWZmICp0bywgc3RydWN0IHNrX2J1ZmYgKmZyb20pDQogCXNrYl9jb3B5X3NlY21h
cmsodG8sIGZyb20pOw0KIH0NCiANCi1zdGF0aWMgaW50IGlwX2ZyYWdtZW50KHN0cnVjdCBuZXQg
Km5ldCwgc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KLQkJICAgICAgIHVu
c2lnbmVkIGludCBtdHUsDQotCQkgICAgICAgaW50ICgqb3V0cHV0KShzdHJ1Y3QgbmV0ICosIHN0
cnVjdCBzb2NrICosIHN0cnVjdCBza19idWZmICopKQ0KK2ludCBpcF9mcmFnbWVudChzdHJ1Y3Qg
bmV0ICpuZXQsIHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCisJCXVuc2ln
bmVkIGludCBtdHUsDQorCQlpbnQgKCpvdXRwdXQpKHN0cnVjdCBuZXQgKiwgc3RydWN0IHNvY2sg
Kiwgc3RydWN0IHNrX2J1ZmYgKikpDQogew0KIAlzdHJ1Y3QgaXBoZHIgKmlwaCA9IGlwX2hkcihz
a2IpOw0KIA0KZGlmZiAtLWdpdCBhL25ldC9pcHY0L3hmcm00X291dHB1dC5jIGIvbmV0L2lwdjQv
eGZybTRfb3V0cHV0LmMNCmluZGV4IDNjZmY1MWJhNzJiYi4uMTQ4OGI3OTE4NmFkIDEwMDY0NA0K
LS0tIGEvbmV0L2lwdjQveGZybTRfb3V0cHV0LmMNCisrKyBiL25ldC9pcHY0L3hmcm00X291dHB1
dC5jDQpAQCAtMTQsOCArMTQsMjcgQEANCiAjaW5jbHVkZSA8bmV0L3hmcm0uaD4NCiAjaW5jbHVk
ZSA8bmV0L2ljbXAuaD4NCiANCitzdGF0aWMgaW50IF9feGZybTRfb3V0cHV0X2ZpbmlzaChzdHJ1
Y3QgbmV0ICpuZXQsIHN0cnVjdCBzb2NrICpzaywNCisJCQkJIHN0cnVjdCBza19idWZmICpza2Ip
DQorew0KKwlyZXR1cm4geGZybV9vdXRwdXQoc2ssIHNrYik7DQorfQ0KKw0KK3N0YXRpYyBpbmxp
bmUgaW50IGlwNF9za2JfZHN0X210dShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KK3sNCisJc3RydWN0
IGluZXRfc29jayAqbnAgPSBza2ItPnNrICYmICFkZXZfcmVjdXJzaW9uX2xldmVsKCkgPw0KKwkJ
CQlpbmV0X3NrKHNrYi0+c2spIDogTlVMTDsNCisNCisJcmV0dXJuIChucCAmIG5wLT5wbXR1ZGlz
YyA+PSBJUF9QTVRVRElTQ19QUk9CRSkgPw0KKwkJc2tiX2RzdChza2IpLT5kZXYtPm10dSA6IGRz
dF9tdHUoc2tiX2RzdChza2IpKTsNCit9DQorDQogc3RhdGljIGludCBfX3hmcm00X291dHB1dChz
dHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiB7
DQorCWludCBtdHU7DQorCWJvb2wgdG9vYmlnOw0KKwlzdHJ1Y3QgeGZybV9zdGF0ZSAqeCA9IHNr
Yl9kc3Qoc2tiKS0+eGZybTsNCisNCiAjaWZkZWYgQ09ORklHX05FVEZJTFRFUg0KIAlzdHJ1Y3Qg
eGZybV9zdGF0ZSAqeCA9IHNrYl9kc3Qoc2tiKS0+eGZybTsNCiANCkBAIC0yNSw2ICs0NCwyNCBA
QCBzdGF0aWMgaW50IF9feGZybTRfb3V0cHV0KHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNvY2sg
KnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIAl9DQogI2VuZGlmDQogDQorCWlmICh4LT5wcm9w
cy5tb2RlICE9IFhGUk1fTU9ERV9UVU5ORUwpDQorCQlnb3RvIHNraXBfZnJhZzsNCisNCisJaWYg
KHNrYi0+cHJvdG9jb2wgPT0gaHRvbnMoRVRIX1BfSVApKQ0KKwkJbXR1ID0gaXA0X3NrYl9kc3Rf
bXR1KHNrYik7DQorCWVsc2UNCisJCWdvdG8gc2tpcF9mcmFnOw0KKw0KKwl0b29iaWcgPSBza2It
PmxlbiA+IG10dSAmJiAhc2tiX2lzX2dzbyhza2IpOw0KKwlpZiAoIXNrYi0+aWdub3JlX2RmICYm
IHRvb2JpZyAmJiBza2ItPnNrKSB7DQorCQl4ZnJtX2xvY2FsX2Vycm9yKHNrYiwgbXR1KTsNCisJ
CXJldHVybiAtRU1TR1NJWkU7DQorCX0NCisNCisJaWYgKHRvb2JpZyB8fCBkc3RfYWxsZnJhZyhz
a2JfZHN0KHNrYikpKQ0KKwkJcmV0dXJuIGlwX2ZyYWdtZW50KG5ldCwgc2ssIHNrYiwgbXR1LCBf
X3hmcm00X291dHB1dF9maW5pc2gpOw0KKw0KK3NraXBfZnJhZzoNCiAJcmV0dXJuIHhmcm1fb3V0
cHV0KHNrLCBza2IpOw0KIH0NCiANCi0tIA0KMi4xOC4wDQo=

