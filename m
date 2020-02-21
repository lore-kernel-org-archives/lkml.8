Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817DAC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5408D207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582328686;
	bh=uMLXKUvP9rdKF8HGi/y1znP35m5mrNUlNmaHCWuNMWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pB1vfKehApYFTQckKAWSS0+0dybvAjBhS1kKoIwZVxjbbxknIQbdon5L5Po3g9Y2S
	 4E1QkAk9eXvs4AnKX3VUsu3FDzFytpMY+9w2ty/ES7XlH37qXhJ1lSade96vDhaVQx
	 CUJWV5B4z02mRs+SIBuz8wwG9Y+YAFCdEINJ9Dvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBUXop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUXoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:44:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF46A20722;
        Fri, 21 Feb 2020 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582328683;
        bh=uMLXKUvP9rdKF8HGi/y1znP35m5mrNUlNmaHCWuNMWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ej5tQ3TPcg+n/Ou8+qvfqKceKz088FOVkCrYHPqmIkdM5qCk1nzVmRKIvlhBSYGWQ
         g2x1I1v5l8eJq31loGcmxAbFP7XIE1ybjMWnoQdIHJcgvBTR8FkOIP4olTnTfnc2D7
         wsqteD+RSVB17Jf5nWUTohbqt4sMLOhZ094PJz6Q=
Date:   Sat, 22 Feb 2020 08:44:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-Id: <20200222084438.37a0ff99edbe32acdb666c79@kernel.org>
In-Reply-To: <20200221144853.GA18153@willie-the-truck>
References: <20200221114404.14641-1-will@kernel.org>
        <20200221232746.6eb84111a0d385bed71613ff@kernel.org>
        <20200221144853.GA18153@willie-the-truck>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 14:48:54 +0000
Will Deacon <will@kernel.org> wrote:

> Hi Masami,
> 
> On Fri, Feb 21, 2020 at 11:27:46PM +0900, Masami Hiramatsu wrote:
> > On Fri, 21 Feb 2020 11:44:01 +0000
> > Will Deacon <will@kernel.org> wrote:
> > > Despite having just a single modular in-tree user that I could spot,
> > > kallsyms_lookup_name() is exported to modules and provides a mechanism
> > > for out-of-tree modules to access and invoke arbitrary, non-exported
> > > kernel symbols when kallsyms is enabled.
> > > 
> > > This patch series fixes up that one user and unexports the symbol along
> > > with kallsyms_on_each_symbol(), since that could also be abused in a
> > > similar manner.
> > 
> > What kind of issue would you like to fix with this?
> 
> I would like to avoid out-of-tree modules being easily able to call
> functions that are not exported. kallsyms_lookup_name() makes this
> trivial to the point that there is very little incentive to rework these
> modules to either use upstream interfaces correctly or propose functionality
> which may be otherwise missing upstream. Both of these latter solutions
> would be pre-requisites to upstreaming these modules, and the current state
> of things actively discourages that approach.
> 
> The background here is that we are aiming for Android devices to be able
> to use a generic binary kernel image closely following upstream, with
> any vendor extensions coming in as kernel modules. In this case, we
> (Google) end up maintaining the binary module ABI within the scope of a
> single LTS kernel. Monitoring and managing the ABI surface is not feasible
> if it effectively includes all data and functions via kallsyms_lookup_name().
> Of course, we could just carry this patch in the Android kernel tree,
> but we're aiming to carry as little as possible (ideally nothing) and
> I think it's a sensible change in its own right. I'm surprised you object
> to it, in all honesty.
> 
> Now, you could turn around and say "that's not upstream's problem", but
> it still seems highly undesirable to me to have an upstream bypass for
> exported symbols that isn't even used by upstream modules. It's ripe for
> abuse and encourages people to work outside of the upstream tree. The
> usual rule is that we don't export symbols without a user in the tree
> and that seems especially relevant in this case.

So this is to officially states our policy that if out-of-tree driver
developers need some symbol exposed, they should work with  upstream to
find better solution. Not for fixing some kind of security hole.

> > There are many ways to find (estimate) symbol address, especially, if
> > the programmer already has the symbol map, it is *very* easy to find
> > the target symbol address even from one exported symbol (the distance
> > of 2 symbols doesn't change.) If not, they can use kprobes to find
> > their required symbol address. If they have a time, they can use
> > snprintf("%pF") to search symbol.
> 
> I would say that both of these are inconvenient enough that the developer
> would think twice before considering to use them in production.

Fair enough.

> 
> > So, for me, this series just make it hard for casual developers (but
> > maybe they will find the answer on any technical Q&A site soon).
> 
> Which casual developers? I don't understand who you're referring to here.
> Do you have a specific example in mind?

No, I don't. :)

> 
> > Hmm, are there other good way to detect such bad-manner out-of-tree
> > module and reject them? What about decoding them and monitor their
> > all call instructions? 
> 
> That sounds like using a sledge hammer to crack a nut to me.

Agreed. Just for discouraging abuse of unexposed symbols, I think this is
enough.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for thise series.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
