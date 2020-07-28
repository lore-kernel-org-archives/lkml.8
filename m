Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B320759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F8rY7g61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgG1GX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:23:26 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41846 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgG1GX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595917405; x=1627453405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=8okPtySGftGwivzrsIFuvgY1nXpSgYqqnN7HH+4yeps=;
  b=F8rY7g61zDqWgVjn64Wnoy4G5IBZmYzEsl7dysKUFBDvtSdUKiFFCDs0
   FGNGYsmmuZRNH0K2bVYS/jHA3VUbs14s10r2q6PsoDiJkFHnEdS5MP2S8
   QSzm7vPkOE8tgyTTlWhCHYPQUdW2QPYBy4iJRzGPJtZAPGQuNu1RGtekt
   4=;
IronPort-SDR: 1W1hzCmiN9VvA84NYArEssp07tnIXE32zlilu5/KtH1udAIYxgswP9bF/UN29C4FraW9sapHzO
 D2btav/Vw14A==
X-IronPort-AV: E=Sophos;i="5.75,405,1589241600"; 
   d="scan'208";a="44473091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jul 2020 06:23:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id ACADAA21AA;
        Tue, 28 Jul 2020 06:23:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 06:23:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 06:23:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Joe Perches <joe@perches.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sj38.park@gmail.com>,
        <linux-kernel@vger.kernel.org>, <apw@canonical.com>,
        <colin.king@canonical.com>, <jslaby@suse.cz>, <pavel@ucw.cz>,
        SeongJae Park <sjpark@amazon.de>, <dan.j.williams@intel.com>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>, <mishi@linux.com>,
        <skhan@linuxfoundation.org>
Subject: Re: checkpatch: support deprecated terms checking
Date:   Tue, 28 Jul 2020 08:22:49 +0200
Message-ID: <20200728062249.25469-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7f07e16c47c7dcb35685cddbb3a740e4698258fc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 13:49:00 -0700 Joe Perches <joe@perches.com> wrote:

> On Mon, 2020-07-27 at 13:44 -0700, Andrew Morton wrote:
> > On Mon, 27 Jul 2020 08:54:41 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > > > > Unfortunately, the inexperienced _do_ in fact run
> > > > > > checkpatch on files and submit inappropriate patches.
> > 
> > I don't think I really agree with the "new code only" guideline (where
> > did this come from, anyway?).  10 years from now any remaining pre-2020
> > terms will look exceedingly archaic and will get converted at some
> > point.
> > 
> > Wouldn't be longterm realistic to just bite the bullet now and add these
> > conversions to the various todo lists?
> 
> I don't think so.
> 
> There's no exclusion list for existing uses
> written to external specification.
> 
> It's just emitting effectively noisy warnings
> on things that should not be changed.
> 

Just noticed that this patchset and the followup[1] for sync with inclusive
terms commit[2] are dropped from -mm tree.  I admit it could generate some
false positive warnings, though my followup patch[3] makes the message noisy
but gives clear references.

I still believe it's better to provide the messages, but I also know people
could think differently.  After all, the biggest part of the initial goal of
this patches is already made by the inclusive terms commit[2].  So, I would
respect the decision.

[1] https://lore.kernel.org/lkml/20200713071912.24432-1-sjpark@amazon.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=a5f526ecb075a08c4a082355020166c7fe13ae27
[3] https://lore.kernel.org/lkml/20200726180748.29924-1-sj38.park@gmail.com/


Thanks,
SeongJae Park
