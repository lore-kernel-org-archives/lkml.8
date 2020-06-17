Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE292070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFQJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:08:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2545 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgFQJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:08:52 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 18C4EEB1569EE67C1842;
        Wed, 17 Jun 2020 17:08:49 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 17 Jun 2020 17:08:48 +0800
Received: from DGGEMM528-MBS.china.huawei.com ([169.254.7.247]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Wed, 17 Jun 2020 17:08:38 +0800
From:   Chenweilong <chenweilong@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Lizefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH linux-next] kernel/fork.c: annotate data races for
 copy_process
Thread-Topic: [PATCH linux-next] kernel/fork.c: annotate data races for
 copy_process
Thread-Index: AdZEhqLwKSS2XuNPSEC3wK4+VeNb7w==
Date:   Wed, 17 Jun 2020 09:08:38 +0000
Message-ID: <AB5DF7CCD2A48B4A97860D5EDCA2B71D94AA8AEC@DGGEMM528-MBS.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.213.91]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFR1ZSwgSnVuIDA5LCAyMDIwIGF0IDExOjA4OjAxQU0gKzA4MDAsIFdlaWxvbmcgQ2hlbiB3
cm90ZToNCj4+IFRoZSBjaGVjayBpcyBvbmx5IHRoZXJlIHRvIHN0b3Agcm9vdCBmb3JrIGJvbWJz
Lg0KPj4NCj4+IEJVRzogS0NTQU46IGRhdGEtcmFjZSBpbiBjb3B5X3Byb2Nlc3MgLyBjb3B5X3By
b2Nlc3MNCj4+DQo+PiB3cml0ZSB0byAweGZmZmZmZmZmODZmODdkMjAgb2YgNCBieXRlcyBieSB0
YXNrIDcxMjEgb24gY3B1IDU6DQo+PiAgY29weV9wcm9jZXNzKzB4MmUxYS8weDNhZjAga2VybmVs
L2ZvcmsuYzoyMjg1DQo+PiAgX2RvX2ZvcmsrMHhmNy8weDc5MCBrZXJuZWwvZm9yay5jOjI0MzAN
Cj4+ICBfX2RvX3N5c19jbG9uZSsweGY5LzB4MTMwIGtlcm5lbC9mb3JrLmM6MjU4NSAgX19zZV9z
eXNfY2xvbmUNCj4+IGtlcm5lbC9mb3JrLmM6MjU2NiBbaW5saW5lXQ0KPj4gIF9feDY0X3N5c19j
bG9uZSsweDZjLzB4ODAga2VybmVsL2ZvcmsuYzoyNTY2DQo+PiAgZG9fc3lzY2FsbF82NCsweGM3
LzB4M2IwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjI5NQ0KPj4gIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4+DQo+PiByZWFkIHRvIDB4ZmZmZmZmZmY4NmY4N2Qy
MCBvZiA0IGJ5dGVzIGJ5IHRhc2sgNzEyNSBvbiBjcHUgMzoNCj4+ICBjb3B5X3Byb2Nlc3MrMHg5
ZWIvMHgzYWYwIGtlcm5lbC9mb3JrLmM6MTk2Nw0KPj4gIF9kb19mb3JrKzB4ZjcvMHg3OTAga2Vy
bmVsL2ZvcmsuYzoyNDMwDQo+PiAgX19kb19zeXNfY2xvbmUrMHhmOS8weDEzMCBrZXJuZWwvZm9y
ay5jOjI1ODUgIF9fc2Vfc3lzX2Nsb25lDQo+PiBrZXJuZWwvZm9yay5jOjI1NjYgW2lubGluZV0N
Cj4+ICBfX3g2NF9zeXNfY2xvbmUrMHg2Yy8weDgwIGtlcm5lbC9mb3JrLmM6MjU2Ng0KPj4gIGRv
X3N5c2NhbGxfNjQrMHhjNy8weDNiMCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzoyOTUNCj4+ICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogV2VpbG9uZyBDaGVuIDxjaGVud2VpbG9uZ0BodWF3ZWkuY29tPg0KPg0KPlBsdW1iaW5n
IGRhdGFfcmFjZSgpIGluIHRoZXJlIGp1c3QgdG8gdGFwZXIgb3ZlciB0aGlzIHNlZW1zIHVnbHku
DQo+QmVmb3JlIHdlIGRvIHRoYXQgd2Ugc2hvdWxkIHByb2JhYmx5IHNpbXBseSBtYWtlIG5yX3Ro
cmVhZHMgYXRvbWljX3QuDQpXaWxsIHVzaW5nIGF0b21pY190IGNhdXNlIHBlcmZvcm1hbmNlIGRl
Z3JhZGF0aW9uID8gSSBkb27igJl0IGtub3cgd2h5IGF0b21pYyB3YXMgbm90IHVzZWQgaW4gdGhl
IGJlZ2lubmluZy4NCg0KPkFsc28sIHdoZXJlJ3MgdGhlIGxpbmsgdG8gdGhlIHN5emJvdC9rY3Nh
biByZXBvcnQ/IE9yIGRpZCB5b3UgZ2V0IHRoaXMgcmVwb3J0IGZyb20gc29tZXdoZXJlIGVsc2U/
DQpJIGdvdCB0aGlzIGZyb20gbG9jYWwgdGVzdC4NCj4NCj5kaWZmIC0tZ2l0IGEva2VybmVsL2V4
aXQuYyBiL2tlcm5lbC9leGl0LmMgaW5kZXggYzMwMDI1M2E3YjhlLi40MmUxY2Y2NDBiMjAgMTAw
NjQ0DQo+LS0tIGEva2VybmVsL2V4aXQuYw0KPisrKyBiL2tlcm5lbC9leGl0LmMNCj5AQCAtNzEs
NyArNzEsNyBAQA0KPg0KPiBzdGF0aWMgdm9pZCBfX3VuaGFzaF9wcm9jZXNzKHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCwgYm9vbCBncm91cF9kZWFkKSAgew0KPi0gICAgICAgbnJfdGhyZWFkcy0tOw0K
PisgICAgICAgYXRvbWljX2RlYygmbnJfdGhyZWFkcyk7DQo+ICAgICAgICBkZXRhY2hfcGlkKHAs
IFBJRFRZUEVfUElEKTsNCj4gICAgICAgIGlmIChncm91cF9kZWFkKSB7DQo+ICAgICAgICAgICAg
ICAgIGRldGFjaF9waWQocCwgUElEVFlQRV9UR0lEKTsgZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3Jr
LmMgYi9rZXJuZWwvZm9yay5jIGluZGV4IGNlZmU4NzQ1YzQ2ZS4uYzgzNTU0NDhkN2M2IDEwMDY0
NA0KPi0tLSBhL2tlcm5lbC9mb3JrLmMNCj4rKysgYi9rZXJuZWwvZm9yay5jDQo+QEAgLTEyMiw3
ICsxMjIsNyBAQA0KPiAgKiBQcm90ZWN0ZWQgY291bnRlcnMgYnkgd3JpdGVfbG9ja19pcnEoJnRh
c2tsaXN0X2xvY2spDQo+ICAqLw0KPiB1bnNpZ25lZCBsb25nIHRvdGFsX2ZvcmtzOyAgICAgLyog
SGFuZGxlIG5vcm1hbCBMaW51eCB1cHRpbWVzLiAqLw0KPi1pbnQgbnJfdGhyZWFkczsgICAgICAg
ICAgICAgICAgICAgICAgICAvKiBUaGUgaWRsZSB0aHJlYWRzIGRvIG5vdCBjb3VudC4uICovDQo+
K2F0b21pY190IG5yX3RocmVhZHM7ICAgICAgICAgICAvKiBUaGUgaWRsZSB0aHJlYWRzIGRvIG5v
dCBjb3VudC4uICovDQo+DQo+IHN0YXRpYyBpbnQgbWF4X3RocmVhZHM7ICAgICAgICAgICAgICAg
IC8qIHR1bmFibGUgbGltaXQgb24gbnJfdGhyZWFkcyAqLw0KPg0KPkBAIC0xOTc4LDcgKzE5Nzgs
NyBAQCBzdGF0aWMgX19sYXRlbnRfZW50cm9weSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNvcHlfcHJv
Y2VzcygNCj4gICAgICAgICAqIHRvIHN0b3Agcm9vdCBmb3JrIGJvbWJzLg0KPiAgICAgICAgICov
DQo+ICAgICAgICByZXR2YWwgPSAtRUFHQUlOOw0KPi0gICAgICAgaWYgKG5yX3RocmVhZHMgPj0g
bWF4X3RocmVhZHMpDQo+KyAgICAgICBpZiAoYXRvbWljX3JlYWQoJm5yX3RocmVhZHMpID49IG1h
eF90aHJlYWRzKQ0KPiAgICAgICAgICAgICAgICBnb3RvIGJhZF9mb3JrX2NsZWFudXBfY291bnQ7
DQo+DQo+ICAgICAgICBkZWxheWFjY3RfdHNrX2luaXQocCk7ICAvKiBNdXN0IHJlbWFpbiBhZnRl
ciBkdXBfdGFza19zdHJ1Y3QoKSAqLyBAQCAtMjI5Niw3ICsyMjk2LDcgQEAgc3RhdGljIF9fbGF0
ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3RydWN0ICpjb3B5X3Byb2Nlc3MoDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnAtPnNpZ25hbC0+dGhyZWFkX2hlYWQp
Ow0KPiAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgIGF0dGFjaF9waWQocCwgUElE
VFlQRV9QSUQpOw0KPi0gICAgICAgICAgICAgICBucl90aHJlYWRzKys7DQo+KyAgICAgICAgICAg
ICAgIGF0b21pY19pbmMoJm5yX3RocmVhZHMpOw0KPiAgICAgICAgfQ0KPiAgICAgICAgdG90YWxf
Zm9ya3MrKzsNCj4gICAgICAgIGhsaXN0X2RlbF9pbml0KCZkZWxheWVkLm5vZGUpOw0KPg0KPj4g
LS0tDQo+PiAga2VybmVsL2ZvcmsuYyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2Zvcmsu
YyBiL2tlcm5lbC9mb3JrLmMgaW5kZXgNCj4+IDE0MmIyMzY0NWQ4Mi4uZWZjNTQ5MzIwM2FlIDEw
MDY0NA0KPj4gLS0tIGEva2VybmVsL2ZvcmsuYw0KPj4gKysrIGIva2VybmVsL2ZvcmsuYw0KPj4g
QEAgLTE5NzcsNyArMTk3Nyw3IEBAIHN0YXRpYyBfX2xhdGVudF9lbnRyb3B5IHN0cnVjdCB0YXNr
X3N0cnVjdCAqY29weV9wcm9jZXNzKA0KPj4gICAgICAgKiB0byBzdG9wIHJvb3QgZm9yayBib21i
cy4NCj4+ICAgICAgICovDQo+PiAgICAgIHJldHZhbCA9IC1FQUdBSU47DQo+PiAtICAgIGlmIChu
cl90aHJlYWRzID49IG1heF90aHJlYWRzKQ0KPj4gKyAgICBpZiAoZGF0YV9yYWNlKG5yX3RocmVh
ZHMgPj0gbWF4X3RocmVhZHMpKQ0KPj4gICAgICAgICAgICAgIGdvdG8gYmFkX2ZvcmtfY2xlYW51
cF9jb3VudDsNCj4+DQo+PiAgICAgIGRlbGF5YWNjdF90c2tfaW5pdChwKTsgIC8qIE11c3QgcmVt
YWluIGFmdGVyIGR1cF90YXNrX3N0cnVjdCgpICovDQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0KPg0K
