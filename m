Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CB020842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE9f0Eg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCBTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:10:13 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40487 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:10:13 -0500
Received: by mail-qv1-f67.google.com with SMTP id ea1so423083qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FT+gA03R7sYYywonP3FXBoJ8aaFtyvcvQUrij5tqPLg=;
        b=sE9f0Eg0VhRGny9VwikAD3qu6192FQtCMvMKbtoWt8LD1wnNJIu/GoTwLGXwa07W7v
         N8H1KLALaO+//cwUqXg7AlkYafRAD+vuxKpcY53Bl9IdnmS5HYADY4CK1/edJRwxsytu
         Oi8lGG2fteDT48bodChU0feXMtLXlkbPlmqFAlGIvE7qOByRn1ubq9o+N6ckgn9EkuCx
         DPLWUY+/PoGP0geHKcMp+Kfon04pwBIeczpBSzEAC8Xm8lXixUDVLG7joogPuHj33WrD
         270PNe3strTBwn/Gpq0RtMPVLy2E726z6E002R3YMUpuGMB76gK7cAzo0rNfLS4LUDXN
         gYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FT+gA03R7sYYywonP3FXBoJ8aaFtyvcvQUrij5tqPLg=;
        b=fx2zz2F6/ZVaZWAwZ2kQUfeFyZn9wzredu2EDKG+7Ybi4+qXlLdzH2Ns8BGXUvRZxP
         9Z84s8x1t8lDicCC+bsDgg80FhMvCuYEasMavmgs5Na75fz+9rJkxO9IbgvPLZgQLTHy
         Q+lU89sto1O0LCex+aGgv25lpVW/cljLXZc5iVzEoi2dBFWC9XKjw012zZv2nuza5r9K
         atrS8QMenSuodvDHOryWwi9NOEK6o+pYcciU6KCmIUvgOE4MTCFvndW7g20T4Vjfw2Pp
         pMV7avNbkhyUHWi1Go/fpPB8/5YlePufDmOWCZ4YOHpBWg77/Sv3EPT5H0VSFTLpffB8
         qhYw==
X-Gm-Message-State: ANhLgQ3LE4lmJaJd7ccJ++NztPla0wq/+JcEtH2tSDZyJEbx96BsZEXU
        T6Z+UonJBlOuvKefxwtGaoo=
X-Google-Smtp-Source: ADFU+vv3UgOjuWcH1zefXPfEQtQjOtCOFhn9t/kwbxmfNj+MkVUklLkkGvhCsNStG/+V9ptHnCTj8Q==
X-Received: by 2002:a0c:e7c3:: with SMTP id c3mr803548qvo.183.1583176211659;
        Mon, 02 Mar 2020 11:10:11 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i1sm5193890qtg.31.2020.03.02.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:10:11 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3D2D403AD; Mon,  2 Mar 2020 16:10:07 -0300 (-03)
Date:   Mon, 2 Mar 2020 16:10:07 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf symbols: Don't try to find a vmlinux file when looking
 for kernel modules
Message-ID: <20200302191007.GD10335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dso->kernel value is now set to everything that is in
machine->kmaps, but that was being used to decide if vmlinux lookup is
needed, which ended up making that lookup be made for kernel modules,
that now have dso->kernel set, leading to these kinds of warnings when
running on a machine with compressed kernel modules, like fedora:31:
    
  [root@five ~]# perf record -F 10000 -a sleep 2
  [ perf record: Woken up 1 times to write data ]
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  lzma: fopen failed on vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
  lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
  lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
  [ perf record: Captured and wrote 1.024 MB perf.data (1366 samples) ]
  [root@five ~]#

This happens when collecting the buildid, when we find samples for
kernel modules, fix it by checking if the looked up DSO is a kernel
module by other means.

Fixes: 02213cec64bb ("perf maps: Mark module DSOs with kernel type")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1077013d8ce2..26bc6a0096ce 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1622,7 +1622,12 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (dso->kernel) {
+	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+
+	if (dso->kernel && !kmod) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
@@ -1650,12 +1655,6 @@ int dso__load(struct dso *dso, struct map *map)
 	if (!name)
 		goto out;
 
-	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
-
-
 	/*
 	 * Read the build id if possible. This is required for
 	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
