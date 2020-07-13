Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ecXF2CYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGMIc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:32:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527BEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:32:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so5694950pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0T+GMH1Kh2ICjHY21eXCCE66DOmM5GvIu3hqK8aoBU=;
        b=ecXF2CYXVgfNVLmav2XOWfVtk0U81NPq0g31QUQx+V53EK3fzxxN0wb8dpfZDPA79T
         xsm2kCCMH3iM9gAAzUjzuAcT4CWtnW8vk9p94f93xa2bzu7R1YJTLAAsiu79qZJgrBk3
         tnxMwUzJ8GqxaTh4KEgvaW9pmLrnLhSjy23X8p1ySl2m06lC7kvbG00cTVijNlFkfce/
         qh9ePNYZOZHwEwSkKetIKn0eBwfDwMPXOMb+HL1BDv3HhiIOM5+C06elUE7ArLIW4hUv
         5njnkJx6PR2bt9dXDi3IbPBvSaZy/2QZroCphjKFF1LaPvSfggxx0O3LdxUZHK4dsaDJ
         8FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0T+GMH1Kh2ICjHY21eXCCE66DOmM5GvIu3hqK8aoBU=;
        b=omGuZqRfkatQrjlO5N3alI+xxoQEm77D+jw5foswoGU1Yo+XoUW7JtfeTlwIW0PEVp
         PYpH438/t/Ybv6bOEKEu2CQ6jOIHnTy02CKaxrJ8A3GDPPCpoauPA88W5jlTAOg69KZc
         IUG+vpL6AI40t7GIKiLU68/0VyU/veaBpcpjZ4F/OXCmlzDaC7l0nu04Lmk9n53ALeft
         c3cdHNoTVzlbKJGMOb6K7KAouKUtdxMQtT2K+Ih9Z+AISznkRFIHPPOlAQRxD9jNx3xE
         7QtBMRJs/x/0yDrrkafi866VXTW6KKJvwe/qeKDeW3ODPuD1AOWy7t2j4OBX3RIORux7
         mEWw==
X-Gm-Message-State: AOAM530NpCjaNZxUj68n/Jqd2LAs6ftBAZn07VNumnTg4UAaJcTv0IW6
        i7pC4oWrW9FnCtr86j55zMiG3g==
X-Google-Smtp-Source: ABdhPJzYIKvSchn6EAYr5Yv3j4DAQKytxquVEMaHG6dFxMusYnStue1qyRJp6N/+iUZHihl3zE3w0Q==
X-Received: by 2002:a62:3744:: with SMTP id e65mr38578823pfa.20.1594629148757;
        Mon, 13 Jul 2020 01:32:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id b4sm13603678pjn.38.2020.07.13.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:32:28 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] riscv: Fix building error in entry.S when CONFIG_RISCV_M_MODE is enabled
Date:   Mon, 13 Jul 2020 16:32:15 +0800
Message-Id: <742f0a82a9d4ab62d8616784db5a88a95d8b5389.1594629047.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/riscv/kernel/entry.S: Assembler messages:
arch/riscv/kernel/entry.S:106: Error: illegal operands `andi a0,s1,0x00001800'

This building error is because of the SR_MPP value is too large to be used
as an immediate value for andi. To fix this issue I use li to set the
immediate value to t0, then it can use t0 and s1 to do and operation.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/entry.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 6ed579fc1073..000984695cd6 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -99,7 +99,8 @@ _save_context:
 
 #ifdef CONFIG_CONTEXT_TRACKING
 	/* If previous state is in user mode, call context_tracking_user_exit. */
-	andi a0, s1, SR_SPP
+	li t0, SR_PP
+	and a0, s1, t0
 	bnez a0, skip_context_tracking
 	call context_tracking_user_exit
 
-- 
2.27.0

