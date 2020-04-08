Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C3E20787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KugTKP0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgDHJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:52:22 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:43568 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586339541;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=s5R7D5BnyU070vlj0QlFtAb/87pkZkZ5QFo+14l3Few=;
  b=KugTKP0YQefozAGbeMkY8PsKugD/wr/BvVpAmyA4yBNRi7UTdadM0iPx
   Z/azB/tLNi9TO/XRilPOaMJMyO+S6H57gGUG3vKMULnk9hsKzHHo+mP6s
   VKIh2Bqx2BXHilV3dfkXUxSrcySOXUFcjomw2DS7D8SUZofxqtSLgZkEC
   Y=;
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
IronPort-SDR: qQ748PLXSV8gr/0TeYSgN9/NIsPnRKOhEHsRpFu8s7tlrSOgUVIrMTbjV1xzZNhYhwGSDtx0ul
 GSciAXK4Th/GRUFWl/pXGNrZcdidd/u0i/UeRK75PdwUbIWQ2v9Fi37XL7vBfOoUxVxxvyESt4
 hquQf+1G2nwwt/O1w5gPM4OVI7Rp1wiQQDQG2IR79lmltAAUyjtwckfT6kBHjd6v5aVmFbAkas
 hg1TQWbMfPhuHnYIWpn8bOcTVOFj2Xc3dxQ6jn/oh4KP/sSdF03Wp/k1orwt5zh1sFUSl1lppO
 Da8=
X-SBRS: 2.7
X-MesageID: 15340486
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,357,1580792400"; 
   d="scan'208";a="15340486"
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, <hpa@zytor.com>,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <jannh@google.com>, <keescook@chromium.org>,
        <David.Laight@aculab.com>, "Doug Covelli" <dcovelli@vmware.com>,
        <mhiramat@kernel.org>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <04f4fc03-95cd-df2e-e93d-e9c4fa221ae4@citrix.com>
 <a263df2d-6dd7-83c1-baff-301625ef60a2@redhat.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <1b90c04b-7c5a-80cb-0f28-5026cecf7f10@citrix.com>
Date:   Wed, 8 Apr 2020 10:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a263df2d-6dd7-83c1-baff-301625ef60a2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2020 01:22, Paolo Bonzini wrote:
> On 08/04/20 01:15, Andrew Cooper wrote:
>>> Anyhow, I do not think it is the only use-case which is not covered by your
>>> patches (even considering CRs/DRs alone). For example, there is no kernel
>>> function to turn on CR4.VMXE, which is required to run hypervisors on x86.
>> How about taking this opportunity to see if there is a way to improve on
>> the status quo for co-existing hypervisor modules?
> Almost serious question: why?  I can understand VMware, but why can't at
> least VirtualBox use KVM on Linux?  I am not sure if they are still
> running device emulation in ring zero, but if so do you really want to
> do that these days?

I see a lot of good reasons not to use the VirtualBox out-of-tree module
specifically, but there are plenty of other out-of-tree hypervisors,
including Jailhouse and Bareflank which come to mind.

I'm not suggesting bending over backwards for them, but at the point
you're already breaking all of them anyway, it seems silly not to try
and address some of the other robustness issues.

~Andrew
