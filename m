Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC43DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7B92071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BghTe+Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgDAWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:30:21 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:17133 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585780220;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ypBqtZEADdvBfEkNyBIc74TZ0B3GOgvL58CLHWMq3dA=;
  b=BghTe+GjZGAnkwGOU/afP6eqbI7t2OVc8mMHXiN616OUqI5mOZepMLi2
   mETUjLEfkFuphaUueaPUW4EzmFbNmPc+CO55K4Va6nH/ETf5YkkdSy/x5
   b0jLvmQkqd7eAnLUvKZuJv4JafF5S6oxr4lWoh9dZkvA3IxeG/cDTM8ck
   M=;
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
IronPort-SDR: SlBOpDVSyfmlaZYloDXfRtyji0AMLQW2ggHFzCnIad2qFJeMl2e6w5vnfnDP1epnj1a35l01GE
 gJ7p7IE9mrSXq7gTPDtz4HLJaxJsYAKLarA2Put92a64Iob8XDKqpo0/8TG+R+KdS4IwfCptHM
 3sa/qfuCnMhgrFOog8P6Z8VQCurgolww554Z39ZPQ4r42ACZAW9vDKaDbgS46pyXIssmpFvjXA
 JMqF5IT32+YSitByXxOUC0NDPlCySni8S5lfM4ufZGVyGZGgHJW77gz+rXUO1e3O0guDB0wtz/
 bH0=
X-SBRS: 2.7
X-MesageID: 15694073
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,333,1580792400"; 
   d="scan'208";a="15694073"
Subject: Re: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot path
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "Jan Kiszka" <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        "David Howells" <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        <jailhouse-dev@googlegroups.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com>
 <87r1xgxzy6.fsf@nanos.tec.linutronix.de>
 <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <beefca46-ac7c-374b-e80a-4e7c3af2eb2b@citrix.com>
Date:   Wed, 1 Apr 2020 23:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2020 00:35, Maciej W. Rozycki wrote:
> On Wed, 25 Mar 2020, Thomas Gleixner wrote:
>
>>>> @@ -1118,7 +1121,7 @@ static int do_boot_cpu(int apicid, int cpu,
>>>> struct task_struct *idle,
>>>> 		}
>>>> 	}
>>>>
>>>> -	if (x86_platform.legacy.warm_reset) {
>>>> +	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
>>>> 		/*
>>>> 		 * Cleanup possible dangling ends...
>>>> 		 */
>>> We don't support SMP on 486 and haven't for a very long time. Is there
>>> any reason to retain that code at all?
>> Not that I'm aware off.
>  For the record: this code is for Pentium really, covering original P5 
> systems, which lacked integrated APIC, as well as P54C systems that went 
> beyond dual (e.g. ALR made quad-SMP P54C systems).  They all used external 
> i82489DX APICs for SMP support.  Few were ever manufactured and getting 
> across one let alone running Linux might be tough these days.  I never 
> managed to get one for myself, which would have been helpful for 
> maintaining this code.
>
>  Even though we supported them by spec I believe we never actually ran MP 
> on any 486 SMP system (Alan Cox might be able to straighten me out on 
> this); none that I know of implemented the MPS even though actual hardware 
> might have used the APIC architecture.  Compaq had its competing solution 
> for 486 and newer SMP, actually deployed, the name of which I long forgot.  
> We never supported it due to the lack of documentation combined with the 
> lack of enough incentive for someone to reverse-engineer it.

:)

I chose "486-ism" based on what the MP spec said about external vs
integrated Local APICs.  I can't claim to have any experience of those days.

I guess given v2 of the patch, I guess this should become "Remove
external-LAPIC support from the AP boot path" ?

~Andrew
