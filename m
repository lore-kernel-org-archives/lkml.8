Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9970C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B72072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltrh8w3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD1VuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD1VuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:50:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C9C03C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:50:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g12so428020wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9osxT0MDRAr90MhYiRbJBK9XB7tK1G0OyiTUDsj+BTw=;
        b=Ltrh8w3mofifrPYnhW7F/YpSDUWfqWBGttCogGG7upeFfTyqmg5WP1zPGzJ8LtNgZ0
         nIjaMIcdFDHTmrHyvQCZZocyyrue7u2Bnt97Rz4MO9BVESkLDOpuH1FWlDI+qhhvuSdx
         wU1RS3Jnx/g7ztfzyomuC3XgIUMuwN41/k/McQ3nquREFqmO2bjOxjknwUWpwj8lg1ZB
         UCWi5tf7CRHzOAoHH9INamrfcHlkBt+mlBqvcLYaJ9io0h/qh2x/JStK85+oErteVtV3
         ep5VnrBGSRVyRND3QaGo8dJsNQBIZqOyPrRotv7ef52Cl6HZw3536W07Kzw+8gW84hL5
         VFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9osxT0MDRAr90MhYiRbJBK9XB7tK1G0OyiTUDsj+BTw=;
        b=HP9WcxgBoEKwQCNssQkoN++3jz4kUfMoGZKmfn7eII11qIsL3oGHqbkqNhp1QBHQ7r
         tfbo6gbuS9ttxNLNZ6Dj3Ilblwqn5+xc8PT0TRCZex2yeo1GsTMcBwsL7gOk/lr1jbOn
         d05AENSnG2p9u1vweLgWDziFm49xYDVOqBYVQZuiJuYn6VkG4HNgiTDIw6YsblHkRTmr
         SzmH2sxXH1n7vD/A3AJfkAy+jhrTXHxvIS5Hx3CNfm/kgOolG7WccGWJYG9b2P7dfX25
         gZhKfgAUBscph64p4zdcbHotca2aPUq6iK5ViSSg+SC7QXynyeUZLeZhHQ/+H+ENXFfM
         WI/A==
X-Gm-Message-State: AGi0PubZfgb3A3Gg+GJVvCAflVSdpnPsVgNvOSyTs91Q8xBYeO8uZKdx
        0nxE2RqoG1DsduuT5E3Nck0=
X-Google-Smtp-Source: APiQypI9qgfV1+REi0XM8VGhwJIz32lZSuaEJEumxoKQpNULcjKPYre3H1tJVm37PBeMQJkp2YWa2w==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr6799912wma.138.1588110616170;
        Tue, 28 Apr 2020 14:50:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t16sm4876236wmi.27.2020.04.28.14.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 14:50:15 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] tracing: Fix doc mistakes in trace sample
Date:   Tue, 28 Apr 2020 21:49:59 +0000
Message-Id: <20200428214959.11259-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the example below shows, DECLARE_EVENT_CLASS() is used instead of
DEFINE_EVENT_CLASS().

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 samples/trace_events/trace-events-sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 80b4a70315b6..13a35f7cbe66 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -416,7 +416,7 @@ TRACE_EVENT_FN(foo_bar_with_fn,
  * Note, TRACE_EVENT() itself is simply defined as:
  *
  * #define TRACE_EVENT(name, proto, args, tstruct, assign, printk)  \
- *  DEFINE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
+ *  DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
  *  DEFINE_EVENT(name, name, proto, args)
  *
  * The DEFINE_EVENT() also can be declared with conditions and reg functions:
-- 
2.23.0

