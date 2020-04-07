Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C3C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA42074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RCzMih5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDGULZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:11:25 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:9813 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586290284;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=quurHnnNLF0M8WZ4vUq1YW38UCZI+5kCMuLuV15f4r0=;
  b=RCzMih5pjqaJmoOa1e6tIRlKvnZFM7NCmexDxUQpN54A8Ip6kF/DcbDx
   CD9n4I+AFLY1Lw0orDDM6aqOddJp8Px4rsItzdakFTwIWaWTmkPAJHYTA
   G5iYmUuElkFiNWPQ89QD/P7zdwTDaOx1OI+4bzzPdVfx93Ub2hUG98sRo
   M=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: rtcWbxk7c8SK6kJYticYxMe0smMHwTMG/FGKuATkjjZAr+joYGSVGtOEiiLbwx9KP4MupDFIlF
 9mceB6Km/MzViGBrVK1Mf4nRwjHuYCk2YrB/62EItwXDwjVR34QPtKFq1oHcKqY+AtTi/UzMNb
 o7hrxV7UVZEK58R9PDhhID3++8SxLBzLCL6EifKEInglMs68NuwIrUCE3W+gZ0Ib6RZghXcNXv
 KPTPSyK6oOwQwS1xb4P6lmYXKulhe578dBJMyHVFN1lVMitovImEuXO024IkrtteGp9y3zJ+57
 XxY=
X-SBRS: 2.7
X-MesageID: 15338151
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,356,1580792400"; 
   d="scan'208";a="15338151"
Subject: Re: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hch@infradead.org>, <sean.j.christopherson@intel.com>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <kenny@panix.com>, <jeyu@kernel.org>,
        <rasmus.villemoes@prevas.dk>, <pbonzini@redhat.com>,
        <fenghua.yu@intel.com>, <xiaoyao.li@intel.com>,
        <nadav.amit@gmail.com>, <thellstrom@vmware.com>,
        <tony.luck@intel.com>, <rostedt@goodmis.org>,
        <gregkh@linuxfoundation.org>, <jannh@google.com>,
        <keescook@chromium.org>, <David.Laight@aculab.com>,
        <dcovelli@vmware.com>, <mhiramat@kernel.org>
References: <20200407110236.930134290@infradead.org>
 <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
 <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <e6d9f83e-e88c-c079-50b3-ff8ad8682074@citrix.com>
Date:   Tue, 7 Apr 2020 21:11:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 20:41, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 06:23:27PM +0100, Andrew Cooper wrote:
>> On 07/04/2020 12:02, Peter Zijlstra wrote:
>>> Hi all,
>>>
>>> Driven by the SLD vs VMX interaction, here are some patches that provide means
>>> to analyze the text of out-of-tree modules.
>>>
>>> The first user of that is refusing to load modules on VMX-SLD conflicts, but it
>>> also has a second patch that refulses to load any module that tries to modify
>>> CRn/DRn.
>>>
>>> I'm thinking people will quickly come up with more and more elaborate tests to
>>> which to subject out-of-tree modules.
>> Anything playing with LGDT & friends?  Shouldn't be substantially more
>> elaborate than CR/DR to check for.
> More friends? (I wasn't sure on the Sxxx instructions, they appear
> harmless, but what do I know..)
>
> I was also eyeing LSL LTR LSS, none of which I figured a module has any
> business of using. Are there more?

Sorry - should have been more clear.  By friends, I meant LGDT, LIDT,
LLDT and LTR which are the 4 system table loading instructions.  LLDT
and LTR depend on being able to write into the GDT, but still have no
business being used.

Also, LMSW if you care about it, but its utility is somewhere close to 0
these days, so probably not worth the cycles searching for.

The Sxxx instructions have no business being used, but are also harmless
and similarly, probably not worth spending cycles searching for.

L{D,E,F,S}S are functional equivalents to "MOV val1, %sreg; mov val2,
%reg"  so harmless (also mode specific as to whether they are useable).


Other things to consider, while we're on a roll:

WRMSR and RDMSR:  There is a lot of damage which can be done with these,
and at least forcing people to use the regular hooks will get proper
paravirt support and/or exception support.  That said, this might cause
large carnage to out-of-tree modules which are a device driver for
random platform things.

POPF: Don't really want someone being able to set IOPL3.  However, this
might quite easily show up as a false positive depending on how the
irqsafe infrastructure gets inlined.

SYSRET/SYSEXIT/IRET: Don't want a module returning to userspace behind
the kernels back.  IRET may be a false positive for serialising
purposes, as may be a write to CR2 for that matter.

Looking over the list of other privileged instructions, CLTS,
{,WB,WBNO}INVD, INVLPG and HLT might be candidates for "clearly doing
something which shouldn't be done".  Not on the list is INVPCID which
falls into the same category.

Come to think about it, it might be easier to gauge on CPL0 instructions
and whitelist the ok ones, such as VMX and SVM for out-of-tree hypervisors.

~Andrew
