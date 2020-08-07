Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01CF214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcgHBwGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHGUKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:13 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A745C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:13 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id o36so661945ooi.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=soqS30MM7Lvz4xj7E5lcaM6TYNPttmmFgM0OZvhcFi4=;
        b=TcgHBwGBV180Qzb+5Q7lmvpy+TY9LRvlMXf10V4beYwGfA/qVc1lpX5CVqk1CfysmS
         X4D1k/PRqlhFuAUx9Z031PDqRwoJmjGiTDxBfyYOE8UD3tw+KTt82zUluR2jWQjuqYw5
         6C0T4Pdh2RhCV4gP6N7Xvx8LVdxY82scCtfA9D9FeLG9w7AfBJqmgucGN/7e1pqTy92M
         W7rYXB9uFHW0n1iI//YkAJW54KPct5L8KeNvMCJNqvbFkD4fzxBkZXgEKHq0v7MOLohL
         AaiL70yDCYMyGMKa8SjPbUfr1RYw+StFHiBD7QkcbPzd+Fcfo0NItTeoms1r1jBWrStO
         eQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=soqS30MM7Lvz4xj7E5lcaM6TYNPttmmFgM0OZvhcFi4=;
        b=Gnll3MmrOx9F/2ekRuHVMIIltHXDOAOEe+DqADASQ5WuQ2HV4+hIsajwQaF6LKkArN
         In7ghr78awzN+kSIAt1SDmIZRDxKR7OMjatL3Vob0uz2UsH4QD5TZNKwVpmfWoAM2oVk
         CV2ibnTIKiTkyW5dG3FxP3BdSiXovdMUtg12jTldKyW6Ha/Gvjms5dy5xq58hpMMsr1C
         6n84+8DeMfs5WGMHsAOtXiFnYCFSIFXWCsQQgXPHgrfpUH87BEPaS9kd+OePkMqffk5T
         lqo+RIkUXzbdBvyi8R3ZCc7Z5jRWSux33/nG6iBJvcG3Jp/x11rxuUECuwQMob22pthp
         raEQ==
X-Gm-Message-State: AOAM531TXNcWzd5l4mce8JwwRHqQmWwuXPR+3qPrBwzxLGnnCP+zC0+r
        tAAdJwel+u3RIP+KXJ9gdK0=
X-Google-Smtp-Source: ABdhPJyAK2UqU6tVeNe21WWNq9OdVEC5p+XtuXSnZhxpZrGS3LGxm+R287zqhFmY+2lf3sd4aV2eSg==
X-Received: by 2002:a4a:c887:: with SMTP id t7mr14059716ooq.57.1596831012751;
        Fri, 07 Aug 2020 13:10:12 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/7] dyndbg: WIP diet plan
Date:   Fri,  7 Aug 2020 14:09:47 -0600
Message-Id: <20200807200957.1269454-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic-debug metadata is bloated; the __dyndbg linker section is
effectively an array of struct _ddebugs, and its 1st 3 members are
highly repetetive, with 90%, 84%, 45% repeats.  Total reported usage
~150kb for ~2600 callsites on my laptop config.

This patchset is one diet plan. it all holds together nicely until the
"cache" commit, when it blows up starting init (or right after freeing
unused kernel image, which Im hoping to do...).

last commit log has the BUG trace from a LOCKDEP build, which reports
stuff I dont quite undertand, except that it looks bad.


Jim Cromie (7):
  dyndbg: give %3u width in pr-format, cosmetic only
  dyndbg: motivate a diet plan
  dyndbg: select ZPOOL in Kconfig.debug
  dyndbg: split struct _ddebug in 2, creating _ddebug_callsite
  dyndbg: WIP replace __dyndbg_callsite section with a zs-pool copy.
  dyndbg: add locking around zpool-add loop in zpool-init
  dyndbg: enable 'cache' of active pr_debug callsites

 include/asm-generic/vmlinux.lds.h |   4 +
 include/linux/dynamic_debug.h     |  36 +++--
 lib/Kconfig.debug                 |   1 +
 lib/dynamic_debug.c               | 220 +++++++++++++++++++++++++-----
 4 files changed, 218 insertions(+), 43 deletions(-)

-- 
2.26.2

