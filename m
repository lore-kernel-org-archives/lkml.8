Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F1AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE3620719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCZVyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:54:31 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:49504 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgCZVyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:54:31 -0400
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 6847934F9E4;
        Thu, 26 Mar 2020 21:54:28 +0000 (UTC)
Date:   Thu, 26 Mar 2020 21:54:24 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200326215424.5f1851f3@sf>
In-Reply-To: <20200325133137.GC27261@zn.tnic>
References: <20200314164451.346497-1-slyfox@gentoo.org>
        <20200316130414.GC12561@hirez.programming.kicks-ass.net>
        <20200316132648.GM2156@tucnak>
        <20200316134234.GE12561@hirez.programming.kicks-ass.net>
        <20200316175450.GO26126@zn.tnic>
        <20200316180303.GR2156@tucnak>
        <20200317143602.GC15609@zn.tnic>
        <20200317143914.GI2156@tucnak>
        <20200317144942.GE15609@zn.tnic>
        <20200325133137.GC27261@zn.tnic>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 14:31:37 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 17, 2020 at 03:49:42PM +0100, Borislav Petkov wrote:
> > On Tue, Mar 17, 2020 at 03:39:14PM +0100, Jakub Jelinek wrote:  
> > > That is because the option is called -fno-stack-protector, so one needs to
> > > use __attribute__((optimize("no-stack-protector")))  
> > 
> > Ha, that works even! :-)
> > 
> > And my guest boots.
> > 
> > I guess we can do that then. Looks like the optimal solution to me.
> > 
> > Also, I'm assuming older gccs will simply ignore unknown optimize
> > options?  
> 
> Sergei,
> 
> wanna send v2 where you add the function attribute to start_secondary()
> only instead?

Will attempt to write, test and send out the patch by tomorrow.

-- 

  Sergei
