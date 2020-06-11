Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC4EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7672072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ei1yezdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgFKHif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:38:35 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:20225 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591861115; x=1623397115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=0In+9Sc2XsmstubOSR2LUHXPW51gPjn95v7nxGAoUvo=;
  b=Ei1yezdtntbhv3bpG6ke9uUWTkUokXLtTlBYE40VVSx2bUwerrXWGSGu
   ztEkHLZ5Gya7Afd4l4CPAemhqYtGuqU5PwGXue70lMVpLZV09YOsvNe79
   vC20JLFZLID5Q/FsSKr5gs8XTs8B2vGyjyq7eQu1MhvMsrOK3jLJmrY9z
   Y=;
IronPort-SDR: eY2Jj1ZXc3WgwmUwEM0TwHHQ+GY3nelbGck1Src2rkAhDZNFFWFtzZm5uapTxfz1JC9BpKRPVb
 cqS8L2cHzRGA==
X-IronPort-AV: E=Sophos;i="5.73,499,1583193600"; 
   d="scan'208";a="35699073"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Jun 2020 07:38:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 657EBA24A0;
        Thu, 11 Jun 2020 07:38:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 07:38:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 07:38:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Joe Perches <joe@perches.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        <apw@canonical.com>, SeongJae Park <sjpark@amazon.de>,
        <colin.king@canonical.com>, <sj38.park@gmail.com>,
        <jslaby@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Thu, 11 Jun 2020 09:38:04 +0200
Message-ID: <20200611073804.10225-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d323a6a114690e4757c777befc997d60d82558f2.camel@perches.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D20UWA001.ant.amazon.com (10.43.160.34) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 23:35:24 -0700 Joe Perches <joe@perches.com> wrote:

> On Thu, 2020-06-11 at 08:25 +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> > and 2) set the 'blacklist' and 'whitelist' as deprecated with
> > replacement suggestion of 'denylist' and 'allowlist', because the
> > suggestions are incontrovertible, doesn't make people hurt, and more
> > self-explanatory.
> 
> While the checkpatch implementation is better,
> I'm still very "meh" about the whole concept.

I can understand your concerns about politic things in the second patch.
However, the concept of the 'deprecated terms' in the first patch is not
political but applicable to the general cases.  We already had the commits[1]
for a similar case.  So, could you ack for at least the first patch?

[1] https://www.phoronix.com/scan.php?page=news_item&px=Linux-Kernel-Hugs


Thanks,
SeongJae Park
