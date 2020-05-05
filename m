Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F5C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9380B207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588691517;
	bh=QuX9vn31uQ/v8nykk4K4lR23eNtpDJLWEZk/rfaSGII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CZYNhzPpnWwnqOEHis6MCM5y4v+JkJN7jlDGrmW2RYH/94mLsYCvaU2xRJ12XuWeS
	 WXcvy5DAPZ8qyi7xUlSRMc6om/29uw03qybioD32ya1vpYeyjM8iuJbcCuNOH8Bv5m
	 QkvYxBqEe04MKeobayWd95TOyyRy926W9Ijk3EFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgEEPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbgEEPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:11:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8050B2078D;
        Tue,  5 May 2020 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588691515;
        bh=QuX9vn31uQ/v8nykk4K4lR23eNtpDJLWEZk/rfaSGII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbxK4diAUXU6Dx3LzLM/VkDX6SbjoytcJwqeWq5zBH1RodT/oKqvPQckgAS/Frmu1
         0Szq2BMamAqpu7uF35mVfnJdg0y6qLRCtPOfsWgGQcadDbRGtzg5OEtD5ar+QOBik1
         HJ+SVXOr7Pu8hf6vgxl3Ntt1QLBPhh0yBoWtWa0w=
Date:   Tue, 5 May 2020 16:11:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix section mismatch for
 __write_once_size/blacklisted_initcalls
Message-ID: <20200505151150.GD24239@willie-the-truck>
References: <20200505141137.665940-1-arnd@arndb.de>
 <CANpmjNNwgkVR6kjFudrR4ga--PigU5Mx69HZ1mhCAQ0GCLqQGg@mail.gmail.com>
 <CAK8P3a3r35VrKVfpn_q2YYhxkvH9j0+3MnMqgRM6R=QOcsE96Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3r35VrKVfpn_q2YYhxkvH9j0+3MnMqgRM6R=QOcsE96Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:05:36PM +0200, Arnd Bergmann wrote:
> On Tue, May 5, 2020 at 4:17 PM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> > On Tue, 5 May 2020 at 16:11, Arnd Bergmann <arnd@arndb.de> wrote:
> > > So far, my randconfig checks found two such instances, one for read_once
> > > and one for write_once. There are probably a couple more in random
> > > configurations, but I guess they are rare enough that we can just work
> > > around them like this.
> >
> > [+Cc Will]
> >
> > Thanks for testing and fixing this. Note that this may no longer be
> > necessary once Will's patches land. Also noted here:
> > https://lkml.kernel.org/r/CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com
> >
> > For reference, Will's series:
> > https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org/
> 
> Right, good point. If that is going to get merged for the same release, we don't
> need my workarounds and I'll just keep them applied locally in my linux-next
> randconfig tree for the moment.

I'll send out a new version based on the kcsan stuff this week, so fingers
crossed for 5.8!

Will
