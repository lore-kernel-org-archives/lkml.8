Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC63C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1532206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4JUPiU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgC3MhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:37:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgC3MhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so21383480wrc.8;
        Mon, 30 Mar 2020 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jNBtBIRPRZRApRTVxkc7PFluInjWdCPFuYyNKh6tucA=;
        b=l4JUPiU8ZgfQa3qprm8PFClUiTwLgLd5G8yy0AsAKiXgcuTx8F/AcKk3AOcu87CWE5
         UgTYZxgpE6ALxD6UHgSCVNkAzBqLQkBnWJO43/7k9zJWQlYEZJ7xK7FzkwQgYBcPBR+R
         L/+XnYl0pXtCsr1b0c6tU2fOGdOBTWl2LsoBZl0bezAaSZ0HqU67KNjcUXtn3EBTFGe1
         WEPjbwLLKsq80yP4O9zillTCPjniPXHbBZlmb80x4olKz554cgfC7kf3/7EDKUpgWt8Z
         Q5HgScVmmo522p2rGjR1orkI9auHMiD6rKsv6T9umcyc+g0K1tkTwV/4iE17c4lNs0mb
         Uh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jNBtBIRPRZRApRTVxkc7PFluInjWdCPFuYyNKh6tucA=;
        b=brqrOuIVD603wO9xDPjvf6hq+NDhsd1aK4AbPRgC7lct05Kt363q67zCyxBz4G2EED
         TUegl4BFJ+913GHjzauMLBIlCPE+Hcth3RPr119NjRmeh5ni/f39jIoQs/1YA887xymU
         XW1fPZ6VBueLNMZ8LuHuelOxLeISos75PwqAEisGlxrIaxYDcBgnoa67eveJ44SHRJGT
         5s+hVsvoXsp2ycBdB7Js38YXQNXVuTZIwfvGXpdj/P0kQAljWUFPpU2i4UIUBYR3Cnpf
         o/hwMpAbql1abmu33XTdq7dfoe8NsKq/4jAvDq+r3f33AZSC7ZqD4xuUOQ6K+ypSY5x9
         6c9A==
X-Gm-Message-State: ANhLgQ0jwFrPw3I44i0jASPySjaDyt9HRk752NBDHflz99RyyyXGVccj
        LknskobfodWid/LgakVXSAQKm0NM
X-Google-Smtp-Source: ADFU+vuL5szum6XYdq6ZVe5/X7bVyxnFchqJuR++uYQ3ZtIVDodT4SVFHQrQdsyqZsytzN1S/I0BGw==
X-Received: by 2002:a5d:44d0:: with SMTP id z16mr14230594wrr.28.1585571834724;
        Mon, 30 Mar 2020 05:37:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r15sm23341498wra.19.2020.03.30.05.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:14 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 5/9] XArray: entry in last level is not expected to be a node
Date:   Mon, 30 Mar 2020 12:36:39 +0000
Message-Id: <20200330123643.17120-6-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an entry is at the last level, whose parent's shift is 0, it is not
expected to be a node. We can just leverage the xa_is_node() check to
break the loop instead of check shift additionally.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index e08a0388a156..0c5b44def3aa 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -238,8 +238,6 @@ void *xas_load(struct xa_state *xas)
 		if (xas->xa_shift > node->shift)
 			break;
 		entry = xas_descend(xas, node);
-		if (node->shift == 0)
-			break;
 	}
 	return entry;
 }
-- 
2.23.0

