Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66BF2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSjEVNoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHYRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:33:46 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC65C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:45 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u24so12336535oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaGokeMKmXOs1jMVx4acN7Y6RUoNOKwjM19wqaunc6c=;
        b=kSjEVNoZsC75lG7EfGEkWB7xp/wMWZm1SZe5zXG1qmtU9tSKWdjSuVUeQ6Dvfc8cqQ
         pjfjX3C8QQY8bg+bHDUGZlvzJzOVW+xj0vi2BdqeF8MOMtj8WJRUBxm6+Y05vWr3NGyh
         k2MECzaTDtfCsVbSRKXCjXLwQHEDYIjbxxuFmj3aeb+TsbFC9Up7V1NZm9M+YEuFnHth
         g4G8OLCf/ptteTaGSYwNh1CnPM+supY2hbs6dF98aAM3k6QsdQdQ5lR8CPwXeaWVNJ6X
         2yv2/ep+0FEpyIrBNAuJcDTW6akyW0iG1uEBJHsCwPVUQ+9p34DY8ZQLiW/jpyHp9Z5v
         UTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaGokeMKmXOs1jMVx4acN7Y6RUoNOKwjM19wqaunc6c=;
        b=BUwZGNwOMpWOc3PF1GzpxlS785inUsfVfwIy4kBiVIQuG0OepgdO1RM9bkg4gEetLD
         mCdQdukd5Y5v78kU+VIhTLDCbRxg+eKh3r3/k+YsYP6srZvexZ9NB5mMBqn+1Xkhsl1M
         JGQzML+jTgY80A2cthBzvX1jg4T47S5med5eqaKtOWaP3s40YreUPOvfuO4zqOfNh2ik
         Rc67GPHN9YUm7sJQfCznUGwVG4FMsnjTJLFEHHxat9lzB+bU4hgH6GebyjRZ2DoKq5qu
         ohBSW8en0C1lxs/Y8uGrHhzDXWGPCys8PMsjzko8F6u/l0uhGEiSAs7IXDBQQeH/syzL
         blng==
X-Gm-Message-State: AOAM532p3vljDBUUtk/gnENKcHPGQtvFEmPHJTmhl4Gj5BV5VSmQTH23
        67sty2kg1Q0mSKJS9L/TOyo=
X-Google-Smtp-Source: ABdhPJxE5fBL0Xi1xQBnFysT/oXwKsgvXUwNBHBUrfFbvhno5s3QB6X6IWMtqV2/2apR21algmY6rg==
X-Received: by 2002:aca:b444:: with SMTP id d65mr1720837oif.174.1598376825036;
        Tue, 25 Aug 2020 10:33:45 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id x11sm3214168oot.0.2020.08.25.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:33:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH-v2 0/3] dynamic-debug fixups for 5.9
Date:   Tue, 25 Aug 2020 11:33:36 -0600
Message-Id: <20200825173339.2082585-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - fix new export name, with a wrapper for more utility.
   now with fixes per Joe Perches
 - parse format="foo bar" like "format" "foo bar"
 - pretty-print

Jim Cromie (3):
  dyndbg: give %3u width in pr-format, cosmetic only
  dyndbg: refine export, rename to dynamic_debug_exec_queries()
  dyndbg: fix problem parsing format="foo bar"

 include/linux/dynamic_debug.h | 20 +++++++++---
 lib/dynamic_debug.c           | 59 ++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.26.2

