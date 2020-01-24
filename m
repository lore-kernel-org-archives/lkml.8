Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B34C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20A208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858415;
	bh=kp3IHcUGCWSe9ZCqHXFVdUGxGW8YejMbbuy0RmSLS4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J9OrC3h6sftJjWOjtNCPRbJE5hfdP4rzIdM3Lbkg7r9zXU8qtmAi8EcA3VjwQdwbp
	 FDyUxXrqLawgB0Jgl5Cm+cn2kYyuXvsSo4YxnvT1bFw0CllLWMdBJCqyTm67Y6+9VP
	 Ocy0TMGcyBy6aTMDkDxPmuTNYi6ynG1CFOsZ8yOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgAXJde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgAXJdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:33:32 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39202070A;
        Fri, 24 Jan 2020 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858410;
        bh=kp3IHcUGCWSe9ZCqHXFVdUGxGW8YejMbbuy0RmSLS4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFIstm8Fu44uVBMsf9QTGtcQHnQ4fo4DOmkCvCWMZc/TY690KoakSyd7afVeILOWO
         8C9e+b9AfQOToev+ziFQodSAaeGgUIo0I0b7ZizkwU6gr84nqr89YanlSGy2nuAqn7
         UFYqZPqz6HXMSNFii2P8FjI/unRQU9ikV54O2hzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.4 003/102] libbpf: Fix memory leak/double free issue
Date:   Fri, 24 Jan 2020 10:30:04 +0100
Message-Id: <20200124092806.581825738@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

commit 3dc5e059821376974177cc801d377e3fcdac6712 upstream.

Coverity scan against Github libbpf code found the issue of not freeing memory and
leaving already freed memory still referenced from bpf_program. Fix it by
re-assigning successfully reallocated memory sooner.

Fixes: 2993e0515bb4 ("tools/bpf: add support to read .BTF.ext sections")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20191107020855.3834758-2-andriin@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/bpf/libbpf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3220,6 +3220,7 @@ bpf_program__reloc_text(struct bpf_progr
 			pr_warning("oom in prog realloc\n");
 			return -ENOMEM;
 		}
+		prog->insns = new_insn;
 
 		if (obj->btf_ext) {
 			err = bpf_program_reloc_btf_ext(prog, obj,
@@ -3231,7 +3232,6 @@ bpf_program__reloc_text(struct bpf_progr
 
 		memcpy(new_insn + prog->insns_cnt, text->insns,
 		       text->insns_cnt * sizeof(*insn));
-		prog->insns = new_insn;
 		prog->main_prog_cnt = prog->insns_cnt;
 		prog->insns_cnt = new_cnt;
 		pr_debug("added %zd insn from %s to prog %s\n",


