Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B660C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE56206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GLlt3wUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDGRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:17:05 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:25693 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586279824;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CFH284UVURW+fholSmYMuPSjtq9I/FN7YW1VnZI39yI=;
  b=GLlt3wUP2aUmQLG3Q5Y7o/FTTEWGQuXcCuh+EF6l3eKbY2ZuZXQf/mqT
   uhD6y+QvgAXBVwYkiV46vA8xv1GVEj8NJmI5SULvZ0E9gsDs50fH4Wagf
   WZr2jCuiphQUAQOO+nmX6flUYOepvF8O3N9dUCDRoD4SrRfabE61YkjJn
   4=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 9A/2YSIz5AnvxGFrf5dobOlFalq0zeLrYgndQTW6VGG4UiGIixMbW3Go67kSaLWg211eYzhZGf
 9xJttr0q6ik4l68ZpGIbuRAkg5g4YUqONQS6JaTc0G7j2wSVDD5ax93irvimYThYtszDYWeGQY
 90T2RA2nlP2sSSWduPEnAi25df4RuXQZMpGFWFEfqCOmdZ4/qPdZppVgVzO6RPtTkLSRxBw7XW
 u3fQEiSExzrmDIoeN3rJNEst5McXglVL6WVBjuLTPjQOM7x1Uo1mOh5mlKQv4ponsH1DxbyzH/
 7Fw=
X-SBRS: 2.7
X-MesageID: 15639234
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,355,1580792400"; 
   d="scan'208";a="15639234"
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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
        <dcovelli@vmware.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <55dfd3fd-26c2-77d6-4961-3cef8d746f7f@citrix.com>
Date:   Tue, 7 Apr 2020 18:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 17:51, Masami Hiramatsu wrote:
> diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> index d74d9e605723..ade80796453c 100644
> --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -70,6 +70,8 @@ BEGIN {
>  	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
>  	fpu_expr = "^x87"
>  
> +	vmx_expr = "^VM.*" # All mnemonic start with "VM" are VMX instructions

Not really.

VMMCALL, VMLOAD, VMSAVE and VMRUN are SVM instructions.

VMASKMOV is a AVX instruction.

~Andrew
