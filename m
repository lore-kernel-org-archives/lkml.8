Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249B12075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XGnzWoNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHYXSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:18:07 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:6726 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHYXSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598397481; x=1629933481;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OZtUg8bkcWalZh9AnNqlOzfHczxvpTVUs+LUb8aFXXg=;
  b=XGnzWoNI8BFAh/jbrn5Z06/iiHYPaSeEw0A22NvvRLUBLl+2ctUDMP/Y
   iFfEX8zi3gDaW+x8H56A4lFfBpG3V5tf4IvNeyCfpbEQMIJkwYu0mm1LF
   TswD1djyF+X89SISs6zKSumipLkR+NN1rMsaTf0uhu3MTgLsVLhThmCyC
   o=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="49993520"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Aug 2020 23:17:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 99BBDA238E;
        Tue, 25 Aug 2020 23:17:50 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 23:17:48 +0000
Received: from s3-prod-s3ws-c3-7217.iad7.amazon.com (10.43.162.40) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 23:17:41 +0000
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in
 ptregs
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Andy Lutomirski <luto@kernel.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <avi@scylladb.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
        <robketr@amazon.de>, <amos@scylladb.com>
References: <20200521200513.656533920@linutronix.de>
 <20200521202118.796915981@linutronix.de>
 <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com>
 <87a6yj58af.fsf@nanos.tec.linutronix.de>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <051182cc-6c90-e48b-d191-8ca004385261@amazon.com>
