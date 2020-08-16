Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690CAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389EA2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcdFOTXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgHPTaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:30:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66608C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:30:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r15so2939938wrp.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XLquzJ4Zpz4GTbTovMw+SxCIL1JgsFNaSaKJHhRL954=;
        b=kcdFOTXxO6tcXoc/qn0h8QSC7i96hcX9E6mqbvdkkFh4/Ract8XMzLK/Jxzxp79V4J
         l6MD59eS3W5w2E61BeG1GxwFrK/jPrK1Sw0Z3vwGI+8oKnevNVPfVZgm/fquO6aSke8c
         uAoj9Z0Eol/kmopu2Z4UnYudCONS4E2KbbavGv0GejkcswogXOjWtMqnFrGY5pdm12v8
         zGhlpffW9ah0nk/BxxYpwBoP2Pve+lwlrnIO/Fbl1Yi1ylxN3F4YIuAjJeLgevIyQhj/
         lLxszNyq7swn3cIQPXqgEOia8Ed/HVrrnyzexlHhzUKMDmlW1mSkOCiV3zm79AIeXbkC
         dpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLquzJ4Zpz4GTbTovMw+SxCIL1JgsFNaSaKJHhRL954=;
        b=q+5yNzD8aclKjlEGcvQMmM4bPAj0mtsgLOn4pCiOzw7qHZKoP835PNWK3Or1H9gVJZ
         O/s8RiioXWj3GO1tESdGez4dU4wRhacYXbMmpTBiNQ0UG1V5DFuT7b98cFXDBmhmR933
         zFmlHlHY54b8gNc7fK3TxejHrWes/xgJpAvTL+V6eIeL7XLKtAogrLeoQMbolQqTZ9u2
         wwSA3b5Y+NPtmY+6p5B69yu/1biL9SkhzTfarvgmcDKgC5RPvRwHonZcYPJJRNzT6roW
         9Amya8rQuKLmIKRhJ7uuoGg7R0wArLixusCaHt02C5822vx9RdRr6fdSRYep3vW1ofCE
         UkTQ==
X-Gm-Message-State: AOAM531KWFv+5v9n0xi5qk9ipQZ7aKUsKEgeWelsLyB+tl05wPOBK0tH
        C0Vl/fTbGMtLK6IYZyE84Zk=
X-Google-Smtp-Source: ABdhPJyJcXlT1TRHPVd0k3hl02Itec2AZKk9a03oJxboPilmdcG+9rNBFnVIO6i49mzETlfgGhMnhA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr11662578wru.211.1597606214107;
        Sun, 16 Aug 2020 12:30:14 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id b2sm25492527wmj.47.2020.08.16.12.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 12:30:13 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:30:10 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: android: Convert BUG to WARN
Message-ID: <3a483158a742a38589c8322e96fc00734da441d9.1597602783.git.tomersamara98@gmail.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace BUG() with WARN() at ion_sytem_heap.c, this
fix the following checkpatch issue:
Avoid crashing the kernel - try using WARN_ON &
recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index eac0632ab4e8..37065a59ca69 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -30,7 +30,8 @@ static int order_to_index(unsigned int order)
 	for (i = 0; i < NUM_ORDERS; i++)
 		if (order == orders[i])
 			return i;
-	BUG();
+
+	WARN(1, "%s: Did not found index to order %d", __FUNCTION__, order);
 	return -1;
 }
 
-- 
2.25.1

