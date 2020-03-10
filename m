Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65C1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D60C21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQaUMGOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCJSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:08:57 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35516 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:08:57 -0400
Received: by mail-ot1-f54.google.com with SMTP id k26so6841524otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k0YINB0FGb2izRGDvx6dOeweQ26xeFfqgFiUly0T1/8=;
        b=lQaUMGOJHO38pdQsfm+YF9Hjvz2ISFmJWQowjGrWwKTDNGxgjqUZxI/jaQVO6qbP2i
         QGfCgEcg0A/QCP/Xp4BleRLam2x5ZJquwMYF4/BjOS7GXqND31C86ME1wB5TqaTq/4ij
         i5puUFShLSbloXJW2J5vmtYmDY4VnQ+4Fon9DJRbCYhK8PvILBLE0rD8fgs/LyPw03zH
         QaJUyAFf2mlBFSEGAJ6M6KnNuDcf/hFXMe2Zmbra0r0S+8mh7YruvWBXkqyAbp7OSaDE
         taMlrywYmhVuq32hgVTtci472Ic4H0XCP1gZYWuZc1srQpgqEWN3X5+gip4OR3I29Btb
         4mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k0YINB0FGb2izRGDvx6dOeweQ26xeFfqgFiUly0T1/8=;
        b=lI8l/vmTQ2mtbwQGMb0rW4juS0DLtKlZpeQpbNk3+tBDqDU2M6DQX9VCfE4nAqqGc2
         s22icfSWguDk0z4Mc7u5EY6t3CAXhIgkbmCAzfiqHu+uLDLqQMw0eV7Fvjn6gpx1k23D
         bSl5NQ2eXuDJxqTBlQzR7zjTc5LPrWKFrmHY9J5SPNwDuiJf9rRdJS41ydaAGYGclLeW
         SBbYHqDhoTEMbNVphScxbTtUPjH6B6cVHG9J8fCsC3EJ/x2z50/GnIv/B0I//ldjxxqD
         2pU2V5iuHFhNWloyB/5UKMPquioOxMRZOkydO/KEp/X/PRPaRlBEGUVwVRfLSzI9qLHL
         LRxQ==
X-Gm-Message-State: ANhLgQ2mysOc4fjnPK/Lv10p6NBEZgLkch1QsxDiMANM7oNbTOQmSBFT
        njMqVnciIpipUqkBTcY7nJ35i59Cq+xlHWaylcTk7ZS8p34=
X-Google-Smtp-Source: ADFU+vuWAonvIQE1fvFkPfcoOs/5Bq1l3fPdVW7kVNiRepRS2lFM4d4PXrhb9txFaSDi9JANBW/6IZbgB78jYDhzrQE=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr18154276otl.110.1583863734919;
 Tue, 10 Mar 2020 11:08:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 19:08:28 +0100
Message-ID: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
Subject: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

From looking at the source code, it looks to me as if using
MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
possible, even if other processes still have the same page mapped. Is
that correct?

If so, that's probably bad in environments where many processes (with
different privileges) are forked from a single zygote process (like
Android and Chrome), I think? If you accidentally call it on a CoW
anonymous mapping with shared pages, you'll degrade the performance of
other processes. And if an attacker does it intentionally, they could
use that to aid with exploiting race conditions or weird
microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
talks about "the assumption that attackers can provoke page faults or
microcode assists for (arbitrary) load operations in the victim
domain").

Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
pages with mapcount>1, or something like that? Or does it already do
that, and I just missed the check?
