Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7332075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhE+xx8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgHTQS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729802AbgHTQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597940257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T4Kp9q57v6oKTddIn0XFYGFL+/Vlz9rKcFYPTaJ4D5s=;
        b=OhE+xx8nl+dhYZ/88q7PxDHrapj+C/kuq4J9gAlQRvn+KdD+l+FQm+8UxivCy6VeKOIRPx
        222kbxqQULHsm8vUhIrMyAEo+Ye6BvDZ0ueki7YGOFLHhhVKtzP4mk7/3mkFTOaGz/dq8s
        e+cpYzY3oTEcAg6G0z2U6JG6JddAJvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-ClgmlA3JMhuolaQDkwRw-g-1; Thu, 20 Aug 2020 12:17:35 -0400
X-MC-Unique: ClgmlA3JMhuolaQDkwRw-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09C2A185519C;
        Thu, 20 Aug 2020 16:17:33 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC3F110023A7;
        Thu, 20 Aug 2020 16:17:30 +0000 (UTC)
Date:   Thu, 20 Aug 2020 11:17:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     peterz@infradead.org
Cc:     Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820161729.cxzjsdqtgr6vktqx@treble>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <CAMzpN2gmCu0q_8gLAOcSuLjpKF+rNj=wiCFsGZXgNwz000HCvg@mail.gmail.com>
 <20200820150841.GB1362448@hirez.programming.kicks-ass.net>
 <20200820151659.b7q7hspe5zsf46eg@treble>
 <20200820152111.GC1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820152111.GC1362448@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 05:21:11PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 20, 2020 at 10:16:59AM -0500, Josh Poimboeuf wrote:
> > On Thu, Aug 20, 2020 at 05:08:41PM +0200, peterz@infradead.org wrote:
> > > On Thu, Aug 20, 2020 at 10:45:12AM -0400, Brian Gerst wrote:
> > > > On Thu, Aug 20, 2020 at 6:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > >
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > ---
> > > > >  arch/x86/kernel/traps.c |   24 ++++++++++++------------
> > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > >
> > > > > --- a/arch/x86/kernel/traps.c
> > > > > +++ b/arch/x86/kernel/traps.c
> > > > > @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
> > > > >                 goto out;
> > > > >         }
> > > > >
> > > > > -       if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> > > > > -               /*
> > > > > -                * Historical junk that used to handle SYSENTER single-stepping.
> > > > > -                * This should be unreachable now.  If we survive for a while
> > > > > -                * without anyone hitting this warning, we'll turn this into
> > > > > -                * an oops.
> > > > > -                */
> > > > > -               tsk->thread.debugreg6 &= ~DR_STEP;
> > > > > -               set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> > > > > -               regs->flags &= ~X86_EFLAGS_TF;
> > > > > -       }
> > > > > -
> > > > >         si_code = get_si_code(tsk->thread.debugreg6);
> > > > >         if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> > > > >                 send_sigtrap(regs, 0, si_code);
> > > > > @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
> > > > >         if (kprobe_debug_handler(regs))
> > > > >                 goto out;
> > > > >
> > > > > +       if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> > > > > +               /*
> > > > > +                * Historical junk that used to handle SYSENTER single-stepping.
> > > > > +                * This should be unreachable now.  If we survive for a while
> > > > > +                * without anyone hitting this warning, we'll turn this into
> > > > > +                * an oops.
> > > > > +                */
> > > > > +               dr6 &= ~DR_STEP;
> > > > > +               set_thread_flag(TIF_SINGLESTEP);
> > > > > +               regs->flags &= ~X86_EFLAGS_TF;
> > > > > +       }
> > > > > +
> > > > >         handle_debug(regs, dr6, false);
> > > > >
> > > > >  out:
> > > > 
> > > > Can this be removed or changed to a BUG()?  The warning has been there
> > > > since 2016 and nobody has apparently complained about it.
> > > 
> > > Something like:
> > > 
> > > 	/*
> > > 	 * The kernel doesn't do TF outside of Kprobes, so if we get
> > > 	 * here, something's fishy.
> > > 	 */
> > > 	BUG_ON(dr6 & DR_STEP);
> > > 
> > > ?
> > 
> > What about kernel debuggers like kgdb and qemu gdb?
> 
> qemu-gdb stub should eat the event before it lands in the guest

