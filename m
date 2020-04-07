Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CAC2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgDGOtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgDGOtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:49:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B16A206F7;
        Tue,  7 Apr 2020 14:49:30 +0000 (UTC)
Date:   Tue, 7 Apr 2020 10:49:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200407104928.566db3f8@gandalf.local.home>
In-Reply-To: <20200407143543.GB876345@kroah.com>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
        <20200407143543.GB876345@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Apr 2020 16:35:43 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > Hypervisors, which have been modified and are known to work correctly,
> > can add:
> > 
> >   MODULE_INFO(sld_safe, "Y");
> > 
> > to explicitly tell the module loader they're good.  
> 
> What's to keep any out-of-tree module from adding this same module info
> "flag" and just lie about it?  Isn't that what you are trying to catch
> here, or is it a case of, "if you lie, your code will break" as well?

Keeping with the analogy to module kabi breakage, that would basically be
the same as an out of tree module fixing the api but not using it properly.
It will break.

All this is doing is to make sure VM modules that haven't been updated to
handle split lock detection, wont be loaded if split lock detection is
enabled. Saying you can handle SLD and not handling it is just broken code
and we can't really protect against that.

-- Steve

