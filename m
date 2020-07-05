Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA2320739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="IBzETkII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGEUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:00:32 -0400
Received: from smtp100.iad3a.emailsrvr.com ([173.203.187.100]:48120 "EHLO
        smtp100.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgGEUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593979230;
        bh=SZFxyj7tOxHfnQrUXcI+g4bE81fGde5BNLxVVeDCCQU=;
        h=Date:Subject:From:To:From;
        b=IBzETkIIKifJXWqJpkyJRxTNHuK4e/CYzUyH6dlDA4ljfW/HzTxzzh3qgHnp9ZR3o
         hzc1AWCWu9gZO6tAz3t7KWHzt2xlCXuVgRt2D77eW9pUU7fbOYFv1nuP85yR+ThIz5
         ligx8d3kPHmYn+3LViwBWbYLvPu/u6wnxYX6hoq0=
Received: from app62.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp21.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 6C70F1F7FE;
        Sun,  5 Jul 2020 16:00:30 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app62.wa-webapps.iad3a (Postfix) with ESMTP id 38ADB61850;
        Sun,  5 Jul 2020 16:00:33 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Sun, 5 Jul 2020 16:00:33 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Sun, 5 Jul 2020 16:00:33 -0400 (EDT)
Subject: Re: [PATCH v3 3/3] Force all cpus to exit VMX root operation on crash/panic reliably
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     "Sean Christopherson" <sean.j.christopherson@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Allison Randal" <allison@lohutok.net>,
        "Enrico Weigelt" <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "=?utf-8?Q?Peter_Zijlstra_=28Intel=29?=" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Martin Molnar" <martin.molnar.programming@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        "Jann Horn" <jannh@google.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
In-Reply-To: <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
References: <20200629214956.GA12962@linux.intel.com> 
 <20200704203809.76391-1-dpreed@deepplum.com> 
 <20200704203809.76391-4-dpreed@deepplum.com> 
 <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
Message-ID: <1593979233.22877148@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: a1c609fb-b075-4b3d-a03e-875389d0f20c-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0AOn Sunday, July 5, 2020 2:26pm, "Andy Lutomirski" <luto@kernel.org> s=
aid:=0A=0A> On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum.c=
om> wrote:=0A>>=0A>> Fix the logic during crash/panic reboot on Intel proce=
ssors that=0A>> can support VMX operation to ensure that all processors are=
 not=0A>> in VMX root operation. Prior code made optimistic assumptions=0A>=
> about other cpus that would leave other cpus in VMX root operation=0A>> d=
epending on timing of crash/panic reboot.=0A>> Builds on cpu_ermergency_vmx=
off() and __cpu_emergency_vmxoff() created=0A>> in a prior patch.=0A>>=0A>>=
 Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>=0A>> S=
igned-off-by: David P. Reed <dpreed@deepplum.com>=0A>> ---=0A>>  arch/x86/k=
ernel/reboot.c | 20 +++++++-------------=0A>>  1 file changed, 7 insertions=
(+), 13 deletions(-)=0A>>=0A>> diff --git a/arch/x86/kernel/reboot.c b/arch=
/x86/kernel/reboot.c=0A>> index 0ec7ced727fe..c8e96ba78efc 100644=0A>> --- =
a/arch/x86/kernel/reboot.c=0A>> +++ b/arch/x86/kernel/reboot.c=0A>> @@ -543=
,24 +543,18 @@ static void emergency_vmx_disable_all(void)=0A>>          * =
signals when VMX is enabled.=0A>>          *=0A>>          * We can't take =
any locks and we may be on an inconsistent=0A>> -        * state, so we use=
 NMIs as IPIs to tell the other CPUs to disable=0A>> -        * VMX and hal=
t.=0A>> +        * state, so we use NMIs as IPIs to tell the other CPUs to =
exit=0A>> +        * VMX root operation and halt.=0A>>          *=0A>>     =
     * For safety, we will avoid running the nmi_shootdown_cpus()=0A>>     =
     * stuff unnecessarily, but we don't have a way to check=0A>> -        =
* if other CPUs have VMX enabled. So we will call it only if the=0A>> -    =
    * CPU we are running on has VMX enabled.=0A>> -        *=0A>> -        =
* We will miss cases where VMX is not enabled on all CPUs. This=0A>> -     =
   * shouldn't do much harm because KVM always enable VMX on all=0A>> -    =
    * CPUs anyway. But we can miss it on the small window where KVM=0A>> - =
       * is still enabling VMX.=0A>> +        * if other CPUs might be in V=
MX root operation.=0A>>          */=0A>> -       if (cpu_has_vmx() && cpu_v=
mx_enabled()) {=0A>> -               /* Disable VMX on this CPU. */=0A>> - =
              cpu_vmxoff();=0A>> +       if (cpu_has_vmx()) {=0A>> +       =
        /* Safely force out of VMX root operation on this CPU. */=0A>> +   =
            __cpu_emergency_vmxoff();=0A>>=0A>> -               /* Halt and=
 disable VMX on the other CPUs */=0A>> +               /* Halt and exit VMX=
 root operation on the other CPUs */=0A>>                 nmi_shootdown_cpu=
s(vmxoff_nmi);=0A>>=0A>>         }=0A> =0A> Seems reasonable to me.=0A> =0A=
> As a minor caveat, doing cr4_clear_bits() in NMI context is not really=0A=
> okay, but we're about to reboot, so nothing too awful should happen.=0A> =
And this has very little to do with your patch.=0A=0AI had wondered why the=
 bit is cleared, too. (I assumed it was OK or desirable, because it was bei=
ng cleared in NMI context before). Happy to submit a separate patch to elim=
inate that issue as well, since the point of emergency vmxoff is only to ge=
t out of VMX root mode - CR4.VMXE's state is irrelevant. Of course, clearin=
g it prevents any future emergency vmxoff attempts. (there seemed to be som=
e confusion about "enabling" VMX vs. "in VMX operation" in the comments)  S=
hould I?=0A=0A> =0A> Reviewed-by: Andy Lutomirski <luto@kernel.org>=0A> =0A

