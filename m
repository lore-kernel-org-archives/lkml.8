Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D671C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9392076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZvXWcuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGQS5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgGQS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA52C0619D2;
        Fri, 17 Jul 2020 11:57:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t11so4699505qvk.1;
        Fri, 17 Jul 2020 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tb3YCK/c62Z69fKYY0wfCAnwz2Aal0Ahd0wwgfnC/w8=;
        b=BZvXWcuUaA66V6OVlhDHzs5Gkwouvt5VzASw+VVoy1q+742E60/wa4a2fogoE+cndb
         tvu3IyHZgc4mxoQmJrJj3IqstJ1xJqqIXZpG1sFOycNogXsp13j/ggbmfHjJNyC7+UAE
         eLMcrDEOSQc4o5cllJ4B/OhMVlJfAmhWBNYAx50HyOLJPV0pFuCsmYsH7ylIuTxgK2BY
         90NB89v9aqE3wTv0Mh0H5N+cbOFY71dB1AQfxwDivf4DD1CXTmYwyL9mqIuUGugKoHM+
         9biKxorIO6ICGy4RwbPo8oOMS9jPmj7t3Dilbsug17rsDYaDEPqvCPCOrOyo8ICk2JoP
         S8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tb3YCK/c62Z69fKYY0wfCAnwz2Aal0Ahd0wwgfnC/w8=;
        b=aR/FAXMZJaiVpUhSebvFW+eZIIol4IyLFBW0vy583itFberqoOr27OTu06GCxS8AR4
         akQbxDz4wqg/k8dIbfx/ZX48+6B3gaFe/MCTpCra4RCuoPL7ef5Qxs8nr07o7faBae1m
         vpjn8/s1A55pA+N3adYGT7ctH8kovkDRggsOImKCgeFNAWQkb9+2nxSZvZqxzPYDals5
         lCE/t99FbRljbMpmRpqWxTdoeAK7p9jXhLY1K7Ak4wQmyz1mRKfN2WyJTNh9u1IJuZOt
         cLecrv9XHLcBe0t15MbF29mjv+CtCqM1N33WWt+Gg9whg//tKR6dtdJD5+MLN6XsLkPc
         2yHw==
X-Gm-Message-State: AOAM530kv3aa4wtu4wO7JIap3JsWqv6728+d7U5tZzxMTJRFBcQjGysq
        l332tYVAJRhA86IiAhqO3f8=
X-Google-Smtp-Source: ABdhPJwlWD/vbOKzmpTA24Et1w9J595JHAwuxXazrHLW8rbPunqNCWGu9Oh9AB2WGgNPgD3ToAgZTg==
X-Received: by 2002:a05:6214:a72:: with SMTP id ef18mr10389712qvb.166.1595012249145;
        Fri, 17 Jul 2020 11:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:28 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] Documentation: kvm/api.rst: Fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:13 -0300
Message-Id: <20200717185624.2009393-14-dwlsalmeida@gmail.com>
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

Fix the following warnings:

WARNING: Definition list ends without a blank line; unexpected unindent

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 29a35bddf3069..6b6698a56590d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4336,7 +4336,7 @@ Errors:
   #define KVM_STATE_NESTED_VMX_SMM_GUEST_MODE	0x00000001
   #define KVM_STATE_NESTED_VMX_SMM_VMXON	0x00000002
 
-#define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE 0x00000001
+  #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE 0x00000001
 
   struct kvm_vmx_nested_state_hdr {
 	__u32 flags;
-- 
2.27.0

