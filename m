Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39582C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF362311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHMfc5Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgHFQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgHFQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:54:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A89C0A3BD0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:54:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d30so14305784qve.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rCm9cY6ajxJ7usQ3AHKrWox7W/sIb0CRigoftU0dpEI=;
        b=PHMfc5AxB5CnXqLw5iAjfPAjw6WolNBPr/1vdUHJd1AEFoh7clU9JHC/sqqOUj+riM
         pHOVnHgkDYQ6gDD4TSr0Qt1sZZ6haTuBWdiyXgUv3p334IQRsmrCJtSqn7rDA5JJFq7U
         FZB2xOwlw3vgmdtsJjISSZjuzXy5q/6iucfcKQLhaUNv5mVCWHpRl4SjU47YEuT5PJJf
         QErCeYe4YECdbsGWYTrlvRzKz3C5oiJSLJ1sNSJDlyMfX+1ZGYFluOH1Dc52izdTH8YK
         qlEQS1BWZRa3Mh38M4pPBs04tjmwhIepZGBJzJHnRrDD0cXu1RmcNswMPetBtdMshnll
         2PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rCm9cY6ajxJ7usQ3AHKrWox7W/sIb0CRigoftU0dpEI=;
        b=UrWtHB1lpZ58AvSHw/KBobZ5sJvsQluC7Ybcvi3r+wo0cdOrf0Od7PbQApziEoKsMh
         IxVh9yTqTkE+Zs169sCyTcYzSejrMOxIkWZ0B+C6ZD4fXo9smRi4XgOcSwfVYlHeYfEy
         PgmnoYANL4LCYPBAlZ5hsBS6D/yOLG2eeeM2bl+TNpGRcVWps6zHAJgtsxJTZ/bwUv9X
         zIWoJ7SNPCvHsLySoKKkn4uaVJvLfE1cmcZ/EiIgen7NfwNPC/A+450v9/tL8rgQ//6s
         4DcdV2CW3DghH8Py0HmcIvuWsE1RWTz3QceeqNBhfRkIzHGuKNy/SWznv8r3UzjoNsqe
         BqAw==
X-Gm-Message-State: AOAM533F4rPuK8Jl/Q5we0YxGvNZd0vzkylX3kcNJfiZZ/pqgSV0pZdL
        ub9cHZGvtQM16RBqixn7wq9obL3lMw==
X-Google-Smtp-Source: ABdhPJxKMwuPDKBYR+NJXzoJwI9ymXY2JTIR/CIMWdANcc0jRgvGsIlnEHvb2S29PQ10EUHf5fUrNicbyA==
X-Received: by 2002:ad4:56ee:: with SMTP id cr14mr10244737qvb.119.1596732850548;
 Thu, 06 Aug 2020 09:54:10 -0700 (PDT)
Date:   Thu,  6 Aug 2020 18:53:59 +0200
Message-Id: <20200806165359.2381483-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] binder: Remove bogus warning on failed same-process transaction
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While binder transactions with the same binder_proc as sender and recipient
are forbidden, transactions with the same task_struct as sender and
recipient are possible (even though currently there is a weird check in
binder_transaction() that rejects them in the target==0 case).
Therefore, task_struct identities can't be used to distinguish whether
the caller is running in the context of the sender or the recipient.

Since I see no easy way to make this WARN_ON() useful and correct, let's
just remove it.

Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
Reported-by: syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..5b0376344dbe 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2344,8 +2344,6 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			 * file is done when the transaction is torn
 			 * down.
 			 */
-			WARN_ON(failed_at &&
-				proc->tsk == current->group_leader);
 		} break;
 		case BINDER_TYPE_PTR:
 			/*

base-commit: 47ec5303d73ea344e84f46660fff693c57641386
-- 
2.28.0.163.g6104cc2f0b6-goog

