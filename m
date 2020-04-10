Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A8AC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D0207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gug0M9Uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJRAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:00:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58712 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJRAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oUKFqLg3+HDFm2vs2QWf5wGOnTF90+YW2FpbPNodGzs=; b=Gug0M9UyuSpEBsOoExHvkg79nj
        RraZD7s/HpjWHeZhbOm1BTN9DBDiI2Isn1+bvmxmTSDIrbX8CQXtqQh3YB3OwGB7+l/o9XGoDoWCC
        pRm39IUagOU54lOG36W8XUoJ/UXPMnC67Qf+gqMTWNVdbv/3Bt5Fjum7MZRraqCdCQCI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jMx0O-001zrZ-H4; Fri, 10 Apr 2020 18:59:48 +0200
Date:   Fri, 10 Apr 2020 18:59:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jian Cai <caij2003@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, Peter.Smith@arm.com,
        stefan@agner.ch, David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        manojgupta@google.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux@googlegroups.com, ilie.halip@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        samitolvanen@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        jiancai@google.com, Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200410165948.GD448831@lunn.ch>
References: <20200409232728.231527-1-caij2003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409232728.231527-1-caij2003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:27:26PM -0700, Jian Cai wrote:
> iwmmxt.S contains XScale instructions

Dumb question....

Are these Xscale instructions? My understanding is that they are an
instruction set of their own, implementing something similar to IA-32
MMX. 

Would it be more accurate to say CLANG does not support the iwmmxt
instruction set?

	    Andrew
