Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610592465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="bV93vL/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAVABP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:01:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33583 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAVABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:01:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so5435893wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OHaBdf9m1dDSgiWgOEcClSMTZD84LoHiqTmQD6cEaTs=;
        b=bV93vL/4fDzGXFO2JCLe7XSiny5jsOXP+1mc/RM3P5+9LAEdfRZ4M2qFZguvwNb7Xg
         9F1VYmZZ0XO1/g/fAbDib/KRX8L3WacCqQvO4UFl28J2h5N0x8RjEjQsbICjFSJoWwur
         dwzrNK6ji2knC+Pl++t+qqjSspXviqg+HIn8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OHaBdf9m1dDSgiWgOEcClSMTZD84LoHiqTmQD6cEaTs=;
        b=f+Es6abNr9xLu/FE5BVN5mquTMVIgqvcoM0PQdrY/bLXN3pCVHJIIcd+aeDJ2RtODR
         kZr8Qz7XSuva+QXcOwId13hZLK/o4h9aMCLCSyVG+WGWODs5SyCt9INaratWocn9uTFi
         IFjNTDQrqIbiBA5XDADlcDXUlw7MYlf3f+DyE2CvS+3s0sLXNP+52Lg/5mayusQhb/rN
         tK/4cVFqo2M4yDlBlt2qtcoNTnqAISxgFoUWRZzmEcjlgkWIFgNhSDGYlD3PHLn6Bin9
         5CgnCI2gcVuM+rv9iA9WYs7oySTTGKDoDRVDYB1+hRxZertZdK+aPQih/0r/lxGXFscp
         odRg==
X-Gm-Message-State: APjAAAXOGZGdIIS6ZmBg86CsEjMAk7eNp2PptKItztON0Z3IIPqn1JOY
        tax73KOUbyjYOSHgrbt07Kk25w==
X-Google-Smtp-Source: APXvYqzLfa6mB53r67UDMjQCKejKBIn+YrmuY3wys2gdKrsrsMSEhdOHpEKYG/W3HLJzNJrxjyoBgQ==
X-Received: by 2002:a5d:5234:: with SMTP id i20mr7998319wra.403.1579651271992;
        Tue, 21 Jan 2020 16:01:11 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:58ec])
        by smtp.gmail.com with ESMTPSA id n3sm1341159wmc.27.2020.01.21.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:01:11 -0800 (PST)
Date:   Wed, 22 Jan 2020 00:01:10 +0000
From:   Chris Down <chris@chrisdown.name>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] bpf: btf: Always output invariant hit in pahole DWARF to
 BTF transform
Message-ID: <20200122000110.GA310073@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to compile with CONFIG_DEBUG_INFO_BTF enabled, I got this
error:

    % make -s
    Failed to generate BTF for vmlinux
    Try to disable CONFIG_DEBUG_INFO_BTF
    make[3]: *** [vmlinux] Error 1

Compiling again without -s shows the true error (that pahole is
missing), but since this is fatal, we should show the error
unconditionally on stderr as well, not silence it using the `info`
function. With this patch:

    % make -s
    BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
    Failed to generate BTF for vmlinux
    Try to disable CONFIG_DEBUG_INFO_BTF
    make[3]: *** [vmlinux] Error 1

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: kernel-team@fb.com
---
 scripts/link-vmlinux.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c287ad9b3a67..bbe9be2bf5ff 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,13 +108,13 @@ gen_btf()
 	local bin_arch
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
-		info "BTF" "${1}: pahole (${PAHOLE}) is not available"
+		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
 		return 1
 	fi
 
 	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
 	if [ "${pahole_ver}" -lt "113" ]; then
-		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
+		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
 		return 1
 	fi
 
-- 
2.25.0

