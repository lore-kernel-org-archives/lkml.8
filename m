Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A1AC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378102072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bXay2jdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCWJYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:24:44 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:37131 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgCWJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:24:43 -0400
Received: by mail-pj1-f53.google.com with SMTP id o12so2071786pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bdTHn3nXQn2EfuwJRXtyjGGloibRrt8s6wxTkj/U+A=;
        b=bXay2jdTdHaTyCEl44b+RKKSYect2Ugntrm1gnY07gcLAJusH9cN2GgkpbbAJdKd8i
         yRjbl+Q+1td9SpYJfXsilb0rCN4NqGqMZQ858xJUkEU3gq1dTOztsn6pSHB/F+fDC1Kp
         8UUgSzinRltm+e4NTfpjI9x2LZhCXqprz5rJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bdTHn3nXQn2EfuwJRXtyjGGloibRrt8s6wxTkj/U+A=;
        b=bdEwyo4YBSiCx3xiYqM1YjXYrgXnNJ6Zzf9UHgRuYsboa7GE2h/JeBSMUB893FZrlx
         xNVBIrW+tLc1flK3eI4G+5vXUcCcwLkJA2bhNyQXn81Hi04YleNNF9vcmufNpZknBkp/
         F2S+wBfMzhY9tzjX8Qv3XyKkJQxK/6w/IDSIQOoTGeZLC0wNapdAB3DTYdeFeimLvxTT
         0wjyHKpXpl2MKNXS2HO3IE5Q+k1VVxQrnr2m5MCQBp6WVBiomG+y/A8WhDLyETkuDHdV
         uoxpMOBB5XcC3IpnYrku7Z+Hd1QasnTLobsWw61aAAgXHDqkUDABJouCbqE6kj9rPeW8
         YWZA==
X-Gm-Message-State: ANhLgQ0FsrhMmDd/rVlciI5TK13deWjhyl6jcCZpZWeL+wy/982qBFq8
        rpWY9Wat3cdBYCZEXbeBFRI66w==
X-Google-Smtp-Source: ADFU+vs4WZxYQEwx+zNTHgg6ZUe1A1BpGJdICQls2V2lfHdhLmgMWfyrbNZmAfQSvcLz5E9ekx460g==
X-Received: by 2002:a17:902:ed03:: with SMTP id b3mr1634171pld.247.1584955482641;
        Mon, 23 Mar 2020 02:24:42 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:41 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 0/2] Handle return value and remove unnecessary check
Date:   Mon, 23 Mar 2020 14:54:22 +0530
Message-Id: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains following changes,
1. Handle clk_get_rate() return
2. remove unnecessary check of 'duty'

Changes from v1:
-Address code review comments from Uwe Kleine-König,
 added more details to commit message 

Rayagonda Kokatanur (2):
  pwm: bcm-iproc: handle clk_get_rate() return
  pwm: bcm-iproc: remove unnecessary check of 'duty'

 drivers/pwm/pwm-bcm-iproc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.17.1

