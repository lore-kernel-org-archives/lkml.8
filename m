Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD56C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3562620663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Pg1lgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGOPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgGOPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:43:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A4C061755;
        Wed, 15 Jul 2020 08:43:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y18so1302692lfh.11;
        Wed, 15 Jul 2020 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5ULyzdtP/gpM8jSAC401vPHxbT9Qpm6n9VXueGgwlc=;
        b=C0Pg1lgwzXeHao1SbuzJo78AD2H02WFXgwwCYHBOYIt5QuVf5+NS4PyfNfTDk+kvXr
         i9iBby/yON+10+AyBk+8mbIszDILlxEQvzkMivTqhZxHV03P9Wm3/df1ce34+atSE0pw
         SYc/IM9HewITQjPMnbAF3k2HgSDWzX1QFgUYeKF6O32rLylcbcgXlg8o2JGKpbBuTCrl
         QkThW3uy2nyi+Lh7vK8AXq7HbPyBf4gBN2eBOgtrQ1KzYh1kuCenvKS62nbIOC5Z15+v
         bbloZyJ26jp42I8t1PQ4mvDX3O+2yBCH0LudRhjXqWS5S7ZwlPTeKm/p6lMWKq9B0Nx3
         Z9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5ULyzdtP/gpM8jSAC401vPHxbT9Qpm6n9VXueGgwlc=;
        b=uQi+7QTCrQPJoDVYZSwazquN/C3p4J8kr3aY58XFdCmkCpBRkzRWl9A40xnAeKF4tL
         xd/LI874dwBMzdYixVqcelFDtM40XhkrqlDRyJqw1+qDGujlf8UmHsY7xUupTMvBg1oU
         egz2zfGr03ofva3zbWzl7L3sQaCdyJnSi060RKZt+P+ry4mQduZOMDz0LMmOFtL/53eO
         qfugDko8i54GMbXigcQj6wNMatZw55MyHnoZvPYTdePbaBzg/2AEwI33ttVgpN7tbboU
         n7gvdeli5AiAMIihM+z1slm/rDi0w4AMa4wAeRARTBSHSeYlQLy1V1XjiZGTSBRXFSAZ
         1pog==
X-Gm-Message-State: AOAM533y+OmBtaNhfgxwDG6VRxy4YzuISjjHUikJplcyNFsEZhtRwLd2
        874Xe3m7XazLiBOQLb4JWnQCnE8p
X-Google-Smtp-Source: ABdhPJzltRTXqk6cMCCJeIvQexBXVOL0y34EIn0ZoltM3BSXJWzUivQIowoecW92rpi8s13+IEthCA==
X-Received: by 2002:a19:c886:: with SMTP id y128mr4991345lff.98.1594827785900;
        Wed, 15 Jul 2020 08:43:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c6sm563955lff.77.2020.07.15.08.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:43:05 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH net-next v2 0/4]  net: fec: a few improvements
Date:   Wed, 15 Jul 2020 18:42:56 +0300
Message-Id: <20200715154300.13933-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706142616.25192-1-sorganov@gmail.com>
References: <20200706142616.25192-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of simple improvements that reduce and/or
simplify code. They got developed out of attempt to use DP83640 PTP
PHY connected to built-in FEC (that has its own PTP support) of the
iMX 6SX micro-controller. The primary bug-fix was now submitted
separately, and this is the rest of the changes.

NOTE: the patches are developed and tested on 4.9.146, and rebased on
top of recent 'net-next/master', where, besides visual inspection, I
only tested that they do compile.

Sergey Organov (4):
  net: fec: enable to use PPS feature without time stamping
  net: fec: initialize clock with 0 rather than current kernel time
  net: fec: get rid of redundant code in fec_ptp_set()
  net: fec: replace snprintf() with strlcpy() in fec_ptp_init()

v2:
  - bug-fix patch from original series submitted separately
  - added Acked-by: where applicable
  
 drivers/net/ethernet/freescale/fec_ptp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.10.0.1.g57b01a3

