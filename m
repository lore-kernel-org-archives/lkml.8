Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9317EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6988724684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gtrzkuQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgAWRAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:00:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgAWQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:59:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so3897730wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=gtrzkuQ3f7nCSsbvZV+79p3YHEpiG55tz/BtLLT1TKC04h4wnV8nBZfVTy/oeleTWI
         FLytsgneqoqPVgRerwb4UmFKfANQw/OyLCbDS9cyI8/FdPksxF1YRxNFYVfCmifcHrmO
         gfDjmiP/5qHzq51cApwjJfE8JvSN2pHsTbzhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=Br/rcPTWq5nbhVFZ6yTn/EZ4D30Wn1WVmu74hE1UJnU6cNTt62LNM3Bj7ivrteK4ao
         9Rlroap3t3kd2SDhdsLiN4g2w7T/MPgcyrOMGbDGkaAOk/KJQ/t+3fyM4+XluSPvR5nu
         aKiFZGjjn0r0W/LMchLFhKocklfI8BowN8JlU/Jfp/qzDHvcb0qr9hNSNZ2CU5nbUxRb
         wZwlHgZ3yqQI7X5PcezHbyJ78LFBet9Ixc2V2H7r+jqFjUAnCZ2F3me6KNJITN6uDy7E
         vZg8EQX3hBdcFFcrb0KcfQ95aGtaPb/K8YhQklMM54QSGqS/CBseIo29wsDC+n/BWMN6
         ficg==
X-Gm-Message-State: APjAAAUYCLGutWO49EbWh0g/bBe/9KrPeOlzAixK7LVHKVMRgQ1HIs6x
        TeVpHfTNt0hXdqnkMBcc8Zr+lA==
X-Google-Smtp-Source: APXvYqxZBMzloyeuvuGWMOXyEMsTRg357vgRAFLanDZW9K3hvo17Oc9CnYfhEOKDJRcCoIGSj/eFaA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr18246948wrj.325.1579798783545;
        Thu, 23 Jan 2020 08:59:43 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:d0a9:6cca:1210:a574])
        by smtp.gmail.com with ESMTPSA id u1sm3217698wmc.5.2020.01.23.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:59:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
Date:   Thu, 23 Jan 2020 16:59:31 +0000
Message-Id: <20200123165934.9584-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reuseport tests currently suffer from a race condition: RST
packets count towards DROP_ERR_SKB_DATA, since they don't contain
a valid struct cmd. Tests will spuriously fail depending on whether
check_results is called before or after the RST is processed.

Exit the BPF program early if FIN is set.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/progs/test_select_reuseport_kern.c        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index d69a1f2bbbfd..26e77dcc7e91 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -113,6 +113,12 @@ int _select_by_skb_data(struct sk_reuseport_md *reuse_md)
 		data_check.skb_ports[0] = th->source;
 		data_check.skb_ports[1] = th->dest;
 
+		if (th->fin)
+			/* The connection is being torn down at the end of a
+			 * test. It can't contain a cmd, so return early.
+			 */
+			return SK_PASS;
+
 		if ((th->doff << 2) + sizeof(*cmd) > data_check.len)
 			GOTO_DONE(DROP_ERR_SKB_DATA);
 		if (bpf_skb_load_bytes(reuse_md, th->doff << 2, &cmd_copy,
-- 
2.20.1

