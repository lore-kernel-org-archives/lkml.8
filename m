Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52674C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD012076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="XjIsjt7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgDGUVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:21:39 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:34173 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586290897;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WtVl2Tqlgobs3aTGznDkxrp2IRy/nD6GLGW1APrqHHY=;
  b=XjIsjt7KYWpO3BMgvTOK/FxHB7NIiwyCAfS8YBn9qKsSAXAZD3tU3/YZ
   sCIp6TGBw/yUrNHCNPgaivTDWEFEKWveTfLIKh6NUsux94leIfprxWXRz
   bCeayo1B0ThHOu25FoKOfURVJW520ZV6LoJl8S2mSzMVLMxf3pK93C1xB
   k=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 1eDelT3dZ0888ZvXjwp6+FAhyRUH3fRbOibIZI8yY9Gxmy9iGmv1WSxTdw9nmc6e3y8ppZdh7j
 M6jN4Rq1bsoMYcSNTSTyM2YV801o4rJh8FrLoKgLi7mbuZvUT1PkYMcOTzXwQMlKy46eg+pZJB
 CaFLEQEpjXzN09jZMHVjCCF7pPdE0Hq4RsQ2u87YxXzGg5cTBOUrv89QeFaLdvye6DUPljvxlw
 DFX1eMatkkhImuuD/qwrjBRyCLK6/gWyn+X3MHTVJo6oMlBAyH57OsYmrbin5EWbEXKHP2cGBO
 Qv4=
X-SBRS: 2.7
X-MesageID: 15994726
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,356,1580792400"; 
   d="scan'208";a="15994726"
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
Message-ID: <3245cf5e-b21b-634e-a9d7-a63d55145c33@citrix.com>
Date:   Tue, 7 Apr 2020 21:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
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
>
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -282,6 +282,50 @@ static bool insn_is_mov_DRn(struct insn
>  	return false;
>  }
>  
> +static bool insn_is_LxDT(struct insn *insn)
> +{
> +	u8 modrm = insn->modrm.bytes[0];
> +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> +	u8 modrm_reg = X86_MODRM_REG(modrm);
> +
> +	if (insn->opcode.bytes[0] != 0x0f)
> +		return false;
> +
> +	switch (insn->opcode.bytes[1]) {
> +	case 0x00:
> +		if (modrm_mod != 0x03)
> +			break;
> +

Apologies - missed this before.  LLDT and LTR can be encoded with a
memory operand, so you need to drop the modrm_mod check to spot all
instances.

~Andrew
