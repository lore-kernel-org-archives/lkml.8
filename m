Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6F20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OM+IOqbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGXPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:15:10 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:1524 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586301310;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kqfqt8fleUUonNH2T7+V1D0+RdS+r1sUzRmj6ggzkjQ=;
  b=OM+IOqbVhyFqbku6oURXKhYN1yJ8DhcI86G4BpT3DFvM/Mpe9Fc6ifAV
   D+jTuZ5mg2evsl+XW/FDRBZowLUeavgvoIrxEE6CY70xbLDC5ch08HGVx
   S0lVefDq8i1+mID/eVnPc0RzsYy1VTvamDEXTUGpgwOFjiFq/9Bm9ii5u
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: vuiBD1ORzZfMMH0MT7F67HfRCExRbmhQw3S5duBfVZCrmR8bT3W0GMLSYMl1+vcK0D62ykIXm/
 QjIZZYciW+Emc9VgPlIL302AyXDHHrK5dqI61gxpLpfZakPSnGl8FEq0EfSM3GiTsn+ePduchs
 +9ZejmLYVQICqX9J0ueCpmkEgdYAwQHDtI9gCfcZ4NZy8bDI77D0PxezUrJiT6IRvZC7EQR+6H
 mNxucqiT1wwCKkgqbovY5KM9GQ6q4aNS+Q40R1QobJz+Es2NENDuo7tZCUgeNtd+rgZIdmQyn9
 L1g=
X-SBRS: 2.7
X-MesageID: 15320098
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,356,1580792400"; 
   d="scan'208";a="15320098"
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, <hpa@zytor.com>,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <jannh@google.com>, <keescook@chromium.org>,
        <David.Laight@aculab.com>, Doug Covelli <dcovelli@vmware.com>,
        <mhiramat@kernel.org>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <04f4fc03-95cd-df2e-e93d-e9c4fa221ae4@citrix.com>
Date:   Wed, 8 Apr 2020 00:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 22:22, Nadav Amit wrote:
>> On Apr 7, 2020, at 1:50 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Apr 07, 2020 at 01:27:45PM -0700, Nadav Amit wrote:
>>>> On Apr 7, 2020, at 12:38 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Tue, Apr 07, 2020 at 11:55:21AM -0700, Nadav Amit wrote:
>>>>>> On Apr 7, 2020, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>>>
>>>>>> Since we now have infrastructure to analyze module text, disallow
>>>>>> modules that write to CRn and DRn registers.
>>>>> Assuming the kernel is built without CONFIG_PARAVIRT, what is the right way
>>>>> for out-of-tree modules to write to CRs? Let’s say CR2?
>>>> Most of them there is no real justification for ever writing to. CR2 I
>>>> suppose we can have an exception for given a sane rationale for why
>>>> you'd need to rewrite the fault address.
>>> For the same reason that KVM writes to CR2 - to restore CR2 before entering
>>> a guest, since CR2 not architecturally loaded from the VMCS. I suspect there
>>> are additional use-cases which are not covered by the kernel interfaces.
>> So I'm not much of a virt guy (clearly), and *groan*, that's horrible.
>> I'll go make an exception for CR2.
> Clearly you are not a virt guy if you think that this is the horrible part
> in x86 virtualization ;-)

Very definitely seconded :)

> Anyhow, I do not think it is the only use-case which is not covered by your
> patches (even considering CRs/DRs alone). For example, there is no kernel
> function to turn on CR4.VMXE, which is required to run hypervisors on x86.

How about taking this opportunity to see if there is a way to improve on
the status quo for co-existing hypervisor modules?

ISTR there are a large number of hoops to jump through if you're not
sure if anything else in the system is using VMX, going as far as
needing to do a full VMXON/VMXOFF cycle each context.

Enabling CR4.VMXE might want to be done proactively by the kernel. 
Amongst other things, it gives protection against stray INIT IPIs in the
system, although the interaction with SMX (tboot / trenchboot) wants
considering carefully.

~Andrew
