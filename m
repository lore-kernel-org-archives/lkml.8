Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433BE207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4vnm5Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgE0XHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:06:59 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5357C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 16:06:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r3so12091508qve.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kx5jjhzRTT9k/ayNNCv2FNZP9ssXX3su13oNYV9ODvI=;
        b=p4vnm5Dl1NxywKsqveyeOvzbcvLEGR63InkRGLVJ70vMP0tHZX4JAC6Y7r8r5V+1L+
         1emdKUbk2WTcJ0TBd/ztmW0SYSWQ1OXyo8uIxVHPVFjJibAoSkd/2j/ORpbYV62/alm6
         8tAvPrvVr7eYW5mTOdp9MmReago3NMctiEmBsTJwAGQsw6EJbuKTStcWn8TsruJKRWBk
         7/vY0YG9ecmN7A7sOhHdx28wBjx4a30qCZI1oNWwj6s6OHfoyvbGeNjSqH9KEvRt3fv1
         Pk3wrE7jb3YdFbpzog7MzIDTVr2hCQ27Ixjr+VRn6eW84FWlp9HX+MoCa8gTledNSBDB
         hpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kx5jjhzRTT9k/ayNNCv2FNZP9ssXX3su13oNYV9ODvI=;
        b=NIlkkth3RcCC+emovSPchq47MqozjzSd+/SmA0VmMrU+WJawQ5NcKU0XSyUF/4ewjA
         zNKiGjly1EDY3b9j0PjjWcOZRTxgLX9jTaYmQ1AcPD/IYtIdOifgE4YhQwayRo7xHvuH
         bDvXYfk3W/nPlYy8CKQk0k7Hcfo7EIIvT3fKydyJGxX8bl+hVM0gRXmIcwZIWJC8w5lS
         SWSlpU6xJsAS9o4VFhQIrxscqtn9WjpVTz0cuhs2g6xLm3lbrUkU3KnxVS7PzhXzGvSe
         FCbsocUq0O1Hlsn12gWNZTpV1+lmQGGm3RAaQ8Sd+tsqWLpjrQa6H+UmRxH5NU00kGTC
         ZJsg==
X-Gm-Message-State: AOAM533m+J11wDIzPfu/n2S5WztEUXl3fkXNLWtlZIg3Rgpq9z7vCx/9
        zKix0XxgLnRczrZDe+Vc0p8=
X-Google-Smtp-Source: ABdhPJyX2espAYej2SjLBQPlHsSSL6H4gT9HxfStEkSqexl4o6tLwRZMBaeWZ5d2Mw7dmQWKcopQCw==
X-Received: by 2002:a05:6214:405:: with SMTP id z5mr363581qvx.112.1590620819013;
        Wed, 27 May 2020 16:06:59 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k17sm4162582qtb.5.2020.05.27.16.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 16:06:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1B9B727C005B;
        Wed, 27 May 2020 19:06:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 May 2020 19:06:56 -0400
X-ME-Sender: <xms:jfLOXpdyP4nUl9auAItvsDtE6LXtWiwtif5UjU72YA649hkF69-a-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvhedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jfLOXnOQIU55FK1g0Rgfna7k4-hKj6MKS6ieuv1qq4XjunlRvrNdWg>
    <xmx:jfLOXigrdkfDKLpiTUouFWThLb4q5EuYaD4ulyrU0sbezUI0m-17UA>
    <xmx:jfLOXi-82VUXTpNnqukJhy6tIY9L-JzbVOALEdJGu_pXtgrNQbsyLg>
    <xmx:kPLOXuu1bnt_fBSR5pfzOaZ6ngnJ7gGBNpVckgwDsgUgnHt1kdIm5kvNWlA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id B87723280060;
        Wed, 27 May 2020 19:06:52 -0400 (EDT)
Date:   Thu, 28 May 2020 07:06:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 30/39] x86/entry: Convert various hypervisor vectors
 to IDTENTRY_SYSVEC
Message-ID: <20200527230651.GB94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200521200513.656533920@linutronix.de>
 <20200521202119.647997594@linutronix.de>
 <20200527014616.GA123239@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200527083803.gpigonfy2kd2g5t4@debian>
 <20200527120918.ly5vuhvxzqesdt6j@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527120918.ly5vuhvxzqesdt6j@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:09:18PM +0000, Wei Liu wrote:
