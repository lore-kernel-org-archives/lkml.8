Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF8C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCA824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582079217;
	bh=Cj5wtHSQTHs0MGIuBG0BGGIOlWVFaLueuVHj9Y7gXp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mJ4aXH0Bq3rezEo9y2++BHR5BgS/Qv+8qNoGUjZfgGTuiUZeFWKPoIko7Yn8cGjUg
	 JGSC/betRHFLhN736gSkAaiAIf0m/AFRq9xyv9z3IGEIkrX9cFDbshCkY50wOclMcf
	 sGCxIPa4G72OxyfnHXMWmEvSVlmTQJk0repVMeA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBSC04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgBSC0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:26:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA3124655;
        Wed, 19 Feb 2020 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582079215;
        bh=Cj5wtHSQTHs0MGIuBG0BGGIOlWVFaLueuVHj9Y7gXp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9MB2io/vRu6ZJt4lRUNAnXUtJfpbrMiezxwIJiK9pd+84+Jg3BBsUCaXm/IGc+L4
         /brvI5NHrH/4fMEYRHJuD9rd1Nin/AJcejRB3DDitN/jq+L60SwUbYXB5r1zPC5Q9x
         Wgyv0THxIoYMhe4gpM7zWOKOu+BpmkaPphO4fys8=
Date:   Wed, 19 Feb 2020 11:26:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200219112651.ea5d46978b79a33566660d8f@kernel.org>
In-Reply-To: <20200218193850.GM14449@zn.tnic>
References: <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
        <20200211001007.62290c743e049b231bdd7052@kernel.org>
        <20200210174053.GD29627@zn.tnic>
        <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
        <20200218132724.GC14449@zn.tnic>
        <20200218125748.5085929c@gandalf.local.home>
        <20200218193850.GM14449@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 20:38:50 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 18, 2020 at 12:57:48PM -0500, Steven Rostedt wrote:
> > OK, what if we put it as default 'n' but we still check if "bootconfig"
> > is on the command line. And if it is, we warn with something like:
> > 
> > #ifndef CONFIG_BOOTCONFIG
> > 	pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set in this kernel\n");
> > #endif
> 
> Sure, makes sense to me. And all the code that requires it, can simply
> select BOOTCONFIG.

OK, so I'll update it.

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
