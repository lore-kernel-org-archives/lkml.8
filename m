Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE7220756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KQuSLbio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgEUAm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEUAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:42:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27759C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:42:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so979687pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9lcgxOePL36AQ0knEK3MtyFB2f1t6WCcVjbm8u69P4Q=;
        b=KQuSLbioPDEM6PN+q54NvX+ow8jfxIu4/lR6XtjJ3TZYQxzn/KyksNTl/vWG/jIabS
         sNPXrc6eBiVM4zeXcuYMxUb3Yks7fZAff7nM+TCVcR41YN0H+ge6NRLGXoE6yqCXs3AE
         fZ/KbBWqPQHjeWqbxbNg+GGVYR6Lzi0CwXmONpHwEnMHymlMrfdWqn0vGY5OE8Q1KUOe
         fESBsDlOtVlZNntUXxFDyj/08RXMJMRbky97oun7oNongd8044Vz+iWso4LI/nKKGebL
         +Wm1rkPEYhuoFeV7GQA27ZlFMxaYq3srLVT+YiQFi6VpvJ4aiVLvRGaW/0POcsIkZCF2
         2tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9lcgxOePL36AQ0knEK3MtyFB2f1t6WCcVjbm8u69P4Q=;
        b=JWe8N6omJb8/Pqrvo2VIQckR1FX2rTmxZBFMmVjtip/Z7xzttrr6/GWs94xrcnS/Ap
         uWYO3pRmZh0FNZlqvWLYXhuh8rxyOSxUcXQihvub3jMEE4RlsaAf24JIH9vQKE7WNpcO
         hHAvB0S5iJWxWcC9EgK85f5/zYyVFgObjV0qSnOkNBNO9yKHmigaujZ5O9rPG8lQ39zu
         q6f9BFBl4kB3m5KIzCnjwAMw188fEkT/H93V+wUbP+9c0ShS2YUdGPKguHfqIy9yPCPe
         884YfwjqIsv+D2sPdhTbaakU2ZUCRPsp9LXJc0u/fPT6qcLCGZ6+ElEw2ykUPFAYQ/XI
         R1ig==
X-Gm-Message-State: AOAM533Y1LBsqRPMyd9bZpdTUbeB/uaxn2YDaM3vGvybAd6JFrsnqjiM
        tr2d7TlRpPyQLphm9ep6GQrJ9KhMhWU=
X-Google-Smtp-Source: ABdhPJz5fRkOmxb4TTcnaGWbBWrwdizdu509/uCrR5N/VDpnLao/v+Y6ksGxvDDE29hLN81ULTtlww==
X-Received: by 2002:a17:90a:a43:: with SMTP id o61mr8267109pjo.179.1590021778250;
        Wed, 20 May 2020 17:42:58 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id q16sm2695120pgm.91.2020.05.20.17.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 17:42:57 -0700 (PDT)
To:     David Howells <dhowells@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH]: splice fix opipe_prep() full check
Message-ID: <cf341c51-ba8c-4f81-fe4e-6bf8190293e3@kernel.dk>
Date:   Wed, 20 May 2020 18:42:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch converting pipes to head and tail pointers mistakenly
turned the splice pipe-to-pipe opipe check into something
nonsensical. It's supposed to check if we have room in the pipe,
and return success if we do. If not, wait for room in the pipe.
Instead it's now returning success for a full pipe, and entering
the slow path for a non-full pipe.

Cc: stable@vger.kernel.org
Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

I didn't check if the offending commit had other logical fumbles.

diff --git a/fs/splice.c b/fs/splice.c
index fd0a1e7e5959..4e53efbd621d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1494,7 +1494,7 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	 * Check pipe occupancy without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		return 0;
 
 	ret = 0;

-- 
Jens Axboe

