Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB9C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950642074B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxAf5d48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgDEQFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:05:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44451 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:05:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so6284476pgf.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UqSgbTfBu0jcZCaM0oc0kISBfiho9HffnFw9COQCojE=;
        b=VxAf5d48DRZRexH/cGYVkrCik5YS23LJI3vRfWq8DrC4jnEYODgwRQUFtMzFMPuI0A
         RvwDNcqY9+LziDLgktH5++yTO9Lj++8hXi+6AP0ZV7pnug3iG1S0/cQfysVfbO2l+Q5p
         M5D5Bc8vt0lFg0baXuXbt0Gq5ve38+wYFd0w6CcCUnmE2TURjkQACXRl5SEvtoAWeZ9b
         xD3y66TPFmPwgVOH3EllNP5StDWc7AETGUEK3OvLF59KGA6xKELTm0knAaEk2Mju9tY5
         2xED/nMUHF/VPn+j0QH4lvlbaYyXuUeTA+h1+tvufCO7VOBjVCjY+BX4lVvSlolyFRf2
         m3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UqSgbTfBu0jcZCaM0oc0kISBfiho9HffnFw9COQCojE=;
        b=E3XWtkQ45GAXgwO75sY58k4/ghjnVax9wJBR3ETKKb6Z0J6f4iwh8LIWoUObbIx5Pl
         P9KHSd93oVv0d5WNhvLuBKE5c2v7JwJFerZO9cOU907veMvW7D0toOuRLXvse5lNyVgs
         odvMvQHOv9hYnxd+yeNWn/1G71AmUrFdi6lX59s+GUI2X8WqnpT7OPon2XvaQ6J+hMwc
         nr08GuVgnayMe6zwu3nfscVspDoPxyB5GLgKxwqNACcLvY4MKu1dw0m6GzcwYPUxju4c
         Tw0y1oCy/iNuICKMQ+R3uJPza7V08FzMxAyJpOWuP5c7KW4JY96yPb9S8FFY0IoZHgaC
         gTSw==
X-Gm-Message-State: AGi0PubQ0X+L71uBmMy/m1fuEyGimlGBvbEjqwqZGHMZP0TebJmVNfnV
        ++ZgP2P4mubTHixXQgmFFQ0=
X-Google-Smtp-Source: APiQypLrDyCz/U4y3UC+l4l4tbPtwWcKMXexbWVdmeqmWmeaTYmwilsYrTURuLKWupJ+PgFkuJNFAw==
X-Received: by 2002:a63:d351:: with SMTP id u17mr17163613pgi.396.1586102751711;
        Sun, 05 Apr 2020 09:05:51 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id m2sm10068699pjk.4.2020.04.05.09.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 09:05:51 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] mm, slab_common: Fix a typo in comment "eariler"->"earlier"
Date:   Mon,  6 Apr 2020 00:05:44 +0800
Message-Id: <20200405160544.1246-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in comment, fix it.
s/eariler/earlier/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1907cb2903c7..3b93a95cfb02 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -731,7 +731,7 @@ static void kmemcg_rcufn(struct rcu_head *head)
 	/*
 	 * We need to grab blocking locks.  Bounce to ->work.  The
 	 * work item shares the space with the RCU head and can't be
-	 * initialized eariler.
+	 * initialized earlier.
 	 */
 	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
 	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
-- 
2.17.1

