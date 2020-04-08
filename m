Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64DFC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F002082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgDHQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:03:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:28384 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbgDHQDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:03:00 -0400
IronPort-SDR: UYcoLh5xYCPG6aq0jxgPSOHaW63ko6YuEHtCMvPJOXokuM0asCgzmmoqPpIH7r63090kKdXPiP
 IymLaEpsOvsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:02:58 -0700
IronPort-SDR: krJHKQ7pS0QJRJBq0YdxLpoAcDLTKiCB2PTLscsZzEN4Mthr3EwZQN9Lc8NII8IaSY5/IE6Bh8
 XDXsofpRYovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="269790350"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2020 09:02:57 -0700
Date:   Wed, 8 Apr 2020 09:02:57 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408160257.GB11322@linux.intel.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
 <20200408154602.GA24869@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408154602.GA24869@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:46:02AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 05:44:19PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 08, 2020 at 09:27:26AM -0400, Steven Rostedt wrote:
> > > On Tue, 07 Apr 2020 13:02:40 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
> > > > +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
> > > > +			return -ENOEXEC;
> > > > +		}
> > > > +
> > > 
> > > Something like this should be done for all modules, not just out of tree
> > > modules.
> > 
> > I'm all for it; but people were worried scanning all modules was too
> > expensive (I don't really believe it is, module loading just can't be a
> > hot-path). Also, in-tree modules are audited a lot more than out of tree
> > magic voodoo crap.
> 
> Scanning all modules seems safer.  While we're at it - can be move the
> kvm bits using VMX to be always in the core kernel and just forbid
> modules from using those instructions entirely?

Practically speaking, no.  Turning VMX on and off (literally VMXON/VMXOFF)
could be moved to helpers in the kernel, but KVM relies on inlining all
post-VMXON instructions (except for VMLAUNCH/VMRESUME) for performance.
VMLAUNCH/VMRESUME have their own caveats, moving them out of KVM would be
messy, to say the least.
