Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BA5208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFZLoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:44:46 -0400
Received: from 8bytes.org ([81.169.241.247]:50258 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFZLoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:44:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E39DE391; Fri, 26 Jun 2020 13:44:44 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:44:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joerg Roedel <jroedel@suse.de>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Message-ID: <20200626114443.GS3701@8bytes.org>
References: <20200626093450.27741-1-joro@8bytes.org>
 <20200626110731.GC4817@hirez.programming.kicks-ass.net>
 <20200626111711.GO14101@suse.de>
 <20200626113101.GG4817@hirez.programming.kicks-ass.net>
 <20200626113215.GG117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626113215.GG117543@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:32:15PM +0200, Peter Zijlstra wrote:
> That is, this is boot time only, right? clone() would return -ENOMEM, as
> it's part of the normal page-table copy.

Yes, the pre-allocation happens shortly after the buddy allocator took
over from bootmem. I don't quite get what clone() has to do with it.


	Joerg