Date:   Wed, 26 Aug 2020 01:17:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <87a6yj58af.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
X-Originating-IP: [10.43.162.40]
X-ClientProxiedBy: EX13D06UWA004.ant.amazon.com (10.43.160.164) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLAoKT24gMjUuMDguMjAgMTI6MjgsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiAK
PiBBbGV4LAo+IAo+IE9uIE1vbiwgQXVnIDI0IDIwMjAgYXQgMTk6MjksIEFsZXhhbmRlciBHcmFm
IHdyb3RlOgo+PiBJJ20gY3VycmVudGx5IHRyeWluZyB0byB1bmRlcnN0YW5kIGEgcGVyZm9ybWFu
Y2UgcmVncmVzc2lvbiB3aXRoCj4+IFNjeWxsYURCIG9uIGkzZW4uM3hsYXJnZSAoS1ZNIGJhc2Vk
IFZNIG9uIFNreWxha2UpIHdoaWNoIHdlIHJlbGlhYmx5Cj4+IGJpc2VjdGVkIGRvd24gdG8gdGhp
cyBjb21taXQ6Cj4+Cj4+ICAgICBodHRwczovL2dpdGh1Yi5jb20vc2N5bGxhZGIvc2N5bGxhL2lz
c3Vlcy83MDM2Cj4+Cj4+IFdoYXQgd2UncmUgc2VlaW5nIGlzIHRoYXQgc3lzY2FsbHMgc3VjaCBh
cyBtZW1iYXJyaWVyKCkgdGFrZSBmb3JldmVyCj4+ICgwLTEwIMK1cyB3b3VsZCBiZSBub3JtYWwp
Ogo+IC4uLgo+PiBUaGF0IGFnYWluIHNlZW1zIHRvIHN0ZW0gZnJvbSBhIHZhc3RseSBzbG93ZWQg
ZG93bgo+PiBzbXBfY2FsbF9mdW5jdGlvbl9tYW55X2NvbmQoKToKPj4KPj4gU2FtcGxlczogMjE4
SyBvZiBldmVudCAnY3B1LWNsb2NrJywgNDAwMCBIego+PiBPdmVyaGVhZCAgU2hhcmVkIE9iamVj
dCAgICAgICAgU3ltYm9sCj4+ICAgICA5NC41MSUgIFtrZXJuZWxdICAgICAgICAgICAgIFtrXSBz
bXBfY2FsbF9mdW5jdGlvbl9tYW55X2NvbmQKPj4gICAgICAwLjc2JSAgW2tlcm5lbF0gICAgICAg
ICAgICAgW2tdIF9fZG9fc29mdGlycQo+PiAgICAgIDAuMzIlICBba2VybmVsXSAgICAgICAgICAg
ICBba10gbmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgKPj4gWy4uLl0KPj4KPj4gd2hp
Y2ggaXMgc3R1Y2sgaW4KPj4KPj4gICAgICAgICAg4pSCICAgICBjc2RfbG9ja193YWl0KCk6Cj4+
ICAgICAgICAgIOKUgiAgICAgICAgICAgICBzbXBfY29uZF9sb2FkX2FjcXVpcmUoJmNzZC0+Zmxh
Z3MsICEoVkFMICYKPj4gICAgIDAuMDAg4pSCICAgICAgIG1vdiAgICAweDgoJXJjeCksJWVkeAo+
PiAgICAgMC4wMCDilIIgICAgICAgYW5kICAgICQweDEsJWVkeAo+PiAgICAgICAgICDilIIgICAg
IOKGkyBqZSAgICAgMmI5Cj4+ICAgICAgICAgIOKUgiAgICAgcmVwX25vcCgpOgo+PiAgICAgMC43
MCDilIIyYWY6ICAgcGF1c2UKPj4gICAgICAgICAg4pSCICAgICBjc2RfbG9ja193YWl0KCk6Cj4+
ICAgIDkyLjgyIOKUgiAgICAgICBtb3YgICAgMHg4KCVyY3gpLCVlZHgKPj4gICAgIDYuNDgg4pSC
ICAgICAgIGFuZCAgICAkMHgxLCVlZHgKPj4gICAgIDAuMDAg4pSCICAgICDihpEgam5lICAgIDJh
Zgo+PiAgICAgMC4wMCDilIIyYjk6IOKGkSBqbXAgICAgMjgyCj4+Cj4+Cj4+IEdpdmVuIHRoZSBw
YXRjaCBhdCBoYW5kIEkgd2FzIGV4cGVjdGluZyBsb3N0IElQSXMsIGJ1dCBJIGNhbid0IHF1aXRl
IHNlZQo+PiBhbnl0aGluZyBnZXR0aW5nIGxvc3QuCj4gCj4gSSBoYXZlIG5vIGlkZWEgaG93IHRo
YXQgcGF0Y2ggc2hvdWxkIGJlIHJlbGF0ZWQgdG8gSVBJIGFuZCBzbXAgZnVuY3Rpb24KPiBjYWxs
cy4gSXQncyBjaGFuZ2luZyB0aGUgd2F5IGhvdyByZWd1bGFyIGRldmljZSBpbnRlcnJ1cHRzIGFu
ZCB0aGVpcgo+IHNwdXJpb3VzIGNvdW50ZXJwYXJ0IGFyZSBoYW5kbGVkIGFuZCBub3QgdGhlIHdh
eSBob3cgSVBJcyBhcmUKPiBoYW5kbGVkLiBUaGV5IGFyZSBoYW5kbGVkIGJ5IGRpcmVjdCB2ZWN0
b3JzIGFuZCBkbyBub3QgZ28gdGhyb3VnaAo+IGRvX0lSUSgpIGF0IGFsbC4KPiAKPiBBc2lkZSBv
ZiB0aGF0IHRoZSBjb21taXQganVzdCBjaGFuZ2VzIHRoZSB3YXkgaG93IHRoZSBpbnRlcnJ1cHQg
dmVjdG9yCj4gb2YgYSByZWd1bGFyIGRldmljZSBpbnRlcnJ1cHQgaXMgc3RvcmVkIGFuZCBjb252
ZXllZC4gVGhlIGV4dHJhIHJlYWQgYW5kCj4gd3JpdGUgb24gdGhlIGNhY2hlIGhvdCBzdGFjayBp
cyBoYXJkbHkgcmVsYXRlZCB0byBhbnl0aGluZyBJUEkuCgpJIGFtIGFzIHB1enpsZWQgYXMgeW91
IGFyZSwgYnV0IHRoZSBiaXNlY3QgaXMgdmVyeSBjbGVhcjogNzliOWMxODMwMjFlIAp3b3JrcyBm
YXN0IGFuZCA2MzMyNjBmYTEgKGFzIHdlbGwgYXMgbWFpbmxpbmUpIHNob3dzIHRoZSB3ZWlyZCBi
ZWhhdmlvciAKYWJvdmUuCgpJdCBnZXRzIGV2ZW4gYmV0dGVyLiBUaGlzIHNtYWxsIChkZW1vbnN0
cmF0aXZlIG9ubHksIG1hbmdsZWQpIHBhdGNoIG9uIAp0b3Agb2YgNjMzMjYwZmExIGFsc28gcmVz
b2x2ZXMgdGhlIHBlcmZvcm1hbmNlIGlzc3VlOgoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9pcnEuYyBiL2FyY2gveDg2L2tlcm5lbC9pcnEuYwppbmRleCBjNzY2OTM2Li43ZTkxZTlhIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvaXJxLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2ly
cS5jCkBAIC0yMzksNiArMjM5LDcgQEAgX192aXNpYmxlIHZvaWQgX19pcnFfZW50cnkgZG9fSVJR
KHN0cnVjdCBwdF9yZWdzIAoqcmVncywgdW5zaWduZWQgbG9uZyB2ZWN0b3IpCiAgCSAqIGxvd2Vy
IDggYml0cy4KICAJICovCiAgCXZlY3RvciAmPSAweEZGOworCXJlZ3MtPm9yaWdfYXggPSB+dmVj
dG9yOwoKICAJLyogZW50ZXJpbmdfaXJxKCkgdGVsbHMgUkNVIHRoYXQgd2UncmUgbm90IHF1aWVz
Y2VudC4gIENoZWNrIGl0LiAqLwogIAlSQ1VfTE9DS0RFUF9XQVJOKCFyY3VfaXNfd2F0Y2hpbmco
KSwgIklSUSBmYWlsZWQgdG8gd2FrZSB1cCBSQ1UiKTsKCgpUbyBtZSB0aGF0IHNvdW5kcyBsaWtl
IHNvbWUgaXJxIGV4aXQgY29kZSBzb21ld2hlcmUgbXVzdCBzdGlsbCBiZSAKbG9va2luZyBhdCBv
cmlnX2F4IHRvIGRlY2lkZSBvbiBzb21ldGhpbmcgLSBhbmQgdGhhdCBzb21ldGhpbmcgaXMgd3Jv
bmcgCm5vdyB0aGF0IHdlIHJlbW92ZWQgdGhlIG5lZ2F0aW9uIG9mIHRoZSB2ZWN0b3IuIEl0IGFs
c28gc2VlbXMgdG8gaGF2ZSBhbiAKaW1wYWN0IG9uIHJlbW90ZSBmdW5jdGlvbiBjYWxscy4KCkkn
bGwgaGF2ZSBhIGRlZXBlciBsb29rIHRvbW9ycm93IGFnYWluIGlmIEkgY2FuIGZpbmQgYW55IHN1
Y2ggcGxhY2UsIGJ1dCAKSSB3b3VsZG4ndCBtaW5kIGlmIGFueW9uZSBjb3VsZCBwb2ludCBtZSBp
bnRvIHRoZSByaWdodCBkaXJlY3Rpb24gCmVhcmxpZXIgOikuCgoKQWxleAoKCgpBbWF6b24gRGV2
ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4K
R2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTcz
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

