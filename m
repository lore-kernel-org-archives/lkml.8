Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A04206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sEaKptpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHZAEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:04:23 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40399 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHZAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598400259; x=1629936259;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xD/0LWcndbDe9PvEGRwdzYMHIsrik8uf+2hBH55T1Ak=;
  b=sEaKptpQS/ECVg6HyO+ZLoVg2WpN441oby2ztSmw3v61fqWKNZM6kYTy
   EU0ciBQi51FIqsT45I44m0sVWSYDcPtBjHp1EEKFD2s9cH92cN0+26PVZ
   /kjNJRXX8eXUvd4PRUm/hxPAh5gGSRZY2W+kDuaLnt8B5YNoL1mNNuPPw
   0=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="50091494"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Aug 2020 00:04:14 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 87323A1D54;
        Wed, 26 Aug 2020 00:04:12 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 00:04:12 +0000
Received: from s3-prod-s3ws-c3-7217.iad7.amazon.com (10.43.162.40) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 00:04:05 +0000
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in
 ptregs
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>, <robketr@amazon.de>,
        <amos@scylladb.com>
References: <20200521200513.656533920@linutronix.de>
 <20200521202118.796915981@linutronix.de>
 <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com>
 <87a6yj58af.fsf@nanos.tec.linutronix.de>
 <051182cc-6c90-e48b-d191-8ca004385261@amazon.com>
 <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <b1fdf037-9c11-9f47-f285-e9a0843d648a@amazon.com>
