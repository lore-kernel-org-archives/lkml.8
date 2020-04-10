Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 05:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29872206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 05:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VshMhl2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDJFhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 01:37:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDJFhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:37:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n13so554783pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 22:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe24B+23cv+PIIpVHdJo0boX8ah4ju8gQaUITPU+VoI=;
        b=VshMhl2K1MfwxuNjWLiVEpnOxw1iEL8wgxKPgltnyxmpKGonuslDwd9KbBtvZ1Zqme
         SaRFYOsTLeIEQpvmOIxY0oPaK2L5ZFPF+iJtgd5514BWPxWxp86QcAr3AvtnDzKqmDL5
         RjxaTLwObqy46peDJFjSERs1MjMCajfCD3OEqhCE+hs5UCZwdSyt+yaFgFsbSZHDRM9b
         RFH4eypQNwDN92nP66RwgRehL0ZWEJnUXW6umElX/OMr4rmsSFGH++AzRkb4LkNgi6mQ
         ZHk+73XFN7T6TK8vtrO9eN9dPDBngGdEVYjgB81Qvk4s/+9ZlLIvB4hvP1g+SjkVNQ1E
         ad6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe24B+23cv+PIIpVHdJo0boX8ah4ju8gQaUITPU+VoI=;
        b=kaw4sTamdTxrxrqT3ee1tkvigOGHcl1I8rNnlDWxios4HxiATTcBN8oh5qFSx26mom
         /hQ8jztp5kBAjVJkyxr3sPN/o5/0r98KXOewc5WOrNYQIRM64IziZfzn6JFyb8nb+Y/u
         B6h+WS783WVSdmpMQoNF5p3GxpoG5hAUB1FcFHDqG1FgOQ26n8SfiAl7FAXjGSz2pTw5
         IKF4AuDRbiOcKZ85O0RTC9iDs36cj2qHllxRoCUeLCC+iddlMwLomvHPXuFyZhBI3iQ8
         eYyClTzq3XbYBLzVnQCEaXU4wteG4J4xkBVb9ozUfF5n1kmvFcnqcvVxmxSkRcH0kw48
         t+SA==
X-Gm-Message-State: AGi0PuaL/S+OPnofRyUkBGPI/MWX9G3d7s1z1qH+IoqFWZFPZm0nZyq0
        XxeEsUAbyce6NUVfdUg0OxE=
X-Google-Smtp-Source: APiQypLq7mqq7TnLCZc8hHSvWLfXQ1w70HzQ93yIb9mrJteaU6PW1MgzxYAswVaMA3G9WblmoR0y+Q==
X-Received: by 2002:aa7:9823:: with SMTP id q3mr3170488pfl.219.1586497035595;
        Thu, 09 Apr 2020 22:37:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4700:9b2:d8e9:9b3c:bb20:8b56? ([2601:647:4700:9b2:d8e9:9b3c:bb20:8b56])
        by smtp.gmail.com with ESMTPSA id k1sm702842pgh.72.2020.04.09.22.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 22:37:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20200409181823.00bcd14a@gandalf.local.home>
Date:   Thu, 9 Apr 2020 22:37:12 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <92E51AF2-D763-4B73-A573-6E24A6B46831@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
 <20200408154602.GA24869@infradead.org>
 <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
 <20200409085632.GB20713@hirez.programming.kicks-ass.net>
 <9A25271A-71F7-4EA1-9D1C-23B53E35C281@gmail.com>
 <87imi8pdl9.fsf@nanos.tec.linutronix.de>
 <20200409181823.00bcd14a@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 9, 2020, at 3:18 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Thu, 09 Apr 2020 23:13:22 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>=20
>> __vmx_vcpu_run() is roughly the scope, but that wont work.
>>=20
>> Looking at the vmmon source:
>>=20
>>=20

[ Snip ]

>>=20
>>    8) Invoke monitor on some magic page which switches CR3 and GDT =
and
>>       clears CR4.PCIDE (at least thats what the comments claim)
>>=20
>>       The monitor code is loaded from a binary only blob and that =
does
>>       the actual vmlaunch/vmresume ...
>=20
> =46rom what I understand (never looked at the code), is that this =
binary blob
> is the same for Windows and Apple. It's basically its own operating =
system
> that does all the work and vmmon is the way to switch to and from it. =
When
> this blob gets an interrupt that it doesn't know about, it assumes it
> belongs to the operating system its sharing the machine with and exits =
back
> to it, whether that's Linux, Windows or OSX.
>=20
> It's not too unlike what jailhouse does with its hypervisor, to take =
over
> the machine and place the running Linux into its own "cell", except =
that it
> will switch full control of the machine back to Linux.
>=20
> -- Steve
>=20
>=20
>>       And as this runs with a completely different CR3 sharing that
>>       code is impossible.


To complement Steven=E2=80=99s response, we are fully aware in VMware =
about this
issue since the patches were sent, and the hypervisor developers =
consider
how to address it. Indeed, vmmon does something similar to VirtualBox =
and
Jailhouse. The planned restriction on the creation of executable =
mappings by
modules would require changes in all of these hypervisors.

Actually, IIUC, even Mircosoft Hyper-V might be broken by the proposed
changes that prevent the creation of executable mappings. It may appear =
as
if there is no issue since the __vmalloc() that hyperv_init() uses in =
the
kernel to setup the hypercall pages will be changed into vmalloc_exec() =
[1].
But, AFAICT Microsoft can also setup the hypercall page in a module as =
part
of its Linux Integration Services. This code uses
__vmalloc(=E2=80=A6PAGE_KERNEL_RX), and would therefore be broken. [2]

It seems to me that the proposed restrictions on which instructions a =
module
is allowed to run are completely new, have significant implications, and
therefore would hopefully not be rushed in. Alternatively, a transition
period in which the checks only trigger warnings would be beneficial.

I am not a developer of the VMware hypervisor, but my understanding is =
that
developers have every intention to fully comply with the new =
restrictions on
memory mappings and instructions that a module is allowed to run. They =
can
consider sharing VM-entry/exit code with KVM even if requires code =
changes
for VMware. They just ask for sufficient time to make the required
adaptations. It would help to have a reasonable timeline for when each
of the proposed changes (__vmalloc(), MOV-CR/DR, other instructions)
is expected to be merged.

[1] https://lore.kernel.org/lkml/20200408115926.1467567-2-hch@lst.de/
[2] =
https://github.com/LIS/lis-next/blob/master/hv-rhel7.x/hv/arch/x86/hyperv/=
hv_init.c#L187

