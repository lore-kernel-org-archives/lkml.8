Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3EC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2450E2063A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW2mYPAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDERgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgDERgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so14539225wru.13;
        Sun, 05 Apr 2020 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DTFnfqknLyGp+3XkRw9j6lN2nC/vQBz5akOO6Jq+9E=;
        b=SW2mYPAVdRTHZs56xizZJof0PB0/H10dF7kN5MZRV0Mwbe/pirMi+hzGe0zy2l+aTi
         gt7nAAaROKaNwZgN1V1K1oIxQ0Tx3fhFTEtB2UZ5z2dIl2rGDNsIb9bpPi8BAhUC1+Io
         KZTlb7c4rfAotfPPW8wEPlTJDpfwEVTHKj92ibNwwqfcLyIAfQw876UWFShUZUplpMdO
         /9pXyLfaw/g3ge3ftNepvrc6hdYrJ4qax74F2HQWEJnBe1E87JRok3RMdAmTQia2I4vn
         PIVoOXlaXiPqyAIoADS2lTONpme31SQxnFF/2Rfzkxdh50PyJNyA8/Svca29QH1NotuI
         Ib0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DTFnfqknLyGp+3XkRw9j6lN2nC/vQBz5akOO6Jq+9E=;
        b=fUL8SJHpEbum4iekdT3SMiIevqZNk9JoQMgPsGxaRJNFS3l+o8jk44RRE6J0c3afa/
         X3EvHDzkff4ZiYB1AEMdKVoFF+mpX6vF6Iry1mjVFzg7VBNEIkCjxHs/DIA1oFsN9h3/
         tj1oTHSqxq6QhLFyaffzH2w3GXGNhiSDoW4SeYKeGjqbbtG/PnMVBdeOI+BYEulBNFIV
         lsAQGkNaZ2ja/rt9CoU1jKMgr1DwiOsLZlejHjbWq3MLIx77IIJrekB3rBsnS0dtREaR
         OHwlx3fbyDmsb7Yz/F5G6mzeS9bL/p1W60S++ASOfoQBxH1hG6DqQPvJrxNINr2H0VW3
         v3xw==
X-Gm-Message-State: AGi0PuaVX+7pDdpCZBKquu3AloGA07+pj78v9iwCTGs+2PdnVdQd2VaT
        aBnavl7V3JCMo2FRMtF3Ljw=
X-Google-Smtp-Source: APiQypJWB+qPDgIK1ujMiEJT95YHqkgQ0srkjyqkRtFkq0vai3h9oU1y9+4p3mUKEgMS+0t9VDQFwA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr18957292wrw.235.1586108170606;
        Sun, 05 Apr 2020 10:36:10 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:09 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 5/7] arm64: configs: Enable sun50i cpufreq nvmem
Date:   Sun,  5 Apr 2020 19:35:59 +0200
Message-Id: <20200405173601.24331-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405173601.24331-1-peron.clem@gmail.com>
References: <20200405173601.24331-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 needs this driver to be able to get
the correct speed_bin required for DVFS.

Enable this option in arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4db223dbc549..28b25fc0347c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -83,6 +83,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
+CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=y
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
-- 
2.20.1

