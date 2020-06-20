Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1F82339E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrC+IOZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbgFTDde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732912AbgFTDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:30:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1AC0619CA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so5398471pgk.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7EOwykxg6pvaBNDuOu+42kuk7rsiOpCvhCBE52K1bI=;
        b=GrC+IOZrySdlLEK4pF+BAlmewCfLoCyliKgUjuk/ydT85FlEL5FqnBzvvOnr57wPjD
         +d4BDwGj8Yh36sEtqrgsaBveizDU+DBCtSr8QhxGsnrQavIJDCOrsXigZzkhdt7/OpSS
         XRgdiyXdiRjqSnqowhnYgzQBDhHhT2C1CEEkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7EOwykxg6pvaBNDuOu+42kuk7rsiOpCvhCBE52K1bI=;
        b=BSxtxb52Gn/ukFTo7Hz5xg5kKU4mXvaXSx5hX5ng6HYjJSBN0f7eTH7JlTH6S/AwQN
         s4dhP225EEL9zBoi/b/a9SK2/jsLWrUEYu1IBdlQVaNM8QFEMYWj27KCgev3RKOIX2Mh
         Qq5BQ2Nndi8CJlGMtyBjr4HSuFRxl+moA/LSebFKdg8O3LDVq0yYv8nSz4i5CISCuxcJ
         VoMeqAoz/7OVF455yb8H6Tb2Mg1DlryCHiSSXTsX0W2JRNtDzi4Ii599sXqNfQKp+xE8
         0Jw/uhF4hr6kDnJgVUmCI0pd4DxBOqLR15ISGevD7Nt83hxL3aDsZAdWxjjwCiiGQ96f
         AOgQ==
X-Gm-Message-State: AOAM533/OqRGicRJK6SIeJsjkGmGctm1014DL/AqL78g7P5qw/+ricAp
        O8kW0FnRYUUURvEL7Q93IPB+0A==
X-Google-Smtp-Source: ABdhPJxUwYihv19naIWd90YPWGy74MBa6LZXytAE9iB2nTpTiFceu0QVc6N3h97/9su8g55CPqhYHw==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr5268010pgm.73.1592623821607;
        Fri, 19 Jun 2020 20:30:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm6301749pju.11.2020.06.19.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 05/16] rtlwifi: rtl8192cu: Remove uninitialized_var() usage
Date:   Fri, 19 Jun 2020 20:29:56 -0700
Message-Id: <20200620033007.1444705-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just initialize this variable to NULL,
and avoid sending garbage by returning.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: dc0313f46664 ("rtlwifi: rtl8192cu: Add routine hw")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index f070f25bb735..5b071b70bc08 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -592,7 +592,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 						    bool wmm_enable,
 						    u8 queue_sel)
 {
-	u16 uninitialized_var(value);
+	u16 value;
 
 	switch (queue_sel) {
 	case TX_SELE_HQ:
@@ -606,7 +606,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 		break;
 	default:
 		WARN_ON(1); /* Shall not reach here! */
-		break;
+		return;
 	}
 	_rtl92c_init_chipn_reg_priority(hw, value, value, value, value,
 					value, value);
-- 
2.25.1

