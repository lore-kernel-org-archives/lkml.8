Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEFDC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A11A2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594386700;
	bh=GC5XQdwAmbxeL9BiSSJkx+9P/hI7PVaj2CeNYPfjtfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxVIWbniq0y6hQA9B4SW78pnr2ZxBPBmj8JgBewfw8RBO8EzJ+NM8Fc7gpy7YXDig
	 QSvB3wKevqCK21DiEVWMEl4z1fLJRy6r+im18LN6OtG9AkAIy5OuyYJCbTZASs4RGk
	 uDxWrvCSgQJGBJBd/F2Q8NqZNlagC7h723/AK2G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgGJNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgGJNLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:11:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1E8206A5;
        Fri, 10 Jul 2020 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386698;
        bh=GC5XQdwAmbxeL9BiSSJkx+9P/hI7PVaj2CeNYPfjtfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM3h7HiZQqDTsv53FcQ0OjcaR3Ca6HCDUi4kNA44YS9kkKF7oEyBJOWWUcxC6USyl
         zTPxpB7z1THWGYhf5WewgNzaN64SqyZZ5BuvanSJ7h87hhA74nuickZgMSyTkGqAXn
         UWqbiSlp/5cDecVQXl62DxQ7vaiG/5G5tW91e6CM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 4/4] perf-probe: Warn if the target function is GNU Indirect function
Date:   Fri, 10 Jul 2020 22:11:33 +0900
Message-Id: <159438669349.62703.5978345670436126948.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159438665389.62703.13848613271334658629.stgit@devnote2>
References: <159438665389.62703.13848613271334658629.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn if the probe target function is GNU indirect function (GNU_IFUNC)
because it may not what the user want to probe.

The GNU indirect function ( https://sourceware.org/glibc/wiki/GNU_IFUNC )
is the dynamic solved symbol at runtime. IFUNC function is a selector
which is invoked from the elf loader, but the symbol address of the
function which will be modified by the IFUNC is same as the IFUNC in
the symbol table. This can confuse users who is trying to probe on
such functions.

For example, the memcpy is one of IFUNC.

# perf probe -x /lib64/libc-2.30.so -a memcpy
# perf probe -l
  probe_libc:memcpy    (on __new_memcpy_ifunc@x86_64/multiarch/memcpy.c in /usr/lib64/libc-2.30.so)

the probe is put on a IFUNC.

# perf record -e probe_libc:memcpy --call-graph dwarf -aR ./perf
# perf script
perf  1742 [000] 26201.715632: probe_libc:memcpy: (7fdaa53824c0)
            7fdaa53824c0 __new_memcpy_ifunc+0x0 (inlined)
            7fdaa5d4a980 elf_machine_rela+0x6c0 (inlined)
            7fdaa5d4a980 elf_dynamic_do_Rela+0x6c0 (inlined)
            7fdaa5d4a980 _dl_relocate_object+0x6c0 (/usr/lib64/ld-2.30.so)
            7fdaa5d42155 dl_main+0x1cc5 (/usr/lib64/ld-2.30.so)
            7fdaa5d5831a _dl_sysdep_start+0x54a (/usr/lib64/ld-2.30.so)
            7fdaa5d3ffeb _dl_start_final+0x25b (inlined)
            7fdaa5d3ffeb _dl_start+0x25b (/usr/lib64/ld-2.30.so)
            7fdaa5d3f117 .annobin_rtld.c+0x7 (inlined)
...

And the event is invoked from the elf loader instead of the target
program's main code.


Moreover, at this moment, we can not probe on the function which will
be selected by the IFUNC, because it is determined at runtime. But
uprobe will be prepared before running the target binary.

Thus, I decided to warn user when the perf probe detects the probe point
is on the GNU IFUNC symbol. Someone who wants to probe an IFUNC symbol to
debug the IFUNC function, they can ignore this warning.

Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Check GNU_IFUNC only for uprobe
   - Show function name instead of the address.
   - Update the warning message according to Andi's comment.
---
 tools/perf/util/probe-event.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8cd1224e5f4c..679447f13c20 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -375,9 +375,13 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 
 	/* Find the address of given function */
 	map__for_each_symbol_by_name(map, pp->function, sym) {
-		if (uprobes)
+		if (uprobes) {
 			address = sym->start;
-		else
+			if (sym->type == STT_GNU_IFUNC)
+				pr_warning("Warning: The probe function (%s) is a GNU indirect function.\n"
+					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
+					   pp->function);
+		} else
 			address = map->unmap_ip(map, sym->start) - map->reloc;
 		break;
 	}

