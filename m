Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD172076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9uKljiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgEXJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgEXJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:55:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so8988664lfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeCr+tIMG+AGGaMyeGFNxL4+bMrusxmuCDUQGmo3Ue4=;
        b=T9uKljiYEm4gKFUMgPQyzhryUKmuantsdGhQyjz05fgiLUTe79SZYtEXUNyM/rMg3Y
         H2JIW01RnvPlpZl4z84xophy+H2XkfRiA00kGEuibh83eWVR51ZAk0/YkIHwNfL0c1PT
         bLWV8DWEVCjPjjk0BHU+RvMtk1YAAaIYw/sc3733RMAtDsDj/IbCqbYxB2JnwNxFU8Nq
         tHcDc7NOX59DA/7A1Px0yhkNSaHXmhHhdXWeVPekqUi+XFBGkUpogsvv0DxUt+jiHzeq
         iKfPYZ8E/5yzQobeSSzVHkQB0dqvC5tqpsiWjJgW/m/v3PUNToq4cLIwu9P46vcd06Q9
         daow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeCr+tIMG+AGGaMyeGFNxL4+bMrusxmuCDUQGmo3Ue4=;
        b=KED8ISLP1tzWHxdj2vhB6p2iLkyD7OrkpIq1a71ycECQVYEz7KfcJvqpYHbuTPFEbQ
         R0D7lFxWvs6tWQ+NdNTqaaNks4axPkOJCa0MyZG+3g+qOP4I+pXkRaK+Pjbx2OOyA2T8
         aPVN9a8frLe+/Hg6QTrgjGZWDisacDKleMFPN3i9kB8HALJytiw55xszHLbMH+7paPJ9
         cktYaIVpPF93ETuNJK2KsrZ5Jgk5Bzu+j7pk+YgpuOcuxEpaWMkc7jLHJRngunGoenrA
         sJDzIt+PFKNVJ/fwszGEv833zWPamroS0ULW+Bgw3nnI82wb3Ym/hXofRhinTEzVKHhI
         UZAg==
X-Gm-Message-State: AOAM530ilGBfNWU0tgH7HdMuyJu9E6eW0D59RRRn/B00GmCc+kdKYwua
        LXFATcELnPL1TtiWyVmwB5E=
X-Google-Smtp-Source: ABdhPJy6Mvwxj4Uxar/LqdTznbN2eX9wHVUuSEsfgMSGqPG9YO3sMsQUvZSs6lrnb8yyDI5/YTpc2Q==
X-Received: by 2002:a19:8c04:: with SMTP id o4mr4795188lfd.25.1590314130708;
        Sun, 24 May 2020 02:55:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id 72sm2153576lfa.52.2020.05.24.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 02:55:30 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>, Jyri Sarha <jsarha@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/2] drivers/phy/ti: Constify structs
Date:   Sun, 24 May 2020 11:55:14 +0200
Message-Id: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify some static structs that are not modified in order to allow the
compiler to put them in read-only memory.

Rikard Falkeborn (2):
  phy: ti: am654-serdes: Constify regmap_config
  phy: ti: j721e-wiz: Constify structs

 drivers/phy/ti/phy-am654-serdes.c |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.26.2

