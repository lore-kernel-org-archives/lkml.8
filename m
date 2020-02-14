Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F0C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6155A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOHJbFLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgBNEIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:08:05 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41682 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgBNEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:08:05 -0500
Received: by mail-io1-f65.google.com with SMTP id m25so9082832ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g/1Jk3mtbadzw4L1okkvpYISXwJslSTM7k9X5r8t9lo=;
        b=HOHJbFLJfRysO5nDIRyHqzVUPUcKe/Pd/D88lvWDDbRcCjIe0kQ03VfzkXiHqyIGYF
         3OzuDrBDIkmx7u7Xc2IPeyAjr0R54vGLW1g9HME0Jxzj26g/3n9vk9KC78eTnw9SRpnV
         PkX/GoV1y6MLmspD6kKtdKmxUa0CBpOtQ5MIG2EmJjV2hswXwpPEPrrnHQJt3/+6HWUC
         szpwezRqJssnqZ2QVJYbvx6P9zlBFUKSov/FaGSFiZNUfgH4znGOYP5rAbTWIC6TIrjY
         HdVrF70av5+OHgXR4sIJMQE89PAahN44b9tSo5wZNbZKD4H/WLF4vxNaNkS2J9YuCcSU
         mcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g/1Jk3mtbadzw4L1okkvpYISXwJslSTM7k9X5r8t9lo=;
        b=HUiLo8GQwg+ySWtytrQu+v227AqIaWlihj33n2kmHOtnaDuH4zrsAK7L3d+mvvHpsz
         5BizkHtiOU+vZ6FImzlKtGK8EY6vwyjgdOvu+BNQJgWxlSFzMFl98yTmFqylZND5zvue
         Iilh1pLEuXHsMgUPRf93Xsy0JV9GRm5z1uBYxXj5lRDwY2T9JLI/4nRDL+A9uuCYz4bX
         H82XPDkgOhHTEiCf/uYAv3sK4eSnQbcx+jzS/zw6jy1K64tsVmwneqQVY71OppWzDWOW
         8GkDj3R+XGw8/nUMQ6h3h4sjB8mt3yxqQX1J9Ahic/bRHL8zdLr78aGuvSDoTWPGsgp4
         Jr5Q==
X-Gm-Message-State: APjAAAVCiysd0JZokuGnyPrftW4uygtU1ksgySF7YR6OnT/1G87dFviZ
        ygdNTFbOh03N+1lPpRIq+kVNOGfu4lvPzE8L310=
X-Google-Smtp-Source: APXvYqx9wm1JhVDjER/3tKBYkw3APXuWqRZLPYRzBfTDKAqaGnfTgT9QaDugKx4Uas7fEwd1x2D9wU2sGI6dj91DnAE=
X-Received: by 2002:a5d:8f90:: with SMTP id l16mr702474iol.165.1581653284272;
 Thu, 13 Feb 2020 20:08:04 -0800 (PST)
MIME-Version: 1.0
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com> <1581401993-20041-4-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1581401993-20041-4-git-send-email-iamjoonsoo.kim@lge.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 14 Feb 2020 13:07:53 +0900
Message-ID: <CAAmzW4NGwvTiE_unACAcSZUH9V3tO0qR=ZPxi=q9s=zDi53DeQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] mm/workingset: extend the workingset detection for
 anon LRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 2=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:20, <=
js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> In the following patch, workingset detection will be applied to
> anonymous LRU. To prepare it, this patch adds some code to
> distinguish/handle the both LRUs.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/mmzone.h | 14 +++++++++-----
>  mm/memcontrol.c        | 12 ++++++++----
>  mm/vmscan.c            | 15 ++++++++++-----
>  mm/vmstat.c            |  6 ++++--
>  mm/workingset.c        | 35 ++++++++++++++++++++++-------------
>  5 files changed, 53 insertions(+), 29 deletions(-)

This patch should be changed as following.

-       enum lru_list active_lru =3D page_lru_base_type(page) + LRU_ACTIVE_=
FILE;
+       enum lru_list active_lru =3D page_lru_base_type(page) + LRU_ACTIVE;

Whole fixed patch is as following.

--------------------->8----------------------
From 2b0691140d11c4e9a0f1500dda831b70697b2a00 Mon Sep 17 00:00:00 2001
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Fri, 15 Nov 2019 09:40:22 +0900
Subject: [PATCH] mm/workingset: extend the workingset detection for anon LR=
U

