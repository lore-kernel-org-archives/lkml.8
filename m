Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DDC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77542083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GsQGasfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgBOJVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 04:21:00 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725852AbgBOJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 04:21:00 -0500
X-UUID: e183eb48eb1f403b98a19fec620da92a-20200215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=k13YbxXhz4gHeoY8sCSPlvVxaM10t7m2oHtq2oD0CI0=;
        b=GsQGasfnVre3dzigm4NEoBALH29uYsv1l36FYecb8416SjNKbbTuoWmTgQnYwVvcWwm1eYbKzXxTnrkazpFzJlIjmJnlWIgzz1t46a3wuaQ/VceKUUDP+tio+wcD7m4bCrh/swNoa+w+qJ9dvsTHcYNBJHkfDM0BWDlpIQXgJxo=;
X-UUID: e183eb48eb1f403b98a19fec620da92a-20200215
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1317205863; Sat, 15 Feb 2020 17:20:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 15 Feb
 2020 17:19:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 15 Feb 2020 17:18:49 +0800
Message-ID: <1581758398.3473.3.camel@mhfsdcap03>
Subject: Re: [PATCH 4/9] usb: roles: Leave the private driver data pointer
 to the drivers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Date:   Sat, 15 Feb 2020 17:19:58 +0800
In-Reply-To: <20200213132428.53374-5-heikki.krogerus@linux.intel.com>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
         <20200213132428.53374-5-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B88534A6BE45C77582AA7EE259A2C4329D073BDE8CECCF35BFDCADB4570735E32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTEzIGF0IDE2OjI0ICswMzAwLCBIZWlra2kgS3JvZ2VydXMgd3JvdGU6
