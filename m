Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BCD20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iZf7im/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgC3UlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:41:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38754 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgC3UlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:41:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so310525wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diBJ0x79+6O/wxFqEKBl8ch1Vskurhroixe+etKg5ds=;
        b=iZf7im/xB2B8gsISeTSt6aduVdGAss3K01k9DkivavNEydV0FoEpJ1r82SpBLvmavJ
         +Vz3Lgj5/BAtjn8epPfJydi5sCistPfYs7bAlrv0Dn1PhziubG5wDMVxLdF1iJ7fzFc6
         F6DKQuKnAC74stkr/1GzCKXNfgFPebUCEvuYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diBJ0x79+6O/wxFqEKBl8ch1Vskurhroixe+etKg5ds=;
        b=EJCTFdrdJRv7V9fDbgDPhoqUgqdwNf6YFBiB2k/56+CGE+5CRUmWtIVuwmi8YTU6Uj
         TM5tvnkQNS6uYUbhfv3l/dqElDplGySe1P10fNLQZeIgZoTDSKF4jKWnpu5S2SOTjjWh
         sfnS2OYJeoj6UOZELrFJzoEloiUcEuyQd7eVj6JiKP5t21dXEGhWEGJX+5T9UicdnmMe
         9zDxCIWuem1Mtt2IX/wORwa4GBw6EAbVHrrMDUKxL7i7E6jX7ADXh/CO9RPr6wQyRlZk
         U6sovquP6JMH3cs95N2NIW5Xuw7imYXLgC64gS4oI85V6EW4LynYKf7nEZHZtHb8jAHY
         7KWA==
X-Gm-Message-State: ANhLgQ0+FFwGI1weKUQzLadIvKHZgoygMb1TVUMBXnm86ejeu+zxMMFu
        x1COLDw7WFRoxyraOYKp387FpFlTYNs=
X-Google-Smtp-Source: ADFU+vs0+WO+HMZReh+CV4b+EKUCIVkXRdBnzid39Ti1/WKMh5uSQ/VzWIEU+mU3N4lZ4g7u9xHuxA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr1087478wma.36.1585600862543;
        Mon, 30 Mar 2020 13:41:02 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w81sm890156wmg.19.2020.03.30.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:41:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: lsm: Make BPF_LSM depend on BPF_EVENTS
Date:   Mon, 30 Mar 2020 22:40:59 +0200
Message-Id: <20200330204059.13024-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

LSM and tracing programs share their helpers with bpf_tracing_func_proto
which is only defined (in bpf_trace.c) when BPF_EVENTS is enabled.

Instead of adding __weak symbol, make BPF_LSM depend on
BPF_EVENTS so that both tracing and LSM programs can actually share
helpers.

Signed-off-by: KP Singh <kpsingh@google.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: fc611f47f218 ("bpf: Introduce BPF_PROG_TYPE_LSM")
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index deae572d1927..7b7ea70e64ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1619,6 +1619,7 @@ config KALLSYMS_BASE_RELATIVE
 
 config BPF_LSM
 	bool "LSM Instrumentation with BPF"
+	depends on BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on SECURITY
 	depends on BPF_JIT
-- 
2.20.1

