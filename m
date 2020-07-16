Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB3AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E62B20791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGPCE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:04:58 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:51342 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGPCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:04:57 -0400
Received: from localhost (unknown [192.168.167.225])
        by regular1.263xmail.com (Postfix) with ESMTP id E5649817;
        Thu, 16 Jul 2020 10:04:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from hp1216 (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P7251T139772307691264S1594865084409843_;
        Thu, 16 Jul 2020 10:04:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e89130cb787b0a5d976783346e0ad0fe>
X-RL-SENDER: zyf@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: zyf@rock-chips.com
X-FST-TO: robh@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Date:   Thu, 16 Jul 2020 10:04:45 +0800
Organization: =?UTF-8?B?55Ge6Iqv5b6u55S15a2Q?=
From:   =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
To:     "Rob Herring" <robh@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        vigneshr <vigneshr@ti.com>,
        =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        robh+dt <robh+dt@kernel.org>, richard <richard@nod.at>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggdjcgMS84XSBkdC1iaW5kaW5nczogbXRkOiBEZXNjcmliZSBSb2NrY2hpcCBSSzN4eHggTkFORA0KIGZsYXNoIGNvbnRyb2xsZXLjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFyb2JoZXJyaW5nMkBnbWFpbC5jb23ku6Plj5HjgJE=?=
References: <20200715090342.28339-1-yifeng.zhao@rock-chips.com>, 
        <20200715090342.28339-2-yifeng.zhao@rock-chips.com>, 
        <20200715175356.GA502928@bogus>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.17.58[cn]
Mime-Version: 1.0
Message-ID: <2020071610022540759717@rock-chips.com>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLAoKPk9uIFdlZCwgMTUgSnVsIDIwMjAgMTc6MDM6MzkgKzA4MDAsIFlpZmVuZyBaaGFv
IHdyb3RlOgo+PiBEb2N1bWVudGF0aW9uIHN1cHBvcnQgZm9yIFJvY2tjaGlwIFJLM3h4eCBOQU5E
IGZsYXNoIGNvbnRyb2xsZXJzCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFlpZmVuZyBaaGFvIDx5aWZl
bmcuemhhb0Byb2NrLWNoaXBzLmNvbT4KPj4gLS0tCj4+Cj4+IENoYW5nZXMgaW4gdjc6Cj4+IC0g
Rml4IHNvbWUgd3JvbmcgZGVmaW5lCj4+Cj4+IENoYW5nZXMgaW4gdjY6Cj4+IC0gRml4IHNvbWUg
d3JvbmcgZGVmaW5lCj4+IC0gTW9kaWZpZWQgdGhlIGRlZmluaXRpb24gb2YgY29tcGF0aWJsZQo+
Pgo+PiBDaGFuZ2VzIGluIHY1Ogo+PiAtIEZpeCBzb21lIHdyb25nIGRlZmluZS4KPj4gLSBBZGQg
Ym9vdC1tZWRpdW0gZGVmaW5lLgo+PiAtIFJlbW92ZSBzb21lIGNvbXBhdGlibGUgZGVmaW5lLgo+
Pgo+PiBDaGFuZ2VzIGluIHY0Ogo+PiAtIFRoZSBjb21wYXRpYmxlIGRlZmluZSB3aXRoIHJreHhf
bmZjLgo+PiAtIEFkZCBhc3NpZ25lZC1jbG9ja3MuCj4+IC0gRml4IHNvbWUgd3JvbmcgZGVmaW5l
Q2hhbmdlcyBpbi4KPj4KPj4gQ2hhbmdlcyBpbiB2MzoKPj4gLSBDaGFuZ2UgdGhlIHRpdGxlIGZv
ciB0aGUgZHQtYmluZGluZ3MuCj4+Cj4+IENoYW5nZXMgaW4gdjI6IE5vbmUKPj4KPj7CoCAuLi4v
bXRkL3JvY2tjaGlwLG5hbmQtY29udHJvbGxlci55YW1swqDCoMKgwqDCoMKgwqDCoCB8IDE2MiAr
KysrKysrKysrKysrKysrKysKPj7CoCAxIGZpbGUgY2hhbmdlZCwgMTYyIGluc2VydGlvbnMoKykK
Pj7CoCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xsZXIueWFtbAo+Pgo+Cj4KPk15IGJvdCBmb3VuZCBl
cnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOgo+Cj4v
YnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tdGQvcm9ja2NoaXAsbmFuZC1jb250cm9sbGVyLmV4YW1wbGUuZHQueWFtbDog
ZXhhbXBsZS0wOiBuYW5kLWNvbnRyb2xsZXJAZmY0YjAwMDA6cmVnOjA6IFswLCA0MjgzMTA1Mjgw
LCAwLCAxNjM4NF0gaXMgdG9vIGxvbmcKPgo+Cj5TZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wYXRjaC8xMzI5MzI1Cj4KPklmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5n
X2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUKPmVycm9yKHMpLCB0aGVuIG1ha2Ugc3Vy
ZSBkdC1zY2hlbWEgaXMgdXAgdG8gZGF0ZToKPgo+cGlwMyBpbnN0YWxsIGdpdCtodHRwczovL2dp
dGh1Yi5jb20vZGV2aWNldHJlZS1vcmcvZHQtc2NoZW1hLmdpdEBtYXN0ZXIgLS11cGdyYWRlCj4K
PlBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0LgoKbWFrZSBBUkNIPWFybTY0IGR0X2JpbmRpbmdf
Y2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
dGQvcm9ja2NoaXAsbmFuZC1jb250cm9sbGVyLnlhbWzCoArCoCBIT1NUQ0MgwqBzY3JpcHRzL2Jh
c2ljL2ZpeGRlcArCoCBIT1NUQ0MgwqBzY3JpcHRzL2R0Yy9kdGMubwrCoCBIT1NUQ0MgwqBzY3Jp
cHRzL2R0Yy9mbGF0dHJlZS5vCsKgIEhPU1RDQyDCoHNjcmlwdHMvZHRjL2ZzdHJlZS5vCsKgIEhP
U1RDQyDCoHNjcmlwdHMvZHRjL2RhdGEubwrCoCBIT1NUQ0MgwqBzY3JpcHRzL2R0Yy9saXZldHJl
ZS5vCsKgIEhPU1RDQyDCoHNjcmlwdHMvZHRjL3RyZWVzb3VyY2UubwrCoCBIT1NUQ0MgwqBzY3Jp
cHRzL2R0Yy9zcmNwb3MubwrCoCBIT1NUQ0MgwqBzY3JpcHRzL2R0Yy9jaGVja3MubwrCoCBIT1NU
Q0MgwqBzY3JpcHRzL2R0Yy91dGlsLm8KwqAgTEVYIMKgIMKgIHNjcmlwdHMvZHRjL2R0Yy1sZXhl
ci5sZXguYwrCoCBZQUNDIMKgIMKgc2NyaXB0cy9kdGMvZHRjLXBhcnNlci50YWIuW2NoXQrCoCBI
T1NUQ0MgwqBzY3JpcHRzL2R0Yy9kdGMtbGV4ZXIubGV4Lm8KwqAgSE9TVENDIMKgc2NyaXB0cy9k
dGMvZHRjLXBhcnNlci50YWIubwrCoCBIT1NUQ0MgwqBzY3JpcHRzL2R0Yy95YW1sdHJlZS5vCsKg
IEhPU1RMRCDCoHNjcmlwdHMvZHRjL2R0YwrCoCBDSEtEVCDCoCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbXRkL3JvY2tjaGlwLG5hbmQtY29udHJvbGxlci55YW1sCsKgIFNDSEVN
QSDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQtc2NoZW1hLWV4
YW1wbGVzLnlhbWwKwqAgRFRDIMKgIMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tdGQvcm9ja2NoaXAsbmFuZC1jb250cm9sbGVyLmV4YW1wbGUuZHQueWFtbArCoCBDSEVDSyDC
oCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3JvY2tjaGlwLG5hbmQtY29u
dHJvbGxlci5leGFtcGxlLmR0LnlhbWwKL2hvbWUveWlmZW5nL3dvcmsvbGludXgvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xsZXIuZXhh
bXBsZS5kdC55YW1sOiBleGFtcGxlLTA6IG5hbmQtY29udHJvbGxlckBmZjRiMDAwMDpyZWc6MDog
WzAsIDQyODMxMDUyODAsIDAsIDE2Mzg0XSBpcyB0b28gbG9uZwoKSSBhbHJlYWR5IHJhbiB0aGUg
Im1ha2UgZHRfYmluZGluZ19jaGVjayIgYmVmb3JlIHN1Ym1pdCB0aGlzIHBhdGNoIGFuZCBmb3Vu
ZCB0aGlzIGlzc3VlLgpUaGUgZHRzIGV4YW1wbGVzIGlzIGZvciBSSzMzMDgsIEFSQ0g9YXJtNjQs
IGFuZCB0aGUgcmVnIGRlZmluZSBpcyBjb3JyZWN0LgpJIHRob3VnaHQgdGhlcmUgd2FzIHNvbWV0
aGluZyB3cm9uZyB3aXRoIHRoZSBjaGVja++8jCBvciBzb21ldGhpbmcgY29uZmlndXJhdGlvbiBJ
IG1pc3NlZC4KUGxlYXNlIGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucy4KCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRy
b2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvcm9ja2No
aXAsbmFuZC1jb250cm9sbGVyLnlhbWwKaW5kZXggNDkzNzA1YTU1NjM4Li5iOWQ3YThjNzk0MDIg
MTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvcm9ja2No
aXAsbmFuZC1jb250cm9sbGVyLnlhbWwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xsZXIueWFtbApAQCAtMTMyLDcgKzEzMiw3
IEBAIGV4YW1wbGVzOgrCoCDCoCDCoG5mYzogbmFuZC1jb250cm9sbGVyQGZmNGIwMDAwIHsKwqAg
wqAgwqAgwqBjb21wYXRpYmxlID0gInJvY2tjaGlwLHJrMzMwOC1uZmMiLArCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAicm9ja2NoaXAscnYxMTA4LW5mYyI7Ci0gwqAgwqAgwqByZWcgPSA8
MHgwIDB4ZmY0YjAwMDAgMHgwIDB4NDAwMD47CisgwqAgwqAgwqByZWcgPSA8MHhmZjRiMDAwMCAw
eDQwMDA+OwrCoCDCoCDCoCDCoGludGVycnVwdHMgPSA8R0lDX1NQSSA4MSBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsKwqAgwqAgwqAgwqBjbG9ja3MgPSA8JmNydSBIQ0xLX05BTkRDPiwgPCZjcnUgU0NM
S19OQU5EQz47CsKgIMKgIMKgIMKgY2xvY2stbmFtZXMgPSAiYWhiIiwgIm5mYyI7CgptYWtlIEFS
Q0g9YXJtNjQgZHRfYmluZGluZ19jaGVjayBEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xsZXIueWFtbMKgCsKg
IFNDSEVNQSDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQtc2No
ZW1hLWV4YW1wbGVzLnlhbWwKwqAgQ0hLRFQgwqAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xsZXIueWFtbArCoCBEVEMgwqAgwqAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9yb2NrY2hpcCxuYW5kLWNvbnRyb2xs
ZXIuZXhhbXBsZS5kdC55YW1sCsKgIENIRUNLIMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tdGQvcm9ja2NoaXAsbmFuZC1jb250cm9sbGVyLmV4YW1wbGUuZHQueWFtbAoKeWlm
ZW5nLnpoYW8KCg==



