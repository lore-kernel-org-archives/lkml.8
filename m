Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E05C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98221206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOyS+Xfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgG2MWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:22:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50813 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgG2MWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596025365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpyOWSPe1mDJUCalnib+RdakBtwf9GKVyJoJrNi65D4=;
        b=KOyS+XfnEEK1E/luJ30XSZnk/y2VrmG3jlrcWCv28Z9zBkWY5tbw/SdWXt9ahCWwQ8ywnk
        m+kw8KbLg5fPGYzN5ncm9uSg76486smiih4HkhdD2wqThT7ZAyKNjyDQNrnMT7Q5kzzfxS
        2cPpwURGxW+IyWbn+Jt6SI0voi1+4vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-JlU9oetmMg6ICSEKurRjXg-1; Wed, 29 Jul 2020 08:22:39 -0400
X-MC-Unique: JlU9oetmMg6ICSEKurRjXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CDC81932482;
        Wed, 29 Jul 2020 12:22:38 +0000 (UTC)
Received: from prarit.7a2m.lab.eng.bos.redhat.com (dhcp16-222-232.7a2m.lab.eng.bos.redhat.com [10.16.222.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35F6910098AB;
        Wed, 29 Jul 2020 12:22:37 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     corbet@lwn.net, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com
Cc:     chunyan.zhang@unisoc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Re: [PATCH V13] printk: Add monotonic, boottime, and realtime timestamps
Date:   Wed, 29 Jul 2020 08:22:36 -0400
Message-Id: <20200729122236.17418-1-prarit@redhat.com>
In-Reply-To: <20200729114423.30606-1-zhang.lyra@gmail.com>
References: <20200729114423.30606-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> From: Prarit Bhargava <prarit@redhat.com>
> 
> printk.time=1/CONFIG_PRINTK_TIME=1 adds a unmodified local hardware clock
> timestamp to printk messages.  The local hardware clock loses time each
> day making it difficult to determine exactly when an issue has occurred in
> the kernel log, and making it difficult to determine how kernel and
> hardware issues relate to each other in real time.
> 
> Make printk output different timestamps by adding options for no
> timestamp, the local hardware clock, the monotonic clock, the boottime
> clock, and the real clock.  Allow a user to pick one of the clocks by
> using the printk.time kernel parameter.  Output the type of clock in
> /sys/module/printk/parameters/time so userspace programs can interpret the
> timestamp.
> 
> v13: This patch seems have being forgotten for 3 years. Rebase it on
> the latest kernel v5.8, reolve conflicts and fix compiling errors.
> Change code to adapt new printk_time usage.
> Petr's concern on printk_time is addressed by current version of kernel, too.

Lyra,

Copying a reply I sent to Orson who sent me this patch privately this
morning with some additional information.

ISTR the reason that this was dropped was because of the a problem with
the way systemd read the kernel's timestamps.  It got the attention of
Linus, and it was then pulled from the tree.

I need to go back and review the entire thread as it's been several years
since we had the discussion although ISTR someone mentioning that doing two
timestamps would not be a problem for systemd.

For example,

[48551.015086]

would be

[48551.015086] m[xxxx.xxxx]

for the monotonic clock timestamp, and

[48551.015086] b[xxxx.xxxx]

for the boottime clock, etc.

P.

