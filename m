Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B1C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C4A2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqRdB+56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBVGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:42:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44370 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgBVGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:42:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so2438060pfb.11;
        Fri, 21 Feb 2020 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6NOWgkJuVNBzcRIWQKK+1L2R6ELyCXl3BZEpc2cyyg=;
        b=FqRdB+56woJ+aqiLb2Cd0+dDu3Rnbt4s70LQ8+EbM106IRfJasluEqi2KryUpycnpa
         q46Pq0kb0YYO4m1Eo9qos5zs55uz/HYlEiPssXEfy33wSj5in56o1Mw0y49vLcmJS0SY
         KOTH5triN05mU1FQJYa8AJqZsid6Aonj/ufDlabhYcxsGlsumxffcFpMUDxWLnL7pr6X
         0NyVv9KrUsBpfk2Ha2RdaczyDdXY9OoGLoN+oazdrGPJHmXtTPYKfgVT6KW0BL/sOZbz
         p53x+j7OfmyjxxNdXL1y2/YbXE19bh+x/h6q2IwQ6BwfPUi0JCZPZU8zOtK1LS1pEVFh
         rD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6NOWgkJuVNBzcRIWQKK+1L2R6ELyCXl3BZEpc2cyyg=;
        b=h0EixJphnExxQ4PoJSWJmhHQhgw+8rhVGBhgjGeZdeEiTIljOAJ0fb0jkapeCsahhG
         QG7mI69bUtbnRg/WjznbQfpH3wB1GyfoI9ZHtW/klzZzrULSHETpt194CXP1aF9diRcH
         PbBa/akioy+y54839J74hL4v8/HVOeYWTfSAfCRazri4TMJdHd3TLR07MSwssFq4xFB/
         hm+lxtk+uAa/atyPZzFJ0lQsh5EAC1457rLC0/MQz7YTrzdCT3uIJ46IKoJNIcXWTOpA
         hw3hZO7zh/zfPDVt0rVcRYYXdwlJmNglaHLpf86LYvmzjwWazBvfm1v0KtuvQEpa0VfL
         djnQ==
X-Gm-Message-State: APjAAAXsmXovDhb8/O6A21lrPUskiW1w3XXG/EifURk7gE5aJE6xA8vy
        IFu4J3FaVPyAL+QDnFAmht8=
X-Google-Smtp-Source: APXvYqzDbgRAfSah8enAHJuCFgRyyBPFc5qmEZEwMTAKxSh/dXWKbXLbH0Ui0FVikX6GYWQ+VW/dWg==
X-Received: by 2002:a65:5a42:: with SMTP id z2mr1036184pgs.213.1582353729466;
        Fri, 21 Feb 2020 22:42:09 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.201])
        by smtp.googlemail.com with ESMTPSA id k5sm4455071pju.29.2020.02.21.22.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 22:42:08 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 1/2] ipmr: Fix RCU list debugging warning
Date:   Sat, 22 Feb 2020 12:08:35 +0530
Message-Id: <20200222063835.14328-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipmr_for_each_table() macro uses list_for_each_entry_rcu()
for traversing outside of an RCU read side critical section
but under the protection of rtnl_mutex. Hence, add the
corresponding lockdep expression to silence the following
false-positive warning at boot:

[    4.319347] =============================
[    4.319349] WARNING: suspicious RCU usage
[    4.319351] 5.5.4-stable #17 Tainted: G            E
[    4.319352] -----------------------------
[    4.319354] net/ipv4/ipmr.c:1757 RCU-list traversed in non-reader section!!

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 net/ipv4/ipmr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6e68def66822..99c864eb6e34 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -110,7 +110,8 @@ static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
 #define ipmr_for_each_table(mrt, net) \
-	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list)
+	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list, \
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
-- 
2.24.1