Date:   Wed, 26 Aug 2020 02:04:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.40]
X-ClientProxiedBy: EX13D23UWC003.ant.amazon.com (10.43.162.81) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwKCk9uIDI2LjA4LjIwIDAxOjQxLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4gCj4g
T24gVHVlLCBBdWcgMjUsIDIwMjAgYXQgNDoxOCBQTSBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6
b24uY29tPiB3cm90ZToKPj4KPj4gSGkgVGhvbWFzLAo+Pgo+PiBPbiAyNS4wOC4yMCAxMjoyOCwg
VGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4gdm9pZCBpcnFfY29tcGxldGVfbW92ZShzdHJ1Y3Qg
aXJxX2NmZyAqY2ZnKQo+IHsKPiAgICAgICAgICBfX2lycV9jb21wbGV0ZV9tb3ZlKGNmZywgfmdl
dF9pcnFfcmVncygpLT5vcmlnX2F4KTsKPiB9Cj4gCj4+PiBBbGV4LAo+Pj4KPj4+IE9uIE1vbiwg
QXVnIDI0IDIwMjAgYXQgMTk6MjksIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+Pj4+IEknbSBjdXJy
ZW50bHkgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIHdpdGgK
Pj4+PiBTY3lsbGFEQiBvbiBpM2VuLjN4bGFyZ2UgKEtWTSBiYXNlZCBWTSBvbiBTa3lsYWtlKSB3
aGljaCB3ZSByZWxpYWJseQo+Pj4+IGJpc2VjdGVkIGRvd24gdG8gdGhpcyBjb21taXQ6Cj4+Pj4K
Pj4+PiAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zY3lsbGFkYi9zY3lsbGEvaXNzdWVzLzcwMzYK
Pj4+Pgo+Pj4+IFdoYXQgd2UncmUgc2VlaW5nIGlzIHRoYXQgc3lzY2FsbHMgc3VjaCBhcyBtZW1i
YXJyaWVyKCkgdGFrZSBmb3JldmVyCj4+Pj4gKDAtMTAgwrVzIHdvdWxkIGJlIG5vcm1hbCk6Cj4+
PiAuLi4KPj4+PiBUaGF0IGFnYWluIHNlZW1zIHRvIHN0ZW0gZnJvbSBhIHZhc3RseSBzbG93ZWQg
ZG93bgo+Pj4+IHNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCgpOgo+Pj4+Cj4+Pj4gU2FtcGxl
czogMjE4SyBvZiBldmVudCAnY3B1LWNsb2NrJywgNDAwMCBIego+Pj4+IE92ZXJoZWFkICBTaGFy
ZWQgT2JqZWN0ICAgICAgICBTeW1ib2wKPj4+PiAgICAgIDk0LjUxJSAgW2tlcm5lbF0gICAgICAg
ICAgICAgW2tdIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZAo+Pj4+ICAgICAgIDAuNzYlICBb
a2VybmVsXSAgICAgICAgICAgICBba10gX19kb19zb2Z0aXJxCj4+Pj4gICAgICAgMC4zMiUgIFtr
ZXJuZWxdICAgICAgICAgICAgIFtrXSBuYXRpdmVfcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aAo+
Pj4+IFsuLi5dCj4+Pj4KPj4+PiB3aGljaCBpcyBzdHVjayBpbgo+Pj4+Cj4+Pj4gICAgICAgICAg
IOKUgiAgICAgY3NkX2xvY2tfd2FpdCgpOgo+Pj4+ICAgICAgICAgICDilIIgICAgICAgICAgICAg
c21wX2NvbmRfbG9hZF9hY3F1aXJlKCZjc2QtPmZsYWdzLCAhKFZBTCAmCj4+Pj4gICAgICAwLjAw
IOKUgiAgICAgICBtb3YgICAgMHg4KCVyY3gpLCVlZHgKPj4+PiAgICAgIDAuMDAg4pSCICAgICAg
IGFuZCAgICAkMHgxLCVlZHgKPj4+PiAgICAgICAgICAg4pSCICAgICDihpMgamUgICAgIDJiOQo+
Pj4+ICAgICAgICAgICDilIIgICAgIHJlcF9ub3AoKToKPj4+PiAgICAgIDAuNzAg4pSCMmFmOiAg
IHBhdXNlCj4+Pj4gICAgICAgICAgIOKUgiAgICAgY3NkX2xvY2tfd2FpdCgpOgo+Pj4+ICAgICA5
Mi44MiDilIIgICAgICAgbW92ICAgIDB4OCglcmN4KSwlZWR4Cj4+Pj4gICAgICA2LjQ4IOKUgiAg
ICAgICBhbmQgICAgJDB4MSwlZWR4Cj4+Pj4gICAgICAwLjAwIOKUgiAgICAg4oaRIGpuZSAgICAy
YWYKPj4+PiAgICAgIDAuMDAg4pSCMmI5OiDihpEgam1wICAgIDI4Mgo+Pj4+Cj4+Pj4KPj4+PiBH
aXZlbiB0aGUgcGF0Y2ggYXQgaGFuZCBJIHdhcyBleHBlY3RpbmcgbG9zdCBJUElzLCBidXQgSSBj
YW4ndCBxdWl0ZSBzZWUKPj4+PiBhbnl0aGluZyBnZXR0aW5nIGxvc3QuCj4+Pgo+Pj4gSSBoYXZl
IG5vIGlkZWEgaG93IHRoYXQgcGF0Y2ggc2hvdWxkIGJlIHJlbGF0ZWQgdG8gSVBJIGFuZCBzbXAg
ZnVuY3Rpb24KPj4+IGNhbGxzLiBJdCdzIGNoYW5naW5nIHRoZSB3YXkgaG93IHJlZ3VsYXIgZGV2
aWNlIGludGVycnVwdHMgYW5kIHRoZWlyCj4+PiBzcHVyaW91cyBjb3VudGVycGFydCBhcmUgaGFu
ZGxlZCBhbmQgbm90IHRoZSB3YXkgaG93IElQSXMgYXJlCj4+PiBoYW5kbGVkLiBUaGV5IGFyZSBo
YW5kbGVkIGJ5IGRpcmVjdCB2ZWN0b3JzIGFuZCBkbyBub3QgZ28gdGhyb3VnaAo+Pj4gZG9fSVJR
KCkgYXQgYWxsLgo+Pj4KPj4+IEFzaWRlIG9mIHRoYXQgdGhlIGNvbW1pdCBqdXN0IGNoYW5nZXMg
dGhlIHdheSBob3cgdGhlIGludGVycnVwdCB2ZWN0b3IKPj4+IG9mIGEgcmVndWxhciBkZXZpY2Ug
aW50ZXJydXB0IGlzIHN0b3JlZCBhbmQgY29udmV5ZWQuIFRoZSBleHRyYSByZWFkIGFuZAo+Pj4g
d3JpdGUgb24gdGhlIGNhY2hlIGhvdCBzdGFjayBpcyBoYXJkbHkgcmVsYXRlZCB0byBhbnl0aGlu
ZyBJUEkuCj4+Cj4+IEkgYW0gYXMgcHV6emxlZCBhcyB5b3UgYXJlLCBidXQgdGhlIGJpc2VjdCBp
cyB2ZXJ5IGNsZWFyOiA3OWI5YzE4MzAyMWUKPj4gd29ya3MgZmFzdCBhbmQgNjMzMjYwZmExIChh
cyB3ZWxsIGFzIG1haW5saW5lKSBzaG93cyB0aGUgd2VpcmQgYmVoYXZpb3IKPj4gYWJvdmUuCj4+
Cj4+IEl0IGdldHMgZXZlbiBiZXR0ZXIuIFRoaXMgc21hbGwgKGRlbW9uc3RyYXRpdmUgb25seSwg
bWFuZ2xlZCkgcGF0Y2ggb24KPj4gdG9wIG9mIDYzMzI2MGZhMSBhbHNvIHJlc29sdmVzIHRoZSBw
ZXJmb3JtYW5jZSBpc3N1ZToKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9pcnEu
YyBiL2FyY2gveDg2L2tlcm5lbC9pcnEuYwo+PiBpbmRleCBjNzY2OTM2Li43ZTkxZTlhIDEwMDY0
NAo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvaXJxLmMKPj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2lycS5jCj4+IEBAIC0yMzksNiArMjM5LDcgQEAgX192aXNpYmxlIHZvaWQgX19pcnFfZW50cnkg
ZG9fSVJRKHN0cnVjdCBwdF9yZWdzCj4+ICpyZWdzLCB1bnNpZ25lZCBsb25nIHZlY3RvcikKPj4g
ICAgICAgICAgICogbG93ZXIgOCBiaXRzLgo+PiAgICAgICAgICAgKi8KPj4gICAgICAgICAgdmVj
dG9yICY9IDB4RkY7Cj4+ICsgICAgICAgcmVncy0+b3JpZ19heCA9IH52ZWN0b3I7Cj4+Cj4+ICAg
ICAgICAgIC8qIGVudGVyaW5nX2lycSgpIHRlbGxzIFJDVSB0aGF0IHdlJ3JlIG5vdCBxdWllc2Nl
bnQuICBDaGVjayBpdC4gKi8KPj4gICAgICAgICAgUkNVX0xPQ0tERVBfV0FSTighcmN1X2lzX3dh
dGNoaW5nKCksICJJUlEgZmFpbGVkIHRvIHdha2UgdXAgUkNVIik7Cj4+Cj4+Cj4+IFRvIG1lIHRo
YXQgc291bmRzIGxpa2Ugc29tZSBpcnEgZXhpdCBjb2RlIHNvbWV3aGVyZSBtdXN0IHN0aWxsIGJl
Cj4+IGxvb2tpbmcgYXQgb3JpZ19heCB0byBkZWNpZGUgb24gc29tZXRoaW5nIC0gYW5kIHRoYXQg
c29tZXRoaW5nIGlzIHdyb25nCj4+IG5vdyB0aGF0IHdlIHJlbW92ZWQgdGhlIG5lZ2F0aW9uIG9m
IHRoZSB2ZWN0b3IuIEl0IGFsc28gc2VlbXMgdG8gaGF2ZSBhbgo+PiBpbXBhY3Qgb24gcmVtb3Rl
IGZ1bmN0aW9uIGNhbGxzLgo+Pgo+PiBJJ2xsIGhhdmUgYSBkZWVwZXIgbG9vayB0b21vcnJvdyBh
Z2FpbiBpZiBJIGNhbiBmaW5kIGFueSBzdWNoIHBsYWNlLCBidXQKPj4gSSB3b3VsZG4ndCBtaW5k
IGlmIGFueW9uZSBjb3VsZCBwb2ludCBtZSBpbnRvIHRoZSByaWdodCBkaXJlY3Rpb24KPj4gZWFy
bGllciA6KS4KPiAKPiBIb3cgYWJvdXQgdGhpczoKPiAKPiB2b2lkIGlycV9jb21wbGV0ZV9tb3Zl
KHN0cnVjdCBpcnFfY2ZnICpjZmcpCj4gewo+ICAgICAgICAgIF9faXJxX2NvbXBsZXRlX21vdmUo
Y2ZnLCB+Z2V0X2lycV9yZWdzKCktPm9yaWdfYXgpOwo+IH0KPiAKPiBpbiBhcmNoL3g4Ni9rZXJu
ZWwvYXBpYy92ZWN0b3IuYy4KPiAKClRoYW5rcyBhIGxvdCwgSSBzdHVtYmxlZCBvdmVyIHRoZSBz
YW1lIHRoaW5nIGp1c3QgYWZ0ZXIgSSBzZW50IHRoZSBlbWFpbCAKYXMgd2VsbCBhbmQgaGFkIGJl
ZW4gdHJ5aW5nIHRvIHNlZSBpZiBJIGNhbiBxdWlja2x5IHBhdGNoIGl0IHVwIGJlZm9yZSBJIApm
YWxsIGFzbGVlcCA6KS4KClRoZSBjb2RlIHBhdGggYWJvdmUgaXMgdXNlZCBieSB0aGUgQVBJQyB2
ZWN0b3IgbW92ZSAoaXJxYmFsYW5jZSkgbG9naWMsIAp3aGljaCBleHBsYWlucyB3aHkgbm90IGV2
ZXJ5b25lIHdhcyBzZWVpbmcgaXNzdWVzLgoKU28gd2l0aCA2MzMyNjBmYTEgYXBwbGllZCwgd2Ug
bmV2ZXIgZ2V0IG91dCBvZiBtb3Zpbmcgc3RhdGUgZm9yIG91ciBJUlEgCmJlY2F1c2Ugb3JpZ19h
eCBpcyBhbHdheXMgLTEuIFRoYXQgbWVhbnMgd2Ugc2VuZCBhbiBJUEkgdG8gdGhlIGNsZWFudXAg
CnZlY3RvciBvbiBldmVyeSBzaW5nbGUgZGV2aWNlIGludGVycnVwdCwgY29tcGxldGVseSBvY2N1
cHlpbmcgdGhlIHBvb3IgCkNQVSB0aGF0IHdlIG1vdmVkIHRoZSBJUlEgZnJvbS4KCkkndmUgY29u
ZmlybWVkIHRoYXQgdGhlIHBhdGNoIGJlbG93IGZpeGVzIHRoZSBpc3N1ZSBhbmQgd2lsbCBzZW5k
IGEgCnByb3BlciwgbW9yZSBjb21wbGV0ZSBwYXRjaCBvbiB0b3Agb2YgbWFpbmxpbmUgd2l0aCBm
YW5jeSBkZXNjcmlwdGlvbiAKYW5kIHN0YWJsZSB0YWcgdG9tb3Jyb3cuCgoKQWxleAoKCgpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5
XzY0LlMKaW5kZXggZTc0MzRjZC4uYTQ3NGU2ZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUworKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TCkBAIC03MzQsNyArNzM0
LDYgQEAgU1lNX0NPREVfU1RBUlRfTE9DQUwoY29tbW9uX3NwdXJpb3VzKQogIAljYWxsCWludGVy
cnVwdF9lbnRyeQogIAlVTldJTkRfSElOVF9SRUdTIGluZGlyZWN0PTEKICAJbW92cQlPUklHX1JB
WCglcmRpKSwgJXJzaQkJLyogZ2V0IHZlY3RvciBmcm9tIHN0YWNrICovCi0JbW92cQkkLTEsIE9S
SUdfUkFYKCVyZGkpCQkvKiBubyBzeXNjYWxsIHRvIHJlc3RhcnQgKi8KICAJY2FsbAlzbXBfc3B1
cmlvdXNfaW50ZXJydXB0CQkvKiByZGkgcG9pbnRzIHRvIHB0X3JlZ3MgKi8KICAJam1wCXJldF9m
cm9tX2ludHIKICBTWU1fQ09ERV9FTkQoY29tbW9uX3NwdXJpb3VzKQpAQCAtNzQ2LDcgKzc0NSw2
IEBAIFNZTV9DT0RFX1NUQVJUX0xPQ0FMKGNvbW1vbl9pbnRlcnJ1cHQpCiAgCWNhbGwJaW50ZXJy
dXB0X2VudHJ5CiAgCVVOV0lORF9ISU5UX1JFR1MgaW5kaXJlY3Q9MQogIAltb3ZxCU9SSUdfUkFY
KCVyZGkpLCAlcnNpCQkvKiBnZXQgdmVjdG9yIGZyb20gc3RhY2sgKi8KLQltb3ZxCSQtMSwgT1JJ
R19SQVgoJXJkaSkJCS8qIG5vIHN5c2NhbGwgdG8gcmVzdGFydCAqLwogIAljYWxsCWRvX0lSUQkJ
CQkvKiByZGkgcG9pbnRzIHRvIHB0X3JlZ3MgKi8KICAJLyogMCglcnNwKTogb2xkIFJTUCAqLwog
IHJldF9mcm9tX2ludHI6CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy92ZWN0b3Iu
YyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jCmluZGV4IDY3NzY4ZTU0NDMuLjViNmY3
NGUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jCkBAIC05MzQsNyArOTM0LDcgQEAgc3RhdGljIHZvaWQg
X19pcnFfY29tcGxldGVfbW92ZShzdHJ1Y3QgaXJxX2NmZyAqY2ZnLCAKdW5zaWduZWQgdmVjdG9y
KQoKICB2b2lkIGlycV9jb21wbGV0ZV9tb3ZlKHN0cnVjdCBpcnFfY2ZnICpjZmcpCiAgewotCV9f
aXJxX2NvbXBsZXRlX21vdmUoY2ZnLCB+Z2V0X2lycV9yZWdzKCktPm9yaWdfYXgpOworCV9faXJx
X2NvbXBsZXRlX21vdmUoY2ZnLCBnZXRfaXJxX3JlZ3MoKS0+b3JpZ19heCk7CiAgfQoKICAvKgoK
CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAox
MDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25h
dGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRl
ciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

