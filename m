Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7678620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520756;
	bh=RgtwO8P4ThNDooONmVCNihMiiHEBUmQW2apUetaPoEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcK/BD3B3bnFHCCg7mnaMLCCM+3z8yut2Rrbh4LFhzZX5tRRLvphKqzXAbDsiUlo5
	 23E7qgwIXvf32Ev39XCifvmXGNE6yGfxrJuOS7PmpmnTnMzcWeiF2z54EftnECxPTp
	 IO/oOxK8igQl3t/uB/5E4EeF30+jLn8ZuGJWL5og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392415AbgEZTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404202AbgEZTNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:13:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EACE208B3;
        Tue, 26 May 2020 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520401;
        bh=RgtwO8P4ThNDooONmVCNihMiiHEBUmQW2apUetaPoEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkMzTTWWnBYENAit+Zv2Jf+Ut2C1UMnfbVnbl6VE19s7dscGlt+XYEOeIc1fwZjIl
         XGgQNhPD/bqEX9DZUUJu5H9SxtKotOgTzvmcBDhs99524M7nfDOjI7hp5QgVlLOpXM
         74aOxtSaO8pgWrWB71HiCjg2Vr/v4xnskcHicTeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 5.6 063/126] bpf: Add bpf_probe_read_{user, kernel}_str() to do_refine_retval_range
Date:   Tue, 26 May 2020 20:53:20 +0200
Message-Id: <20200526183943.453926113@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 47cc0ed574abcbbde0cf143ddb21a0baed1aa2df upstream.

Given bpf_probe_read{,str}() BPF helpers are now only available under
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE, we need to add the drop-in
replacements of bpf_probe_read_{kernel,user}_str() to do_refine_retval_range()
as well to avoid hitting the same issue as in 849fa50662fbc ("bpf/verifier:
refine retval R0 state for bpf_get_stack helper").

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200515101118.6508-3-daniel@iogearbox.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/verifier.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4113,7 +4113,9 @@ static int do_refine_retval_range(struct
 
 	if (ret_type != RET_INTEGER ||
 	    (func_id != BPF_FUNC_get_stack &&
-	     func_id != BPF_FUNC_probe_read_str))
+	     func_id != BPF_FUNC_probe_read_str &&
+	     func_id != BPF_FUNC_probe_read_kernel_str &&
+	     func_id != BPF_FUNC_probe_read_user_str))
 		return 0;
 
 	/* Error case where ret is in interval [S32MIN, -1]. */