> On Wed, May 27, 2020 at 09:38:03AM +0100, Wei Liu wrote:
> > On Wed, May 27, 2020 at 09:46:16AM +0800, Boqun Feng wrote:
> > > Hi Thomas,
> > > 
> > > On Thu, May 21, 2020 at 10:05:43PM +0200, Thomas Gleixner wrote:
> > > > From: Thomas Gleixner <tglx@linutronix.de>
> > > > 
> > > > Convert various hypervisor vectors to IDTENTRY_SYSVEC
> > > >   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
> > > >   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
> > > >   - Remove the ASM idtentries in 64bit
> > > >   - Remove the BUILD_INTERRUPT entries in 32bit
> > > >   - Remove the old prototypes
> > > > 
> > > > No functional change.
> > > > 
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Acked-by: Andy Lutomirski <luto@kernel.org>
> > > 
> > > I hit the following while trying to test the whole patchset on a Hyper-V
> > > guest, and git bisect told me this patch introduced the problem, the
> > > config file is in the attachment.
> > > 
> > > Regards,
> > > Boqun
> > > 
> > 
> > Hi Boqun,
> > 
> > Thanks for testing and reporting.
> > 
> > This patch modifies Hyper-V's entry point so no wonder you pin down this
> > patch.
> > 
> > > [    3.366637] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > > [    3.369959] #PF: supervisor instruction fetch in kernel mode
> > > [    3.369959] #PF: error_code(0x0010) - not-present page
> > > [    3.369959] PGD 0 P4D 0
> > > [    3.369959] Oops: 0010 [#1] PREEMPT SMP PTI
> > > [    3.369959] CPU: 27 PID: 0 Comm: swapper/27 Not tainted 5.7.0-rc5-00374-ge2d215d23d72 #23
> > > [    3.369959] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 05/16/2019
> > > [    3.369959] RIP: 0010:0x10
> > 
> > Hmmm... NULL pointer here.
> > 
> > > [    3.369959] Code: Bad RIP value.
> > > [    3.369959] RSP: 0000:ffffbf444018beb8 EFLAGS: 00010086
> > > [    3.369959] RAX: 000000000000001b RBX: ffffa04620900000 RCX: 00000000c8aab6dc
> > > [    3.369959] RDX: 0000000000000001 RSI: ffffffffb390feaf RDI: ffffffffb3919e60
> > > [    3.369959] RBP: 000000000000001b R08: 0000000000000000 R09: 0000000000000101
> > > [    3.369959] R10: 0000000000dda899 R11: 0000000001d417ad R12: 0000000000000000
> > > [    3.369959] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > [    3.369959] FS:  0000000000000000(0000) GS:ffffa04627ac0000(0000) knlGS:0000000000000000
> > > [    3.369959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    3.369959] CR2: ffffffffffffffe6 CR3: 000000101bcba002 CR4: 00000000003606e0
> > > [    3.369959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [    3.369959] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [    3.369959] Call Trace:
> > > [    3.369959]  ? default_idle+0x1c/0x190
> > > [    3.369959]  ? do_idle+0x1cd/0x230
> > > [    3.369959]  ? cpu_startup_entry+0x19/0x20
> > > [    3.369959]  ? secondary_startup_64+0xa4/0xb0
> > 
> > And I certainly didn't expect this.
> > 
> > > [    3.369959] Modules linked in: crc32c_intel hv_vmbus(+)
> > 
> > VMBus is being loaded. That gives me some clue.
> > 
> > I notice a hunk in the patch:
> > 
> > @@ -331,17 +327,19 @@ static void __init ms_hyperv_init_platfo
> >         x86_platform.apic_post_init = hyperv_init;
> >         hyperv_setup_mmu_ops();
> >         /* Setup the IDT for hypervisor callback */
> > -       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, hyperv_callback_vector);
> > +       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
> > 
> > It is not using the asm variant.
> > 
> > Could this be the culprit? Thomas?
> > 
> 
> I'm able to reproduce the issue locally.  And after applying the
> following diff I'm able to get a VM booting again on Hyper-V.
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index a103e1c0b90e..af94f05a5c66 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -327,7 +327,7 @@ static void __init ms_hyperv_init_platform(void)
>         x86_platform.apic_post_init = hyperv_init;
>         hyperv_setup_mmu_ops();
>         /* Setup the IDT for hypervisor callback */
> -       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
> +       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
> 
>         /* Setup the IDT for reenlightenment notifications */
>         if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {
> 
> Boqun, can you give this a try?
> 

Sure, I just build a kernel with your modification, and the guest kernel
booted without any problem, thanks!

> Thomas, feel free to fold this in.
> 

FWIW, feel free to add

Tested-by: Boqun Feng <boqun.feng@gmail.com>

, for the version with this change folded.

Regards,
Boqun

> Wei.
