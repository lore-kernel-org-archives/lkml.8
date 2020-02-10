Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824EC3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7EA20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581345164;
	bh=oz4pF8eBf7LHUWhtiifzhHy2PGleiLKDs9rUfuIU6k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdagsPlG+EkAkXTU/3Pyzu81+wTHACcEjhAR36kB3F9p42jYB6uF2HsHLyPEe0Yff
	 dU9Kvd2vGAfoOJ5D4NGORt6HIWIWn5wqidtRg7gR7+bEX0kOFUI+2tETKrHa2YEthI
	 pAo3b/hiT7tBx9UmfXAb35NBMb6QxsNjBY/nqkWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBJOcn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:32:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39843 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbgBJOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:32:42 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-2mkHyP3OM4iZsy39PIdPKg-1; Mon, 10 Feb 2020 09:32:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F7018A8C82;
        Mon, 10 Feb 2020 14:32:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC6860BF1;
        Mon, 10 Feb 2020 14:32:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 4/4] perf tools: Move kmap::kmaps setup to maps__insert
Date:   Mon, 10 Feb 2020 15:32:18 +0100
Message-Id: <20200210143218.24948-5-jolsa@kernel.org>
In-Reply-To: <20200210143218.24948-1-jolsa@kernel.org>
References: <20200210143218.24948-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2mkHyP3OM4iZsy39PIdPKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the kmaps pointer setup is centralized and we do not need
to update it in all those places (2 current places and few
more missing) after calling maps__insert.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 13 +------------
 tools/perf/util/map.c     | 10 ++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0a43dc83d7b2..460315476314 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -979,7 +979,6 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(&machine->kmaps, map);
@@ -1089,9 +1088,6 @@ int __weak machine__create_extra_kernel_maps(struct machine *machine __maybe_unu
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
-	struct kmap *kmap;
-	struct map *map;
-
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
@@ -1100,14 +1096,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		return -1;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	map = machine__kernel_map(machine);
-	kmap = map__kmap(map);
-	if (!kmap)
-		return -1;
-
-	kmap->kmaps = &machine->kmaps;
-	maps__insert(&machine->kmaps, map);
-
+	maps__insert(&machine->kmaps, machine->vmlinux_map);
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cea05fc9595c..a08ca276098e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -543,6 +543,16 @@ void maps__insert(struct maps *maps, struct map *map)
 	__maps__insert(maps, map);
 	++maps->nr_maps;
 
+	if (map->dso && map->dso->kernel) {
+		struct kmap *kmap = map__kmap(map);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+
+
 	/*
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
-- 
2.24.1

