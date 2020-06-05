Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7487EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C7F206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgFEIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:16:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgFEIQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:16:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96884AD18;
        Fri,  5 Jun 2020 08:16:49 +0000 (UTC)
Date:   Fri, 5 Jun 2020 10:16:44 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200605081644.GS6857@suse.de>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:12:14PM -0700, Linus Torvalds wrote:
> That said, the commentary about "why is p.._alloc_track() in such a
> core header file, when it's only used by two special cases" is
> probably still true regardless of the 5-level fixup header.. I assume
> Mike didn't do those kinds of changes?

I'll try to move them to a separate header next week. The compile
testing I set up for this patch-set will certainly be helpful for that
:)


	Joerg

