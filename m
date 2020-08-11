Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0351204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHKHGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:06:07 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:34472
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727846AbgHKHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:06:07 -0400
Received: from qiuwenbo$phytium.com.cn ( [106.19.114.17] ) by
 ajax-webmail-c1app10 (Coremail) ; Tue, 11 Aug 2020 15:05:46 +0800
 (GMT+08:00)
X-Originating-IP: [106.19.114.17]
Date:   Tue, 11 Aug 2020 15:05:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6YKx5paH5Y2a?= <qiuwenbo@phytium.com.cn>
To:     "Damien Le Moal" <Damien.LeMoal@wdc.com>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Atish Patra" <Atish.Patra@wdc.com>,
        "Anup Patel" <anup@brainfault.org>,
        "Guo Ren" <guoren@linux.alibaba.com>,
        "Zong Li" <zong.li@sifive.com>,
        "Greentime Hu" <greentime.hu@sifive.com>,
        "Vincent Chen" <vincent.chen@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] riscv: Setup exception vector for K210 properly
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200612(f94081b1)
 Copyright (c) 2002-2020 www.mailtech.cn icmhosting
In-Reply-To: <CY4PR04MB375124E6D2AD38BF1D71C1D5E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
 <CY4PR04MB375124E6D2AD38BF1D71C1D5E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: hE3Ci2Zvb3Rlcl90eHQ9NDQ1NDoxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1ff8e8cb.a4c6.173dc56db41.Coremail.qiuwenbo@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CgINCgDnSNZKQzJfLEg0AA--.787W
