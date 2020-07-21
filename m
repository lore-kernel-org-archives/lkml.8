Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA78C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2232072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pku.edu.cn header.i=@pku.edu.cn header.b="S4O/T6C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGUCQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:16:23 -0400
Received: from mx23.pku.edu.cn ([162.105.129.186]:28331 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgGUCQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:16:23 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 22:16:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=kjHGhkAaPVaO9/R6h0HpLCVZ3QUbVo7f1+7O
        Y+J6I4w=; b=S4O/T6C0MCPSOY3QxJDfNcN2uJGr0uENrEL6j6qli9+mZtHgyytx
        UHljqoP/aNzQDgbpIjaF6EeiucTwZp6wAcNj6nRkRz1sD2F9g4SxbPex5pGFERAK
        XvxIhv99ViF7H1l7Dk0ZJKiyexywnQwSDwuNembnyIDit8sVUka7dA0=
Received: by ajax-webmail-mailfront01 (Coremail) ; Tue, 21 Jul 2020 10:09:20
 +0800 (GMT+08:00)
X-Originating-IP: [10.1.22.182]
Date:   Tue, 21 Jul 2020 10:09:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Guan Xuetao" <gxt@pku.edu.cn>
To:     "christoph hellwig" <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicore32: use get_kernel_nofault in dump mem and
 dump_instr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn  pku.edu.cn
In-Reply-To: <20200720114358.201161-1-hch@lst.de>
References: <20200720114358.201161-1-hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1fdc8e7c.4dfcd.1736f21e98b.Coremail.gxt@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: x4FpogBXpGZQThZfQaiwAQ--.15780W
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/1tbiAQIEBysxYB327gABs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmVyeSBnb29kIHRvIHJlbW92ZSBkcy9mcyBpbiB1bmljb3JlIGFyY2guCkNvdWxkIHUgc2VuZCBt
ZSBmdWxsIHBhdGNoIGZvciB0ZXN0PwoKR3VhbiBYdWV0YW8KCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2
LS0tLS0KPiDlj5Hku7bkuro6ICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBsc3QuZGU+Cj4g5Y+R
6YCB5pe26Ze0OiAyMDIwLTA3LTIwIDE5OjQzOjU4ICjmmJ/mnJ/kuIApCj4g5pS25Lu25Lq6OiBn
eHRAcGt1LmVkdS5jbgo+IOaKhOmAgTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IOS4
u+mimDogW1BBVENIXSB1bmljb3JlMzI6IHVzZSBnZXRfa2VybmVsX25vZmF1bHQgaW4gZHVtcCBt
ZW0gYW5kIGR1bXBfaW5zdHIKPiAKPiBVc2UgdGhlIHByb3BlciBnZXRfa2VybmVsX25vZmF1bHQg
aGVscGVyIHRvIGFjY2VzcyBhbiB1bnNhZmUga2VybmVsCj4gcG9pbnRlciB3aXRob3V0IGZhdWx0
aW5nIGluc3RlYWQgb2YgcGxheWluZyB3aXRoIHNldF9mcyBhbmQgZ2V0X3VzZXIuCj4gCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gIGFyY2gv
dW5pY29yZTMyL2tlcm5lbC90cmFwcy5jIHwgMjggKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvYXJjaC91bmljb3JlMzIva2VybmVsL3RyYXBzLmMgYi9hcmNoL3VuaWNv
cmUzMi9rZXJuZWwvdHJhcHMuYwo+IGluZGV4IGEzYWMwMWRmMWEyZTQzLi5jMTk2NGE0YTFlZGJi
MCAxMDA2NDQKPiAtLS0gYS9hcmNoL3VuaWNvcmUzMi9rZXJuZWwvdHJhcHMuYwo+ICsrKyBiL2Fy
Y2gvdW5pY29yZTMyL2tlcm5lbC90cmFwcy5jCj4gQEAgLTY1LDE3ICs2NSw4IEBAIHN0YXRpYyB2
b2lkIGR1bXBfbWVtKGNvbnN0IGNoYXIgKmx2bCwgY29uc3QgY2hhciAqc3RyLCB1bnNpZ25lZCBs
b25nIGJvdHRvbSwKPiAgCQkgICAgIHVuc2lnbmVkIGxvbmcgdG9wKQo+ICB7Cj4gIAl1bnNpZ25l
ZCBsb25nIGZpcnN0Owo+IC0JbW1fc2VnbWVudF90IGZzOwo+ICAJaW50IGk7Cj4gIAo+IC0JLyoK
PiAtCSAqIFdlIG5lZWQgdG8gc3dpdGNoIHRvIGtlcm5lbCBtb2RlIHNvIHRoYXQgd2UgY2FuIHVz
ZSBfX2dldF91c2VyCj4gLQkgKiB0byBzYWZlbHkgcmVhZCBmcm9tIGtlcm5lbCBzcGFjZS4gIE5v
dGUgdGhhdCB3ZSBub3cgZHVtcCB0aGUKPiAtCSAqIGNvZGUgZmlyc3QsIGp1c3QgaW4gY2FzZSB0
aGUgYmFja3RyYWNlIGtpbGxzIHVzLgo+IC0JICovCj4gLQlmcyA9IGdldF9mcygpOwo+IC0Jc2V0
X2ZzKEtFUk5FTF9EUyk7Cj4gLQo+ICAJcHJpbnRrKEtFUk5fREVGQVVMVCAiJXMlcygweCUwOGx4
IHRvIDB4JTA4bHgpXG4iLAo+ICAJCQlsdmwsIHN0ciwgYm90dG9tLCB0b3ApOwo+ICAKPiBAQCAt
ODksNyArODAsOCBAQCBzdGF0aWMgdm9pZCBkdW1wX21lbShjb25zdCBjaGFyICpsdmwsIGNvbnN0
IGNoYXIgKnN0ciwgdW5zaWduZWQgbG9uZyBib3R0b20sCj4gIAkJZm9yIChwID0gZmlyc3QsIGkg
PSAwOyBpIDwgOCAmJiBwIDwgdG9wOyBpKyssIHAgKz0gNCkgewo+ICAJCQlpZiAocCA+PSBib3R0
b20gJiYgcCA8IHRvcCkgewo+ICAJCQkJdW5zaWduZWQgbG9uZyB2YWw7Cj4gLQkJCQlpZiAoX19n
ZXRfdXNlcih2YWwsICh1bnNpZ25lZCBsb25nICopcCkgPT0gMCkKPiArCQkJCWlmIChnZXRfa2Vy
bmVsX25vZmF1bHQodmFsLCAodW5zaWduZWQgbG9uZyAqKXApCj4gKwkJCQkJCT09IDApCj4gIAkJ
CQkJc3ByaW50ZihzdHIgKyBpICogOSwgIiAlMDhseCIsIHZhbCk7Cj4gIAkJCQllbHNlCj4gIAkJ
CQkJc3ByaW50ZihzdHIgKyBpICogOSwgIiA/Pz8/Pz8/PyIpOwo+IEBAIC05NywzMSArODksMTkg
QEAgc3RhdGljIHZvaWQgZHVtcF9tZW0oY29uc3QgY2hhciAqbHZsLCBjb25zdCBjaGFyICpzdHIs
IHVuc2lnbmVkIGxvbmcgYm90dG9tLAo+ICAJCX0KPiAgCQlwcmludGsoS0VSTl9ERUZBVUxUICIl
cyUwNGx4OiVzXG4iLCBsdmwsIGZpcnN0ICYgMHhmZmZmLCBzdHIpOwo+ICAJfQo+IC0KPiAtCXNl
dF9mcyhmcyk7Cj4gIH0KPiAgCj4gIHN0YXRpYyB2b2lkIGR1bXBfaW5zdHIoY29uc3QgY2hhciAq
bHZsLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKPiAgewo+ICAJdW5zaWduZWQgbG9uZyBhZGRyID0g
aW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKTsKPiAgCWNvbnN0IGludCB3aWR0aCA9IDg7Cj4gLQlt
bV9zZWdtZW50X3QgZnM7Cj4gIAljaGFyIHN0cltzaXplb2YoIjAwMDAwMDAwICIpICogNSArIDIg
KyAxXSwgKnAgPSBzdHI7Cj4gIAlpbnQgaTsKPiAgCj4gLQkvKgo+IC0JICogV2UgbmVlZCB0byBz
d2l0Y2ggdG8ga2VybmVsIG1vZGUgc28gdGhhdCB3ZSBjYW4gdXNlIF9fZ2V0X3VzZXIKPiAtCSAq
IHRvIHNhZmVseSByZWFkIGZyb20ga2VybmVsIHNwYWNlLiAgTm90ZSB0aGF0IHdlIG5vdyBkdW1w
IHRoZQo+IC0JICogY29kZSBmaXJzdCwganVzdCBpbiBjYXNlIHRoZSBiYWNrdHJhY2Uga2lsbHMg
dXMuCj4gLQkgKi8KPiAtCWZzID0gZ2V0X2ZzKCk7Cj4gLQlzZXRfZnMoS0VSTkVMX0RTKTsKPiAt
Cj4gIAlmb3IgKGkgPSAtNDsgaSA8IDE7IGkrKykgewo+ICAJCXVuc2lnbmVkIGludCB2YWwsIGJh
ZDsKPiAgCj4gLQkJYmFkID0gX19nZXRfdXNlcih2YWwsICYoKHUzMiAqKWFkZHIpW2ldKTsKPiAt
Cj4gKwkJYmFkID0gZ2V0X2tlcm5lbF9ub2ZhdWx0KHZhbCwgJigodTMyICopYWRkcilbaV0pOwo+
ICAJCWlmICghYmFkKQo+ICAJCQlwICs9IHNwcmludGYocCwgaSA9PSAwID8gIiglMCp4KSAiIDog
IiUwKnggIiwKPiAgCQkJCQl3aWR0aCwgdmFsKTsKPiBAQCAtMTMxLDggKzExMSw2IEBAIHN0YXRp
YyB2b2lkIGR1bXBfaW5zdHIoY29uc3QgY2hhciAqbHZsLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykK
PiAgCQl9Cj4gIAl9Cj4gIAlwcmludGsoS0VSTl9ERUZBVUxUICIlc0NvZGU6ICVzXG4iLCBsdmws
IHN0cik7Cj4gLQo+IC0Jc2V0X2ZzKGZzKTsKPiAgfQo+ICAKPiAgc3RhdGljIHZvaWQgZHVtcF9i
YWNrdHJhY2Uoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLAo+
IC0tIAo+IDIuMjcuMAo=
