Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798822067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ERmnc3yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgFOGq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:46:59 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61278 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592203619; x=1623739619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=n9xEj1S1zm4BAv1ix2dtneBn+lmgT67gEX3XKW8QTbY=;
  b=ERmnc3yEwYl8tzzIYK8C7Ml+QTVP6m2OVPRXXEk4ClfuCCIi1h/l2c27
   h2aH/sL0p0qcAmyL52UmzeuNb4Izk5zcA4k9K5ghzIoGlbKQ4B6imUohF
   T0GMo8wPtC8CI1KUn0hmxSOHK9bsLWQOBdCflyxbHoy7OoZZLhJzeUEVV
   Q=;
IronPort-SDR: CKYfCodys5a2jbgE+Cga2MzmUs8G9bh61AkZVN7lNVFObrSjZNlvWjx0Mxh0En0ObCNn5Ps/xx
 S3PfG+xdyHCA==
X-IronPort-AV: E=Sophos;i="5.73,514,1583193600"; 
   d="scan'208";a="43948403"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 15 Jun 2020 06:46:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 63D97A1E5D;
        Mon, 15 Jun 2020 06:46:55 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 06:46:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 06:46:49 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jiri Slaby <jslaby@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
        SeongJae Park <sjpark@amazon.com>,
        Joe Perches <joe@perches.com>, <akpm@linux-foundation.org>,
        <apw@canonical.com>, SeongJae Park <sjpark@amazon.de>,
        <colin.king@canonical.com>, <sj38.park@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Mon, 15 Jun 2020 08:46:31 +0200
Message-ID: <20200615064631.18910-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615061208.GA31489@amd> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 08:12:08 +0200 Pavel Machek <pavel@ucw.cz> wrote:

> 
> [-- Attachment #1: Type: text/plain, Size: 1115 bytes --]
> 
> On Mon 2020-06-15 06:21:43, Jiri Slaby wrote:
> > On 14. 06. 20, 23:29, Pavel Machek wrote:
> 
> > >> It's not like blacklist / whitelist are even good to begin with, it's
> > >> not obvious which is which, you have to learn that black is bad and
> > >> white is good.
> > >>
> > >> Blocklist (or denylist?) and allowlist are actually more descriptive and
> > >> less likely to cause confusion.
> > > 
> > > You do not understand how word "blacklist" is used inside the kernel,
> > > do you? Do a quick grep.

I of course did grep of the terms before making this patchset.  There are so
many uses of the term, and therefore I thought it would be very hard and
painful to replace the whole words.  Of course, I also found some miuse of the
terms and therefore I thought automatic scripting for the replacement also
wouldn't make sense.

That's why I made gives only warning to future patches.   What this patch aims
to do is avoiding the further spread of the terms, and incremental replacements
to better terms, rather than the one point buggy and risky replacement.

> > 
> > And now, do the same for "blocklist".
> > 
> > And is "denylist" a proper word? As grep gives zarro results...
> > 
> > It's not that easy to find alternatives. OTOH, admittedly, "blacklist"
> > is used improperly in some contexts. Some synonyms fit better.
> 
> Well, many of the uses is "list of hardware that needs particular
> workaround" or "list of hardware that is broken in some
> way"... Neither 'blocklist' nor 'denylist' fit that usage.

Agreed, 'denylist' would also not fit in there.  That said, this patchset will
warn even such case so that people can think once again and find better term.
So, I agree this patch is imperfect for many cases, but better than nothing.


Thanks,
SeongJae Park
