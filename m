Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65190C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C3421556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578885406;
	bh=3zYO/LV7CNbRZmQEB1qLQGLItuEsGDzoXBLkzEVNe2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mdJbYFnJlRCAsaZWAG1QwJx7nHZnzXFtpV5bOI4lWnqmNVMVfH9TqLZheLorWwohE
	 vC0RbTFzPYACqCnqDl37gDEPHUWVFLMXFoc/ox0Pvx6j91FO0tCBtIoNDE4VlBgCCo
	 lnrC5KsMUCmg6oO80LsaOCSu2RYhMGdiVSnPrxso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbgAMDQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732961AbgAMDQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:16:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B025721556;
        Mon, 13 Jan 2020 03:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578885404;
        bh=3zYO/LV7CNbRZmQEB1qLQGLItuEsGDzoXBLkzEVNe2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RCdMxJUOUJEUP6ZUIV4gkd0trBnyqFBTGpbWavtcwtLwkOB8MXaEFeJ3rAwHW6SAh
         BVmV/1FnfE9vhJDJtPEo1A9BwKoH+PYD0Ob2nYi3IxYH3Er8nN1pKfhOde6flu8GYe
         dY1HHkqDJzlAqqI0qXTA6vhjyBUAPpyuDy0P0A/Q=
Date:   Mon, 13 Jan 2020 12:16:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20200113121640.bfab48c105dae9b1918c2d82@kernel.org>
In-Reply-To: <20200112020537.GJ128013@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
        <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
        <20200107211535.233e7ff396f867ee1348178b@kernel.org>
        <20200110211438.GE128013@google.com>
        <20200111083507.c32b85b1d47aa69928de530b@kernel.org>
        <20200112020537.GJ128013@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2020 21:05:37 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Sat, Jan 11, 2020 at 08:35:07AM +0900, Masami Hiramatsu wrote:
> > Hi Joel and Paul,
> > 
> > On Fri, 10 Jan 2020 16:14:38 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Tue, Jan 07, 2020 at 09:15:35PM +0900, Masami Hiramatsu wrote:
> > > > Hello,
> > > > 
> > > > Anyone have any comment on this series?
> > > > Without this series, I still see the suspicious RCU warning for kprobe on -tip tree.
> > > 
> > > +Paul since RCU.
> > > 
> > > Hi Masami,
> > > 
> > > I believe I had commented before that I don't agree with this patch:
> > > https://lore.kernel.org/lkml/157535318870.16485.6366477974356032624.stgit@devnote2/
> > > 
> > > The rationale you used is to replace RCU-api with non-RCU api just to avoid
> > > warnings. I think a better approach is to use RCU api and pass the optional
> > > expression to silence the false-positive warnings by informing the RCU API
> > > about the fact that locks are held (similar to what we do for
> > > rcu_dereference_protected()). The RCU API will do additional checking
> > > (such as making sure preemption is disabled for safe RCU usage etc) as well.
> > 
> > Yes, that is what I did in [1/2] for get_kprobe().
> > Let me clarify the RCU list usage in [2/2].
> > 
> > With the careful check, other list traversals never be done in non-sleepable
> > context, those are always runs with kprobe_mutex held.
> > If I correctly understand the Documentation/RCU/listRCU.rst, we should/can use
> > non-RCU api for those cases, or do I miss something?
> 
> Yes, that is fine. However personally I prefer not to mix usage of
> list_for_each_entry_rcu() and list_for_each_entry() on the same pointer
> (kprobe_table). I think it is more confusing and error prone. Just use
> list_for_each_entry_rcu() everywhere and pass the appropriate lockdep
> expression, instead of calling lockdep_assert_held() independently. Is this
> not doable?

Hmm, but isn't it more confusing that user just take a mutex but
no rcu_read_lock() with list_for_each_entry_rcu()? In that case,
sometimes it might sleep inside list_for_each_entry_rcu(), I thought
that might be more confusing mind model for users...

Anyway, if so, please update Documentation/RCU/listRCU.rst too.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
