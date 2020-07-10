Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7212920787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594362481;
	bh=H0eG/s1lyQ6sGKykTdhmRGHO9rgBoUeZDW5jJ3sAsmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gLsM+WqCwsIfpwHgBg75GWVFevTe4OvTFFHy4um2jpSIgMXuagfszlpytAAy7gRHl
	 ZO5KtSGrx9eHlE6cydCQ5jNCQlSZAALbLaeo4RnvMWWDGHyELDY3P77YXWZpvAivYh
	 nl/IPAeb5ZjIdqpwVGnjbdmsy/v79Hfk8zq9Zmmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:27:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA672072E;
        Fri, 10 Jul 2020 06:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594362478;
        bh=H0eG/s1lyQ6sGKykTdhmRGHO9rgBoUeZDW5jJ3sAsmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txiTPIjP7EudtwFFn2YASO02jf6cgq/0rtL5MoTYHZAIdyuF4w0LA9lL93NoFVq9Z
         LZGcvlkTF3hScD2f6C2C5Wea2oJGht379bfES+OFi4ulUp5FNwovbNxDFVnkPqwjH4
         hBnrMQ+ZJy7bLi8Q3iET28YzUrjvicIXswH/LVe4=
Date:   Fri, 10 Jul 2020 08:28:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200710062803.GA1071395@kroah.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> Hello folks,
> I'm working on putting together an LLVM "Micro Conference" for the
> upcoming Linux Plumbers Conf
> (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> solidified yet, but I would really like to run a session on support
> for Rust "in tree."  I suspect we could cover technical aspects of
> what that might look like (I have a prototype of that, was trivial to
> wire up KBuild support), but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"
> 
> Question to folks explicitly in To:, are you planning on attending plumbers?
> 
> If so, would this be an interesting topic that you'd participate in?

Yes, I'll be there.

thanks,

greg k-h