In the following patch, workingset detection will be applied to
anonymous LRU. To prepare it, this patch adds some code to
distinguish/handle the both LRUs.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h | 14 +++++++++-----
 mm/memcontrol.c        | 12 ++++++++----
 mm/vmscan.c            | 15 ++++++++++-----
 mm/vmstat.c            |  6 ++++--
 mm/workingset.c        | 35 ++++++++++++++++++++++-------------
 5 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5334ad8fc7bd..b78fd8c7284b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,8 +220,12 @@ enum node_stat_item {
  NR_ISOLATED_ANON, /* Temporary isolated pages from anon lru */
  NR_ISOLATED_FILE, /* Temporary isolated pages from file lru */
  WORKINGSET_NODES,
- WORKINGSET_REFAULT,
- WORKINGSET_ACTIVATE,
+ WORKINGSET_REFAULT_BASE,
+ WORKINGSET_REFAULT_ANON =3D WORKINGSET_REFAULT_BASE,
+ WORKINGSET_REFAULT_FILE,
+ WORKINGSET_ACTIVATE_BASE,
+ WORKINGSET_ACTIVATE_ANON =3D WORKINGSET_ACTIVATE_BASE,
+ WORKINGSET_ACTIVATE_FILE,
  WORKINGSET_RESTORE,
  WORKINGSET_NODERECLAIM,
  NR_ANON_MAPPED, /* Mapped anonymous pages */
@@ -304,10 +308,10 @@ enum lruvec_flags {
 struct lruvec {
  struct list_head lists[NR_LRU_LISTS];
  struct zone_reclaim_stat reclaim_stat;
- /* Evictions & activations on the inactive file list */
- atomic_long_t inactive_age;
+ /* Evictions & activations on the inactive list */
+ atomic_long_t inactive_age[2];
  /* Refaults at the time of last reclaim cycle */
- unsigned long refaults;
+ unsigned long refaults[2];
  /* Various lruvec state flags (enum lruvec_flags) */
  unsigned long flags;
 #ifdef CONFIG_MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c83cf4ed970..8f4473d6ff9c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1431,10 +1431,14 @@ static char *memory_stat_format(struct
mem_cgroup *memcg)
  seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
         memcg_events(memcg, PGMAJFAULT));

- seq_buf_printf(&s, "workingset_refault %lu\n",
-        memcg_page_state(memcg, WORKINGSET_REFAULT));
- seq_buf_printf(&s, "workingset_activate %lu\n",
-        memcg_page_state(memcg, WORKINGSET_ACTIVATE));
+ seq_buf_printf(&s, "workingset_refault_anon %lu\n",
+        memcg_page_state(memcg, WORKINGSET_REFAULT_ANON));
+ seq_buf_printf(&s, "workingset_refault_file %lu\n",
+        memcg_page_state(memcg, WORKINGSET_REFAULT_FILE));
+ seq_buf_printf(&s, "workingset_activate_anon %lu\n",
+        memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
+ seq_buf_printf(&s, "workingset_activate_file %lu\n",
+        memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
  seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
         memcg_page_state(memcg, WORKINGSET_NODERECLAIM));

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4122a841dfce..74c3adefc933 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2735,7 +2735,10 @@ static bool shrink_node(pg_data_t *pgdat,
struct scan_control *sc)
  if (!sc->force_deactivate) {
  unsigned long refaults;

- if (inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+ refaults =3D lruvec_page_state(target_lruvec,
+ WORKINGSET_ACTIVATE_ANON);
+ if (refaults !=3D target_lruvec->refaults[0] ||
+ inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
  sc->may_deactivate |=3D DEACTIVATE_ANON;
  else
  sc->may_deactivate &=3D ~DEACTIVATE_ANON;
@@ -2746,8 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct
scan_control *sc)
  * rid of any stale active pages quickly.
  */
  refaults =3D lruvec_page_state(target_lruvec,
-      WORKINGSET_ACTIVATE);
- if (refaults !=3D target_lruvec->refaults ||
+ WORKINGSET_ACTIVATE_FILE);
+ if (refaults !=3D target_lruvec->refaults[1] ||
      inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
  sc->may_deactivate |=3D DEACTIVATE_FILE;
  else
@@ -3026,8 +3029,10 @@ static void snapshot_refaults(struct mem_cgroup
*target_memcg, pg_data_t *pgdat)
  unsigned long refaults;

  target_lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
- refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
- target_lruvec->refaults =3D refaults;
+ refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
+ target_lruvec->refaults[0] =3D refaults;
+ refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
+ target_lruvec->refaults[1] =3D refaults;
 }

 /*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..3cdf8e9b0ba2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1146,8 +1146,10 @@ const char * const vmstat_text[] =3D {
  "nr_isolated_anon",
  "nr_isolated_file",
  "workingset_nodes",
- "workingset_refault",
- "workingset_activate",
+ "workingset_refault_anon",
+ "workingset_refault_file",
+ "workingset_activate_anon",
+ "workingset_activate_file",
  "workingset_restore",
  "workingset_nodereclaim",
  "nr_anon_pages",
diff --git a/mm/workingset.c b/mm/workingset.c
index 474186b76ced..5fb8f85d1fec 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -15,6 +15,7 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>

 /*
  * Double CLOCK lists
@@ -156,7 +157,7 @@
  *
  * Implementation
  *
- * For each node's file LRU lists, a counter for inactive evictions
+ * For each node's anon/file LRU lists, a counter for inactive evictions
  * and activations is maintained (node->inactive_age).
  *
  * On eviction, a snapshot of this counter (along with some bits to
@@ -213,7 +214,8 @@ static void unpack_shadow(void *shadow, int
*memcgidp, pg_data_t **pgdat,
  *workingsetp =3D workingset;
 }

-static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgda=
t)
+static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgda=
t,
+ int is_file)
 {
  /*
  * Reclaiming a cgroup means reclaiming all its children in a
@@ -230,7 +232,7 @@ static void advance_inactive_age(struct mem_cgroup
*memcg, pg_data_t *pgdat)
  struct lruvec *lruvec;

  lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
- atomic_long_inc(&lruvec->inactive_age);
+ atomic_long_inc(&lruvec->inactive_age[is_file]);
  } while (memcg && (memcg =3D parent_mem_cgroup(memcg)));
 }

@@ -248,18 +250,19 @@ void *workingset_eviction(struct page *page,
struct mem_cgroup *target_memcg)
  unsigned long eviction;
  struct lruvec *lruvec;
  int memcgid;
+ int is_file =3D page_is_file_cache(page);

  /* Page is fully exclusive and pins page->mem_cgroup */
  VM_BUG_ON_PAGE(PageLRU(page), page);
  VM_BUG_ON_PAGE(page_count(page), page);
  VM_BUG_ON_PAGE(!PageLocked(page), page);

- advance_inactive_age(page_memcg(page), pgdat);
+ advance_inactive_age(page_memcg(page), pgdat, is_file);

  lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
  /* XXX: target_memcg can be NULL, go through lruvec */
  memcgid =3D mem_cgroup_id(lruvec_memcg(lruvec));
- eviction =3D atomic_long_read(&lruvec->inactive_age);
+ eviction =3D atomic_long_read(&lruvec->inactive_age[is_file]);
  return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }

@@ -278,13 +281,16 @@ void workingset_refault(struct page *page, void *shad=
ow)
  struct lruvec *eviction_lruvec;
  unsigned long refault_distance;
  struct pglist_data *pgdat;
- unsigned long active_file;
+ unsigned long active;
  struct mem_cgroup *memcg;
  unsigned long eviction;
  struct lruvec *lruvec;
  unsigned long refault;
  bool workingset;
  int memcgid;
+ int is_file =3D page_is_file_cache(page);
+ enum lru_list active_lru =3D page_lru_base_type(page) + LRU_ACTIVE;
+ enum node_stat_item workingset_stat;

  unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);

@@ -309,8 +315,8 @@ void workingset_refault(struct page *page, void *shadow=
)
  if (!mem_cgroup_disabled() && !eviction_memcg)
  goto out;
  eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgdat);
- refault =3D atomic_long_read(&eviction_lruvec->inactive_age);
- active_file =3D lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+ refault =3D atomic_long_read(&eviction_lruvec->inactive_age[is_file]);
+ active =3D lruvec_page_state(eviction_lruvec, active_lru);

  /*
  * Calculate the refault distance
@@ -341,19 +347,21 @@ void workingset_refault(struct page *page, void *shad=
ow)
  memcg =3D page_memcg(page);
  lruvec =3D mem_cgroup_lruvec(memcg, pgdat);

- inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
+ workingset_stat =3D WORKINGSET_REFAULT_BASE + is_file;
+ inc_lruvec_state(lruvec, workingset_stat);

  /*
  * Compare the distance to the existing workingset size. We
  * don't act on pages that couldn't stay resident even if all
  * the memory was available to the page cache.
  */
- if (refault_distance > active_file)
+ if (refault_distance > active)
  goto out;

  SetPageActive(page);
- advance_inactive_age(memcg, pgdat);
- inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+ advance_inactive_age(memcg, pgdat, is_file);
+ workingset_stat =3D WORKINGSET_ACTIVATE_BASE + is_file;
+ inc_lruvec_state(lruvec, workingset_stat);

  /* Page was active prior to eviction */
  if (workingset) {
@@ -371,6 +379,7 @@ void workingset_refault(struct page *page, void *shadow=
)
 void workingset_activation(struct page *page)
 {
  struct mem_cgroup *memcg;
+ int is_file =3D page_is_file_cache(page);

  rcu_read_lock();
  /*
@@ -383,7 +392,7 @@ void workingset_activation(struct page *page)
  memcg =3D page_memcg_rcu(page);
  if (!mem_cgroup_disabled() && !memcg)
  goto out;
- advance_inactive_age(memcg, page_pgdat(page));
+ advance_inactive_age(memcg, page_pgdat(page), is_file);
 out:
  rcu_read_unlock();
 }
--=20
2.17.1
