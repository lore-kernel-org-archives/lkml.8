Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF7C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5D2206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkz39G++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgDDFOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 01:14:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgDDFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 01:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585977278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZpFf/EoCFh5H+QhRcDIRFMLkLiYNbq7Buj4lk/PV9+E=;
        b=Gkz39G++aYlnMkwUgw1TjGcNADhbWXvaH3nYNBLmmCHtbj8LoS0cHfD2+CG1Z7RKE+SIk6
        wHeg4Hz1R6JC84u1++NS6dO44BZ6ZO5jK1RngfFl7FKmCgy1o9/Ek7uAPHAUMt+Jy4rf6f
        guHlY/h1+Z3fa/76SI+mvaTlxfrKl2g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-0xgC6SnvMRSLsmNc8VYbNg-1; Sat, 04 Apr 2020 01:14:36 -0400
X-MC-Unique: 0xgC6SnvMRSLsmNc8VYbNg-1
Received: by mail-qv1-f70.google.com with SMTP id h12so7735518qvx.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 22:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpFf/EoCFh5H+QhRcDIRFMLkLiYNbq7Buj4lk/PV9+E=;
        b=p/IVH847ACs3AoDvLjiPvlnIRvQJTo+Zs8gYN1l38B9VdXXZgBR/fCxvwH/CReLWFj
         /WrPOuyWHwXt5St7wJ41yJR0JGWdf43qN9QllbhB19fuCFR47yPRxiwFjT4IFrJ69sY0
         CXcXxbtYfmSy/XAmftGfj2bAKuX3bRtnBxAv4ypswjNEsJvpLjF30o7br0uAJ1NgsKvZ
         oCDfFjzzathafP/KT0A8bNrcVc9PS65wmRE3lRSLKtFcfc+Qu+KdLKdOI1loIX4WSzOh
         RUelAEHvMai+gkP8avcb5OGViPqkHVvNuCoOUA1o9zzp8nfIxFiDJJQGVHMy1d8hK+t3
         LlKg==
X-Gm-Message-State: AGi0PuYIOCAM89kghkHh3T/RdxMlOgOf5XIe4Ty72CEqZ7dl+MhIUXDZ
        lZ9bdEho30zkqvDrnDvCQ4MeGeSuVK2d9e3PErdPltNoF9T1cWR33lkvsXvprxyCnc6zVpF2kMG
        qIc6S/V/ZNV8d8Z6gE9OBKaIh
X-Received: by 2002:a37:bc81:: with SMTP id m123mr12055897qkf.319.1585977276502;
        Fri, 03 Apr 2020 22:14:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypKViJKhK46Bek5h3iQkjtptKzLOTEk2G1SgElgDH20cPIvTEPA2VrkO8I0zh/Xbyt+SD5/dCQ==
X-Received: by 2002:a37:bc81:: with SMTP id m123mr12055873qkf.319.1585977275982;
        Fri, 03 Apr 2020 22:14:35 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id t23sm8844247qtj.63.2020.04.03.22.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 22:14:35 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] libbpf: Initialize *nl_pid so gcc 10 is happy
Date:   Sat,  4 Apr 2020 01:14:30 -0400
Message-Id: <20200404051430.698058-1-jcline@redhat.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builds of Fedora's kernel-tools package started to fail with "may be
used uninitialized" warnings for nl_pid in bpf_set_link_xdp_fd() and
bpf_get_link_xdp_info() on the s390 architecture.

Although libbpf_netlink_open() always returns a negative number when it
does not set *nl_pid, the compiler does not determine this and thus
believes the variable might be used uninitialized. Assuage gcc's fears
by explicitly initializing nl_pid.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1807781
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 tools/lib/bpf/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 18b5319025e19..9a14694176de0 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -142,7 +142,7 @@ static int __bpf_set_link_xdp_fd_replace(int ifindex, int fd, int old_fd,
 		struct ifinfomsg ifinfo;
 		char             attrbuf[64];
 	} req;
-	__u32 nl_pid;
+	__u32 nl_pid = 0;
 
 	sock = libbpf_netlink_open(&nl_pid);
 	if (sock < 0)
@@ -288,7 +288,7 @@ int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
 {
 	struct xdp_id_md xdp_id = {};
 	int sock, ret;
-	__u32 nl_pid;
+	__u32 nl_pid = 0;
 	__u32 mask;
 
 	if (flags & ~XDP_FLAGS_MASK || !info_size)
-- 
2.26.0

