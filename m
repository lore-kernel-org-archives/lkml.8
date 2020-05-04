Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C412C28CBC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA7D206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV1ryh5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEDDfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDDfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:35:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19637C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:35:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d22so2711208pgk.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFNufphzGXBROWukXNZxiPGve6xzr6sYwrgcdceohMg=;
        b=GV1ryh5W4p2i91iOvBeY319Lo8wB1lMJwKED2JyA/X1gGb84GTBDtj/8wpHj8CTuvB
         7ZdCSuUj0WFi9JMTjFRtVPQuvizXe+svoHjmHxuXXYrL5LkT11sfexpsIAgMeRXtumeC
         qi2AuexiAFbeFB4VqDCEOMI4aTEOB8+kaJiAm1YY1QMlB3z1wuvdUd/4VQiEqu8vEfqE
         ja4F/BHKrek4TvowrBE1ZJexAxHf0+GjJ9ZwAjKvobXp4M7w32vTIcijPCh+UrSRQsOJ
         KMvFY+IuGbN648iRssrsrgC/GeAVlQ3K75GjFh/pXv1KiOGMPIuAbcDpHAOUqVUn3nzV
         jaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFNufphzGXBROWukXNZxiPGve6xzr6sYwrgcdceohMg=;
        b=SSaXYMrbiUDGvdQi0QH1yl4oNLwo7uRYr+eCG4wJAxWimpI5SiPaQNiQ/pRjXKfKPB
         mrdkp14WMHarG8DL7D7Ch05dkNkjAaHDosm9n6EZer45mYPDqChbukzARVpvciO1WGi8
         vr+YCLx2tyvMozmomlUZEJbls3X+7EHEhu+eSFy8QfExDMexlRF8enIms0ZdnedShKUG
         MRkk2Xtpl/xB68WHo2CSJIWOkA7Pb3O3L/i/kiTIxhGx0nZLwnxd2fvQgOwK9Ip9FjbM
         MS6If7iHFSGWWMPCUmHluJTh0hjxOxT9Qk81UG1ojf3Hz7FCur1yw+ZrhoF6BJzKeJ8V
         97Ig==
X-Gm-Message-State: AGi0PuYl3/9x0tazSVMoUXUFWXK1flHKwDqFxmMcdkvaMaNGf62j+SuV
        SmlQmVGsWao1CdZbKMS23e0=
X-Google-Smtp-Source: APiQypIUj5/ud6OPqvUH768YcPFfFfrPqd9lWvnlEMI0Uuz3a0NaVv6xmyYs9yNnsFO4TW4tnwR0eg==
X-Received: by 2002:a63:2347:: with SMTP id u7mr14728495pgm.183.1588563346621;
        Sun, 03 May 2020 20:35:46 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id p66sm7474051pfb.65.2020.05.03.20.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 20:35:46 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5.6-rt] mm: slub: Always flush the delayed empty slubs in flush_all()
Date:   Mon,  4 May 2020 11:34:07 +0800
Message-Id: <20200504033407.2385-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f0b231101c94 ("mm/SLUB: delay giving back empty slubs to
IRQ enabled regions"), when the free_slab() is invoked with the IRQ
disabled, the empty slubs are moved to a per-CPU list and will be
freed after IRQ enabled later. But in the current codes, there is
a check to see if there really has the cpu slub on a specific cpu
before flushing the delayed empty slubs, this may cause a reference
of already released kmem_cache in a scenario like below:
	cpu 0				cpu 1
  kmem_cache_destroy()
    flush_all()
                         --->IPI       flush_cpu_slab()
                                         flush_slab()
                                           deactivate_slab()
                                             discard_slab()
                                               free_slab()
                                             c->page = NULL;
      for_each_online_cpu(cpu)
        if (!has_cpu_slab(1, s))
          continue
        this skip to flush the delayed
        empty slub released by cpu1
    kmem_cache_free(kmem_cache, s)

                                       kmalloc()
                                         __slab_alloc()
                                            free_delayed()
                                            __free_slab()
                                            reference to released kmem_cache

Fixes: f0b231101c94 ("mm/SLUB: delay giving back empty slubs to IRQ enabled regions")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 mm/slub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 15c194ff16e6..83b29bf71fd0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2402,9 +2402,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);
-- 
2.26.0

