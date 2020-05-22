Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89762073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="K46G5HlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgEVFX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:23:58 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:39574 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:23:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49Svzc6xSrz9vBs6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3ShFys4YjyYL for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 00:23:56 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49Svzc5JLxz9vBrk
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:23:56 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49Svzc5JLxz9vBrk
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49Svzc5JLxz9vBrk
Received: by mail-il1-f200.google.com with SMTP id d8so7717017ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gMkSYpaYiObsrUAVjFqJo6jrnyjpZK7kA9iCJfIjrqc=;
        b=K46G5HlWLq1auBODxrIzWkUvSV1jUEIMLHROEWmKaZZxC32phG4tfLMl8okF/csdmU
         Qb7d4/gZfZBmI5FFy/CTuhYTjf2XFyJn/Lz58hnRoh6IDboSeixagSp/3EOh9bqeKaXg
         kNh+s14RC3ogRe/maSFJvzUAdyi3IpaZlrNBR3nc2ouwvsXXKD5XiI2OSsvOYtePv5y3
         Li1xzhSOlRYK1iGyU3LvgGDwlSscEgxEHCUPo+9cK9a+h+2siKz4EJMGu0wqasrfgjlN
         kPauEuxP8pTiLDeFVqoJ172uqZ0UMqu/r5aQes6a4/HmFAl+96BRgXKmuFVpqIqHDaWw
         CxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMkSYpaYiObsrUAVjFqJo6jrnyjpZK7kA9iCJfIjrqc=;
        b=F8wxb1IGYkQD+wdxSUBjfI2p6D6q9gKbe5W9snrTyM0/3IA7Mmu2C76EvY2N96vKao
         yXt1y3PbybmKVm8r71ynoo6M8YB6xMeImdWKh2/dMPoc4sHNGHxBiecnc+RRcv0W44Nj
         K5FH925zMLx68k6SDwol6mZYGgNAn/79MzHDa3KGW5XFjxa2DVhSdn8ssAudV/koTYbg
         Nq/RPYZ7mREwYGdoahF6W5GKcjfxhNgIZBYjDppfY7nF63DuLU8f1HNAEOZbpQTvKgrM
         rzoWYyKqa1d1FgOrko7XQ0cTvNmratUUkRi9nld5fnsGLY3yg2l5aGVgmB+cG2XVard/
         W0wA==
X-Gm-Message-State: AOAM5319LcJ2Qa32eyV5FcRho8j2MaOQ4PYTcGA/WcMRWg/b+SK+jojA
        NQH+v2hTcYlscla7BmdGJVmETgdIMwcDP1jSckzTeRszMfvRTja48TQNTgIlJh7bB92fD5tSkWm
        2Nz86MMclCj7l548O1nSisYpT55a1
X-Received: by 2002:a05:6638:12d4:: with SMTP id v20mr6892433jas.96.1590125036282;
        Thu, 21 May 2020 22:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9YKaP7wbCt6UDzTnd/OuhdJydO+ARIMKhGdek3jVG5RqkpTWXM/g1l8gx5w/z/sQO+Uq0Qg==
X-Received: by 2002:a05:6638:12d4:: with SMTP id v20mr6892420jas.96.1590125036048;
        Thu, 21 May 2020 22:23:56 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id i10sm4042490ilp.28.2020.05.21.22.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 22:23:55 -0700 (PDT)
From:   wu000273@umn.edu
To:     tariqt@mellanox.com
Cc:     davem@davemloft.net, kuba@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kjlu@umn.edu,
        wu000273@umn.edu
Subject: [PATCH] net/mlx4_core: fix a memory leak bug.
Date:   Fri, 22 May 2020 00:23:48 -0500
Message-Id: <20200522052348.1241-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function mlx4_opreq_action(), pointer "mailbox" is not released,
when mlx4_cmd_box() return and error, causing a memory leak bug.
Fix this issue by going to "out" label, mlx4_free_cmd_mailbox() can
free this pointer.

Fixes: fe6f700d6cbb7 ("Respond to operation request by firmware")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index 6e501af0e532..f6ff9620a137 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
 		if (err) {
 			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
 				 err);
-			return;
+			goto out;
 		}
 		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
 		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
-- 
2.17.1

