Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F313C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CAE2065D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hM8AYy4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGXGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:55:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27190 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726554AbgGXGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:55:28 -0400
X-UUID: 6fe1d2b8e77346ebb37fd399acf1aaa9-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=q01wzjCOY5vFlFseo009NsttvmUbWBwPonDdZpHH7Rw=;
        b=hM8AYy4eUduS2lFYAbw3GLURg3yNmQd1KPzn3oPH48hOczzhF+s7VaNW203ChF4TMk8wwfgftzhqeYt+TW47fOGSlvlkE0hXe/nDTqJ/TFWUselxa7I2tEtJPN0/9Bf0Cy7BJWkLiwYRMoZZropmqC9ItYwhdr/dwjAk7yPH9Wk=;
X-UUID: 6fe1d2b8e77346ebb37fd399acf1aaa9-20200724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 637720230; Fri, 24 Jul 2020 14:55:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jul 2020 14:55:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 14:55:20 +0800
Message-ID: <1595573719.24412.9.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/2] soc: mediatek: add mtk-devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 24 Jul 2020 14:55:19 +0800
In-Reply-To: <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
         <1595303971-8793-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
         <1595389756.20193.12.camel@mtkswgap22>
         <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
         <1595484707.26237.12.camel@mtkswgap22>
         <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4673738F0BEE6C71A94E980DF580DB52A6EBAABCB8B0CA45363D3FF3C96305582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gRnJpLCAyMDIwLTA3LTI0IGF0IDAwOjMyICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0N+aciDIz5pelIOmAseWbmyDkuIvljYgyOjEx5a+r6YGT
