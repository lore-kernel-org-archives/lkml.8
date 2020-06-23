Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501DD2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944332;
	bh=M+0sSCRDZWoAPBliZcFqcaB+5cROYX2R/+ZG6JIW9iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bij3e+4jeGYhlPChfaOJ60lTyOv3RSdw+6iZZsEADRdgymFiQKNH4Y+LtiYkoaeeT
	 t5j4NDl1rP7PwFxg/cIzPyu8ByV//Q+e2QaXYfb8K03gaeC67EQdeNbbXhED55i4OH
	 cfPO5XSkHwXGuYC06Hv/klmpaiP8V6oAMD/qrL+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbgFWUcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390988AbgFWUbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:31:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EFD207FF;
        Tue, 23 Jun 2020 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944309;
        bh=M+0sSCRDZWoAPBliZcFqcaB+5cROYX2R/+ZG6JIW9iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atsNorNoKDNbVS6ycQN6qNxywAX4VtGtWiqENl5nBDwJrsuckWen5N9lSzoVHgxDA
         +M2mDbCW1gBwZI71djvP/BjWJGmDjx78JI9/2H7U6XMOo+P+UebH5wYoGQIiQmNfl8
         qAE1Y9R8O1Z243WnUiB35d/HqPfg0xiKJt4EFe/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YiFei Zhu <zhuyifei@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 254/314] net/filter: Permit reading NET in load_bytes_relative when MAC not set
Date:   Tue, 23 Jun 2020 21:57:29 +0200
Message-Id: <20200623195351.079327441@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <zhuyifei1999@gmail.com>

[ Upstream commit 0f5d82f187e1beda3fe7295dfc500af266a5bd80 ]

Added a check in the switch case on start_header that checks for
the existence of the header, and in the case that MAC is not set
and the caller requests for MAC, -EFAULT. If the caller requests
for NET then MAC's existence is completely ignored.

There is no function to check NET header's existence and as far
as cgroup_skb/egress is concerned it should always be set.

Removed for ptr >= the start of header, considering offset is
bounded unsigned and should always be true. len <= end - mac is
redundant to ptr + len <= end.

Fixes: 3eee1f75f2b9 ("bpf: fix bpf_skb_load_bytes_relative pkt length check")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/76bb820ddb6a95f59a772ecbd8c8a336f646b362.1591812755.git.zhuyifei@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f1f2304822e3b..a0a492f7cf9ce 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1766,25 +1766,27 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	   u32, offset, void *, to, u32, len, u32, start_header)
 {
 	u8 *end = skb_tail_pointer(skb);
-	u8 *net = skb_network_header(skb);
-	u8 *mac = skb_mac_header(skb);
-	u8 *ptr;
+	u8 *start, *ptr;
 
-	if (unlikely(offset > 0xffff || len > (end - mac)))
+	if (unlikely(offset > 0xffff))
 		goto err_clear;
 
 	switch (start_header) {
 	case BPF_HDR_START_MAC:
-		ptr = mac + offset;
+		if (unlikely(!skb_mac_header_was_set(skb)))
+			goto err_clear;
+		start = skb_mac_header(skb);
 		break;
 	case BPF_HDR_START_NET:
-		ptr = net + offset;
+		start = skb_network_header(skb);
 		break;
 	default:
 		goto err_clear;
 	}
 
-	if (likely(ptr >= mac && ptr + len <= end)) {
+	ptr = start + offset;
+
+	if (likely(ptr + len <= end)) {
 		memcpy(to, ptr, len);
 		return 0;
 	}
-- 
2.25.1