X-CM-SenderInfo: 5tlx4vhqerq15k1wx33pof0zgofq/1tbiDAN9w17uG6uyjQAGsI
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHNlcmlhbCBwb3J0IGRpZCBub3QgcHJpbnQgYW55dGhpbmcgYWZ0ZXIgZWFybHkgY29uc29s
ZS4gDQoNClsgICAgMC4wMDAwMDBdIFNvcnRpbmcgX19leF90YWJsZS4uLg0KWyAgICAwLjAwMDAw
MF0gbWVtIGF1dG8taW5pdDogc3RhY2s6b2ZmLCBoZWFwIGFsbG9jOm9mZiwgaGVhcCBmcmVlOm9m
Zg0KWyAgICAwLjAwMDAwMF0gTWVtb3J5OiA2NDgwSy84MTkySyBhdmFpbGFibGUgKDEwMjRLIGtl
cm5lbCBjb2RlLCAxMTFLIHJ3ZGF0YSwgMTcwSyByb2RhdGEsIDEwMUsgaW5pdCwgOTdLIGJzcywg
MTcxMksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCkNClsgICAgMC4wMDAwMDBdIHJjdTogSGll
cmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4NClsgICAgMC4wMDAwMDBdIHJjdTogUkNVIGNh
bGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVubGlzdG1lbnQgZGVsYXkgaXMgMjUgamlmZmll
cy4NClsgICAgMC4wMDAwMDBdIE5SX0lSUVM6IDY0LCBucl9pcnFzOiA2NCwgcHJlYWxsb2NhdGVk
IGlycXM6IDANClsgICAgMC4wMDAwMDBdIHJpc2N2LWludGM6IDY0IGxvY2FsIGludGVycnVwdHMg
bWFwcGVkDQpbICAgIDAuMDAwMDAwXSBwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBjMDAwMDAw
OiBtYXBwZWQgNjUgaW50ZXJydXB0cyB3aXRoIDIgaGFuZGxlcnMgZm9yIDQgY29udGV4dHMuDQpb
ICAgIDAuMDAwMDAwXSByYW5kb206IGdldF9yYW5kb21fYnl0ZXMgY2FsbGVkIGZyb20gMHgwMDAw
MDAwMDgwMDAxOWE0IHdpdGggY3JuZ19pbml0PTANClsgICAgMC4wMDAwMDBdIHJpc2N2X3RpbWVy
X2luaXRfZHQ6IFJlZ2lzdGVyaW5nIGNsb2Nrc291cmNlIGNwdWlkIFswXSBoYXJ0aWQgWzBdDQpb
ICAgIDAuMDAwMDAwXSBjbG9ja3NvdXJjZTogcmlzY3ZfY2xvY2tzb3VyY2U6IG1hc2s6IDB4ZmZm
ZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOiAweDM5OTBiZTY4YiwgbWF4X2lkbGVfbnM6IDg4MTU5
MDQwNDI3MiBucw0KWyAgICAwLjAwMDAxNV0gc2NoZWRfY2xvY2s6IDY0IGJpdHMgYXQgN01Ieiwg
cmVzb2x1dGlvbiAxMjhucywgd3JhcHMgZXZlcnkgNDM5ODA0NjUxMTA1NG5zDQpbICAgIDAuMDA4
MjU0XSBDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1DQoNCg0KDQomZ3Q7IC0tLS0t
5Y6f5aeL6YKu5Lu2LS0tLS0NCiZndDsg5Y+R5Lu25Lq6OiAiRGFtaWVuIExlIE1vYWwiIDxkYW1p
ZW4ubGVtb2FsQHdkYy5jb20+DQomZ3Q7IOWPkemAgeaXtumXtDogMjAyMC0wOC0xMSAxNDo0Mjox
NSAo5pif5pyf5LqMKQ0KJmd0OyDmlLbku7bkuro6ICJRaXUgV2VuYm8iIDxxaXV3ZW5ib0BwaHl0
aXVtLmNvbS5jbj4sICJQYWxtZXIgRGFiYmVsdCIgPHBhbG1lckBkYWJiZWx0LmNvbT4sICJQYXVs
IFdhbG1zbGV5IiA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPiwgImxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmciIDxsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnPg0KJmd0OyDm
ioTpgIE6ICJBbGJlcnQgT3UiIDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+LCAiQXRpc2ggUGF0cmEi
IDxhdGlzaC5wYXRyYUB3ZGMuY29tPiwgIkFudXANCiZndDsgIFBhdGVsIiA8YW51cEBicmFpbmZh
dWx0Lm9yZz4sICJHdW8gUmVuIiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPiwgIlpvbmcgTGki
IDx6b25nLmxpQHNpZml2ZS5jb20+LCAiR3JlZW50aW1lIEh1IiA8Z3JlZW50aW1lLmh1QHNpZml2
ZS5jb20+LCAiVmluY2VudCBDaGVuIiA8dmluY2VudC5jaGVuQHNpZml2ZS5jb20+LCAibGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZyIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQom
Z3Q7IOS4u+mimDogUmU6IFtQQVRDSF0gcmlzY3Y6IFNldHVwIGV4Y2VwdGlvbiB2ZWN0b3IgZm9y
IEsyMTAgcHJvcGVybHkNCiZndDsgDQomZ3Q7IE9uIDIwMjAvMDgvMTEgMTU6MzgsIFFpdSBXZW5i
byB3cm90ZToNCiZndDsgJmd0OyBFeGNlcHRpb24gdmVjdG9yIGlzIG1pc3Npbmcgb24gbm9tbXUg
cGxhdGZvcm0gYW5kIGl0IGlzIGEgYmlnIGlzc3VlLg0KJmd0OyAmZ3Q7IFRoaXMgcGF0Y2ggaXMg
dGVzdGVkIGluIFNpcGVlZCBNQUlYIEJpdCBEZXYgQm9hcmQuDQomZ3Q7ICZndDsgDQomZ3Q7ICZn
dDsgRml4ZXM6IDc5YjFmZWJhNTQ1NSAoIlJJU0MtVjogU2V0dXAgZXhjZXB0aW9uIHZlY3RvciBl
YXJseSIpDQomZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogUWl1IFdlbmJvIDxxaXV3ZW5ib0BwaHl0
aXVtLmNvbS5jbj4NCiZndDsgJmd0OyAtLS0NCiZndDsgJmd0OyAgYXJjaC9yaXNjdi9rZXJuZWwv
c21wYm9vdC5jIHwgIDEgKw0KJmd0OyAmZ3Q7ICBhcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jICAg
fCAxMSArKysrKysrKysrLQ0KJmd0OyAmZ3Q7ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCiZndDsgJmd0OyANCiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5j
DQomZ3Q7ICZndDsgaW5kZXggMzU2ODI1YTU3NTUxLi4yM2NkZTBjZWIzOWQgMTAwNjQ0DQomZ3Q7
ICZndDsgLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jDQomZ3Q7ICZndDsgKysrIGIv
YXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jDQomZ3Q7ICZndDsgQEAgLTE1NCw2ICsxNTQsNyBA
QCBhc21saW5rYWdlIF9fdmlzaWJsZSB2b2lkIHNtcF9jYWxsaW4odm9pZCkNCiZndDsgJmd0OyAg
CW1tZ3JhYihtbSk7DQomZ3Q7ICZndDsgIAljdXJyZW50LSZndDthY3RpdmVfbW0gPSBtbTsNCiZn
dDsgJmd0OyAgDQomZ3Q7ICZndDsgKwl0cmFwX2luaXQoKTsNCiZndDsgJmd0OyAgCW5vdGlmeV9j
cHVfc3RhcnRpbmcoY3Vycl9jcHVpZCk7DQomZ3Q7ICZndDsgIAl1cGRhdGVfc2libGluZ3NfbWFz
a3MoY3Vycl9jcHVpZCk7DQomZ3Q7ICZndDsgIAlzZXRfY3B1X29ubGluZShjdXJyX2NwdWlkLCAx
KTsNCiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL3RyYXBzLmMNCiZndDsgJmd0OyBpbmRleCBhZDE0ZjQ0NjZkOTIuLmEz
OTAyMzk4MThhZSAxMDA2NDQNCiZndDsgJmd0OyAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC90cmFw
cy5jDQomZ3Q7ICZndDsgKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYw0KJmd0OyAmZ3Q7
IEBAIC0xNzQsNyArMTc0LDE2IEBAIGludCBpc192YWxpZF9idWdhZGRyKHVuc2lnbmVkIGxvbmcg
cGMpDQomZ3Q7ICZndDsgIH0NCiZndDsgJmd0OyAgI2VuZGlmIC8qIENPTkZJR19HRU5FUklDX0JV
RyAqLw0KJmd0OyAmZ3Q7ICANCiZndDsgJmd0OyAtLyogc3R2ZWMgJmFtcDsgc2NyYXRjaCBpcyBh
bHJlYWR5IHNldCBmcm9tIGhlYWQuUyAqLw0KJmd0OyAmZ3Q7ICsvKiBzdHZlYyAmYW1wOyBzY3Jh
dGNoIGlzIGFscmVhZHkgc2V0IGZyb20gaGVhZC5TIHdoZW4gbW11IGlzIGVuYWJsZWQgKi8NCiZn
dDsgJmd0OyAgdm9pZCB0cmFwX2luaXQodm9pZCkNCiZndDsgJmd0OyAgew0KJmd0OyAmZ3Q7ICsj
aWZuZGVmIENPTkZJR19NTVUNCiZndDsgJmd0OyArCS8qDQomZ3Q7ICZndDsgKwkgKiBTZXQgc3Vw
MCBzY3JhdGNoIHJlZ2lzdGVyIHRvIDAsIGluZGljYXRpbmcgdG8gZXhjZXB0aW9uIHZlY3Rvcg0K
Jmd0OyAmZ3Q7ICsJICogdGhhdCB3ZSBhcmUgcHJlc2VudGx5IGV4ZWN1dGluZyBpbiB0aGUga2Vy
bmVsDQomZ3Q7ICZndDsgKwkgKi8NCiZndDsgJmd0OyArCWNzcl93cml0ZShDU1JfU0NSQVRDSCwg
MCk7DQomZ3Q7ICZndDsgKwkvKiBTZXQgdGhlIGV4Y2VwdGlvbiB2ZWN0b3IgYWRkcmVzcyAqLw0K
Jmd0OyAmZ3Q7ICsJY3NyX3dyaXRlKENTUl9UVkVDLCAmYW1wO2hhbmRsZV9leGNlcHRpb24pOw0K
Jmd0OyAmZ3Q7ICsjZW5kaWYNCiZndDsgJmd0OyAgfQ0KJmd0OyAmZ3Q7IA0KJmd0OyANCiZndDsg
TG9va3MgT0sgdG8gbWUuIEJ1dCBvdXQgb2YgY3VyaW9zaXR5LCBob3cgZGlkIHlvdSB0cmlnZ2Vy
IGEgcHJvYmxlbSA/IEkgbmV2ZXINCiZndDsgZ290IGFueSB3ZWlyZCBleGNlcHRpb25zIHdpdGgg
bXkgYnVzeWJveCB1c2Vyc3BhY2UuDQomZ3Q7IA0KJmd0OyAtLSANCiZndDsgRGFtaWVuIExlIE1v
YWwNCiZndDsgV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQo8L3FpdXdlbmJvQHBoeXRpdW0uY29t
LmNuPjwvbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz48L3ZpbmNlbnQuY2hlbkBzaWZpdmUu
Y29tPjwvZ3JlZW50aW1lLmh1QHNpZml2ZS5jb20+PC96b25nLmxpQHNpZml2ZS5jb20+PC9ndW9y
ZW5AbGludXguYWxpYmFiYS5jb20+PC9hbnVwQGJyYWluZmF1bHQub3JnPjwvYXRpc2gucGF0cmFA
d2RjLmNvbT48L2FvdUBlZWNzLmJlcmtlbGV5LmVkdT48L2xpbnV4LXJpc2N2QGxpc3RzLmluZnJh
ZGVhZC5vcmc+PC9wYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+PC9wYWxtZXJAZGFiYmVsdC5jb20+
PC9xaXV3ZW5ib0BwaHl0aXVtLmNvbS5jbj48L2RhbWllbi5sZW1vYWxAd2RjLmNvbT4NCg0KDQoN
Cg0K
