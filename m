Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100FA206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gICO99E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHXRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:30:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37847 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgHXRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598290206; x=1629826206;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Kc02Ox8RiLoMndQ+/wq8VKCoeGmpKrhiNnSaTHgu8KE=;
  b=gICO99E2l0tEp/vEaIbDT2gy990zJkMGzDBwH8AOO3MGXo4S/rhUgbDI
   VPOzVMkxVgK98CPF9NnaEq1M12+A7IYr2EMKPaOJxF+wchjDPX0O3nNGR
   iR/x3TR+i9EZAzsiroYt/tIH5sPXmgOgHN5bYgARjWmka0HCH5+/p/NnT
   c=;
X-IronPort-AV: E=Sophos;i="5.76,349,1592870400"; 
   d="scan'208";a="69254893"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Aug 2020 17:29:53 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 1759EA1D83;
        Mon, 24 Aug 2020 17:29:44 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 24 Aug 2020 17:29:44 +0000
Received: from Alexanders-MacBook-Air.local (10.43.161.145) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 24 Aug 2020 17:29:25 +0000
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
From:   Alexander Graf <graf@amazon.com>
Message-ID: <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com>
Date:   Mon, 24 Aug 2020 19:29:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200521202118.796915981@linutronix.de>
Content-Language: en-US
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLAoKT24gMjEuMDUuMjAgMjI6MDUsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBG
cm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiAKPiBEZXZpY2UgaW50
ZXJydXB0cyB3aGljaCBnbyB0aHJvdWdoIGRvX0lSUSgpIG9yIHRoZSBzcHVyaW91cyBpbnRlcnJ1
cHQKPiBoYW5kbGVyIGhhdmUgdGhlaXIgc2VwYXJhdGUgZW50cnkgY29kZSBvbiA2NCBiaXQgZm9y
IG5vIGdvb2QgcmVhc29uLgo+IAo+IEJvdGggMzIgYW5kIDY0IGJpdCB0cmFuc3BvcnQgdGhlIHZl
Y3RvciBudW1iZXIgdGhyb3VnaCBPUklHX1tSRV1BWCBpbgo+IHB0X3JlZ3MuIEZ1cnRoZXIgdGhl
IHZlY3RvciBudW1iZXIgaXMgZm9yY2VkIHRvIGZpdCBpbnRvIGFuIHU4IGFuZCBpcwo+IGNvbXBs
ZW1lbnRlZCBhbmQgb2Zmc2V0IGJ5IDB4ODAgc28gaXQncyBpbiB0aGUgc2lnbmVkIGNoYXJhY3Rl
cgo+IHJhbmdlLiBPdGhlcndpc2UgR0FTIHdvdWxkIGV4cGFuZCB0aGUgcHVzaHEgdG8gYSA1IGJ5
dGUgaW5zdHJ1Y3Rpb24gZm9yIGFueQo+IHZlY3RvciA+IDB4N0YuCj4gCj4gVHJlYXQgdGhlIHZl
Y3RvciBudW1iZXIgbGlrZSBhbiBlcnJvciBjb2RlIGFuZCBoYW5kIGl0IHRvIHRoZSBDIGZ1bmN0
aW9uIGFzCj4gYXJndW1lbnQuIFRoaXMgYWxsb3dzIHRvIGdldCByaWQgb2YgdGhlIGV4dHJhIGVu
dHJ5IGNvZGUgaW4gYSBsYXRlciBzdGVwLgo+IAo+IFNpbXBsaWZ5IHRoZSBlcnJvciBjb2RlIHB1
c2ggbWFnaWMgYnkgaW1wbGVtZW50aW5nIHRoZSBwdXNocSBpbW04IHZpYSBhCj4gJy5ieXRlIDB4
NmEsIHZlY3Rvcicgc2VxdWVuY2Ugc28gR0FTIGlzIG5vdCBhYmxlIHRvIHNjcmV3IGl0IHVwLiBB
cyB0aGUKPiBwdXNocSBpbW04IGlzIHNpZ24gZXh0ZW5kaW5nIHRoZSByZXN1bHRpbmcgZXJyb3Ig
Y29kZSBuZWVkcyB0byBiZSB0cnVuY2F0ZWQKPiB0byA4IGJpdHMgaW4gQyBjb2RlLgo+IAo+IE9y
aWdpbmFsbHktYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPgo+IFNpZ25lZC1v
ZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IEFja2VkLWJ5OiBB
bmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4KCkknbSBjdXJyZW50bHkgdHJ5aW5nIHRv
IHVuZGVyc3RhbmQgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIHdpdGggClNjeWxsYURCIG9uIGkz
ZW4uM3hsYXJnZSAoS1ZNIGJhc2VkIFZNIG9uIFNreWxha2UpIHdoaWNoIHdlIHJlbGlhYmx5IApi
aXNlY3RlZCBkb3duIHRvIHRoaXMgY29tbWl0OgoKICAgaHR0cHM6Ly9naXRodWIuY29tL3NjeWxs
YWRiL3NjeWxsYS9pc3N1ZXMvNzAzNgoKV2hhdCB3ZSdyZSBzZWVpbmcgaXMgdGhhdCBzeXNjYWxs
cyBzdWNoIGFzIG1lbWJhcnJpZXIoKSB0YWtlIGZvcmV2ZXIgCigwLTEwIMK1cyB3b3VsZCBiZSBu
b3JtYWwpOgoKJSB0aW1lICAgICBzZWNvbmRzICB1c2Vjcy9jYWxsICAgICBjYWxscyAgICBlcnJv
cnMgc3lzY2FsbAotLS0tLS0gLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0gLS0tLS0tLS0tIC0tLS0t
LS0tLSAtLS0tLS0tLS0tLS0tLS0tCiAgNTMuMjYgICAxMi40NTg4ODEgICAgICAxODU5NTMgICAg
ICAgIDY3ICAgICAgICAgICBtZW1iYXJyaWVyCiAgMTUuNzkgICAgMy42OTM2NTEgICAgICAgMTc4
NDMgICAgICAgMjA3ICAgICAgICA0OSByZWFkCiAgMTEuMTcgICAgMi42MTMzNTAgICAgICAgNjcw
MDggICAgICAgIDM5ICAgICAgICAgICBpb19wZ2V0ZXZlbnRzCiAgMTAuODkgICAgMi41NDc3NzIg
ICAgICAgMTE3OTUgICAgICAgMjE2ICAgICAgICAgICB0aW1lcmZkX3NldHRpbWUKICAgNi45MSAg
ICAxLjYxNjgwMiAgICAgICAxMTA3MyAgICAgICAxNDYgICAgICAgICAgIHJ0X3NpZ3Byb2NtYXNr
CiAgIDEuMzkgICAgMC4zMjU5NTUgICAgICAgIDM1NDIgICAgICAgIDkyICAgICAgICAgICB0aW1l
cl9zZXR0aW1lCiAgIDAuMzYgICAgMC4wODM2OTEgICAgICAgICA1MjYgICAgICAgMTU5ICAgICAg
ICAgICBpb19zdWJtaXQKICAgMC4yMiAgICAwLjA1MTM5OSAgICAgICAgIDUzNSAgICAgICAgOTYg
ICAgICAgICAgIHdyaXRlCiAgIDAuMDAgICAgMC4wMDA3ODMgICAgICAgICAgMzcgICAgICAgIDIx
ICAgICAgICAgICBzZW5kbXNnCiAgIDAuMDAgICAgMC4wMDAwNTcgICAgICAgICAgIDMgICAgICAg
IDE4ICAgICAgICAgOSBpb2N0bAotLS0tLS0gLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0gLS0tLS0t
LS0tIC0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tCjEwMC4wMCAgIDIzLjM5MjM0MSAgICAgICAg
ICAgICAgICAgIDEwNjEgICAgICAgIDU4IHRvdGFsCgpUaGF0IGFnYWluIHNlZW1zIHRvIHN0ZW0g
ZnJvbSBhIHZhc3RseSBzbG93ZWQgZG93biAKc21wX2NhbGxfZnVuY3Rpb25fbWFueV9jb25kKCk6
CgpTYW1wbGVzOiAyMThLIG9mIGV2ZW50ICdjcHUtY2xvY2snLCA0MDAwIEh6Ck92ZXJoZWFkICBT
aGFyZWQgT2JqZWN0ICAgICAgICBTeW1ib2wKICAgOTQuNTElICBba2VybmVsXSAgICAgICAgICAg
ICBba10gc21wX2NhbGxfZnVuY3Rpb25fbWFueV9jb25kCiAgICAwLjc2JSAgW2tlcm5lbF0gICAg
ICAgICAgICAgW2tdIF9fZG9fc29mdGlycQogICAgMC4zMiUgIFtrZXJuZWxdICAgICAgICAgICAg
IFtrXSBuYXRpdmVfcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aApbLi4uXQoKd2hpY2ggaXMgc3R1
Y2sgaW4KCiAgICAgICAg4pSCICAgICBjc2RfbG9ja193YWl0KCk6CiAgICAgICAg4pSCICAgICAg
ICAgICAgIHNtcF9jb25kX2xvYWRfYWNxdWlyZSgmY3NkLT5mbGFncywgIShWQUwgJgogICAwLjAw
IOKUgiAgICAgICBtb3YgICAgMHg4KCVyY3gpLCVlZHgKICAgMC4wMCDilIIgICAgICAgYW5kICAg
ICQweDEsJWVkeAogICAgICAgIOKUgiAgICAg4oaTIGplICAgICAyYjkKICAgICAgICDilIIgICAg
IHJlcF9ub3AoKToKICAgMC43MCDilIIyYWY6ICAgcGF1c2UKICAgICAgICDilIIgICAgIGNzZF9s
b2NrX3dhaXQoKToKICA5Mi44MiDilIIgICAgICAgbW92ICAgIDB4OCglcmN4KSwlZWR4CiAgIDYu
NDgg4pSCICAgICAgIGFuZCAgICAkMHgxLCVlZHgKICAgMC4wMCDilIIgICAgIOKGkSBqbmUgICAg
MmFmCiAgIDAuMDAg4pSCMmI5OiDihpEgam1wICAgIDI4MgoKCkdpdmVuIHRoZSBwYXRjaCBhdCBo
YW5kIEkgd2FzIGV4cGVjdGluZyBsb3N0IElQSXMsIGJ1dCBJIGNhbid0IHF1aXRlIHNlZSAKYW55
dGhpbmcgZ2V0dGluZyBsb3N0LgoKRG8geW91IGhhdmUgYW55IGZ1cnRoZXIgcG9pbnRlcnMgSSBj
b3VsZCBsb29rIGF0PwoKClRoYW5rcywKCkFsZXgKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVo
cnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0g
QW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxp
bgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

