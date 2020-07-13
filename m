Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F350C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9520773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="NRegjh3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGMR2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgGMR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65857C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so18149559eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pH1K2vUzPfJhwEBVdOMPKdK/A94n7hLqQfvszT16hv4=;
        b=NRegjh3LBWDlrzUeOyPaQJxImhcWMjvignzs5E6UY4PzLSDkmPbyXeWAHNwJECOTmS
         cwenOTW+EsLhulDrayiQ/2zwo5NgqG4xyARuMoN+FCHCM4FS8fduE6c0yLQ92Dik+fN9
         qPQsCSXMlAdYzgiDDf30IbAHXQyAltxf+sHHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pH1K2vUzPfJhwEBVdOMPKdK/A94n7hLqQfvszT16hv4=;
        b=cxXQnkxCEyJ2DoEggxMZKkzb2gPdwIQTTz32s0Y6m7G5LKzXgMyXI6FjXojXX/qXMe
         hdiQ5KQss0OexPM4xe7I3nLsQZv3rsQ8tDFFu5NVO1le604xa8bNvo1wbEhNIVLoW4Yc
         JbG2ebL85OiPO+RLXjU/hBiV5OapqBSDsEUgIjPDjCFC7f2HXYUjnSklOfaP62WM6oaV
         myPX1y8sslrRxKkpEGANwo6gCfEc4qTLhcH9lJKUnAJg6behUhNObxnJyP5QNjwQNcEA
         ooISkUGaCSAD959OYbCuno4I37BA6xyxGLaUCpp0/hqlnLLTE94QJdN8qQ1aZFIbL9cs
         s2ng==
X-Gm-Message-State: AOAM531v8N7rlS51jhNJyj3x9qmIRi2G65Jo/O64ltMxk8moHl1aHmUx
        szpd4dG23Oe5yiCJmNKTZjXc1g==
X-Google-Smtp-Source: ABdhPJxBuP+bUAv3rzAwsjjREEpJYKQWi2Eub0eeBpMQBkIX2vw77IaPWiNeyjfA4TaX3+SHhnNC/g==
X-Received: by 2002:a17:906:9244:: with SMTP id c4mr796991ejx.60.1594661288807;
        Mon, 13 Jul 2020 10:28:08 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id b14sm10150344ejg.18.2020.07.13.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:28:08 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:28:08 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 0/2] tmpfs: inode: Reduce risk of inum overflow
Message-ID: <cover.1594661218.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
On affected tiers, in excess of 10% of hosts show multiple files with
different content and the same inode number, with some servers even
having as many as 150 duplicated inode numbers with differing file
content.

This causes actual, tangible problems in production. For example, we
have complaints from those working on remote caches that their
application is reporting cache corruptions because it uses (device,
inodenum) to establish the identity of a particular cache object, but
because it's not unique any more, the application refuses to continue
and reports cache corruption. Even worse, sometimes applications may not
even detect the corruption but may continue anyway, causing phantom and
hard to debug behaviour.

In general, userspace applications expect that (device, inodenum) should
be enough to be uniquely point to one inode, which seems fair enough.
One might also need to check the generation, but in this case:

1. That's not currently exposed to userspace
   (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY on tmpfs);
2. Even with generation, there shouldn't be two live inodes with the
   same inode number on one device.

In order to mitigate this, we take a two-pronged approach:

1. Moving inum generation from being global to per-sb for tmpfs. This
   itself allows some reduction in i_ino churn. This works on both 64-
   and 32- bit machines.
2. Adding inode{64,32} for tmpfs. This fix is supported on machines with
   64-bit ino_t only: we allow users to mount tmpfs with a new inode64
   option that uses the full width of ino_t, or CONFIG_TMPFS_INODE64.

You can see how this compares to previous related patches which didn't
implement this per-superblock:

- https://patchwork.kernel.org/patch/11254001/
- https://patchwork.kernel.org/patch/11023915/

Changes since v6:

- Fix misalignment in percpu batching, thanks Matthew.

Chris Down (2):
  tmpfs: Per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.rst |  11 +++
 fs/Kconfig                          |  15 ++++
 include/linux/fs.h                  |  15 ++++
 include/linux/shmem_fs.h            |   3 +
 mm/shmem.c                          | 127 ++++++++++++++++++++++++++--
 5 files changed, 166 insertions(+), 5 deletions(-)

-- 
2.27.0

