Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03EF20EDD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825266;
	bh=Pzq/bwdmcfK0uHr0nFUNIcZXV374tVzgP2Jls2Q/+1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dj0eY38clQbMSwx0sP9hiATnawgzvtAbFG1sXSuA4pH2X8rZPq6+70czxzbfVvjSd
	 Fkn4gMaiK6A6M0GevYuCmq3BSeovZsZOCkn1iGe5+7e069nc7Q45Py2R0Oal4+Sag1
	 odbszWckoZjHzsqtoOnbJ7jJJrKSU9fr3XhMaRcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgERSHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgERSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A5A20715;
        Mon, 18 May 2020 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825257;
        bh=Pzq/bwdmcfK0uHr0nFUNIcZXV374tVzgP2Jls2Q/+1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lk1RJ1Rb55qMeYzg5BzbKBpFWWz0Kaz/4R6+iHZ5C2DllmyqrICWSgMZngg/WAi4p
         O0PYE2L7vZ8YUtPQGxEUUTec61aM8kpkGhZaH2NMvsEnv4J6rK3CnVWoqBV19HNSNY
         t5AQqfr1VCIsnhvXuRMq1DZColVMSMmPa40kmn2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5.6 191/194] bpf: Enforce returning 0 for fentry/fexit progs
Date:   Mon, 18 May 2020 19:38:01 +0200
Message-Id: <20200518173547.306820163@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

commit e92888c72fbdc6f9d07b3b0604c012e81d7c0da7 upstream.

Currently, tracing/fentry and tracing/fexit prog
return values are not enforced. In trampoline codes,
the fentry/fexit prog return values are ignored.
Let us enforce it to be 0 to avoid confusion and
allows potential future extension.

This patch also explicitly added return value
checking for tracing/raw_tp, tracing/fmod_ret,
and freplace programs such that these program
return values can be anything. The purpose are
two folds:
 1. to make it explicit about return value expectations
    for these programs in verifier.
 2. for tracing prog_type, if a future attach type
    is added, the default is -ENOTSUPP which will
    enforce to specify return value ranges explicitly.

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200514053206.1298415-1-yhs@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/verifier.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6498,6 +6498,22 @@ static int check_return_code(struct bpf_
 			return 0;
 		range = tnum_const(0);
 		break;
+	case BPF_PROG_TYPE_TRACING:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+			range = tnum_const(0);
+			break;
+		case BPF_TRACE_RAW_TP:
+			return 0;
+		default:
+			return -ENOTSUPP;
+		}
+		break;
+	case BPF_PROG_TYPE_EXT:
+		/* freplace program can return anything as its return value
+		 * depends on the to-be-replaced kernel func or bpf program.
+		 */
 	default:
 		return 0;
 	}


