Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88192C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6155720748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JCLUg5q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgHUKbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHUKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75650C061349
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:30:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so1492217wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrkad1dT1PqnIAHvf/9uKqIEtr9fqQIFC7z/xBajrtk=;
        b=JCLUg5q3TNl+zUrInUVsJb9rfRTarwsabzIEn4Tk/CwtmbS/lp3Ou6S1BfWrBAUTJ7
         fws8rOT5/BjFv0fYuXRPPRRIlHmY3Un0j0LVVLnLcP2cEbTHgobtoDWS6tB0dXEQub8S
         z4XoKPVmyjyx5YlR9mxAGJYliSpvHRSmBlMXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrkad1dT1PqnIAHvf/9uKqIEtr9fqQIFC7z/xBajrtk=;
        b=jDEvJeMzhokY44e54mB0whYD5V/4PPeNRJ+nnyRDT0FwSV84yRDqeRO6WMLS2iTA1g
         +LVzDI0QzTvJ6Z0+zF65WunAMlfhywum1t1q8cN9y+VHs/rMdRbW98X1rsEArOFZ8QQ8
         QMgp0g/FTj1jM6iG2o/j3NJkKUnJ82jQ4r8Ds5Zv0LxHcVykyNnsC9oZh45Y+FW/JIB3
         u38Dmx1oqS/f7lRlHDD6FltQbtXRA6tkvW4NCTJQGW9Q5QgDc5KiaoriPMA07bN95GYn
         UzeYU8PE0gy7u6RtoKIAtFCmZXMyHcwd3EiE55u4i3qgRipVyhVhwcBNhQb8hnvtKzLw
         tBtg==
X-Gm-Message-State: AOAM5308ivw4fbfwDq929ip4SO0c07ZC64obLQ0h5uV14eqssunNLuzq
        BT0q6Ed4Y3haHgepMWwScS5wXg==
X-Google-Smtp-Source: ABdhPJzMynC4jfB4bnwwHan1D1AwRLftCS/eM+XLyQgRESI8PGz2Tg30nghCyVNW+ktKMZ6yhs3F0Q==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr2169405wrp.308.1598005814012;
        Fri, 21 Aug 2020 03:30:14 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] bpf: override the meaning of ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
Date:   Fri, 21 Aug 2020 11:29:46 +0100
Message-Id: <20200821102948.21918-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821102948.21918-1-lmb@cloudflare.com>
References: <20200821102948.21918-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verifier assumes that map values are simple blobs of memory, and
therefore treats ARG_PTR_TO_MAP_VALUE, etc. as such. However, there are
map types where this isn't true. For example, sockmap and sockhash store
sockets. In general this isn't a big problem: we can just
write helpers that explicitly requests PTR_TO_SOCKET instead of
ARG_PTR_TO_MAP_VALUE.

The one exception are the standard map helpers like map_update_elem,
map_lookup_elem, etc. Here it would be nice we could overload the
function prototype for different kinds of maps. Unfortunately, this
isn't entirely straight forward:
We only know the type of the map once we have resolved meta->map_ptr
in check_func_arg. This means we can't swap out the prototype
in check_helper_call until we're half way through the function.

Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE to
mean "the native type for the map" instead of "pointer to memory"
for sockmap and sockhash. This means we don't have to modify the
function prototype at all

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..7e15866c5184 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3872,6 +3872,33 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
 	return -EINVAL;
 }
 
+static int resolve_map_arg_type(struct bpf_verifier_env *env,
+				 const struct bpf_call_arg_meta *meta,
+				 enum bpf_arg_type *arg_type)
+{
+	if (!meta->map_ptr) {
+		/* kernel subsystem misconfigured verifier */
+		verbose(env, "invalid map_ptr to access map->type\n");
+		return -EACCES;
+	}
+
+	switch (meta->map_ptr->map_type) {
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
+			*arg_type = ARG_PTR_TO_SOCKET;
+		} else {
+			verbose(env, "invalid arg_type for sockmap/sockhash\n");
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -3904,6 +3931,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
+	if (arg_type == ARG_PTR_TO_MAP_VALUE ||
+	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
+	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+		err = resolve_map_arg_type(env, meta, &arg_type);
+		if (err)
+			return err;
+	}
+
 	if (arg_type == ARG_PTR_TO_MAP_KEY ||
 	    arg_type == ARG_PTR_TO_MAP_VALUE ||
 	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-- 
2.25.1

