Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28E8C38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5B720857
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796911;
	bh=NZ2s3E1f67YnyHKyGwrL2P4yPLowkmxMtpl5S3GHJk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHJXYMH6ZSQLxjiasmU0n3Xa+682TADclV8CrY7BzuoEqRd/hAJsmkW2aTJxAGxJD
	 tpM2lOVGcv2OJ6mHZ+cQ0duKj0W3cnjSj/90BjjqornBqgJmt6vezoYpc2AMTlfkEO
	 gTg/PN9ioxC+qCOum1WKZ9eDPOCPx2C522by8B30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgDMQzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbgDMQwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:52:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F4B20739;
        Mon, 13 Apr 2020 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796742;
        bh=NZ2s3E1f67YnyHKyGwrL2P4yPLowkmxMtpl5S3GHJk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+WOgDHoUv4hg0PBxM8flytJgmDI0SRl6gIm6oRYcUwUPjwzgAGOy+9So5eE/tkhH
         3kGbtivhnwFWH1lO5swi+aq66jpZcihvR5y70HT/U9Mq+nA8sqvrvCZ2kIzh5uFKEd
         7RqxSEijCx2SSe9sgXHy9WdMJ9dqwzJ1eNa5QEJo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?q?Bj=C3=83=C2=B6rn=20T=C3=83=C2=B6pel?= 
        <bjorn.topel@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/26] perf machine: Set ksymbol dso as loaded on arrival
Date:   Mon, 13 Apr 2020 13:51:39 -0300
Message-Id: <20200413165203.1816-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no special load action for ksymbol data on map__load/dso__load
action, where the kernel is getting loaded. It only gets confused with
kernel kallsyms/vmlinux load for bpf object, which fails and could mess
up with the map.

Disabling any further load of the map for ksymbol related dso/map.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: BjÃ¶rn TÃ¶pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200312195610.346362-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 97142e9671be..06aa4e4db63d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -759,6 +759,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		dso__set_loaded(dso);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
-- 
2.21.1

