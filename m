Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6420716
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy5/4u1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgA3A2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:28:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38593 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3A2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:28:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so2104094wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 16:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bd+dZicC/B914BxamzBOtfh9IVxBNm+DDvN+Zn2YyBA=;
        b=fy5/4u1VsFtur6eFlxQVgNZ5Tv/lT8fKlFcZBbJEC1u2NzaN8W1HOzg+bpc96ahzV5
         f7/kI7yYGFB1TmvJDaRN36ZpMdK73ApUCb45IuC9Fe1ggkM7vBaH+VLle1P2CzPd+Mwj
         mFC2fzwNPBh2+CSnZgLfAS+ATIfX3hBmMxI+G44GbCW/B9Ohz+BmtdoidplZe5VXW4/F
         uTW9BaX9DpNKK9ci3F62QuwaaoeN+A/cUes6hliuH9SY3d2Fto+aZz6lsc5gc9ROrlbu
         iSpnjPAPd1tLa/56wxInpVamyoHP4DZENgN4qmdYNZbqnkNP0h3m734PgI514mBFjjiW
         M20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bd+dZicC/B914BxamzBOtfh9IVxBNm+DDvN+Zn2YyBA=;
        b=J/zKr5986tuaaXZ8zvG1bP3oPKqj1j5Q7ZuJKigCAVoeLKqHbPUpEooqyVId0FvAd9
         tkXAC1i9FPCOCWSa0AHQRvkIGKuRIJ9AvypqdKuZbN8I86Tt3rGex4rHNQ24facPDgID
         /e4OrUO2sDwkjQYDWe6Dt5LFqmmfok8Z6reMC3rvZtIg7iVO21WLVlmvEAcb08bVgNVa
         ndAuTmHwNxgtv/MmaRfqW/txPJSC58hxIVZaVvoJF979e8pAFwhz0Eo723+kwsqPmmnA
         B7z4bFm7rl8D3Syr9BDifrAqMLrWo9FA6+u+4jF7EKkCDgnoMbN9bcQLS/6h2nJxVDqg
         +zSw==
X-Gm-Message-State: APjAAAVRRFjE9I5yIa6LCjopeLF8hESqeAYFmNOUWIiovhyWZU016qWk
        7x88ufBBFdf4GyxW/IGvyA==
X-Google-Smtp-Source: APXvYqzdf216iL9wclHNtuvNw9ulivlKr+1HkQOpqutswYXcjDTsedHt6wMuTszm3PsFI0PgFdjaHw==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr1767693wmc.123.1580344119015;
        Wed, 29 Jan 2020 16:28:39 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id d14sm5213997wru.9.2020.01.29.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 16:28:38 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, jiangshanlai@gmail.com,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        josh@joshtriplett.org, paulmck@kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/2] Lock warning clean up
Date:   Thu, 30 Jan 2020 00:28:29 +0000
Message-Id: <cover.1580337836.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/2>
References: <0/2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
The adds fix these warnings and give insight on what the functions are actually doing.
In the core kernel,
1. RCU:  a __releases() annotation is added as the functin exit trhe
critical section
2. acct: Multiple warnings were reported, adding  __releases(RCU) to the
fs_pin header file function declaration location clears these warnings
as the function releases RCU lock at exit.
Jules Irenge (2):
  fs_pin: Add missing annotation to pin_kill() declaration
  rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()

 include/linux/fs_pin.h   | 2 +-
 kernel/rcu/tree_plugin.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.24.1