DQo+IEFkZGluZyB1c2Jfcm9sZV9zd2l0Y2hfZ2V0L3NldF9kcnZkYXRhKCkgZnVuY3Rpb25zIHRo
YXQgdGhlDQo+IHN3aXRjaCBkcml2ZXJzIGNhbiB1c2UgZm9yIHNldHRpbmcgYW5kIGdldHRpbmcg
cHJpdmF0ZSBkYXRhDQo+IHBvaW50ZXIgdGhhdCBpcyBhc3NvY2lhdGVkIHdpdGggdGhlIHN3aXRj
aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtraSBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dlcnVz
QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9yb2xlcy9jbGFzcy5jIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC91c2Ivcm9sZS5oICB8
IDE2ICsrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3JvbGVzL2NsYXNzLmMgYi9kcml2ZXJz
L3VzYi9yb2xlcy9jbGFzcy5jDQo+IGluZGV4IDYzYTAwZmYyNjY1NS4uZjMxMzJkMjMxNTk5IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9yb2xlcy9jbGFzcy5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL3JvbGVzL2NsYXNzLmMNCj4gQEAgLTMyOSw2ICszMjksNyBAQCB1c2Jfcm9sZV9zd2l0Y2hf
cmVnaXN0ZXIoc3RydWN0IGRldmljZSAqcGFyZW50LA0KPiAgCXN3LT5kZXYuZndub2RlID0gZGVz
Yy0+Zndub2RlOw0KPiAgCXN3LT5kZXYuY2xhc3MgPSByb2xlX2NsYXNzOw0KPiAgCXN3LT5kZXYu
dHlwZSA9ICZ1c2Jfcm9sZV9kZXZfdHlwZTsNCj4gKwlzdy0+ZGV2LmRyaXZlcl9kYXRhID0gZGVz
Yy0+ZHJpdmVyX2RhdGE7DQpIb3cgYWJvdXQgdXNlIGRldl9zZXRfZHJ2ZGF0YSgpPyB3aWxsIGtl
ZXAgYWxpZ24gd2l0aA0KdXNiX3JvbGVfc3dpdGNoX3NldC9nZXRfZHJ2ZGF0YSgpLCANCg0KPiAg
CWRldl9zZXRfbmFtZSgmc3ctPmRldiwgIiVzLXJvbGUtc3dpdGNoIiwgZGV2X25hbWUocGFyZW50
KSk7DQo+ICANCj4gIAlyZXQgPSBkZXZpY2VfcmVnaXN0ZXIoJnN3LT5kZXYpOw0KPiBAQCAtMzU2
LDYgKzM1NywyNyBAQCB2b2lkIHVzYl9yb2xlX3N3aXRjaF91bnJlZ2lzdGVyKHN0cnVjdCB1c2Jf
cm9sZV9zd2l0Y2ggKnN3KQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX3JvbGVfc3dp
dGNoX3VucmVnaXN0ZXIpOw0KPiAgDQo+ICsvKioNCj4gKyAqIHVzYl9yb2xlX3N3aXRjaF9zZXRf
ZHJ2ZGF0YSAtIEFzc2lnbiBwcml2YXRlIGRhdGEgcG9pbnRlciB0byBhIHN3aXRjaA0KPiArICog
QHN3OiBVU0IgUm9sZSBTd2l0Y2gNCj4gKyAqIEBkYXRhOiBQcml2YXRlIGRhdGEgcG9pbnRlcg0K
PiArICovDQo+ICt2b2lkIHVzYl9yb2xlX3N3aXRjaF9zZXRfZHJ2ZGF0YShzdHJ1Y3QgdXNiX3Jv
bGVfc3dpdGNoICpzdywgdm9pZCAqZGF0YSkNCj4gK3sNCj4gKwlkZXZfc2V0X2RydmRhdGEoJnN3
LT5kZXYsIGRhdGEpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwodXNiX3JvbGVfc3dpdGNo
X3NldF9kcnZkYXRhKTsNCj4gKw0KPiArLyoqDQo+ICsgKiB1c2Jfcm9sZV9zd2l0Y2hfZ2V0X2Ry
dmRhdGEgLSBHZXQgdGhlIHByaXZhdGUgZGF0YSBwb2ludGVyIG9mIGEgc3dpdGNoDQo+ICsgKiBA
c3c6IFVTQiBSb2xlIFN3aXRjaA0KPiArICovDQo+ICt2b2lkICp1c2Jfcm9sZV9zd2l0Y2hfZ2V0
X2RydmRhdGEoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cpDQo+ICt7DQo+ICsJcmV0dXJuIGRl
dl9nZXRfZHJ2ZGF0YSgmc3ctPmRldik7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1c2Jf
cm9sZV9zd2l0Y2hfZ2V0X2RydmRhdGEpOw0KPiArDQo+ICBzdGF0aWMgaW50IF9faW5pdCB1c2Jf
cm9sZXNfaW5pdCh2b2lkKQ0KPiAgew0KPiAgCXJvbGVfY2xhc3MgPSBjbGFzc19jcmVhdGUoVEhJ
U19NT0RVTEUsICJ1c2Jfcm9sZSIpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2Iv
cm9sZS5oIGIvaW5jbHVkZS9saW51eC91c2Ivcm9sZS5oDQo+IGluZGV4IGVmYWMzYWY4M2Q2Yi4u
MDJkYWU5MzZjZWJkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3VzYi9yb2xlLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC91c2Ivcm9sZS5oDQo+IEBAIC0yNSw2ICsyNSw3IEBAIHR5cGVk
ZWYgZW51bSB1c2Jfcm9sZSAoKnVzYl9yb2xlX3N3aXRjaF9nZXRfdCkoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gICAqIEBzZXQ6IENhbGxiYWNrIGZvciBzZXR0aW5nIHRoZSByb2xlDQo+ICAgKiBA
Z2V0OiBDYWxsYmFjayBmb3IgZ2V0dGluZyB0aGUgcm9sZSAob3B0aW9uYWwpDQo+ICAgKiBAYWxs
b3dfdXNlcnNwYWNlX2NvbnRyb2w6IElmIHRydWUgdXNlcnNwYWNlIG1heSBjaGFuZ2UgdGhlIHJv
bGUgdGhyb3VnaCBzeXNmcw0KPiArICogQGRyaXZlcl9kYXRhOiBQcml2YXRlIGRhdGEgcG9pbnRl
cg0KPiAgICoNCj4gICAqIEB1c2IyX3BvcnQgYW5kIEB1c2IzX3BvcnQgd2lsbCBwb2ludCB0byB0
aGUgVVNCIGhvc3QgcG9ydCBhbmQgQHVkYyB0byB0aGUgVVNCDQo+ICAgKiBkZXZpY2UgY29udHJv
bGxlciBiZWhpbmQgdGhlIFVTQiBjb25uZWN0b3Igd2l0aCB0aGUgcm9sZSBzd2l0Y2guIElmDQo+
IEBAIC00MCw2ICs0MSw3IEBAIHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2hfZGVzYyB7DQo+ICAJdXNi
X3JvbGVfc3dpdGNoX3NldF90IHNldDsNCj4gIAl1c2Jfcm9sZV9zd2l0Y2hfZ2V0X3QgZ2V0Ow0K
PiAgCWJvb2wgYWxsb3dfdXNlcnNwYWNlX2NvbnRyb2w7DQo+ICsJdm9pZCAqZHJpdmVyX2RhdGE7
DQo+ICB9Ow0KPiAgDQo+IA0KPiBAQCAtNTcsNiArNTksOSBAQCBzdHJ1Y3QgdXNiX3JvbGVfc3dp
dGNoICoNCj4gIHVzYl9yb2xlX3N3aXRjaF9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpwYXJlbnQs
DQo+ICAJCQkgY29uc3Qgc3RydWN0IHVzYl9yb2xlX3N3aXRjaF9kZXNjICpkZXNjKTsNCj4gIHZv
aWQgdXNiX3JvbGVfc3dpdGNoX3VucmVnaXN0ZXIoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cp
Ow0KPiArDQo+ICt2b2lkIHVzYl9yb2xlX3N3aXRjaF9zZXRfZHJ2ZGF0YShzdHJ1Y3QgdXNiX3Jv
bGVfc3dpdGNoICpzdywgdm9pZCAqZGF0YSk7DQo+ICt2b2lkICp1c2Jfcm9sZV9zd2l0Y2hfZ2V0
X2RydmRhdGEoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cpOw0KPiAgI2Vsc2UNCj4gIHN0YXRp
YyBpbmxpbmUgaW50IHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZShzdHJ1Y3QgdXNiX3JvbGVfc3dp
dGNoICpzdywNCj4gIAkJZW51bSB1c2Jfcm9sZSByb2xlKQ0KPiBAQCAtOTAsNiArOTUsMTcgQEAg
dXNiX3JvbGVfc3dpdGNoX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKnBhcmVudCwNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIGlubGluZSB2b2lkIHVzYl9yb2xlX3N3aXRjaF91bnJlZ2lzdGVyKHN0cnVj
dCB1c2Jfcm9sZV9zd2l0Y2ggKnN3KSB7IH0NCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lkDQo+
ICt1c2Jfcm9sZV9zd2l0Y2hfc2V0X2RydmRhdGEoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cs
IHZvaWQgKmRhdGEpDQo+ICt7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCAqdXNi
X3JvbGVfc3dpdGNoX2dldF9kcnZkYXRhKHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2ggKnN3KQ0KPiAr
ew0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiArDQo+ICAjZW5kaWYNCj4gIA0KPiAgI2VuZGlm
IC8qIF9fTElOVVhfVVNCX1JPTEVfSCAqLw0KDQo=

