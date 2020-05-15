Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC627C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856C207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgEPAKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgEPAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A88C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkP1-00022C-Dp; Sat, 16 May 2020 02:10:07 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CBCCDFF834;
        Sat, 16 May 2020 02:10:06 +0200 (CEST)
Message-Id: <20200515234547.710474468@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is V6 of the rework series. V5 can be found here:

  https://lore.kernel.org/r/20200512210059.056244513@linutronix.de

The V6 leftover series is based on:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-base-v6

which is the reworked base series from part 1-4 of the original 5 part
series with a few changes which are described in detail below in the merge
plan section.

V6 has the following changes vs. V5:

    - Rebased on top entry-base-v6

    - Addressed Stevens request to split up the hardware latency detector.
      This are 3 patches now as I couldn't resist to cleanup the
      timestamping mess in that code before splitting it up.
    
    - Dropped the KVM/SVM change as that is going to be routed
      differently. See below.

The full series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v6-the-rest

On top of that the kvm changes are applied for completeness and available
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v6-full


Merge plan:
-----------

After figuring out that the entry pile and next are not really happy with
each other, I spent quite some time to come up with a plan.

The goal was to:

    - not let Stephen Rothwell grow more grey hair when trying to resolve
      the conflicts

    - allow the affected trees (RCU and KVM) to take a small part of the
      series into their trees while making sure that the x86/entry branch
      is complete and contains the required RCU and KVM changes as well.

About 10 hours of patch tetris later the solution looks like this:

  I've reshuffled the patches so that they are grouped by subsystem instead
  of having the cross tree/subsystem patches close to the actual usage site
  in the x86/entry series.

  This allowed me to tag these subsytem parts and they contain just the
  minimal subset of changes to be able to build and boot.

The resulting tag list is:

  - noinstr-lds-2020-05-15

    A single commit containing the vmlinux.lds.h change which introduces
    the noinstr.text section.

  - noinstr-core-2020-05-15

    Based on noinstr-lds-2020-05-15 and contains the core changes

  - noinstr-core-for-kvm-2020-05-15

    Subset of noinstr-core-2020-05-15 which is required to let KVM pull
    the KVM async pagefault cleanup and base the guest_enter/exit() and
    noinstr changes on top.

  - noinstr-rcu-nmi-2020-05-15

    Based on the core/rcu branch in the tip tree. It has merged in
    noinstr-lds-2020-05-15 and contains the nmi_enter/exit() changes along
    with the noinstr section changes on top.

    This tag is intended to be pulled by Paul into his rcu/next branch so
    he can sort the conflicts and base further work on top.

  - noinstr-core-2020-05-15

    Based on noinstr-core-for-kvm-2020-05-15 and contains the async page
    fault cleanup which goes into x86/entry so the IDTENTRY conversion of
    #PF which also touches the async pagefault code can be applied on top

    This tag is intended to be pulled by Paolo into his next branch so he
    can work against these changes and the merged result is also target for
    the rebased version of the KVM guest_enter/exit() changes. These are
    not part of the entry-v6-base tag. I'm going to post them as a separate
    series because the original ones are conflicting with work in that area
    in the KVM tree.

  - noinstr-kcsan-2020-05015, noinstr-kprobes-2020-05-15,
    noinstr-objtool-2020-05-15

    TIP tree internal tags which I added to reduce the brain-melt.

The x86/entry branch is based on the TIP x86/entry branch and has the
following branches and tags merged and patches from part 1-4 applied:

    - x86/asm because this has conflicting changes vs. #DF

    - A small set of preparatory changes and fixes which are independent
      of the noinstr mechanics

    - noinstr-objtool-2020-05-15
    - noinstr-core-2020-05-15
    - noinstr-kprobes-2020-05-15
    - noinstr-rcu-nmi-2020-05-15
    - noinstr-kcsan-2020-05015
    - noinstr-x86-kvm-2020-05-15
    
    - The part 1-4 patches up to

        51336ff8b658 ("x86/entry: Convert double fault exception to IDTENTRY_DF")

      This is tagged as entry-v6-base

The remaining patches in this leftover series will be applied on top.

If this works for all maintainers involved, then I'm going to pull the tags
and branches into the tip-tree which makes them immutable.

If not, please tell me ASAP that I should restart the patch tetris session
after hiding in a brown paperbag for some time to recover from brain melt.

Thanks,

	tglx


