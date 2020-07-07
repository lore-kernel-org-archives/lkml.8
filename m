Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD81EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99CA206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wld/FDLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGN3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:29:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgGGN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594128560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bpqV8ZGEfDigVwyXYOylVCt2pIZCMYHJKK1J8Iop6Ek=;
        b=Wld/FDLmGkEFamjwzP97csEwuh729A/r4xzGZHHYHoZ9Ut1SLlQVbuqs5mIlZjxcf2ZL6E
        A9SW79ltoIrZhJluFDY4x2eNuuTrLv88y0xQWrXE4jHzoS55JHax8Q3dTp54Qrs/rI3kjG
        b3k5I9X7PAFL+rHok5QTEclricIfb18=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-6He1-iJlMpGx-i6_jZ8hWA-1; Tue, 07 Jul 2020 09:29:16 -0400
X-MC-Unique: 6He1-iJlMpGx-i6_jZ8hWA-1
Received: by mail-qk1-f198.google.com with SMTP id i3so22333270qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bpqV8ZGEfDigVwyXYOylVCt2pIZCMYHJKK1J8Iop6Ek=;
        b=QRiiuKzZZd5+GFCMeM+KNPA5ctoFx4wdn8PfsiVk2BZSEFRID7T9p64kjQtHp5ZSaA
         ZhYHejR7WruG0B6pCiWc0SsJhA0pEw1+qb6N+u1nCdA9sk+eEF/CIuHPhYX4FeAnWdJ4
         BrZ2AQmypAWzH/FQ9UvPzefA1XReJdSWFh1+rAUuJs7n30qxUwCf37EKRzbHrd97uvDt
         CBg/v/QGq5sw7CEAKfHGcg+fUrNleLws48RJyrsrfsai64LEHJ3hFu9odZXgvtoQ+AXt
         GJXx9ZHBgt/eHOQaJEHk+8XLTdrRy2WBS3aVDy5weSIQVIQelIuz9UTS5rEhayYjHZc6
         s1TA==
X-Gm-Message-State: AOAM5306nk+mEOuYLEhq2Sk7RMvqiCg7JRiVq2Tz/nNxeodCHPJk/Se+
        qeu8vc/nkXA8wzjFRooJQNVOj6nJNXOTWLbSPjJVTBqrNDTfpjqJMdItA7N2ySRdc5YqXlnGnCH
        7xQD8BbGWPaSrSprOnHdMcf//
X-Received: by 2002:ac8:6d24:: with SMTP id r4mr30664727qtu.43.1594128555741;
        Tue, 07 Jul 2020 06:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2O03gNYLOwDLCkyXntBfC1UDiAP5Lv/FxSrI+aXh9M2U49IWAz9aERDIYqKOl2j/VlTt3pg==
X-Received: by 2002:ac8:6d24:: with SMTP id r4mr30664700qtu.43.1594128555462;
        Tue, 07 Jul 2020 06:29:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g41sm28492912qtb.37.2020.07.07.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:29:14 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs : fix memory leak in add_block_entry
Date:   Tue,  7 Jul 2020 06:29:08 -0700
Message-Id: <20200707132908.10987-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

fs/btrfs/ref-verify.c:290:3: warning: Potential leak of memory pointed to by 're' [unix.Malloc]
                kfree(be);
                ^~~~~
The problem is in this block of code

		if (root_objectid) {
			struct root_entry *exist_re;

			exist_re = insert_root_entry(&exist->roots, re);
			if (exist_re)
				kfree(re);
		}

There is no 'else' block freeing when root_objectid == 0

So add an 'else'

Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/ref-verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index af92525dbb16..7f03dbe5b609 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -286,6 +286,8 @@ static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,
 			exist_re = insert_root_entry(&exist->roots, re);
 			if (exist_re)
 				kfree(re);
+		} else {
+			kfree(re);
 		}
 		kfree(be);
 		return exist;
-- 
2.18.1

