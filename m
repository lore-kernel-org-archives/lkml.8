Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7949A21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="lqbjIQov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAUPEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:04:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:04:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so3583497wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3fX8yqVdokeUbIrwEfgnVCmcXTtAwRGxuX8ZNd4rp/U=;
        b=lqbjIQovQBhxj+xtgVpB8uPL58iOhyecjOyhwTyWj62vfntLi4PpGJ6VfGKjJ2QUnK
         JMumsdiQl5V6T7LB2vFENkf8ojE07zTSr/3BJxxB/9O7BC4rZwYKSzfyCvx7JknD3GMV
         Ea2K+iKl2ejNEzovb915Aw97aYSA1UGVo51PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3fX8yqVdokeUbIrwEfgnVCmcXTtAwRGxuX8ZNd4rp/U=;
        b=dA8W0F+JESjhVfP5/hFzg+1di5L6sBgRwc92q1yR3d7+jZMMEV3y6mEnXHsjkP3KpH
         R10MqHz7oE36vJ5qEJknW8RLH51S1wLCkgoGyv5rByiuUJz5afbo9tYk6L5/z7ZfIyH2
         ktpedTOc8AZHGBC575lpPeoViDOvZtj2dnAoHpYEVz7UB0MZC42y7I+JR9pMbksARgu2
         jyLU2zAg1ha/YeM1yGB09f6m0vwCflCG279jmyL+qzsdvcS9vIuTimtRgpMsJPUT8pQ0
         MNlyUqByHnkfTcRqIGSHO7zvmRLC+6Ku3n+ZACo/+IJ+6aUX3pZocFpHgAjie1uSWnku
         NSRg==
X-Gm-Message-State: APjAAAUX/q9+ek8PnzR9pEOKzKB5TTX4B8ik6uo5GUBiGjklTftBK5N+
        rngz0x5xLJdycYBnhZaIe5Op2g==
X-Google-Smtp-Source: APXvYqw/n/eK5Xu7u+qMpNfuL8mmr6BDT1kDRYsC9l5O4JsvXRyvkzv097K0+46FPQDNAoOyCpapCg==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr5816499wru.6.1579619072431;
        Tue, 21 Jan 2020 07:04:32 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:db6c])
        by smtp.gmail.com with ESMTPSA id s15sm49352115wrp.4.2020.01.21.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:04:31 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:04:31 +0000
From:   Chris Down <chris@chrisdown.name>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] bpf: btf: Always output invariant hit in pahole DWARF to BTF
 transform
Message-ID: <20200121150431.GA240246@chrisdown.name>
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
 scripts/link-vmlinux.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c287ad9b3a67..c8e9f49903a0 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,13 +108,15 @@ gen_btf()
 	local bin_arch
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
-		info "BTF" "${1}: pahole (${PAHOLE}) is not available"
+		printf 'BTF: %s: pahole (%s) is not available\n' \
+			"${1}" "${PAHOLE}" >&2
 		return 1
 	fi
 
 	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
 	if [ "${pahole_ver}" -lt "113" ]; then
-		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
+		printf 'BTF: %s: pahole version %s is too old, need at least v1.13\n' \
+			"${1}" "$(${PAHOLE} --version)" >&2
 		return 1
 	fi
 
-- 
2.25.0

