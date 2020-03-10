Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC19222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFWwUmO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgCJNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:05 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50645 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731009AbgCJNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:50 -0400
Received: by mail-wm1-f52.google.com with SMTP id a5so1398762wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9mrDkWqOSVZrAWa3qcj4kMEagi9+MSjR3Oh+rWEISs=;
        b=tFWwUmO/cFo1g0Xhn8Zm4xX7vOvSN1OuBhmZ8QRgH1SIvOpiFWMUEp+9FrmUs+yL1V
         /HRcRTqFmg0MHFYqs+RD5JM4qdIl20OrFXXgq8CMS8j3HLDBVgWt81S2biPr6nIpyO2d
         Zzo3C5+YJ3kMU6S3GgkCqVKt2rPEvBpre4zvBNMmXlkjCHXH+n5yy+buDeUiBAfPBv4x
         lLwL9y6W1xG/A85gsyrdSWzN/cUOtBKOoODzw15fCawAVucSMJQx21nJjVhBidQwqB/M
         z0noGVqjfMXxGWF0d+pB+wR1qHum0uT5VbrgkIDpKEjQODwCMC9p3auqasy4zT8pKhdM
         qIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9mrDkWqOSVZrAWa3qcj4kMEagi9+MSjR3Oh+rWEISs=;
        b=T1Fvft5CDnInanq9YlLVa1/53/KrIGx8dvZTYAkX+i+kB6O1bHpnoX7Hct01Z69pJf
         ETscAtzlRJXlobeP8dWwso8pjLDZ+YKzALSC7WM/I1LkwHnrh/BL/ICkvY7WUxDBKgW0
         UHCZkMD7MCjSC9G6FDZixfgobonsFXlFjul52YFTvGLOGk7AzVwhtDKvnApy9NuRIyrG
         9hJtSgFnTzSDr45ZZTqwsx6D81siIJ29KtNu9ljD+UnwfyDBlcMyNcwwytDXkoIRJiQT
         lH9+UKhhCjpjjGSgNL86oN3I8Inj/muarDNPrAtQoXm9tKLgYHEmB50WjJR38yzrkddv
         89dA==
X-Gm-Message-State: ANhLgQ3Ao1uhHJ0ArmkRMTLrTSrRHX6vLckj3BIc+ze/4/Jtgo2JQIgI
        sWjNMOEQbPTBjsoQbvayFNFsSg==
X-Google-Smtp-Source: ADFU+vs241pN3rOBjWdJuxzwrPAis3TV0kqCtWpcyL1xgkPoxz3+ijjp1PG8l4NAnF0JQsOZxO/npA==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr2089478wme.115.1583846627961;
        Tue, 10 Mar 2020 06:23:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/14] Documentation: ABI: nvmem: add documentation for JZ4780 efuse ABI
Date:   Tue, 10 Mar 2020 13:22:56 +0000
Message-Id: <20200310132257.23358-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only exposes
a read only access to the entire 8K bits efuse memory.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../ABI/testing/sysfs-driver-jz4780-efuse        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse

diff --git a/Documentation/ABI/testing/sysfs-driver-jz4780-efuse b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
new file mode 100644
index 000000000000..bb6f5d6ceea0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
@@ -0,0 +1,16 @@
+What:		/sys/devices/*/<our-device>/nvmem
+Date:		December 2017
+Contact:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+Description:	read-only access to the efuse on the Ingenic JZ4780 SoC
+		The SoC has a one time programmable 8K efuse that is
+		split into segments. The driver supports read only.
+		The segments are
+		0x000   64 bit Random Number
+		0x008  128 bit Ingenic Chip ID
+		0x018  128 bit Customer ID
+		0x028 3520 bit Reserved
+		0x1E0    8 bit Protect Segment
+		0x1E1 2296 bit HDMI Key
+		0x300 2048 bit Security boot key
+Users:		any user space application which wants to read the Chip
+		and Customer ID
-- 
2.21.0

