Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA52FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A5320738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue9y1glW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHBQVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:21:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED3C06174A;
        Sun,  2 Aug 2020 09:21:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so22068870wrm.6;
        Sun, 02 Aug 2020 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5T1T+zFmu3MftYYttB9Il2EU0RTA1ff+C11FGJ2VQ8=;
        b=ue9y1glWMg0U8okwewHtv5AE/SKIC3FROr0CO0Ij+gHtK76nmcGWrmBKrqvXJaZ+hh
         GduDnbYhH+qsSBqY+iFDCrKXPd6o1nrDfER8PREo4bP6g77IqnGWrxHqR+eLBtjGK1DN
         uPy/AeDAfZ8aG0AOsjJB+ulBuU3CHaONQxULXU2AW6dghB0VULeFKklFtrlPRIso6a9c
         YN0GVFm1WxkVL/BzXRvrmyaRPsQm7XqQL9Y0CBQ0PydqcfQM/gcLKeJQMABrNVn6cJEg
         WFcqmFqogSxqvDgrmjUIv0HxjLSPZHXHqq1Frqt8+7oUCsi9ewsmVvDHSCCoaC1WkyLU
         8zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5T1T+zFmu3MftYYttB9Il2EU0RTA1ff+C11FGJ2VQ8=;
        b=F1ccFp9MhaHiKJAmpie+LLIYPJQ3YfwuJCPCk2inf6xhPuSVqyBPDCCn/86CtT023J
         fJSSHOBe9ERTbjPsXQaSuphqFKvBSD6g+1BVJ7mIGaDlXmKM1PcfzcfE72jOS4VwH+ot
         YiaVXo5JmTzqIGtGBf2WcpkbRL2dgiVtztViuw3TTJaK80NAYgOYbStOSg+HVDU8HXDg
         O2R5vc6eISDMnIPozsJ1D51K5ycfrR29hH8pXFENvx5FwPfDwLtiitiBxhKQ0ie+PpiZ
         pc4PcDlwwL2UTWB+nmRx57MrnIrNxo1HV+yKlT6t8nQ6tq4ALnvdleIZ5RYUT2aY7POV
         DG7g==
X-Gm-Message-State: AOAM532EYbR0D4S5BpRFMsSlav3y5NtB+jvc4N/kVrnC6zGDbJAVbLrf
        J2Cs4LL8W0FOLKdZQoBpg04=
X-Google-Smtp-Source: ABdhPJwMgL6A7e1V/dEg/MLvpj9US3SFGL5okBJaZwDhwNgzVQYuDpMoIECrBuN/Dw+z8alWVNYKjA==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr11009751wru.22.1596385277100;
        Sun, 02 Aug 2020 09:21:17 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dd3:b900:5cb6:49ea:83a1:88c])
        by smtp.gmail.com with ESMTPSA id p25sm18798905wma.39.2020.08.02.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 09:21:16 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tao Zhou <ouwen210@hotmail.com>, linux-doc@vger.kernel.org
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] doc/zh_CN: fix title heading markup in admin-guide cpu-load
Date:   Sun,  2 Aug 2020 18:21:01 +0200
Message-Id: <20200802162101.18875-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation generation warns:

  Documentation/translations/zh_CN/admin-guide/cpu-load.rst:1:
  WARNING: Title overline too short.

Extend title heading markup by one. It was just off by one.

Fixes: e210c66d567c ("doc/zh_CN: add cpu-load Chinese version")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Alex, Tao, please ack.

Jonathan, please pick this quick minor warning fix.

applies on your docs-next and next-20200731

 Documentation/translations/zh_CN/admin-guide/cpu-load.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/cpu-load.rst b/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
index 0116d0477799..c972731c0e57 100644
--- a/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
@@ -1,6 +1,6 @@
-=======
+========
 CPU 负载
-=======
+========
 
 Linux通过``/proc/stat``和``/proc/uptime``导出各种信息，用户空间工具
 如top(1)使用这些信息计算系统花费在某个特定状态的平均时间。
-- 
2.17.1

