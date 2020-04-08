Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD92C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2A20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gQqgHaZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgDHKPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:15:18 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:57614 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDHKPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586340917;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y/zj0vX632rzrg7mCZPM/4OA0shNehPLx5l94K68Dtc=;
  b=gQqgHaZmQnviB5sqPwnm1posZDZOM1pYPm06OO9PU+uZxLSu3VFhxprH
   p9MDebudlqWgp7sBBLUP7SV8gD9gtApPBN3P5zOdMv7RkyI/9DJFYetKU
   evyWYaJLsu5KDDOZUSg15FdvIXJzVyR4E4BM0YjYgpdiPNbjOPMXuhXUt
   w=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: keMJMnWwEc2YGTwWdnv1EYpSCqsYgTk0bzau7VQQ+dosqPRz92Zls+VaIbPgf3o+d/zG7poiK8
 6rAt3JpijCZ5V/okNkvB0uMtQGboZragm7zmTMWJ9SgM0gg6RGPcJ6KWnfHaITQrenpuLCdtAf
 clCCHVub9MrIKnHyfhzcHPCNwiPeUBh2QpBYXLFt81W6y5NXO65KiKtIthxzvlXyscf4djepTC
 hc54Ee8diQA2zl51DPtTUWOaQtr5232NJnpor9lmkpUCcT6htz4LWr5WD/j0keYNECF5mdGPwd
 RfI=
X-SBRS: 2.7
X-MesageID: 15584448
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,357,1580792400"; 
   d="scan'208";a="15584448"
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
To:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
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
 <20200408170934.7238715574818f31f03e687b@kernel.org>
 <20200408095604.GR20713@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <67d4f6d6-0ada-f899-f736-7a13434b60b9@citrix.com>
Date:   Wed, 8 Apr 2020 11:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408095604.GR20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2020 10:56, Peter Zijlstra wrote:
>>> +		case 0xc1: /* VMCALL */
>>> +		case 0xc2: /* VMLAUNCH */
>>> +		case 0xc3: /* VMRESUME */
>>> +		case 0xc4: /* VMXOFF */
>> 		case 0xd4:	/* VMFUNC */
> As per Andrew, VMCALL and VMFUNC are SMV, and I really only need VMX in
> this case. Including SMV is probably harmless, but I'm thinking a
> smaller function is better.

VMCALL and VMFUNC are both VMX instructions.  VMMCALL (count the M's -
yes it is a different instruction) is SVM, and I forgot VMGEXIT from the
list yesterday which is also SVM.

However, searching for them is probably not helpful.  They are all
guest-only instructions and you wouldn't expect to see them in
hypervisor code.

~Andrew
