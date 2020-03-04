Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F922073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T8AlxQB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgCDCSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:18:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbgCDCSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:18:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id y26so132980pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QV949Rj3SIT5hQv6NYpR6RXzDT9qy+AIzP4ZAVBgOIY=;
        b=T8AlxQB0grraQTN3SYX821Hs2NAC4rtmjN4f+u6itDMX3gg4QoWZHItd6ExweAu7e8
         Oh2aO0XTOZQjg2yHjm12YMHdUq9oTJHwnhvNdxXnyfu6V+Q5ajjNosTYsdMa7QyrHpFx
         j09Q0Md55ADFcq4cfHMj3QjhK6Kws6tlgIeHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QV949Rj3SIT5hQv6NYpR6RXzDT9qy+AIzP4ZAVBgOIY=;
        b=UaWIAyqoM+qpkXxEUbtfUqtZCSk4dgEGuKF3Pe9RRtvwDVdMMqU8tqMt+ZCB6PFZTf
         q6/8pERsJiqUuTT9b1Ckx9qahunksqFQnNWgTeWM+KsGVfngzbW9i2OyFyLODvrKCgRV
         jSUcVGn9H5C5KIuqqrnh29k0fVoFgSsqI33MNHUgKvFXzZ4l4IKxbx5/FO1T1pzyMZ8l
         4QuL6tSDvJ61t5raKmO2bxTbS+54D/TjQOJjqEeW6yfvCb12rBueNDGw7UKUcGVeM2WW
         tJvZVQYnmfSRVdgOYtsDr3DIF/GaQu32iXbsiPTjOwAZpQuqc+Ak6CarUB3vEnCPoass
         k+vQ==
X-Gm-Message-State: ANhLgQ2tPokbGZHK5iFpd5CSlyBLzvnLbQ8SsA5ckk45fQtUHb+D2Vir
        1goE+2bs7Kjc1rdnKMSZxk7bL8bTDtQ=
X-Google-Smtp-Source: ADFU+vuECxjtA8O7vuZBduDwuodZBCiamgB2PThSyYeI44skV+ytDpW6OfrCvkGtgqWWycYS9PBowg==
X-Received: by 2002:a63:af53:: with SMTP id s19mr408689pgo.175.1583288316825;
        Tue, 03 Mar 2020 18:18:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm23809343pgt.70.2020.03.03.18.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 18:18:35 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:18:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v2] kbuild: Remove debug info from kallsyms linking
Message-ID: <202003031814.4AEA3351@keescook>
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
Additionally move "info BTF" to the correct place since commit
8959e39272d6 ("kbuild: Parameterize kallsyms generation and correct
reporting"), which added "info LD ..." to vmlinux_link calls.

For a full debug info build with BTF, my link time goes from 1m06s to
0m54s, saving about 12 seconds, or 18%.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
v2: add Ack, clarify "info BTF" relocation
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