Are we sure about that?  I triggered the warning just now, stepping
through the debug handler.

[   34.577903] ------------[ cut here ]------------
[   34.578410] WARNING: CPU: 0 PID: 950 at arch/x86/kernel/traps.c:843 handle_debug+0x10e/0x140
[   34.579152] Modules linked in:
[   34.579439]  ip6t_rpfilter
[   34.579690]  ip6t_REJECT
[   34.579945]  nf_reject_ipv6
[   34.580216]  xt_conntrack
[   34.580467]  ebtable_nat
[   34.580715]  ebtable_broute
[   34.581003]  ip6table_raw
[   34.581258]  ip6table_mangle
[   34.581534]  ip6table_nat
[   34.581801]  ip6table_security
[   34.582116]  iptable_raw
[   34.582361]  iptable_mangle
[   34.582642]  iptable_nat
[   34.582916]  nf_nat
[   34.583136]  nf_conntrack
[   34.583394]  nf_defrag_ipv6
[   34.583665]  nf_defrag_ipv4
[   34.583937]  iptable_security
[   34.584246]  ebtable_filter
[   34.584504]  ebtables
[   34.584735]  ip6table_filter
[   34.585038]  ip6_tables
[   34.585262]  rfkill
[   34.585453]  snd_hda_codec_generic
[   34.585792]  sunrpc
[   34.586006]  crct10dif_pclmul
[   34.586285]  crc32_pclmul
[   34.586549]  ghash_clmulni_intel
[   34.586892]  snd_hda_intel
[   34.587172]  snd_intel_dspcfg
[   34.587456]  snd_hda_codec
[   34.587705]  snd_hwdep
[   34.587953]  snd_hda_core
[   34.588222]  snd_pcm
[   34.588435]  virtio_balloon
[   34.588706]  snd_timer
[   34.588946]  snd
[   34.589131]  soundcore
[   34.589354]  i2c_piix4
[   34.589889]  xfs
[   34.590381]  libcrc32c
[   34.590904]  virtio_net
[   34.591460]  net_failover
[   34.592004]  virtio_blk
[   34.592544]  failover
[   34.593035]  virtio_console
[   34.593514]  crc32c_intel
[   34.593967]  qxl
[   34.594359]  drm_ttm_helper
[   34.594831]  ttm
[   34.595219]  serio_raw
[   34.595648]  drm_kms_helper
[   34.596126]  virtio_pci
[   34.596568]  virtio_ring
[   34.597026]  drm
[   34.597418]  virtio
[   34.597831]  ata_generic
[   34.598304]  pata_acpi
[   34.598757] CPU: 0 PID: 950 Comm: a.out Not tainted 5.9.0-rc1+ #275
[   34.599555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[   34.601250] RIP: 0010:handle_debug+0x10e/0x140
[   34.601916] Code: 91 00 00 00 02 0f 84 55 ff ff ff fa 66 0f 1f 44 00 00 e8 35 f7 20 00 e9 44 ff ff ff e8 1b f6 20 00 fb 66 0f 1f 44 00 00 cc 87 <0f> 0b 80 e4 bf 49 89 85 18 28 00 00 3e 41 80 4d 00 10 48 81 a3 90
[   34.604087] RSP: 0000:fffffe000000dee8 EFLAGS: 00010246
[   34.604870] RAX: 0000000000004000 RBX: fffffe000000df58 RCX: 00000000ffffffff
[   34.605722] RDX: ffff8881366c0000 RSI: ffffffff81b136f3 RDI: ffffffff81037b65
[   34.606557] RBP: fffffe000000df10 R08: 0000000000000001 R09: 0000000000000001
[   34.607770] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   34.608667] R13: ffff8881366c0000 R14: 0000000000000200 R15: 0000000000004000
[   34.609579] FS:  00007f3503d09700(0000) GS:ffff88813b600000(0000) knlGS:0000000000000000
[   34.610578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.611399] CR2: 00007f3503822ae0 CR3: 0000000137cd4003 CR4: 00000000001706f0
[   34.612345] DR0: 00000000004008cf DR1: 0000000000000000 DR2: 0000000000000000
[   34.613368] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   34.614437] Call Trace:
[   34.615098]  <#DB>

-- 
Josh

