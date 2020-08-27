Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69109C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D8D22B49
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ajbc6Esw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0Fc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:32:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbgH0Fc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:32:56 -0400
X-UUID: 4fffbe82f1f046eb8ef3ec22a46a7691-20200827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ljw7Jcp00ljyO28csPPvYUltiWBjZk46SOJ+biHKHNY=;
        b=Ajbc6Eswqs21Jefub6KGvvfv73Lud7orEBzwGtp+OitA8p7S9TTcJXMdW3OQ5FE3UE7NnVlzq20DoeDJrOLdOJWBSfTAKb1+XnG9tINMQnVJUPXR1GNlBzXCJWDFAoH/REsiFYWKPC/YbpMbScbICkq4Huk+C/d6ARU0ZVZUzRE=;
X-UUID: 4fffbe82f1f046eb8ef3ec22a46a7691-20200827
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 459103778; Thu, 27 Aug 2020 13:32:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Aug
 2020 13:32:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Aug 2020 13:32:44 +0800
Message-ID: <1598506280.19851.5.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading
 infracfg
From:   Yong Wu <yong.wu@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 27 Aug 2020 13:31:20 +0800
In-Reply-To: <20200826085618.2889-1-miles.chen@mediatek.com>
References: <20200826085618.2889-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTI2IGF0IDE2OjU2ICswODAwLCBNaWxlcyBDaGVuIHdyb3RlOg0KPiBJ
biBwcmV2aW91cyBkaXNjdXNzaW9uIFsxXSBhbmQgWzJdLCB3ZSBmb3VuZCB0aGF0IGl0IGlzIHJp
c2t5IHRvDQo+IHVzZSBtYXhfcGZuIG9yIHRvdGFscmFtX3BhZ2VzIHRvIHRlbGwgaWYgNEdCIG1v
ZGUgaXMgZW5hYmxlZC4NCj4gDQo+IENoZWNrIDRHQiBtb2RlIGJ5IHJlYWRpbmcgaW5mcmFjZmcg
cmVnaXN0ZXIsIHJlbW92ZSB0aGUgdXNhZ2UNCj4gb2YgdGhlIHVuLWV4cG9ydGVkIHN5bWJvbCBt
YXhfcGZuLg0KPiANCj4gVGhpcyBpcyBhIHN0ZXAgdG93YXJkcyBidWlsZGluZyBtdGtfaW9tbXUg
YXMgYSBrZXJuZWwgbW9kdWxlLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMDA2MDMxNjExMzIuMjQ0MS0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tLw0KPiBbMl0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDYwNDA4MDEyMC4yNjI4LTEtbWlsZXMu
Y2hlbkBtZWRpYXRlay5jb20vDQo+IFszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjAwNzE1MjA1MTIwLkdBNzc4ODc2QGJvZ3VzLw0KPiANCj4gQ2M6IE1pa2UgUmFwb3BvcnQgPHJw
cHRAbGludXguaWJtLmNvbT4NCj4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KPiBDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+IENjOiBZaW5nam9l
IENoZW4gPHlpbmdqb2UuY2hlbkBtZWRpYXRlay5jb20+DQo+IENjOiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IENj
OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC0tLQ0KPiAN
Cj4gQ2hhbmdlIHNpbmNlIHYzDQo+IC0gdXNlIGxvcmUua2VybmVsLm9yZyBsaW5rcw0KPiAtIG1v
dmUgImNoYW5nZSBzaW5jZS4uLiIgYWZ0ZXIgIi0tLSINCj4gDQo+IENoYW5nZSBzaW5jZSB2MjoN
Cj4gLSBkZXRlcm1pbmUgY29tcGF0aWJsZSBzdHJpbmcgYnkgbTR1X3BsYXQNCj4gLSByZWJhc2Ug
dG8gbmV4dC0yMDIwMDcyMA0KPiAtIGFkZCAiLS0tIg0KPiANCj4gQ2hhbmdlIHNpbmNlIHYxOg0K
PiAtIHJlbW92ZSB0aGUgcGhhbmRsZSB1c2FnZSwgc2VhcmNoIGZvciBpbmZyYWNmZyBpbnN0ZWFk
IFszXQ0KPiAtIHVzZSBpbmZyYWNmZyBpbnN0ZWFkIG9mIGluZnJhY2ZnX3JlZ21hcA0KPiAtIG1v
dmUgaW5mcmFjZmcgZGVmaW5pdGFpb25zIHRvIGxpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5o
DQo+IC0gdXBkYXRlIGVuYWJsZV80R0Igb25seSB3aGVuIGhhc180Z2JfbW9kZQ0KPiAtLS0NCj4g
IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgICAgICAgICAgICAgfCAzNCArKysrKysrKysrKysr
KysrKysrKysrKy0tLS0NCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgg
fCAgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRleCA3ODViMjI4ZDM5YTYuLmFkYzM1MDE1MDQ5
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC0zLDcgKzMsNiBAQA0KPiAgICogQ29weXJpZ2h0
IChjKSAyMDE1LTIwMTYgTWVkaWFUZWsgSW5jLg0KPiAgICogQXV0aG9yOiBZb25nIFd1IDx5b25n
Lnd1QG1lZGlhdGVrLmNvbT4NCj4gICAqLw0KPiAtI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvYnVnLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+IEBAIC0xNSwxMyArMTQsMTYgQEANCj4g
ICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29u
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2lvbW11Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9z
b2MvbWVkaWF0ZWsvaW5mcmFjZmcuaD4NCj4gICNpbmNsdWRlIDxhc20vYmFycmllci5oPg0KPiAg
I2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gIA0KPiBAQCAtNjQwLDggKzY0MiwxMSBA
QCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCXN0cnVjdCByZXNvdXJjZSAgICAgICAgICpyZXM7DQo+ICAJcmVzb3VyY2Vfc2l6ZV90
CQlpb2FkZHI7DQo+ICAJc3RydWN0IGNvbXBvbmVudF9tYXRjaCAgKm1hdGNoID0gTlVMTDsNCj4g
KwlzdHJ1Y3QgcmVnbWFwCQkqaW5mcmFjZmc7DQo+ICAJdm9pZCAgICAgICAgICAgICAgICAgICAg
KnByb3RlY3Q7DQo+ICAJaW50ICAgICAgICAgICAgICAgICAgICAgaSwgbGFyYl9uciwgcmV0Ow0K
PiArCXUzMgkJCXZhbDsNCj4gKwljaGFyICAgICAgICAgICAgICAgICAgICAqcDsNCj4gIA0KPiAg
CWRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsNCj4g
IAlpZiAoIWRhdGEpDQo+IEBAIC02NTUsMTAgKzY2MCwyOSBAQCBzdGF0aWMgaW50IG10a19pb21t
dV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlyZXR1cm4gLUVOT01F
TTsNCj4gIAlkYXRhLT5wcm90ZWN0X2Jhc2UgPSBBTElHTih2aXJ0X3RvX3BoeXMocHJvdGVjdCks
IE1US19QUk9URUNUX1BBX0FMSUdOKTsNCj4gIA0KPiAtCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQg
ZHJhbSBpcyBvdmVyIDRHQiAqLw0KPiAtCWRhdGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4g
KEJJVF9VTEwoMzIpID4+IFBBR0VfU0hJRlQpKTsNCj4gLQlpZiAoIU1US19JT01NVV9IQVNfRkxB
RyhkYXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpDQo+IC0JCWRhdGEtPmVuYWJsZV80R0Ig
PSBmYWxzZTsNCj4gKwlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7DQo+ICsJaWYgKE1US19JT01N
VV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpIHsNCj4gKwkJc3dpdGNo
IChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0KSB7DQo+ICsJCWNhc2UgTTRVX01UMjcxMjoNCj4g
KwkJCXAgPSAibWVkaWF0ZWssbXQyNzEyLWluZnJhY2ZnIjsNCj4gKwkJCWJyZWFrOw0KPiArCQlj
YXNlIE00VV9NVDgxNzM6DQo+ICsJCQlwID0gIm1lZGlhdGVrLG10ODE3My1pbmZyYWNmZyI7DQo+
ICsJCQlicmVhazsNCj4gKwkJZGVmYXVsdDoNCj4gKwkJCXAgPSBOVUxMOw0KPiArCQl9DQo+ICsN
Cg0KVGhpcyBjYW4gYmUgc2ltcGxpZmllZDoNCg0KICAgICAgICBpZiAoZGF0YS0+cGxhdF9kYXRh
LT5tNHVfcGxhdCA9PSBNNFVfTVQyNzEyKQ0KCQlwID0gIm1lZGlhdGVrLG10MjcxMi1pbmZyYWNm
ZyI7DQoJZWxzZSBpZihkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgxNzMpDQoJ
CXAgPSAibWVkaWF0ZWssbXQ4MTczLWluZnJhY2ZnIjsNCgllbHNlDQoJCXJldHVybiAtRUlOVkFM
Ow0KDQpUaGVuLA0KUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0K
CQ0KDQo+ICsJCWluZnJhY2ZnID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZShw
KTsNCj4gKw0KPiArCQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkNCj4gKwkJCXJldHVybiBQVFJfRVJS
KGluZnJhY2ZnKTsNCj4gKw0KPiArCQlyZXQgPSByZWdtYXBfcmVhZChpbmZyYWNmZywgUkVHX0lO
RlJBX01JU0MsICZ2YWwpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJ
ZGF0YS0+ZW5hYmxlXzRHQiA9ICEhKHZhbCAmIEZfRERSXzRHQl9TVVBQT1JUX0VOKTsNCj4gKwl9
DQo+ICANCj4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9N
RU0sIDApOw0KPiAgCWRhdGEtPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMp
Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCj4gaW5kZXggZmQyNWYwMTQ4
NTY2Li4yMzM0NjNkNzg5YzYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL2luZnJhY2ZnLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFj
ZmcuaA0KPiBAQCAtMzIsNiArMzIsOSBAQA0KPiAgI2RlZmluZSBNVDc2MjJfVE9QX0FYSV9QUk9U
X0VOX1dCCQkoQklUKDIpIHwgQklUKDYpIHwgXA0KPiAgCQkJCQkJIEJJVCg3KSB8IEJJVCg4KSkN
Cj4gIA0KPiArI2RlZmluZSBSRUdfSU5GUkFfTUlTQwkJCQkweGYwMA0KPiArI2RlZmluZSBGX0RE
Ul80R0JfU1VQUE9SVF9FTgkJCUJJVCgxMykNCj4gKw0KPiAgaW50IG10a19pbmZyYWNmZ19zZXRf
YnVzX3Byb3RlY3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUzMiBtYXNrLA0KPiAgCQli
b29sIHJlZ191cGRhdGUpOw0KPiAgaW50IG10a19pbmZyYWNmZ19jbGVhcl9idXNfcHJvdGVjdGlv
bihzdHJ1Y3QgcmVnbWFwICppbmZyYWNmZywgdTMyIG1hc2ssDQoNCg==

