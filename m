Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59361C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3174E2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j5XLF8dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGHJ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:28:39 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4568 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgGHJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594200519; x=1625736519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=8k3xFwcl091/kPsNDU+9a7EfmTo6sVful4WNwv2afEU=;
  b=j5XLF8dngnCLNghKfgoMvhgZx+vaZOswGxkjB762qawQ1jBP1MR7vysk
   fx8VHjgOW8jrCkPrII1NMJEnhJpAdevonbs5nc/rX8CTHkvhRDzZn7y6W
   TtcL1Jr+GTKjjpII0YXVrkkOl9Vgj6eyOUZe4VuOnlhh9m3CWqh3/BnC9
   8=;
IronPort-SDR: F5GDwFAxe1rmJcOwvffYYXyTVHsCSC8yIpnynXc9Fpr3OobacI/7ZdU89zj/U5Qdk3ASRwRwQE
 xBBIN5+og0Og==
X-IronPort-AV: E=Sophos;i="5.75,327,1589241600"; 
   d="scan'208";a="42112907"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 08 Jul 2020 09:28:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 15CA6A322B;
        Wed,  8 Jul 2020 09:28:35 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Jul 2020 09:28:34 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Jul 2020 09:28:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Date:   Wed, 8 Jul 2020 11:28:12 +0200
Message-ID: <20200708092812.15647-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPcyv4ggm50tMnaCtMZJRz0j6ZO15buNUmTfk4sLf3AYkxS12w@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D47UWA004.ant.amazon.com (10.43.163.47) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 00:12:03 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Jul 6, 2020 at 11:56 PM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > Hello,
> >
> > On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > Recent events have prompted a Linux position statement on inclusive
> > > terminology. Given that Linux maintains a coding-style and its own
> > > idiomatic set of terminology here is a proposal to answer the call to
> > > replace non-inclusive terminology.
> >
> > I'm glad to see this patch.
> >
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Chris Mason <clm@fb.clm>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> >
> > > ---
> > >  Documentation/process/coding-style.rst          |   12 ++++
> > >  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
> > >  Documentation/process/index.rst                 |    1
> > >  3 files changed, 77 insertions(+)
> > >  create mode 100644 Documentation/process/inclusive-terminology.rst
> > >
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index 2657a55c6f12..4b15ab671089 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
> > >  problem, which is called the function-growth-hormone-imbalance syndrome.
> > >  See chapter 6 (Functions).
> > >
> > > +For symbol names, avoid introducing new usage of the words 'slave' and
> > > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> > > +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> > > +'denylist'.
> >
> > I have submitted a couple of patches for automated encouragement of the the
> > inclusive terms and those merged in the -next tree[1,2] now.  Nonetheless, the
> > version says only "please consider using 'denylist' and 'allowlist' instead of
> > 'blacklist' and 'whitelist'" for now.  I think we could add more terms in there
> > based on this discussion.  I could do that after this patch is merged, or you
> > could do that yourself in the next spin of this patch.  Please do whatever you
> > feel comfort.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7d0bea01dec27195d95d929c1ee49a4a74dd6671
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=95a94258ceb27052f00b7e51588a128d20bf05ed
> >
> 
> Thank you for stepping up to take this on, much appreciated.
> 
> I think I'll leave it to you to fixup checkpatch after the final
> version of this patch is merged. It may be as simple as "See section 4
> 'Naming' in coding-style for suggested replacements".

Agreed, I will do that :)


Thanks,
SeongJae Park
