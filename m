Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842D524656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNnMhi1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgANQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:47:27 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48258 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgANQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:45 -0500
Received: by mail-pl1-f202.google.com with SMTP id bc5so1314083plb.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=QNnMhi1W2Lwr9MiJV1KUIy84wUVGideJuBgoE8jzj7ATu3d+8Iej5m7jE4wEyrUloG
         PmCzBN3Y/FcSXfgNrjtdeca6SP75c21ZSFxwQ33whfSl8Llc/Tfs931jR7JFlKvtpL7R
         OVQD2+sf7pxwqUSXltEoe9xWiW8qtliCn4a6dmeqj6LHT9vtAQItMQikhZnofmzBG3ZN
         SY4j+4f9chtw5cTVKbA+v/YxZpuJTUPdcuSaDlkWIegcBGwvg2oifZEqpMBK4bDDbS8f
         oJPCU+5ZciMpiDheJSoUQnu4UnxzEBByQdSSTGsNpWfzD/C9yoO51HaQXhDAknnJLTT/
         RP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=T8xLPJRzPwKK6OKHKdca6OEz0AK8fjqUvW2PZgUsgxBje8Flq2KoPzTCOWgtR2XEJP
         ENRCcJUd2Lz5Lb9l6lIcpvKuNRy+fRC8arF/jB6qwwmzLKJ0FKMtMs6wU2f4ikBnO5Hy
         L0Ii/W84mE2lTKtOChw0fOF7i46lLUmkCUXtZ26iKwkWdsrYk7ISuJ/gVGxrhkf0TXTG
         k3AO79pHNN/wzHOblgXtZ0DLgwYoNOlbSPbWTzCEmW12SYPtp1rIgKBduErPR/yPlBeo
         zmJA8pReOK+gTXVxCXjZTl7Y4lp6fwHZ18PH1Q9dJdXIfWsWFwrchkKb8dBWks0pq/XC
         8SQg==
X-Gm-Message-State: APjAAAUYEWqIgg7t9vv5MDZoJxcMuWohwLGTZAEGrR59cnxn44ENDiY9
        r8qmfbj7X2XFs0WH8dMBYWnQ3gTQ1Cl5
X-Google-Smtp-Source: APXvYqwNlRjnwBABlatph1aPgTiQJF+O6lc81rsDh02aseJJD5vR/jzq0Fjyes0uwdcfrH/meeLDOMTraN4R
X-Received: by 2002:a63:7843:: with SMTP id t64mr27824323pgc.144.1579020404127;
 Tue, 14 Jan 2020 08:46:44 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:08 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-5-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 4/9] bpf: add lookup and update batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f0d19bbb9211e..95d77770353c9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -503,6 +503,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mmap = array_map_mmap,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

