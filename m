Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C2C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44932072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383621;
	bh=NZ2s3E1f67YnyHKyGwrL2P4yPLowkmxMtpl5S3GHJk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1hQiWK6DAL2vaRF0n0PE1PGNNEALho6cTxI28MGf+LQO2VXL0Mw5wNE+f5pAsLVsO
	 l73UF1L0VKUtQNbP53XOmm40Z9bD7hHapGNbaHJJSK03IYrhNseQ1+LSx5vqVtrG6q
	 faG8JOpE6r+cfJJ9OwfWStTEGnhecdvbRLxrbu2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDTLxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:53:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB9221D94;
        Mon, 20 Apr 2020 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383617;
        bh=NZ2s3E1f67YnyHKyGwrL2P4yPLowkmxMtpl5S3GHJk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtS9m/MpvSy7dzuaa0UNWkPvcRKsDDDG4hiw+NwxuT1uICr8dbRsaFr7ywCs5z5IO
         zkyuE7Uynxke/cKblnasqf5VeyPWHFrM888QGtdOamL7O8HphvKexr35HkGspsxFf6
         LYGtptEEUOymv7M6UourUZj9zcwvtzw5zIMzlLR4=
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
Subject: [PATCH 03/60] perf machine: Set ksymbol dso as loaded on arrival
Date:   Mon, 20 Apr 2020 08:52:19 -0300
Message-Id: <20200420115316.18781-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
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

