Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E348C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A4C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgDWGI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:08:29 -0400
Received: from verein.lst.de ([213.95.11.211]:56104 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWGI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:08:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF29E227A81; Thu, 23 Apr 2020 08:08:25 +0200 (CEST)
Date:   Thu, 23 Apr 2020 08:08:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200423060825.GA9824@lst.de>
References: <20200422214751.GJ26846@zn.tnic> <462564C5-1F0F-4635-AAB8-7629A6379425@lca.pw> <20200422220512.GK26846@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220512.GK26846@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:05:12AM +0200, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 05:57:09PM -0400, Qian Cai wrote:
> > I thought Christ is going to send some minor updates anyway, so it may
> > be better for him to include this one together? Otherwise, I am fine to
> > send this one standalone.
> 
> You mean Christoph.
> 
> Ok, I'll let you guys hash it out.

I can send one, but given that Qian found it and fixed it I'd have
to attribute it to him anyway :)

This assumes you don't want a complete resend of the series, of course.
