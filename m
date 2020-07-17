Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C602C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE592076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvTmK/l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGQS5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgGQS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9740DC0619D2;
        Fri, 17 Jul 2020 11:57:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so8403606qtq.11;
        Fri, 17 Jul 2020 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHG4o9e3c0Ro4niRsuiyIPSjO4sfmpuLTSktuBkoXKg=;
        b=cvTmK/l+Jw1ZfTiS9KB4uRI6T3iIia8C567x/YhrBoWwmpKqvUn16x8C31FPm6g1Bx
         lK7n3ZFU+vAt0fSnBptZ9Bzx4NZUMrQBeH6dpMHS2fj81fDaxvhRGgN+fErNdtygnsNR
         DFMVvIcH5gz8AMVFPll9KwfMaHXWYQELPIJZ0pxBzKGJS1qNXVAQuqvDQflRV9q2d6qi
         wVX5vM6dFwJnsMmnVTDk/BPILI6mppDmZT4edxarmWVp+2heP8nGVtnROVflp1kmb/eM
         cF9xG7CZOSDAHOSQ8AtRDe/bh+6Ss6EVKPqFqrmORlO9ZRDMnax06f9ZMsdf6wNrLQTD
         y8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHG4o9e3c0Ro4niRsuiyIPSjO4sfmpuLTSktuBkoXKg=;
        b=pkwfXIJ7AdJ3dyH9IT3WY6Fo2tJKmnVJumcOCtafeSbo8ilSZzPPEEtWgbWYKAgiMZ
         rkiSLgNxcvT//mrebglo/5dHNih49BC2wJ43pvaf7ayZQsQV86SyPjDKEelgYK1ymWo+
         FfvxCXlNsvLefaTWMa2eBW/B3Kto69ucfnqi8vKuoBNcDr+s6dGA+8BsBzmdjVCPUGuQ
         jNM2OT2j2c3I+Jox5OEMomxSk2g4bq8TZA/dCNsem/hrt6IIUzCLS8hFPG+vREc0GM24
         QulMaauMm39zX18ee+TK6Z5GXT4EUDD5oJTYAnjjOaBSRwerMe9D+2E5BgUHKMEl9l33
         kJrQ==
X-Gm-Message-State: AOAM5335lRG0Lpdg6bGtpr//tvhItKKO6Vu/N6uGsssTIe1u/11aiLUS
        SKyJG3jfz4Th1TW+HRklrv4=
X-Google-Smtp-Source: ABdhPJynblyhgvWW+6JETMuHHTJdZpJ4WnLs2TZv/LQFxX9b2+iAnrqJNlkTrVbgudYckqcSy0Fnng==
X-Received: by 2002:ac8:189c:: with SMTP id s28mr11393074qtj.97.1595012233840;
        Fri, 17 Jul 2020 11:57:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:13 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] Documentation: rcu/tree.c: rcu_nmi_enter: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:08 -0300
Message-Id: <20200717185624.2009393-9-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:

warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716eadc7617f..4540659640fe9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -944,7 +944,6 @@ void __rcu_irq_enter_check_tick(void)
 
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
- * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
-- 
2.27.0

