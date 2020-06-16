Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724962074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFPLrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D1F7ADD3;
        Tue, 16 Jun 2020 11:47:07 +0000 (UTC)
Date:   Tue, 16 Jun 2020 13:47:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 18/24] dyndbg: allow negating flag-chars in modflags
Message-ID: <20200616114702.GM31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-19-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-19-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:32, Jim Cromie wrote:
> Extend flags modifications to allow [PFMLTU] negating flags.
> This allows control-queries like:
> 
>   #> Q () { echo file inode.c $* > control } # to type less
>   #> Q -P	# same as +p
>   #> Q +U	# same as -u
>   #> Q u-P	# same as u+p
> 
> This allows flags in a callsite to be simultaneously set and cleared,
> while still starting with the current flagstate (with +- ops).
> 
> Using filter-flags with negating-flags, you can select exactly the
> flagstates you want, both required and prohibited.
> 
> Then with negating-flags in modflags, you can set and clear every flag
> 
>   #> Q umfLT-Pmf  # select sites with u,m,f only. enable print, turn off m,f leave u
> 
> Its not an important feature, but it does fill out the logic.
> and the patch is tiny, and feels more symmetrical.

I do not think that it is a good idea.

Many people do not like perl because it allows to do the same thing
many ways. The result is that the code is hard to read. There are too
many coding styles and tricks to understand.

Best Regards,
Petr
