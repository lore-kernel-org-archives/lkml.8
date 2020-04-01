Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D511C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB9E20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585761412;
	bh=ZyIh3CjNdBB0NeqOV693cQN3fLIfvPegTmTl9Q3Z8N4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xOCIHPE5FEamtoMCCedYRPv8uejNOSm+vewpewNDcTgK4tttBYLBOoYq/0T9Tzux4
	 Br2mu9tV/Dru+U+HcBCItXcbZ7s9KWCaxVYl0OuZaq3RXyr/730FiukAL7YA7FOkcL
	 WuGnWEt9KYPjkiWipmZIn15USWFL9c03fzY1Dyww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgDARQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:16:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33983 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgDARQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:16:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so456418qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I4nVUN8Fl1U/E6c2DFWbzy6mvM74REswZBIVWpFMG4Q=;
        b=N1OqeoyX3B7AzY4HqIyXrY10aYDOz+DB6MWQ4Eo606xk3M+S76dpICY7We3cDvburv
         oww9uwBgJFHPGl1pdv7xRIWaKuZu0suz2Ny3vsENIHhk4xGiOzOsd7rKbrwsKoyPewMo
         Y05GrJkP8yDK7Z+FJovXA70LgiHu9ErE06v2d0udxjX3peKsknRiaRySoSsBM9ydGkEr
         jRH39flIY7vO5dvVvp3GZ6gUjdoka9injZmWYbjVWBeo7dIkqRKnNbsYbr/Qz9htJDrJ
         bzsHa8PXgm/tqM5deUcY3DhnmbQ/+DU3GjB2RuPOe6H9Rc94MDTkEf520MCehZdfCYFl
         E9Nw==
X-Gm-Message-State: ANhLgQ3LvZPn3VoEnBCljKuuj0AX+/hOnrTcONnZubFcbm+j2U5oQ7zg
        abqvjiBWRGcyNtFVgVHlM4yp/Xhxkx0=
X-Google-Smtp-Source: ADFU+vvTRvImvV3aNtF7AhVEARXKL8ON52ViSDcsc8sDM2BNwKkDS0A+NZIGjwqUHcsapsaaI7hi+w==
X-Received: by 2002:aed:3eec:: with SMTP id o41mr11618313qtf.343.1585761409167;
        Wed, 01 Apr 2020 10:16:49 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id c12sm1803313qkg.30.2020.04.01.10.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 10:16:48 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] percpu: update copyright emails to dennis@kernel.org
Date:   Wed,  1 Apr 2020 12:16:44 -0500
Message-Id: <20200401171644.44676-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are 3 emails tied to me in the kernel tree, I'd rather
dennis@kernel.org be the only one.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
This'll just make it easier to keep track of me. I've applied it to
for-5.7.

 mm/percpu-stats.c | 2 +-
 mm/percpu.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index a5a8b22816ff..32558063c3f9 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -3,7 +3,7 @@
  * mm/percpu-debug.c
  *
  * Copyright (C) 2017		Facebook Inc.
- * Copyright (C) 2017		Dennis Zhou <dennisz@fb.com>
+ * Copyright (C) 2017		Dennis Zhou <dennis@kernel.org>
  *
  * Prints statistics about the percpu allocator and backing chunks.
  */
diff --git a/mm/percpu.c b/mm/percpu.c
index e9844086b236..d7e3bc649f4e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2009		Tejun Heo <tj@kernel.org>
  *
  * Copyright (C) 2017		Facebook Inc.
- * Copyright (C) 2017		Dennis Zhou <dennisszhou@gmail.com>
+ * Copyright (C) 2017		Dennis Zhou <dennis@kernel.org>
  *
  * The percpu allocator handles both static and dynamic areas.  Percpu
  * areas are allocated in chunks which are divided into units.  There is
-- 
2.24.1

