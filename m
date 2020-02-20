Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9AC11D42
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E8E24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqTSY/qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgBTGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34860 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so1397832pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ2hH1WuA3WIBV0TGGs6V9kr1LqyBnjsbugRrEFt9Ew=;
        b=mqTSY/qAB/RCNO8ZmyzzeSV454kKhoI4MrnzIubx8FG9Hs1YDY8qgkYCOOZ03fnOpj
         M9d3mq2QPbxb8DI9+NencQP10TelM1jX3r75i6nEudJJNC0pyPwTl5Zo70spE5jj6nwC
         RYRBy2U0gZtVNXuoqBFMSLZN6PyqSMEXMIPUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ2hH1WuA3WIBV0TGGs6V9kr1LqyBnjsbugRrEFt9Ew=;
        b=qeyE22qWiL2v3NI5+UynFp/Bs9fUkLQkINqsLz/t6iKyG9rU2OwWRR6jCXckAyQC16
         FlYaOo2zUFJw//U5RIYkIxKCt2BBvZQ3qJtkRzRNT22mb8ExFiXaIr31LocKTnDXaI8v
         Rf13FP6dqZhFPzEmgDATPE+WMROTZliwxl54b6j8q6/aTxUOCUL0HAmrMZuZKYIQJ6uF
         Z6TvocyQCfGqvw40iqyiKpHyyHWzbNuy7OKEZz6ii/RuLnl046K2Ck0WkkfxNRNwKaQi
         gb9rcB2pR+Nx8ftus2kKGUjEup31KlmOunJ6et6FbjPJ5gUKUgNvZk43tx/2UmFMVNLP
         SCRA==
X-Gm-Message-State: APjAAAUCs88dccjvvz3wfE3nRvzJ3NyRHfROms9p4kQBbGdUWrOFqqrW
        /iKdLUjpWCeUzCfd5PlBht9zVg==
X-Google-Smtp-Source: APXvYqzAN57Ts+Ho0KQDmWMLWunp5OP1KQlTHt9upDJZGi6oUtxg6xEDyffRcacLKD/SVypLHcvH+Q==
X-Received: by 2002:a63:9251:: with SMTP id s17mr31193888pgn.127.1582179786195;
        Wed, 19 Feb 2020 22:23:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u126sm1728668pfu.182.2020.02.19.22.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:05 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] e1000: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:02 -0800
Message-Id: <20200220062302.68898-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/net/ethernet/intel/e1000/e1000_main.c: In function ‘e1000_xmit_frame’:
drivers/net/ethernet/intel/e1000/e1000_main.c:3143:18: warning: statement will never be executed [-Wswitch-unreachable]
 3143 |     unsigned int pull_size;
      |                  ^~~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 2bced34c19ba..a540d0206129 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3140,8 +3140,9 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 		hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 		if (skb->data_len && hdr_len == len) {
 			switch (hw->mac_type) {
+			case e1000_82544: {
 				unsigned int pull_size;
-			case e1000_82544:
+
 				/* Make sure we have room to chop off 4 bytes,
 				 * and that the end alignment will work out to
 				 * this hardware's requirements
@@ -3162,6 +3163,7 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 				}
 				len = skb_headlen(skb);
 				break;
+			}
 			default:
 				/* do nothing */
 				break;

