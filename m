Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF48CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8001E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OkZd0Hmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDUHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:30:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA248C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so6218148pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ve6GS3o2ZDt+6fVEzio9+oQztNL/K+BP4BCqQwsvGtE=;
        b=OkZd0HmmrZJVRAmeOhR/6MDVes0T/k3X8lBGV919P9SVZveSI3AxIfxQlssEZrZdal
         hCXV8KQNcqqxLQtRlS6E9UT1p5HNSOEM/epjV+AHLtLe7D9b7ad6awx3r9sBBEs5OwOR
         7bbDYBdBT5IDzm85ciogP0GkGiawMB44Hed5Lla5Y1WdU1SKPrLpz4x8v76nLDcDcwWk
         KHs+uxP7swbiuMbrSpB5DUpzVC3SMFFfEuVkC4mAja5BRMyyWiVVx1wbrzzIv31bN2P7
         dP+1i8dKVK1hbUmdTR+H6YBZvzzysZMqlSr+VQuiiRP6UvcIGf4QBSlPPIzW9yn+8nuO
         yqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ve6GS3o2ZDt+6fVEzio9+oQztNL/K+BP4BCqQwsvGtE=;
        b=JrEev1pcOwwd5+by8W9Z5k37MKpGpflB8sn231VMGUPQGAH1oq6TOpxGwimIwr4w2X
         bqkOLw1tLtHWzRA5P2EpU4MHIKc/ye8vl5Tw+/6UkMK+kUsyAGXzNHghrrY/gRdVylFj
         7dd48pkaaiZ+0eJq8sPT7W0Nforq6Gn9dqOt998j42zCq0sVlvC2VyCcnDqNEBOeUf4b
         chbOh6vnH+44ICpG9aT95OwuTReeP75X1/UUfERaZ1lSUQ3uVLBGcy7UIAPGNPs7LC/o
         UJ9C6r4XmRk66UrzFtscUtDBpgssvgMVta7OFZ1ZAYDhq+Pr1S8804zA9h88tnqv7My9
         mKgg==
X-Gm-Message-State: AGi0PuZxV1I0apSY/gGofHt6OQkNY5ewBcTQSy15cLa8F8sDEKficgW8
        lClL04Fh9C6kWTQGWFaOMKwD5g==
X-Google-Smtp-Source: APiQypLh5UEKAA2E++U+a7qnmVHsLG28KN7mZCzpnTw5qDaTGJom/QtjwZn9RRwMmvo57Q8FRhojJg==
X-Received: by 2002:aa7:8a9a:: with SMTP id a26mr19188725pfc.77.1587454207230;
        Tue, 21 Apr 2020 00:30:07 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t7sm1535200pfh.143.2020.04.21.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:30:06 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/3] Refactor patch text interfaces and mechanism
Date:   Tue, 21 Apr 2020 15:29:58 +0800
Message-Id: <cover.1587453338.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains the difference from the newest strict memory
permission. These changes are suggested by Masami Hiramatsu, including
deprecating old style of kprobe annotation, lock protection and so on.

Zong Li (3):
  riscv: Remove the 'riscv_' prefix of function name
  riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
  riscv: Use text_mutex instead of patch_lock

 arch/riscv/include/asm/patch.h |  4 +--
 arch/riscv/kernel/ftrace.c     | 15 ++++++++++-
 arch/riscv/kernel/patch.c      | 46 ++++++++++++++++++++--------------
 3 files changed, 43 insertions(+), 22 deletions(-)

-- 
2.26.1

