Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F90C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4185A20B1F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586587508;
	bh=znAsD9ps7oDDk3limhQCe43kEVC1W33bGHaH2m8vpzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1p4d0oxz7hzwMX6339A/dU+msrIhAS2rmqq5sJv84OZ0biH+nwuuRjDH9KQhJYuC
	 N8EDMtP3lRwWrSPb53GH1hfQP8I5QpfM0zhx5k3bQZDFYTQUXtlGtEiP5bzw9U3QRH
	 xywC7ZK7nPUiee9j0+XeCiEKjCt7+Sq2JadluoHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDKGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 02:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgDKGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:45:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DB52083E;
        Sat, 11 Apr 2020 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586587506;
        bh=znAsD9ps7oDDk3limhQCe43kEVC1W33bGHaH2m8vpzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgp8d/M9oJn340VeC03FpvnWg6l8zX4UU79E8hmo0qIku3qF4W3D56X56uj5jjzoA
         RIlO2vokYVHGA4Nt88I26b4oZ4I80kY1hTCmDRbFNaYvYbUZB0WS0U0Q8TFVfs8w4m
         Tg218zi5UcY4Vmy5ade7JSr9YMT0AeSTbC7/Qtx0=
Date:   Sat, 11 Apr 2020 08:45:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 8/9] block: genhd: export-GPL generic disk device type
Message-ID: <20200411064503.GA2576039@kroah.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
 <20200409193543.18115-9-mathieu.desnoyers@efficios.com>
 <20200410063357.GA1663942@kroah.com>
 <20200410114444.73be173a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410114444.73be173a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 11:44:44AM -0400, Steven Rostedt wrote:
> On Fri, 10 Apr 2020 08:33:57 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > I understand your need here, however we do not export things for
> > modules, when there are no in-kernel module users, sorry.
> 
> This "we don't cater to out-of-tree modules" even when they are GPL seems
> to always baffle me. Especially since we have a high bar of accepting out
> of tree modules especially if they duplicate some functionality of an
> existing infrastructure of the kernel. I like choice, and coming from
> someone that spent over a decade working on code that has been out of tree,
> I'm a little sympathetic to the cause ;-)

We can't do anything for out-of-tree modules as they suddenly become
"higher priority" than in-tree code if you have to not do specific
changes or extra work for them.  Which is not fair at all to the in-tree
code developers at all.

With drivers/staging/ we removed the barrier for accepting any license
compliant driver, so that solved the huge majority of these issues.

> I guess we should be open to allowing LTTng modules in the kernel as well,
> even though it is yet another tracing framework. It's not like its going
> away. And perhaps by doing so, ftrace and perf could start taking advantage
> of anything that LTTng brings.

That is up to you all, as you are the one preventing this from being
merged in the tree, not me :)

Again, don't make us do _more_ work for out-of-tree modules than we do
for in-tree modules, that's just crazy to expect.

thanks,

greg k-h
