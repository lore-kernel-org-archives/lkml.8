Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD76C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7423A206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dzxd7eN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbgDMVBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:01:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57998 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbgDMVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ws2nR0EpxKl2RJkJk3e0Vaf6eTLG8ASGEhenXWS4AfY=; b=Dzxd7eN4Q7tKI7wkTM+04sKxs
        5Tv2wkNSh4cyWzjeq8y4LGxAKRKEvWAeUXH+MGKS+rVoVfeZQkGQL9TZoeyw9gY6q85Sq4NWuAVKo
        2fo03TIBlIr/qc/AIvuRzJXycJuL1e4BAT0zzb1M+8cOnj7Z+Neg/YAtFHQEZbqQxAgdR2MSDyEBE
        cSMTbfuKCJ+Z4ndEQm5fQo7zmDxg75ugA+PkjkCKEHD9cSVcRrMa+9IAGMnmQi0mf7lVHx9EpDezD
        VmeiH0S0sd+8T0DlkVNUMcYuuU0YWZ5ieoYqAuiaZ+BuGGA1Q8qeXsKqW86nm2rFDA45xYxbXAEyz
        ha2KBtFgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49652)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jO6CQ-0003wo-Gw; Mon, 13 Apr 2020 22:00:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jO6CH-0007Ht-8g; Mon, 13 Apr 2020 22:00:49 +0100
Date:   Mon, 13 Apr 2020 22:00:49 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jian Cai <caij2003@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200413210049.GQ25745@shell.armlinux.org.uk>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk>
 <CAKwvOd=-u3grX3O4CtBayJYhv=mmsxMrRTF=AMcKMbphN5Xkgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=-u3grX3O4CtBayJYhv=mmsxMrRTF=AMcKMbphN5Xkgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:23:38PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 10, 2020 at 5:33 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > For older CPUs, it doesn't matter what the latest ARM ARM says, the
> > appropriate version of the ARM ARM is the one relevant for the CPU
> > architecture.  This is a mistake frequently made, and it's been pointed
> > out by Arm Ltd in the past (before ARMv6 even came on the scene) that
> > keeping older revisions is necessary if you want to be interested in
> > the older architectures.
> 
> As if it never existed *waves hands*.  Interesting.  Does ARM still
> distribute these older reference manuals? Do you keep copies of the
> older revisions?

I keep copies of every document I've needed that I'm allowed to keep
as a general rule, including the early paper copies of the ARM
architecture reference manual. I even have the original VLSI ARM2
databook.

For the ARMv5TE architecture, you're looking for DDI0100E which can be
found via google.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
