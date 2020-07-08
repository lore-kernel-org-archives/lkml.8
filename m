Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD1AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A9920708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSxp4nAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGHXNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:13:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788BCC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:13:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x14so56463pln.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3so1mFadbtJsUTXuNrmPVizuAsNzcgxZm5LS3qXi3TY=;
        b=rSxp4nAM5Hran/YIW3CTiosFlC9HRJGR/31njKW8D7cCTy/VwpZqgzZLc659iPN5jI
         9Ak08ysPN4VhObGPu3Nt6Q6OhARBwZGyhXjF9PzewnBLPvTKZ2TuMWyNsOfATimW3U2/
         y0P7tbQf+HN/4Cbo6A9mIdWH6lUf+PGcCS+5+FUMGM22vtHH4CxuZR1Swa0Mcv5c2Nbp
         JjONGvGCQ0VynZlDAdouU0WHS1pCbLYQNpF4MZgJfFRI8rsY02jbYavcnbkda15gStuN
         xOAtMzETruCdxwXQJ+gMyFpj4xL8OKl4+PgzBUFj21lsMSSOs2ZPQl3PZM180sWe9P+I
         y25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3so1mFadbtJsUTXuNrmPVizuAsNzcgxZm5LS3qXi3TY=;
        b=VH8hr57arqAKa5cLNZrw1OXb4U1Ey/VInfXJyKOSBfPnDPDHI8LxKuL3maSuNgboAl
         +KQcmqYtjZpTvHWxYL0CzSDTwa1gTgTlp7dthE92sXlxDLiesjULLyRxFjfDvlARuA/5
         2QuF5tXcQF4uZPxDby+J1BUQW6DsqnbqttYfCTjnLbqC5/s5b4JHaMivoByfk1xlnGtE
         LWskOrySnYmPICnBqIbN1bPFCfOHRzvhHuuMTGVtiHTBVOOeE8TrAZRbpCpiM6D/kVPT
         rbQ9aGi+YeWU8XnHqNiQtEU6cxTjS6GViWQTLnAQqla6erbhGAxY0oPF5AK1KsRjEtb9
         sWaQ==
X-Gm-Message-State: AOAM530jS1kXLMSM8sc6kupLulr5uSMFZexCa0014gNxv8zL4G2SWdrb
        NTzrFqFOJqxj65/BSPLkKHM9EWoHYNE=
X-Google-Smtp-Source: ABdhPJwUUjvR9+6X3a7xnWuKhYRG45zejhz1YQmyd/QqF2x0fticaMmVRRzSGrfco3a0PfX8sNHB/Ls8J1k=
X-Received: by 2002:a17:902:c24a:: with SMTP id 10mr47123134plg.82.1594250002817;
 Wed, 08 Jul 2020 16:13:22 -0700 (PDT)
Date:   Wed,  8 Jul 2020 16:12:53 -0700
Message-Id: <20200708231253.3831497-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 1/1] MAINTAINERS: add Hridya and myself into Android driver
 maintainers list
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     hridya@google.com, gregkh@linuxfoundation.org, tkjos@google.com,
        christian@brauner.io, arve@android.com, maco@android.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new maintainers for ashmem driver to handle related issues.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..8b2f139b196d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1170,6 +1170,8 @@ M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Christian Brauner <christian@brauner.io>
+M:	Hridya Valsaraju <hridya@google.com>
+M:	Suren Baghdasaryan <surenb@google.com>
 L:	devel@driverdev.osuosl.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
-- 
2.27.0.383.g050319c2ae-goog

