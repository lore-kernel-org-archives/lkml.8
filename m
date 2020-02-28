Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F149CC3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C6246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="lsd7u/wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgB1Lyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:54:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgB1Lyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:54:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id v2so2571134wrp.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=lsd7u/wbZ+WEtU7Zu/blNg6YCQE6j6PcKMK7Ynz/VrYdm9MpeXcL47A6XPJZSubLI8
         B72tsfM8iIGm2DikmdXwYByhjVNC7eaK7VTQmdfXwCVqaK4gJn8e0jfHBD0Jjp3mi6Hb
         pOR5x6Xgg2B22tFcttYzzEEMY9hb0e6CI7Vg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=nq60NtNZYFga6oOSuquEomg1tR2+NeVMdKjl+9jLjA/TIfMznybkXgRr0utH4oOf8s
         JeDFTifDzEpmJDUo8hjG8Mtz7f27WaTwg5nZCytZuViXusfIds4MR89I2i/F/UBcUj2y
         FI46v+rmLJUG4TIQPD479FRRiRsd30qjOJ1AN7+Fu4sNeVArDKwhk4/ujLYTdxDJIX7p
         SwwqYacNQNqcCbfCOQnL5rwN7X5HkfwHPB9e5A8h2BJgKnSIsdzmL9eeP6Ew1OI3shbX
         mmkfHXZnOZUJ+jW+OTcqWs0gEKA2bKLODjG7e5YaD3zm68sl1v+K9b6nKXc7nJfZGEbN
         Lwxg==
X-Gm-Message-State: APjAAAXumly9RkROKEkXpdv70/DQaUOu+jqi4ctnbfvjqxIP+bfKMXPH
        dLfOJWWJPEU/3btK5qtb0UIfbw==
X-Google-Smtp-Source: APXvYqxJOCIBurk6Jls7sZVmorMG3mSVBtjX2iT3L6h2322sJJpOuLtQdNYKQUfCqV/GYafskYxluA==
X-Received: by 2002:adf:ebca:: with SMTP id v10mr4553098wrn.307.1582890887425;
        Fri, 28 Feb 2020 03:54:47 -0800 (PST)
Received: from antares.lan (b.2.d.a.1.b.1.b.2.c.5.e.0.3.d.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4d30:e5c2:b1b1:ad2b])
        by smtp.gmail.com with ESMTPSA id q125sm2044284wme.19.2020.02.28.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:54:46 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 8/9] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Fri, 28 Feb 2020 11:53:43 +0000
Message-Id: <20200228115344.17742-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228115344.17742-1-lmb@cloudflare.com>
References: <20200228115344.17742-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap
has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index a1dd13b34d4b..821b4146b7b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -805,12 +805,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
-	/* SOCKMAP/SOCKHASH don't support UDP yet */
-	if (sotype == SOCK_DGRAM &&
-	    (inner_map_type == BPF_MAP_TYPE_SOCKMAP ||
-	     inner_map_type == BPF_MAP_TYPE_SOCKHASH))
-		return;
-
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
 			continue; /* test not compatible with socket type */
-- 
2.20.1

