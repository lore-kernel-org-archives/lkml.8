Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03A120801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591956838;
	bh=YGVdRMoIliwKOkYP14E5HqGygD3q1LI9VS07IqWiP3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eU0JxLp5Jg+6FibTrgcoD+UWQWX7hFxofm9IJKXoxJ4PqN5OyGSGW/60AOf3ewgFB
	 I+rj+f1ZF+l57Z96FssES65+SKR/5qWRMxGvjaRPtJYGBjrMbMSEbfD+hbztSX3NRQ
	 OUjM8fb9omHwyHbFuGKvCntfIXAXC5CslTzGeRqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgFLKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:13:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBD7206A4;
        Fri, 12 Jun 2020 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591956834;
        bh=YGVdRMoIliwKOkYP14E5HqGygD3q1LI9VS07IqWiP3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=if0NuucfwA+mq3EfP/vzlyDR6OgV9i4KX/XR0T7Ui1Xgub1qExH70Dcjge+qMS21A
         OLa1ExtFXbpiiJ+wq9fH/5uSg3jeEbYOmt5e82h+W0UUaMUas6PmJQ1ChWxCd+nft8
         51CZx9o+aNA4gQHkcgNVPGX5a0gluBvck9jKjKak=
Date:   Fri, 12 Jun 2020 19:13:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-Id: <20200612191349.9774d101681b9f8e7ada0200@kernel.org>
In-Reply-To: <20200611143240.u77kxdbhepaazx3j@holly.lan>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
        <20200605142953.GP2750@hirez.programming.kicks-ass.net>
        <20200611214209.bd8fcd290d745ae50d898e69@kernel.org>
        <20200611143240.u77kxdbhepaazx3j@holly.lan>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 15:32:40 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On Thu, Jun 11, 2020 at 09:42:09PM +0900, Masami Hiramatsu wrote:
> > On Fri, 5 Jun 2020 16:29:53 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > > > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > > > placement. If the debugger is commanded to place a breakpoint at an
> > > > address then it will do so even if that breakpoint results in kgdb
> > > > becoming inoperable.
> > > > 
> > > > A stop-the-world debugger with memory peek/poke does intrinsically
> > > > provide its operator with the means to hose their system in all manner
> > > > of exciting ways (not least because stopping-the-world is already a DoS
> > > > attack ;-) ) but the current no safety rail approach is not easy to
> > > > defend, especially given kprobes provides us with plenty of machinery to
> > > > mark parts of the kernel where breakpointing is discouraged.
> > > > 
> > > > This patchset introduces some safety rails by using the existing
> > > > kprobes infrastructure. It does not cover all locations where
> > > > breakpoints can cause trouble but it will definitely block off several
> > > > avenues, including the architecture specific parts that are handled by
> > > > arch_within_kprobe_blacklist().
> > > > 
> > > > This patch is an RFC because:
> > > > 
> > > > 1. My workstation is still chugging through the compile testing.
> > > > 
> > > > 2. Patch 4 needs more runtime testing.
> > > > 
> > > > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> > > >    more review especially for its impact on arch specific code.
> > > > 
> > > > To be clear I do plan to do the detailed review of the kprobe blacklist
> > > > stuff but would like to check the direction of travel first since the
> > > > change is already surprisingly big and maybe there's a better way to
> > > > organise things.
> > > 
> > > Thanks for doing these patches, esp 1-3 look very good to me.
> > > 
> > > I've taken the liberty to bounce the entire set to Masami-San, who is
> > > the kprobes maintainer for comments as well.
> > 
> > Thanks Peter to Cc me.
> > 
> > Reusing kprobe blacklist is good to me as far as it doesn't expand it
> > only for kgdb. For example, if a function which can cause a recursive
> > trap issue only when the kgdb puts a breakpoint, it should be covered
> > by kgdb blacklist, or we should make a "noinstr-list" including
> > both :)
> 
> Recursion is what focuses the mind but I don't think we'd need
> recursion for there to be problems.
> 
> For example taking a kprobe trap whilst executing the kgdb trap handler
> (or vice versa) is already likely to be fragile and is almost certainly
> untested on most or all architectures.

Ah, OK. Actually, on x86 that is not a problem (it can handle recursive int3
if software handles it correctly), but other arch may not accept it.
Hmm, then using NOKPROBE_SYMBOL() is reasonable.

> Further if I understood Peter's
> original nudge correctly then, in addition, x86 plans to explicitly
> prohibit this anyway.
> 
> On other words I think there will only be one blacklist.

Agreed.

> > Thus, Nack for PATCH 4/4, that seems a bit selfish change. If kgdb wants
> > to use the "kprobes blacklist", we should make CONFIG_KGDB depending on
> > CONFIG_KPROBES.
> 
> Some of the architectures currently have kgdb support but do not have
> kprobes...

"depends on KPROBES if HAVE_KPROBES" ? :-)

(Anyway, it is a good chance to port kprobe on such arch...)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
