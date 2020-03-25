Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB0C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D826A2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140352;
	bh=Zp0xuKobEYfkEhlp2F7SiBckao1WWUW2Ke/OPXNTQ0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y0drlE7UyZnR82NyXgf2WzDU84vmIefwmSXmHDP8ac71WMwIsTdkX26no4BQT9hRY
	 pXPd0If7RFTF59JDddKtP/v6hWcoQdKfquWLhQQ6KrejTtXCxSProNLJ4aHLuQWXFN
	 qbCTMZsG10OyuHFKwedOeoZLwvBl/z/YS44pEqeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCYMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:45:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:45:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id l184so989813pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tc8uHbwM3FhGi/4bJYsBrYx/w3VhPJAJEPeUmWgTbds=;
        b=eyHlKsutB/8/W9DYowbkhVeQeuZt32nO/HJN82NYWiwJlw7tlnbbbALy30o1Vv63rb
         VmjIrlu4YJ5tJT73+N5w5NmwABl39Pt5YUB7ewSFBkN+2HaJ3aeoGTURYy4zy55Ez74I
         Nb+DRfIT/EXYQiibCYvLAJjs6FS93ZiGa0OLUqsoYdjp3Sk7hYLzSIwoYRR3GL6kjNcg
         ZuXLK++yVa+dlx12x0flHe9K+ys8GEx+J6USa4lVz6IL+0e1vKRW/gNaDiyAjN/ueNoB
         tk/Fk9Bh+6tK4GuavOfUrs1uGUTtOv2PnQKp5lUdFB4gyaAnqUbje0+1FYE3ju9EZNbd
         uCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Tc8uHbwM3FhGi/4bJYsBrYx/w3VhPJAJEPeUmWgTbds=;
        b=Djx3QUt0Mts1u9/CVgVte5RaRl7oqwvhQGPnNlsgv57uJ5aqi53WbpoDlzOx0MhX9O
         /Vd89Lvne8+rURQflE2kgGZ3aLyu5lBroVQoltvpIxLuO3iDkJTYPgs/4qH/EOqVNujy
         D8XTTaMz7drHltNTkt+yeZt8BI1I1qvCIixNESvbCHmmAbblX4usyvDigsWjxx6LgD3b
         CAxF1h6sbykTkpgsd0f/7fGiQqnq9LztvhvGfRmtJKWd3SPurMJTH48TqXTNE7hd+H7t
         6aYogmPIPz/Nak1ZVGXRb+JjYkZeP7NrYmNgD6Er4CnCMrs388jAnbuubEKSe+NmIUoc
         JZCA==
X-Gm-Message-State: ANhLgQ33M3z+5J8YXPQeuh0VbrtnUdaaGUm+iLNWenjtp2tY3RRL6QY0
        UKN5Tiw1Q2wgntiwyHMRmSA=
X-Google-Smtp-Source: ADFU+vtA6P/A3vzVeM8SkcNI7KgPCQ7mTmvAuoR7vA68uBGqR/bEjR49ydfWZOjQKfDBi37wfy7Rmw==
X-Received: by 2002:a63:1517:: with SMTP id v23mr2880808pgl.89.1585140349932;
        Wed, 25 Mar 2020 05:45:49 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:45:49 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kbuild test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date:   Wed, 25 Mar 2020 21:45:28 +0900
Message-Id: <20200325124536.2800725-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support cgroup tracking, add CGROUP event to save a link between
cgroup path and id number.  This is needed since cgroups can go away
when userspace tries to read the cgroup info (from the id) later.
The attr.cgroup bit was also added to enable cgroup tracking from
userspace.

This event will be generated when a new cgroup becomes active.
Userspace might need to synthesize those events for existing cgroups.

Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
[staticize perf_event_cgroup function]
Reported-by: kbuild test robot <lkp@intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/perf_event.h |  13 +++-
 kernel/events/core.c            | 111 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 397cfd65b3fe..de95f6c7b273 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -381,7 +381,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1012,6 +1013,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d22e4ba59dfa..994932d5e474 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -387,6 +387,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_cgroup_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4608,6 +4609,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_dec(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_dec(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_dec(&nr_task_events);
 	if (event->attr.freq)
@@ -7735,6 +7738,105 @@ void perf_event_namespaces(struct task_struct *task)
 			NULL);
 }
 
+/*
+ * cgroup tracking
+ */
+#ifdef CONFIG_CGROUP_PERF
+
+struct perf_cgroup_event {
+	char				*path;
+	int				path_size;
+	struct {
+		struct perf_event_header	header;
+		u64				id;
+		char				path[];
+	} event_id;
+};
+
+static int perf_event_cgroup_match(struct perf_event *event)
+{
+	return event->attr.cgroup;
+}
+
+static void perf_event_cgroup_output(struct perf_event *event, void *data)
+{
+	struct perf_cgroup_event *cgroup_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u16 header_size = cgroup_event->event_id.header.size;
+	int ret;
+
+	if (!perf_event_cgroup_match(event))
+		return;
+
+	perf_event_header__init_id(&cgroup_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				cgroup_event->event_id.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, cgroup_event->event_id);
+	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	cgroup_event->event_id.header.size = header_size;
+}
+
+static void perf_event_cgroup(struct cgroup *cgrp)
+{
+	struct perf_cgroup_event cgroup_event;
+	char path_enomem[16] = "//enomem";
+	char *pathname;
+	size_t size;
+
+	if (!atomic_read(&nr_cgroup_events))
+		return;
+
+	cgroup_event = (struct perf_cgroup_event){
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_CGROUP,
+				.misc = 0,
+				.size = sizeof(cgroup_event.event_id),
+			},
+			.id = cgroup_id(cgrp),
+		},
+	};
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (pathname == NULL) {
+		cgroup_event.path = path_enomem;
+	} else {
+		/* just to be sure to have enough space for alignment */
+		cgroup_path(cgrp, pathname, PATH_MAX - sizeof(u64));
+		cgroup_event.path = pathname;
+	}
+
+	/*
+	 * Since our buffer works in 8 byte units we need to align our string
+	 * size to a multiple of 8. However, we must guarantee the tail end is
+	 * zero'd out to avoid leaking random bits to userspace.
+	 */
+	size = strlen(cgroup_event.path) + 1;
+	while (!IS_ALIGNED(size, sizeof(u64)))
+		cgroup_event.path[size++] = '\0';
+
+	cgroup_event.event_id.header.size += size;
+	cgroup_event.path_size = size;
+
+	perf_iterate_sb(perf_event_cgroup_output,
+			&cgroup_event,
+			NULL);
+
+	kfree(pathname);
+}
+
+#endif
+
 /*
  * mmap tracking
  */
@@ -10781,6 +10883,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_inc(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_inc(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_inc(&nr_task_events);
 	if (event->attr.freq)
@@ -12757,6 +12861,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(jc);
 }
 
+static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
+{
+	perf_event_cgroup(css->cgroup);
+	return 0;
+}
+
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
@@ -12778,6 +12888,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 struct cgroup_subsys perf_event_cgrp_subsys = {
 	.css_alloc	= perf_cgroup_css_alloc,
 	.css_free	= perf_cgroup_css_free,
+	.css_online	= perf_cgroup_css_online,
 	.attach		= perf_cgroup_attach,
 	/*
 	 * Implicitly enable on dfl hierarchy so that perf events can
-- 
2.25.1.696.g5e7596f4ac-goog

