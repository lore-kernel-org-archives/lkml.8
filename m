Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C50EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153E2207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="dvW6TLlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgHUPTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgHUPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:18:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5FFC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:18:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so2711180ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8voqPtdkbS5RYnHXaRVOj2SC1jKq1kvwIX4dEXxo6Mc=;
        b=dvW6TLlrJDjEGEAodToyDRSdHDeVtZrTlPkpphXFgZJP4ruoNqioicEo4SMlj9EfGK
         KLlAyo5ddYuHnf1bsdHvxvDjO1lwoBOqtzy2+pwPdbhwiCZ1tPSsaBPt+RoKCgqO3CXU
         N77y5xO4VcKYT5Smo8DWsiDJyE1DRxyJOjiTH8orJd/clT93vKL932S2vtrOR34IeQ2z
         /1a7dMTEh/KA+3/Y3sLxVKrNMBN+Xs3gF6gD83owYvA7PI3PxUmzEpvi1B5gw4tmNKJ5
         jXyk4e0s4V6OskizHXK/slofY+JymE2bOvkNZ/wKqH7UK1/VXILgidv09hZM3fFR1ev5
         AEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8voqPtdkbS5RYnHXaRVOj2SC1jKq1kvwIX4dEXxo6Mc=;
        b=nUL2tZgXrIBmHcDMGSGsV5WeImnysi5idcqhaHfvAnNrnVe4QlCwuKzj78evrGq3wF
         SGBLnVUucyc6EfNkBTTgpkoT3vspUuB9mIrM8jy51zA+bvT5m7gzU4Geq4wioseDkqqN
         D36rtv7P6hL3nvXF/UZ3PG5yNikGVut+N/MvbKG4ZXjgPrY4RI3GEJ6W8XfqeS/kKWva
         FFrUUeiN3v19oR/712Xe+raemMfqKSrFlB5qlJ4RN0+YQ5FudAYPY26KTESVBMwlV584
         F49KBP4e0wiVG9ujZ7cEqfU7VGf4t5cvPIA/dzfef/aDC8GRjpCtYRdsW4iY6QPKMjE1
         FGJQ==
X-Gm-Message-State: AOAM530y6OYhdQBOw1oVRuCfmdMJbbMmpLlaIET9lswzEBAOn9n74yWW
        zqpZ3wratgyvO4ucf+DkgCOo8w==
X-Google-Smtp-Source: ABdhPJwOpYm/JZsOt4i112M5zKTyBI4MB/fD3+CWboBDW0jaVUFuRbJKjSTrWL2TU33N/sswar++nQ==
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr3575446ejn.56.1598023097397;
        Fri, 21 Aug 2020 08:18:17 -0700 (PDT)
Received: from localhost.localdomain (223.60-242-81.adsl-dyn.isp.belgacom.be. [81.242.60.223])
        by smtp.gmail.com with ESMTPSA id qp16sm1482709ejb.89.2020.08.21.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:18:16 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/3] mptcp: attach subflow socket to parent cgroup
Date:   Fri, 21 Aug 2020 17:15:40 +0200
Message-Id: <20200821151544.1211989-3-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821151544.1211989-1-nicolas.rybowski@tessares.net>
References: <20200821151544.1211989-1-nicolas.rybowski@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed that the kernel sockets created for the subflows
(except the first one) are not in the same cgroup as their parents.
That's because the additional subflows are created by kernel workers.

This is a problem with eBPF programs attached to the parent's
cgroup won't be executed for the children. But also with any other features
of CGroup linked to a sk.

This patch fixes this behaviour.

As the subflow sockets are created by the kernel, we can't use
'mem_cgroup_sk_alloc' because of the current context being the one of the
kworker. This is why we have to do low level memcg manipulation, if
required.

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 net/mptcp/subflow.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8cac2655c82..535a3f9f8cfc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1130,6 +1130,30 @@ int __mptcp_subflow_connect(struct sock *sk, int ifindex,
 	return err;
 }
 
+static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+{
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	struct sock_cgroup_data *parent_skcd = &parent->sk_cgrp_data,
+				*child_skcd = &child->sk_cgrp_data;
+
+	/* only the additional subflows created by kworkers have to be modified */
+	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
+	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
+#ifdef CONFIG_MEMCG
+		struct mem_cgroup *memcg = parent->sk_memcg;
+
+		mem_cgroup_sk_free(child);
+		if (memcg && css_tryget(&memcg->css))
+			child->sk_memcg = memcg;
+#endif /* CONFIG_MEMCG */
+
+		cgroup_sk_free(child_skcd);
+		*child_skcd = *parent_skcd;
+		cgroup_sk_clone(child_skcd);
+	}
+#endif /* CONFIG_SOCK_CGROUP_DATA */
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1150,6 +1174,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 
 	lock_sock(sf->sk);
 
+	/* the newly created socket has to be in the same cgroup as its parent */
+	mptcp_attach_cgroup(sk, sf->sk);
+
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 */
-- 
2.28.0

