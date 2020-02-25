Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98565C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A924684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CjAlLRcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgBYFQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:16:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38701 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYFQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:16:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so6298256pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=U6Wt/LenosPR0Sx0SmEySrtroNHk0FTBlW4IV6YiiMg=;
        b=CjAlLRcClG0VLkuNyIO9/QTuQ1crb4nJN7Ei+88NEFieNYHXTldlqvWRyC3yHQUUo7
         Wg/5YaAStuyQ1MJGta9daj7RlBnPIPJ3aReGwAgeNQpWUZdkQTfiKw7DNVpjaHnu4XyE
         JhqVUYtujl/gVANQ91Gq143qIqyFwJLLxHKEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U6Wt/LenosPR0Sx0SmEySrtroNHk0FTBlW4IV6YiiMg=;
        b=aNwyx2TvKf7IY6Uldo74qdBPHXjAAjeJdG0fBE0Fi7KwRprUMYAzpaiuW79V5Y5hR/
         jrdR79YI1cHf31R7h6VxCFCl1Z+wi5G1FOJGe18DtUgsZWW72BQZYvwz1x4UyvDwiZ5B
         4gzveNTavHOIVJv+LSolavg3RXLNVTrt305w9maRKYOh2RJCBiA4XnWvYKVAVtsEmY1r
         v9I4znBTQDYMcmh6vwGQkDoU/B1IuSDJ3Z0P6Mv0D9QSr3YSnuKVtACwY2rZIidoHKH6
         F9wnpUfNzrOhDhF5OCFQF8nqNNSQxvGnbDGl/pqvOrmUYLrhRM5A0XeAfILY3++E2hLz
         VsAQ==
X-Gm-Message-State: APjAAAWM0ihFCfVrpwUqxuUFcG22scbFXKtCI/MeacSWlys2Hv6o64rq
        oTD+KEYra0glHWPCkPVX1Z8a9A==
X-Google-Smtp-Source: APXvYqxbtsVYkZjGvUrOjcRDv596Y0cYc435LUeOQfjMG0mCl0eJzQVykAP7z8nr0Sxk5qefm6bfOw==
X-Received: by 2002:a63:8e44:: with SMTP id k65mr11985018pge.452.1582607778850;
        Mon, 24 Feb 2020 21:16:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm1169792pjp.14.2020.02.24.21.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:16:18 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:16:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Remove debug info from kallsyms linking
Message-ID: <202002242114.CBED7F1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_INFO is enabled, the two kallsyms linking steps spend
time collecting and writing the dwarf sections to the temporary output
files. kallsyms does not need this information, and leaving it off
halves their linking time. This is especially noticeable without
CONFIG_DEBUG_INFO_REDUCED. The BTF linking stage, however, does still
need those details.

Refactor the BTF and kallsyms generation stages slightly for more
regularized temporary names. Skip debug during kallsyms links.

For a full debug info build with BTF, my link time goes from 1m06s to
0m54s, saving about 12 seconds, or 18%.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index dd484e92752e..ac569e197bfa 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -63,12 +63,18 @@ vmlinux_link()
 	local lds="${objtree}/${KBUILD_LDS}"
 	local output=${1}
 	local objects
+	local strip_debug
 
 	info LD ${output}
 
 	# skip output file argument
 	shift
 
+	# The kallsyms linking does not need debug symbols included.
+	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
+		strip_debug=-Wl,--strip-debug
+	fi
+
 	if [ "${SRCARCH}" != "um" ]; then
 		objects="--whole-archive			\
 			${KBUILD_VMLINUX_OBJS}			\
@@ -79,6 +85,7 @@ vmlinux_link()
 			${@}"
 
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
+			${strip_debug#-Wl,}			\
 			-o ${output}				\
 			-T ${lds} ${objects}
 	else
@@ -91,6 +98,7 @@ vmlinux_link()
 			${@}"
 
 		${CC} ${CFLAGS_vmlinux}				\
+			${strip_debug}				\
 			-o ${output}				\
 			-Wl,-T,${lds}				\
 			${objects}				\
@@ -106,6 +114,8 @@ gen_btf()
 {
 	local pahole_ver
 	local bin_arch
+	local bin_format
+	local bin_file
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
@@ -118,8 +128,9 @@ gen_btf()
 		return 1
 	fi
 
-	info "BTF" ${2}
 	vmlinux_link ${1}
+
+	info "BTF" ${2}
 	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
 
 	# dump .BTF section into raw binary file to link with final vmlinux
@@ -127,11 +138,12 @@ gen_btf()
 		cut -d, -f1 | cut -d' ' -f2)
 	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
 		awk '{print $4}')
+	bin_file=.btf.vmlinux.bin
 	${OBJCOPY} --change-section-address .BTF=0 \
 		--set-section-flags .BTF=alloc -O binary \
-		--only-section=.BTF ${1} .btf.vmlinux.bin
+		--only-section=.BTF ${1} $bin_file
 	${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
-		--rename-section .data=.BTF .btf.vmlinux.bin ${2}
+		--rename-section .data=.BTF $bin_file ${2}
 }
 
 # Create ${2} .o file with all symbols from the ${1} object file
@@ -166,8 +178,8 @@ kallsyms()
 kallsyms_step()
 {
 	kallsymso_prev=${kallsymso}
-	kallsymso=.tmp_kallsyms${1}.o
-	kallsyms_vmlinux=.tmp_vmlinux${1}
+	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
+	kallsymso=${kallsyms_vmlinux}.o
 
 	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
 	kallsyms ${kallsyms_vmlinux} ${kallsymso}
@@ -190,7 +202,6 @@ cleanup()
 {
 	rm -f .btf.*
 	rm -f .tmp_System.map
-	rm -f .tmp_kallsyms*
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
@@ -257,9 +268,8 @@ tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
 
 btf_vmlinux_bin_o=""
 if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
-	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
-		btf_vmlinux_bin_o=.btf.vmlinux.bin.o
-	else
+	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
+	if ! gen_btf .tmp_vmlinux.btf $btf_vmlinux_bin_o ; then
 		echo >&2 "Failed to generate BTF for vmlinux"
 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
 		exit 1
-- 
2.20.1


-- 
Kees Cook
