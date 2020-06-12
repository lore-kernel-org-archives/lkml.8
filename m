Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19702C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9964207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PBYbhxCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLQCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFLQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:02:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB4C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:02:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so10226828wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQejEshYFNqUb7v3sioackX6D/pyfet7gpxzYUl52wE=;
        b=PBYbhxCMm9X+7/S47/3y+XNZktGaW42Z7fcfOreCztwwDU50QNAbPSjHdjzR+nZFit
         305TjsQRfWasNDoU/NywVe2HLHqNrWeS7kF/hLOrAeXpuypJ4icYBdiY3OxolNpJVbsC
         j2Bp60+NVG2kGFpa1PAj91qYQMPUEWyZsQQqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQejEshYFNqUb7v3sioackX6D/pyfet7gpxzYUl52wE=;
        b=sprG5fkQk36x7xyNkQgMi2vEH1VvUUr61WzAUfBuMboSyvzJEjq1ay0F9jD+PiUZGp
         ttZNYQbyBIw6Fiksn7jI7D3llGlF94HL+IftPhWH1fIX1A6ob5OnniV8A/phRRbDNLrw
         8O/vnL6taH+4TGSIc+NazD8TqPs4p3vqt7hF/WfsfrT2AGtmPM+v2W0J9kfuAbZWCXE+
         Rr+anA1Fmel+Bv4VisupBo5q7BCsEfKISVys/KKXoCX3Be8XtJNWXEmTPdodurbJdXAY
         OXEa5CgpohDL6ZhqtaaTse6Rvx6dHz6WkLMCt67/MQ5vuS2cuPDd7C8rYOR9J8wdl1me
         xqNw==
X-Gm-Message-State: AOAM530lw+WITeYzRbwOtlo5SiILpRpMy64g8Jx6AOVRugXQUrUx+APX
        UtWK6vjGc00DWPDb0sxbewMwMA==
X-Google-Smtp-Source: ABdhPJwmxuL4QdXOsFvU61egyGC88qJdz9nI+m0Pp8bmpgmWGAwH/RDq42CraRgRg31Tvv29fPJ3/g==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr15244107wrn.86.1591977720712;
        Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
Received: from antares.lan (1.e.7.e.0.1.3.6.1.5.d.2.f.1.0.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:901f:2d51:6310:e7e1])
        by smtp.gmail.com with ESMTPSA id k16sm11169941wrp.66.2020.06.12.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf: sockmap: reject invalid attach_flags
Date:   Fri, 12 Jun 2020 17:01:41 +0100
Message-Id: <20200612160141.188370-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200612160141.188370-1-lmb@cloudflare.com>
References: <20200612160141.188370-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using BPF_PROG_ATTACH on a sockmap program currently understands no
flags, but accepts any value. Return EINVAL if any flags are specified.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00a26cf2cfe9..6f0894909138 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -70,6 +70,9 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct fd f;
 	int ret;
 
+	if (attr->attach_flags)
+		return -EINVAL;
+
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
-- 
2.25.1

