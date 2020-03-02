Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA35C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE689246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCcOCzMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBAFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 19:05:31 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55792 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBAFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:05:30 -0500
Received: by mail-pj1-f65.google.com with SMTP id a18so3633112pjs.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VL/26nrsiNq7DuIRWSkkYww+xvM85UOTiZtGPRjHpNk=;
        b=jCcOCzMoAkxXO+a3yWBfOiJ45Uf6bESOwIkL0nuReQm+hXnoJwd7QNZ95iQfEwf5FS
         WDMU+u651Q4nSYiMAm/0Ch3j097L+dqdbcR31evCgWTwULhVye/8jN3qTlzIHyhWPwJu
         6xUPh3PHJkODxQRc8C/UfjU76yJ2NInhCAgHQe4py8NJBxKXJci9b5h5Xb/WzNciCZU9
         dLlMhG28C6RkaL7YiovEpJnGm2sgg27WuFd+cJqOLibTFDx5dxfYqgEaBhOZoCeg2Fv8
         iL8SVfJLrpEwEPdgkDiBTC1OpG5PRYqxpL1dOmG63t9l8NzL7KTifBuJixO7irce2jiW
         Tyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VL/26nrsiNq7DuIRWSkkYww+xvM85UOTiZtGPRjHpNk=;
        b=ISiTc7IliO8eWbQkj3hsHry/DYuM6cXvTzSaufz2pyttIcb9jnASG21WAlNESfesRx
         Vi0XEsIGLuBjA/3lop4yZWEWXVl7o/m9p5mB+KvWLCVHaEStcSUeWHPvEJU2vIE9uJU/
         tzavRmpNqHdcAi7w6As9CRebWVHGChh0HBI4zW6RXKRt/uedd5YyrWYYh6xmZasT/5Rw
         VLbaWssZQY2e93LHjv6Liupw0SK+vZ4IVMyoLsK1OVNGpt2PAVYyXgVras9CEa8Z781u
         bEimXWBdgzRv5f1y8RKF0hJCDdEwdSzDsJkUpnZ0qLoREeEXp0fFj5jMwbapd4JTp/2d
         JALA==
X-Gm-Message-State: APjAAAXW/k9CPNeNjrBWjXM9f5JnUB5NiwHj08+KOHFBtuHe8WETy0TS
        hrUu9PBbhN4aOaF5KfG1lXbJsQ==
X-Google-Smtp-Source: APXvYqzqeaKgu+c5hg3xiux6d/gAKzclk0nAOi5btZcltM3q4Pmip+LPzmAcInXe2EcrK9zDHpR/MQ==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr15245429plt.111.1583107528727;
        Sun, 01 Mar 2020 16:05:28 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l25sm18140080pgn.47.2020.03.01.16.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:05:28 -0800 (PST)
Date:   Sun, 1 Mar 2020 16:05:27 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc 6/6] dma-remap: double the default DMA coherent pool size
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011538260.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AMD memory encryption is enabled, some devices may used more than
256KB/sec from the atomic pools.  Double the default size to make the
original size and expansion more appropriate.

This provides a slight optimization on initial expansion and is deemed
appropriate for all configs with CONFIG_DMA_REMAP enabled because of the
increased reliance on the atomic pools.

Alternatively, this could be done only when CONFIG_AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -105,7 +105,7 @@ static struct gen_pool *atomic_pool __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_normal __ro_after_init;
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
+#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_512K
 static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
