Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47132072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Na5SwJoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFKIbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:31:02 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44710 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgFKIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591864260; x=1623400260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=gE4QUdZh10oJ1Y6AXqRaO1/QXy4fn8StEChlLqZbvW8=;
  b=Na5SwJoj2qJv2MTQa18fq5Ul4NR9cKLXTTSkr0S3mnl3a50XDmdzIrzt
   6mXIetMBychn4PIkMPVA9kTcDEa5Rp2ixcKx/mkrtanRWbzNemxk77IfF
   71lYAoEvrksPrJXbMD+2iwUAHEM7iRfmRuaLWWszygiOo6s8548pGCuQR
   Y=;
IronPort-SDR: 5I2KL3FnQtXkM7r7E08Z+J3eklasVDpSVVpoq5VlJkXPNG7QtaT3FXLj12hVc5BMgsEJOmWXMA
 9iXFTVSS0FIg==
X-IronPort-AV: E=Sophos;i="5.73,499,1583193600"; 
   d="scan'208";a="35704540"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Jun 2020 08:30:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id A066CA07D4;
        Thu, 11 Jun 2020 08:30:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 08:30:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.48) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 08:30:49 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     SeongJae Park <sjpark@amazon.com>, Joe Perches <joe@perches.com>,
        <akpm@linux-foundation.org>, <apw@canonical.com>,
        SeongJae Park <sjpark@amazon.de>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <linux-kernel@vger.kernel.org>,
        <kristen.c.accardi@intel.com>, <mishi@linux.com>,
        <skhan@linuxfoundation.org>, <gregkh@linuxfoundation.org>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Thu, 11 Jun 2020 10:30:35 +0200
Message-ID: <20200611083035.23008-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <38ac91ab-ced3-8a4f-b825-4503fdcddeb8@suse.cz> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 10:16:09 +0200 Jiri Slaby <jslaby@suse.cz> wrote:

> On 11. 06. 20, 9:38, SeongJae Park wrote:
> > On Wed, 10 Jun 2020 23:35:24 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> >> On Thu, 2020-06-11 at 08:25 +0200, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> >>> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> >>> replacement suggestion of 'denylist' and 'allowlist', because the
> >>> suggestions are incontrovertible, doesn't make people hurt, and more
> >>> self-explanatory.
> >>
> >> While the checkpatch implementation is better,
> >> I'm still very "meh" about the whole concept.
> > 
> > I can understand your concerns about politic things in the second patch.
> > However, the concept of the 'deprecated terms' in the first patch is not
> > political but applicable to the general cases.  We already had the commits[1]
> > for a similar case.  So, could you ack for at least the first patch?
> > 
> > [1] https://www.phoronix.com/scan.php?page=news_item&px=Linux-Kernel-Hugs
> 
> Fuck you! replaced by hug you! is a completely different story. The
> former is indeed offending to majority (despite it's quite common to
> tell someone "fuck you" in my subregion; OTOH hugging, no way -- I'm a
> straight non-communist). If it turns out that any word (e.g. blacklist)
> offends _majority_ (or at least a significant part of it) of some
> minority or culture, then sure, we should send it to /dev/null. But we
> should by no means listen to extreme individuals.

Thank you for the opinion.  But, my point here is, deprecating some terms would
occur in general as the f-word to hug replacement was, and the first patch is a
simple technical preparation for such case.  And, therefore, it would not need
to be blocked due to the second patch.

For example, as it seems at least you and I agree on the f-word to hug
replacement, we could add ``fuck||hug`` in the `deprecated_terms.txt` file to
avoid future spread of the f-words.

Also, I personally don't think the second patch as a political extreme change
but just a right thing to do.  Nonetheless, I also understand people could
think in different ways.  Moreover, it is obviously non-technical thing which I
am really bad at.

For the reason, I am CC-ing the code of conduct committees[1].  I would like to
hear their opinions on this.

[1] https://www.kernel.org/code-of-conduct.html


Thanks,
SeongJae Park

> 
> thanks,
> -- 
> js
> suse labs
