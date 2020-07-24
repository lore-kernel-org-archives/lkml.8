Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5BA2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGXSPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B570AAC7;
        Fri, 24 Jul 2020 18:15:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D048CDA701; Fri, 24 Jul 2020 20:14:53 +0200 (CEST)
Date:   Fri, 24 Jul 2020 20:14:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
Message-ID: <20200724181453.GH3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724174130.GC23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724174130.GC23808@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:41:30PM +0100, Matthew Wilcox wrote:
> I think we're all pretty comfortable seeing function names adorned with
> a closing pair of parens.  The ``...`` to adorn constants feels OK to me,
> but maybe not to you?  If that feels excessive, can you suggest something
> that would distinguish between POSIX and AT_EMPTY_PATH?
> 
> [1] Too far being a subjective measure, of course.  My preferences
> are on display in core-api/xarray.rst

I like that minimalistic style and I'd suggest to use the quotes only
for the document-specific definitions, eg. the XA_ macros, and drop
quotes around NULL or other standard macros like LONG_MAX.  The quotes
are hilighted in vim and seeing NULL is actually distracting.

Functions get automatically converted to html links so this does not
need to be explicitly quoted, but similar to wikipedia style, the first
mention could be quoted to provide a visual anchor.
