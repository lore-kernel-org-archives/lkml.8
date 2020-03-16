Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A0620663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgCPPjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:39:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:44987 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731703AbgCPPjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:39:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jDrpX-0008Kq-01; Mon, 16 Mar 2020 16:39:03 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 79690C107B; Mon, 16 Mar 2020 16:32:02 +0100 (CET)
Date:   Mon, 16 Mar 2020 16:32:02 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2] MIPS: pass non-NULL dev_id on shared request_irq()
Message-ID: <20200316153202.GB13674@alpha.franken.de>
References: <20200304203144.GA4323@alpha.franken.de>
 <20200305115759.3186-1-afzal.mohd.ma@gmail.com>
 <20200311053126.GA48442@ubuntu-m2-xlarge-x86>
 <20200311090308.GA5060@afzalpc>
 <20200311104217.GA10615@alpha.franken.de>
 <20200311131210.GA5115@afzalpc>
 <20200311160307.GA15464@alpha.franken.de>
 <20200311163249.GA4984@afzalpc>
 <20200313121138.GA5985@afzalpc>
 <20200314081312.GA4948@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314081312.GA4948@afzalpc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 01:43:12PM +0530, afzal mohammed wrote:
> Recently all usages of setup_irq() was replaced by request_irq().
> request_irq() does a few sanity checks that were not done in
> setup_irq(), if they fail irq registration will fail. One of the check
> is to ensure that non-NULL dev_id is passed in the case of shared irq.
> This caused malta on qemu to hang.
> 
> Fix it by passing handler as dev_id to all request_irq()'s that are
> shared. For sni, instead of passing non-NULL dev_id, remove shared irq
> flags.
> 
> Fixes: ac8fd122e070 ("MIPS: Replace setup_irq() by request_irq()")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

thank you, applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
