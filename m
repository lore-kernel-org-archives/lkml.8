Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A4C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6F220714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgC2Vmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:42:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41767 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727370AbgC2Vmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:42:39 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02TLgFDb018135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Mar 2020 17:42:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E7763420EBA; Sun, 29 Mar 2020 17:42:14 -0400 (EDT)
Date:   Sun, 29 Mar 2020 17:42:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 00/52] Audit kernel random number use
Message-ID: <20200329214214.GB768293@mit.edu>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
 <20200329174122.GD4675@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329174122.GD4675@SDF.ORG>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 05:41:22PM +0000, George Spelvin wrote:
> > Using xor was particularly stupid.
> > The whole generator was then linear and trivially reversable.
> > Just using addition would have made it much stronger.
> 
> I considered changing it to addition (actually, add pairs and XOR the 
> sums), but that would break its self-test.  And once I'd done that,
> there are much better possibilities.
> 
> Actually, addition doesn't make it *much* stronger.  To start
> with, addition and xor are the same thing at the lsbit, so
> observing 113 lsbits gives you a linear decoding problem.

David,

If anyone is trying to rely on prandom_u32() as being "strong" in any
sense of the word in terms of being reversable by attacker --- they
shouldn't be using prandom_u32().  That's going to be true no matter
*what* algorithm we use.

Better distribution?  Sure.  Making prandom_u32() faster?  Absolutely;
that's its primary Raison d'Etre.

George,

Did you send the full set of patches to a single mailing list?  Or can
you make it available on a git tree somewhere?  I've y seen this
message plus the ext4 related change, and I can't find the full patch
series anywhere.  If you can send the next version such that it's
fully cc'ed to linux-kernel, that would be really helpful.

Thanks!!

						- Ted
