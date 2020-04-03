Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF3A20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZGNNLO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403993AbgDCNRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:17:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728044AbgDCNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585919857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ArqORMrJA2OqQPY2t/1A7/OKoVfVWVKes8TY2CWI73M=;
        b=NZGNNLO/TxWo0oQ7DhvsBSV0OCGijfzIJ0Vlv2ULJy98JxfxnzU/bhn0LIES9qBdALS7+C
        1gX5gNPBCw9VABLHOLew190jmafrlq9bTR1cURBUNjkThE5br/Iq6wgCPWHtu05DAswRxK
        U9oCGUJb8Il134hVCs/3vTJG2jAta5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-dVnzUjVvOSWicbIa5YfI0w-1; Fri, 03 Apr 2020 09:17:36 -0400
X-MC-Unique: dVnzUjVvOSWicbIa5YfI0w-1
Received: by mail-wm1-f71.google.com with SMTP id y1so2770082wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArqORMrJA2OqQPY2t/1A7/OKoVfVWVKes8TY2CWI73M=;
        b=RQJms5ZprhR8uQfTx1OLAJLqQAJj3suDFwoVuynUFbev1Yl2LZTwRl5zjBeMBuBCtC
         JmYhAGSG+AII8jNqJpVnz2EMD4rQuGJXRt99Y9l2QDKusTEIvIFJpFaDLNFT/7+m7eWC
         fyNDRcEYG1g/Zc6En+JmiZJcbDqn1aT+LlEm87rdEOCIeIwEuFUtkdX1LLClvZjDGWuP
         flwyMMz4fDM6CLA2pfTD2NCsz5w9GDQXf8dM1JQUD5JQbpvOT2CQ9Ikw0yUYgws0caXx
         qC2DgVs5EsyaLBrklihHYyLTTL9oGywDe3B3SA+e+jZCPDG2YX/T+ctfWwWnAb7TE6Mv
         QOBA==
X-Gm-Message-State: AGi0PuYRGJuQ4qG9ObX7HYzMYWTK0Gam9QDO2bRa0awQK9GWPVv+E47B
        RhzKDfgulf9jnwF6nfimGB5sfhmFtv2W9dxWWZukAa6qiulxp9PlaE7nw4yjNwNXEcBbuFkx3sJ
        ePZxsUbmUBM4PaZLM7ShXgTZ6
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr8540084wmf.162.1585919854426;
        Fri, 03 Apr 2020 06:17:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypLeKuZWTOoGObgblVmU1XlPfLncIoodjwAYn/v1dYHKOG7SEuhVlGH+GOLYChQjO8q56nyz/w==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr8540065wmf.162.1585919854180;
        Fri, 03 Apr 2020 06:17:34 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id e23sm774957wra.43.2020.04.03.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:17:33 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH] objtool: Fix off-by-one in symbol_by_offset()
Date:   Fri,  3 Apr 2020 14:17:30 +0100
Message-Id: <20200403131730.32618-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
associate the first instruction of a symbol with the symbol preceding
it.
This is because symbol->offset + symbol->len is already outside of the
symbol's range.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f1def3..c4857fa3f1d1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -105,7 +105,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 
 	if (*o < s->offset)
 		return -1;
-	if (*o > s->offset + s->len)
+	if (*o >= s->offset + s->len)
 		return 1;
 
 	return 0;
-- 
2.21.1