77yaDQo+ID4NCj4gPiBIaSBDaHVuLUt1YW5nLA0KPiA+DQo+ID4gT24gV2VkLCAyMDIwLTA3LTIy
IGF0IDIyOjI1ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0KPiA+ID4gSGksIE5lYWw6DQo+
ID4gPg0KPiA+ID4gTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4g5pa8IDIwMjDlubQ3
5pyIMjLml6Ug6YCx5LiJIOS4iuWNiDExOjQ55a+r6YGT77yaDQo+ID4gPiA+DQo+ID4gPiA+IEhp
IENodW4tS3VhbmcsDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFdlZCwgMjAyMC0wNy0yMiBhdCAwNzoy
MSArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiA+ID4gPiBIaSwgTmVhbDoNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAyMDIw
5bm0N+aciDIx5pelIOmAseS6jCDkuIvljYgxMjowMOWvq+mBk++8mg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKy8qDQo+ID4gPiA+ID4gPiArICog
bXRrX2RldmFwY19kdW1wX3Zpb19kYmcgLSBnZXQgdGhlIHZpb2xhdGlvbiBpbmRleCBhbmQgZHVt
cCB0aGUgZnVsbCB2aW9sYXRpb24NCj4gPiA+ID4gPiA+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRlYnVnIGluZm9ybWF0aW9uLg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4g
K3N0YXRpYyBib29sIG10a19kZXZhcGNfZHVtcF92aW9fZGJnKHN0cnVjdCBtdGtfZGV2YXBjX2Nv
bnRleHQgKmN0eCwgdTMyIHZpb19pZHgpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKyAg
ICAgICB1MzIgc2hpZnRfYml0Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICBp
ZiAoY2hlY2tfdmlvX21hc2soY3R4LCB2aW9faWR4KSkNCj4gPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGlm
ICghY2hlY2tfdmlvX3N0YXR1cyhjdHgsIHZpb19pZHgpKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgICAg
c2hpZnRfYml0ID0gZ2V0X3NoaWZ0X2dyb3VwKGN0eCwgdmlvX2lkeCk7DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChzeW5jX3Zpb19kYmcoY3R4LCBzaGlmdF9iaXQpKQ0K
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiA+ICsgICAgICAgZGV2YXBjX2V4dHJhY3RfdmlvX2RiZyhjdHgpOw0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gSSB0aGluayBnZXRfc2hpZnRfZ3JvdXAoKSwgc3luY192aW9fZGJnKCks
IGFuZA0KPiA+ID4gPiA+IGRldmFwY19leHRyYWN0X3Zpb19kYmcoKSBzaG91bGQgYmUgbW92ZWQg
b3V0IG9mIHZpb19pZHggZm9yLWxvb3AgKHRoZQ0KPiA+ID4gPiA+IGxvb3AgaW4gZGV2YXBjX3Zp
b2xhdGlvbl9pcnEoKSkgYmVjYXVzZSB0aGVzZSB0aHJlZSBmdW5jdGlvbiBpcyBub3QNCj4gPiA+
ID4gPiByZWxhdGVkIHRvIHZpb19pZHguDQo+ID4gPiA+ID4gQW5vdGhlciBxdWVzdGlvbjogd2hl
biBtdWx0aXBsZSB2aW9faWR4IHZpb2xhdGlvbiBvY2N1ciwgdmlvX2FkZHIgaXMNCj4gPiA+ID4g
PiByZWxhdGVkIHRvIHdoaWNoIG9uZSB2aW9faWR4PyBUaGUgbGF0ZXN0IGhhcHBlbmVkIG9uZT8N
Cj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBY3R1YWxseSwgaXQncyByZWxhdGVkIHRvIHZp
b19pZHguIEJ1dCB3ZSBkb24ndCB1c2UgaXQgZGlyZWN0bHkgb24gdGhlc2UNCj4gPiA+ID4gZnVu
Y3Rpb24uIEkgdGhpbmsgYmVsb3cgc25pcCBjb2RlIG1pZ2h0IGJlIGJldHRlciB3YXkgdG8gdW5k
ZXJzdGFuZCBpdC4NCj4gPiA+ID4NCj4gPiA+ID4gZm9yICguLi4pDQo+ID4gPiA+IHsNCj4gPiA+
ID4gICAgICAgICBjaGVja192aW9fbWFzaygpDQo+ID4gPiA+ICAgICAgICAgY2hlY2tfdmlvX3N0
YXR1cygpDQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgLy8gaWYgZ2V0IHZpb19pZHgsIG1hc2sg
aXQgdGVtcG9yYXJpbHkNCj4gPiA+ID4gICAgICAgICBtYXNrX21vZHVsZV9pcnEodHJ1ZSkNCj4g
PiA+ID4gICAgICAgICBjbGVhcl92aW9fc3RhdHVzKCkNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAg
ICAvLyBkdW1wIHZpb2xhdGlvbiBpbmZvDQo+ID4gPiA+ICAgICAgICAgZ2V0X3NoaWZ0X2dyb3Vw
KCkNCj4gPiA+ID4gICAgICAgICBzeW5jX3Zpb19kYmcoKQ0KPiA+ID4gPiAgICAgICAgIGRldmFw
Y19leHRyYWN0X3Zpb19kYmcoKQ0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIC8vIHVubWFzaw0K
PiA+ID4gPiAgICAgICAgIG1hc2tfbW9kdWxlX2lycShmYWxzZSkNCj4gPiA+ID4gfQ0KPiA+ID4N
Cj4gPiA+IFRoaXMgc25pcCBjb2RlIGRvZXMgbm90IGV4cGxhaW4gYW55IHRoaW5nLiBJIGNvdWxk
IHJld3JpdGUgdGhpcyBjb2RlIGFzOg0KPiA+ID4NCj4gPiA+IGZvciAoLi4uKQ0KPiA+ID4gew0K
PiA+ID4gICAgIGNoZWNrX3Zpb19tYXNrKCkNCj4gPiA+ICAgICBjaGVja192aW9fc3RhdHVzKCkN
Cj4gPiA+DQo+ID4gPiAgICAgLy8gaWYgZ2V0IHZpb19pZHgsIG1hc2sgaXQgdGVtcG9yYXJpbHkN
Cj4gPiA+ICAgICBtYXNrX21vZHVsZV9pcnEodHJ1ZSkNCj4gPiA+ICAgICBjbGVhcl92aW9fc3Rh
dHVzKCkNCj4gPiA+ICAgICAvLyB1bm1hc2sNCj4gPiA+ICAgICBtYXNrX21vZHVsZV9pcnEoZmFs
c2UpDQo+ID4gPiB9DQo+ID4gPg0KPiA+ID4gLy8gZHVtcCB2aW9sYXRpb24gaW5mbw0KPiA+ID4g
Z2V0X3NoaWZ0X2dyb3VwKCkNCj4gPiA+IHN5bmNfdmlvX2RiZygpDQo+ID4gPiBkZXZhcGNfZXh0
cmFjdF92aW9fZGJnKCkNCj4gPiA+DQo+ID4gPiBBbmQgbXkgdmVyc2lvbiBpcyBpZGVudGljYWwg
d2l0aCB5b3VyIHZlcnNpb24sIGlzbid0IGl0Pw0KPiA+DQo+ID4gU29ycnksIEkgZGlkIG5vdCBl
eHBsYWluIGl0IGNsZWFybHkuIExldCdzIG1lIHRyeSBhZ2Fpbi4NCj4gPiBUaGUgcmVhc29uIHdo
eSBJIHB1dCAiZHVtcCB2aW9sYXRpb24gaW5mbyIgYmV0d2VlbiBtYXNrICYgdW5tYXNrIGNvbnRl
eHQNCj4gPiBpcyBiZWNhdXNlIGl0IGhhcyB0byBzdG9wIGludGVycnVwdCBmaXJzdCBiZWZvcmUg
ZHVtcCB2aW9sYXRpb24gaW5mbywNCj4gPiBhbmQgdGhlbiB1bm1hc2sgaXQgdG8gcHJlcGFyZSBu
ZXh0IHZpb2xhdGlvbi4NCj4gPiBUaGVzZSBzZXF1ZW5jZSBndWFyYW50ZWUgdGhhdCBpZiBtdWx0
aXBsZSB2aW9sYXRpb24gaXMgdHJpZ2dlcmVkLCB3ZQ0KPiA+IHN0aWxsIGhhdmUgaW5mb3JtYXRp
b24gdG8gZGVidWcuDQo+ID4gSWYgdGhlIGNvZGUgc2VxdWVuY2UgaW4geW91ciB2ZXJzaW9uIGFu
ZCBtdWx0aXBsZSB2aW9sYXRpb24gaXMNCj4gPiB0cmlnZ2VyZWQsIHRoZXJlIG1pZ2h0IGJlIG5v
IGFueSBpbmZvcm1hdGlvbiBidXQga2VlcHMgZW50ZXJpbmcgSVNSLg0KPiA+IEZpbmFsbHksIHN5
c3RlbSBtaWdodCBiZSBhYm5vcm1hbCBhbmQgd2F0Y2hkb2cgdGltZW91dC4NCj4gPiBJbiB0aGlz
IGNhc2UsIHdlIHN0aWxsIGRvbid0IGhhdmUgYW55IGluZm9ybWF0aW9uIHRvIGRlYnVnLg0KPiAN
Cj4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSBubyBpbmZvcm1hdGlvbiB0byBkZWJ1Zy4g
Rm9yIGV4YW1wbGUgd2hlbg0KPiB2aW9faWR4IDUsIDEwLCAxNSBoYXMgdmlvbGF0aW9uLA0KPiBZ
b3Ugd291bGQgbWFzayB2aW9faWR4IDUgdG8gZ2V0IGluZm9ybWF0aW9uLCBidXQgdmlvX2lkeCAx
MCwgMTUgZG9lcw0KPiBub3QgbWFzayB5ZXQuDQo+IEluIHlvdXIgd29yZHMsIHdoZW4gdmlvX2lk
eCAxMCwgMTUgbm90IG1hc2ssIHlvdSB3b3VsZCBub3QgZ2V0IGFueQ0KPiBkZWJ1ZyBpbmZvcm1h
dGlvbiB3aGVuIHlvdSBwcm9jZXNzIHZpb19pZHggNS4NCj4gDQo+IEluIG15IHZlcnNpb24sIEkg
d291bGQgY2xlYXIgYWxsIHN0YXR1cywgd2h5IGtlZXBzIGVudGVyaW5nIElTUj8NCg0KVGhpbmsg
YWJvdXQgdGhpcyBjYXNlLCBpZiBzb21lb25lIHRyaWVzIHRvIGR1bXAgIkFBQSIgbW9kdWxlJ3Mg
cmVnaXN0ZXIuDQpJdCB3b3VsZCBrZWVwIHJlYWQgcmVnIGJhc2UsIGJhc2UrMHg0LCBiYXNlKzB4
OCwgLi4uDQpBbGwgdGhlc2UgcmVnaXN0ZXJzIGFyZSBpbiB0aGUgc2FtZSBzbGF2ZSwgd2hpY2gg
d291bGQgYmUgc2FtZSB2aW9faWR4Lg0KKFRha2UgdmlvX2lkeCA1IGFzIGV4YW1wbGUpDQpJbiB0
aGlzIGNhc2UsIHZpb19pZHggNSB3aWxsIGtlZXAgdHJpZ2dlcmluZyBpbnRlcnJ1cHQuIElmIHlv
dSBkaWQgbm90DQpkbyAiZHVtcCB2aW9sYXRpb24gaW5mbyIgYmV0d2VlbiBtYXNrICYgdW5tYXNr
LCB5b3UgY2Fubm90IGdldCBhbnkNCnZpb2xhdGlvbiBpbmZvIHVudGlsIHRoZSBsYXN0IGludGVy
cnVwdCBiZWluZyBoYW5kbGVkLg0KTm9ybWFsbHksIHN5c3RlbSB3aWxsIGNyYXNoIGJlZm9yZSBs
YXN0IGludGVycnVwdCBjb21pbmcuDQoNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IEFib3V0IHlvdXIgcXVlc3Rpb24sIHZpb19hZGRyIHdvdWxkIGJlIHRoZSBmaXJzdCBvbmUuDQo+
ID4gPg0KPiA+ID4gU28gb3RoZXIgdmlvX2FkZHIgd291bGQgYmUgZHJvcHBlZD8gT3IgaGFyZHdh
cmUgd291bGQga2VlcCBhbGwNCj4gPiA+IHZpb19hZGRyIGFuZCB5b3UgaGF2ZSBzb21lIHdheSB0
byBnZXQgYWxsIHZpb19hZGRyPw0KPiA+ID4NCj4gPg0KPiA+IEluIHRoaXMgY2FzZSwgaGFyZHdh
cmUgd2lsbCBkcm9wIG90aGVyIHZpb2xhdGlvbiBpbmZvIGFuZCBrZWVwIHRoZSBmaXJzdA0KPiA+
IG9uZSB1bnRpbCBpdCBiZWVuIGhhbmRsZWQuDQo+IA0KPiBEb2VzICdoYW5kbGVkJyBtZWFuIHN0
YXR1cyBpcyBjbGVhcmVkPw0KDQoiaGFuZGxlZCIgbWVhbnMgY2xlYXIgc3RhdHVzIGFuZCBkdW1w
IHZpb2xhdGlvbiBpbmZvLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCj4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICByZXR1cm4gdHJ1
ZTsNCj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArLyoNCj4gPiA+
ID4gPiA+ICsgKiBkZXZhcGNfdmlvbGF0aW9uX2lycSAtIHRoZSBkZXZhcGMgSW50ZXJydXB0IFNl
cnZpY2UgUm91dGluZSAoSVNSKSB3aWxsIGR1bXANCj4gPiA+ID4gPiA+ICsgKiAgICAgICAgICAg
ICAgICAgICAgICAgIHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBpbmNsdWRpbmcgd2hpY2ggbWFzdGVy
IHZpb2xhdGVzDQo+ID4gPiA+ID4gPiArICogICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3Mg
c2xhdmUuDQo+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiArc3RhdGljIGlycXJldHVybl90
IGRldmFwY192aW9sYXRpb25faXJxKGludCBpcnFfbnVtYmVyLA0KPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRl
eHQgKmN0eCkNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiArICAgICAgIHUzMiB2aW9faWR4
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICBmb3IgKHZpb19pZHggPSAwOyB2
aW9faWR4IDwgY3R4LT52aW9faWR4X251bTsgdmlvX2lkeCsrKSB7DQo+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgaWYgKCFtdGtfZGV2YXBjX2R1bXBfdmlvX2RiZyhjdHgsIHZpb19pZHgpKQ0K
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgLyogRW5zdXJlIHRoYXQgdmlvbGF0aW9u
IGluZm8gYXJlIHdyaXR0ZW4gYmVmb3JlDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICog
ZnVydGhlciBvcGVyYXRpb25zDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICovDQo+ID4g
PiA+ID4gPiArICAgICAgICAgICAgICAgc21wX21iKCk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+
ID4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBN
YXNrIHNsYXZlJ3MgaXJxIGJlZm9yZSBjbGVhcmluZyB2aW8gc3RhdHVzLg0KPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgICAgICAqIE11c3QgZG8gaXQgdG8gYXZvaWQgbmVzdGVkIGludGVycnVwdCBh
bmQgcHJldmVudA0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIHVuZXhwZWN0ZWQgYmVo
YXZpb3IuDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICovDQo+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgbWFza19tb2R1bGVfaXJxKGN0eCwgdmlvX2lkeCwgdHJ1ZSk7DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgY2xlYXJfdmlvX3N0YXR1cyhjdHgs
IHZpb19pZHgpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIG1h
c2tfbW9kdWxlX2lycShjdHgsIHZpb19pZHgsIGZhbHNlKTsNCj4gPiA+ID4gPiA+ICsgICAgICAg
fQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7
DQo+ID4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKy8qDQoNCg==

