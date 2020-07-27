Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD125C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9338820658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="doOwxC6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgG0GzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:55:18 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:42308 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0GzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595832917; x=1627368917;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=F4nrWb46+F82CGnixn7vHzgAFJZuoBowfQIpFizN/9Q=;
  b=doOwxC6G3f6BVqRlis+9F2aNyn8PzxTWjI8LALu2+wqZZobUqY598cCG
   ozLfClA2SgxXYTIm693446Vgbx4RAYjVcakaatQ2QO/BufwRrhJHKKVID
   N1alg+woW+dwoalGwzYan/jeQ+v8Ahd/Ct//kVUjQZZDucZbmb6tt9ck4
   c=;
IronPort-SDR: oAYr3MeI/0Y71RZSYQhW2jey6EpHt3/1WwiWFS2/v8Q4tdDQ4hki/stH631pt3wA9Ftbbks6EM
 8UVfYPaqHSOA==
X-IronPort-AV: E=Sophos;i="5.75,401,1589241600"; 
   d="scan'208";a="44281433"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 27 Jul 2020 06:55:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 4EC0EA20CF;
        Mon, 27 Jul 2020 06:55:11 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 06:55:11 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 06:55:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
CC:     SeongJae Park <sj38.park@gmail.com>, Joe Perches <joe@perches.com>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <apw@canonical.com>,
        <colin.king@canonical.com>, <jslaby@suse.cz>, <pavel@ucw.cz>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: checkpatch: support deprecated terms checking
Date:   Mon, 27 Jul 2020 08:54:41 +0200
Message-ID: <20200727065441.27164-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200726203328.GA8321@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D31UWC001.ant.amazon.com (10.43.162.152) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 22:33:28 +0200 "Michał Mirosław" <mirq-linux@rere.qmqm.pl> wrote:

> On Sun, Jul 26, 2020 at 08:07:48PM +0200, SeongJae Park wrote:
> > On Sun, 26 Jul 2020 09:42:06 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Sun, 2020-07-26 at 17:36 +0200, SeongJae Park wrote:
> > > > On Sun, 26 Jul 2020 07:50:54 -0700 Joe Perches <joe@perches.com> wrote:
> > > []
> > > > > I do not want to encourage relatively inexperienced people
> > > > > to run checkpatch and submit inappropriate patches.
> > > > 
> > > > Me, neither.  But, I think providing more warnings and references is better for
> > > > that.
> > > 
> > > Unfortunately, the inexperienced _do_ in fact run
> > > checkpatch on files and submit inappropriate patches.
> > > 
> > > It's generally a time sink for the experienced
> > > maintainers to reply.
> > > 
> > > > Simply limiting checks could allow people submitting inappropriate patches
> > > > intorducing new uses of deprecated terms.
> > > 
> > > Tradeoffs...
> > > 
> > > I expect that patches being reviewed by maintainers
> > > are preferred over files being inappropriately changed
> > > by the inexperienced.
> > > 
> > > Those inappropriate changes should not be encouraged
> > > by tools placed in the hands of the inexperienced.
> > 
> > Right, many things are tradeoff.  Seems we arrived in the point, though we
> > still have different opinions.  To summarize the pros and cons of my patch from
> > my perspective:
> > 
> > Pros 1: Handle future terms deprecated with different reasons and coverages.
> > Pros 2: Inappropriate patches are avoided if the submitters carefully read the
> > warning messages.
> > Cons: Careless people could still bother maintainers by not carefully reading
> > the message and sending inappropriate patches.
> > 
> > To me, the pros still seems larger than the cons.  I would like to also again
> > mention that the maintainer who first reported the problem, Michal, told it's
> > ok with the explicit messaging.  Nonethelss, this is just my opinion.
> > 
> > Attaching the patch addressing your comments for the previous version.  The
> > changes from the previous version are:
> > 
> >  - Make the name of reported terms not too verbose
> >  - Avoid unnecessary initialization of the reported terms hash
> >  - Warn multiple deprecated terms in same line
> 
> Hi,
> 
> Maybe you could split the meaning of --subjective and --strict, and
> enable those checks only for --subjective? The test is really hard to do
> right: you would have to consider the context and not only mere occurrence
> of a word (heh, I even wrote 'blacklisted' here, since it really is about
> a night/danger analogy and not political/ethical one).

I'm concerning if applying the switch and making this patch non-default could
reduce the check coverage.  Moreover, IMHO, the deprecation rule of the terms
that described in the 'coding-style.rst' is not so subjective but clear.  Also,
the checkpatch's warning/check message for those seems explicit enough to me.

And, the deprecated terms feature is not for this specific terms
(master/slave/blacklist/whitelist) only but general deprecated terms.  Maybe we
could add one more rule in the 'deprecated_terms.txt' by adding a comment, say,
"Please add only terms that deprecated with clear rules", for avoiding
introduce of subjective deprecated terms in future, though.


Thanks,
SeongJae Park

> 
> Best Regards,
> Michał Mirosław
