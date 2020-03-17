Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A275DC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350D20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCQSKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:10:25 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42580 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQSKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:10:25 -0400
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 913C434F0C3;
        Tue, 17 Mar 2020 18:10:22 +0000 (UTC)
Date:   Tue, 17 Mar 2020 18:10:16 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200317181016.0b39bf91@sf>
In-Reply-To: <20200317114605.GG2156@tucnak>
References: <20200314164451.346497-1-slyfox@gentoo.org>
        <20200316130414.GC12561@hirez.programming.kicks-ass.net>
        <20200316132648.GM2156@tucnak>
        <20200316221251.7b4f5801@sf>
        <20200317114605.GG2156@tucnak>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 12:46:05 +0100
Jakub Jelinek <jakub@redhat.com> wrote:

> So, a few comments.
> 
> One thing I've noticed in the command line is that
> --param=allow-store-data-races=0
> got dropped.  That is fine, the parameter is gone, but it has been replaced
> in https://gcc.gnu.org/PR92046 by the
> -fno-allow-store-data-races
> option.  Like the param which defaulted to 0 and has been enabled only with
> -Ofast this option is also -fno-allow-store-data-races by default unless
> -Ofast, but if kernel wanted to be explicit or make sure not to introduce
> them even with -Ofast, I'd say it should:
>  # Tell gcc to never replace conditional load with a non-conditional one
>  KBUILD_CFLAGS   += $(call cc-option,--param=allow-store-data-races=0)
> +KBUILD_CFLAGS   += $(call cc-option,-fno-allow-store-data-races)
> in the toplevel Makefile.

Yeah, I noticed it yesterday as well and sent out exactly the same change:
    https://lkml.org/lkml/2020/3/16/1012
I also checked that flag does not change code generation on -O2 for smpboot.c

-- 

  Sergei
