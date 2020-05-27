Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35694C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1637C2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBKa01d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbgE0OR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387800AbgE0OR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:17:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42EC08C5C3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:17:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so2735484wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH1v8wKe1VUKWAjGTwnWnKdT9B4ah56ml0/ndiIz5io=;
        b=jBKa01d6epycwm2tJPgKP5MJmpfECW/858iC9R+HX+08ZSdRe1VOune12GU5FSK6jL
         9ch+4WqcdFqtQm1Uw+0hpM8lDcfTvLDZZoF4N/Nxuz5BB5rrZjHqDr6pE2iuPToiG2h7
         Z5zDJ2TE/ReBM6Aoi/RDfJTpsoxuPWS1pwkhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH1v8wKe1VUKWAjGTwnWnKdT9B4ah56ml0/ndiIz5io=;
        b=a4VfYHu/41Un2FBibw5B/0hJGH8z1SaGiLD177d4ChlCpIgml94qcBsLjNOYnI7uVj
         A0GJXz5t/Rpc6qgn8TivXTsRR1K8Y5kaLZEm5CT/sh2G3nCGyl0U7R6lu9dmSRV7odm/
         +W1HiAsuMuVTaVYnP8ZZ9bMtkTZRgm9yem1FpFwn87PS4u92xe6WRlDzGBpl/uPdbTmF
         +v3XRFN/1W71K6eMJIcJoIz3HTuE/eqJV0FEHAYzVIXqJ++R/Veev3aixPE6J2DLfB4S
         R5a71Bp7B68TNtcUUQ1vE3I8cqPMrUtry58B8OQBmdTx52o2Ty/QpLhrq9rT7fm7+weO
         Pcbw==
X-Gm-Message-State: AOAM533auvH5KyR7Ny65u5pixfYTGPGf7D18fwdTvtfs2G7L6ZDQrXO/
        4ckg+wSLCDXQ9WkIcvEYm1V9TcZtzuc=
X-Google-Smtp-Source: ABdhPJwWguHm0Lnqvgwm14E6sIExIuStJrZLuVvOVvX+cd+cFq+0BnVHHJ+F5pSSo7Tq7jwp6YH5nA==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr4092817wmm.18.1590589075512;
        Wed, 27 May 2020 07:17:55 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o15sm3026908wrv.48.2020.05.27.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:17:55 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fs: Add an explicit might_sleep() to iput
Date:   Wed, 27 May 2020 16:17:53 +0200
Message-Id: <20200527141753.101163-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

It is currently mentioned in the comments to the function that iput
might sleep when the inode is destroyed. Have it call might_sleep, as
dput already does.

Adding an explicity might_sleep() would help in quickly realizing that
iput is called from a place where sleeping is not allowed when
CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:

  https://lore.kernel.org/bpf/20200527021111.GA197666@google.com/

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index cc6e701b7e5d..f55e72e76266 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1583,6 +1583,7 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
+	might_sleep();
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-- 
2.27.0.rc0.183.gde8f92d652-goog

