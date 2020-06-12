Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C4420835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="qAABzAjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLQCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFLQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:02:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221AAC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so10221954wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpEfyDCKd+ROB+iqmoyjwPMNPUKHkA0Y5oDot+dn0s=;
        b=qAABzAjm7oyQ4y1NqFm33ALKrsWUTBS3S09jG4BqvwbL0xCN56LMsAbtG51HFlJJAZ
         3lEuMT+JxCIBTR/jTJile+umYMucfLBAk2oSartCDjmFOPV8RlhVnJYKxMHsbyjWFfDw
         7eX9x99JBypZN8IsO8/xQR9TZ/5a98L1iUGqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpEfyDCKd+ROB+iqmoyjwPMNPUKHkA0Y5oDot+dn0s=;
        b=rZva0V6HLM4Ex393aAxgXTuBHxksNrvUlEcOxOhLub23DmMvELOegliWfGoeKMchfh
         CapQ4lyrvScj1s+WdTubPDw4xoeYJ+eQfyo/pCoAbSfl9aH5Xm5MONHDK9weH5zQmgQ/
         5NcrFDaelQvP/EEi2KWXLi+Z1IOgA5WM4z2JI5puvVAcfbs87PzjR/6pnMHXwy4+vLxR
         bE0SHn4FLegDzjngmoZzC81pC+jJSBh0PVY6Qcn1lx/yrRyYEi2DQGwpQiLpYQ8QGiz0
         fij6gyfFY3I1IUOrN7PGSmPMM+LU3/xGSlk28ouagQZFMfu6eRGTW8YIm8gn0z47FWUF
         bNQQ==
X-Gm-Message-State: AOAM532eRVpgTTzVjU8Jg+qxIl/H354JdJv0gFkhPZhygRe/5CeUT8nm
        tbdePwn0rJSrfWkGOf0RuEo8Rg==
X-Google-Smtp-Source: ABdhPJzJqYbDDGNdygvO/gn5chT5tfnHECzwSmpvROBRkZCI0/ho0BoMfKX6FdsDVl3UTVhkTu/MAQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr14866701wrq.328.1591977718846;
        Fri, 12 Jun 2020 09:01:58 -0700 (PDT)
Received: from antares.lan (1.e.7.e.0.1.3.6.1.5.d.2.f.1.0.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:901f:2d51:6310:e7e1])
        by smtp.gmail.com with ESMTPSA id k16sm11169941wrp.66.2020.06.12.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:01:57 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] flow_dissector: reject invalid attach_flags
Date:   Fri, 12 Jun 2020 17:01:40 +0100
Message-Id: <20200612160141.188370-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using BPF_PROG_ATTACH on a flow dissector program supports neither flags
nor target_fd but accepts any value. Return EINVAL if either are non-zero.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
---
 kernel/bpf/net_namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 78cf061f8179..56133e78ae4f 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -192,6 +192,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net *net;
 	int ret;
 
+	if (attr->attach_flags || attr->target_fd)
+		return -EINVAL;
+
 	type = to_netns_bpf_attach_type(attr->attach_type);
 	if (type < 0)
 		return -EINVAL;
-- 
2.25.1

