Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D1C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138C21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWFVFaE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBD0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 22:26:54 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35345 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCBD0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 22:26:53 -0500
Received: by mail-pg1-f171.google.com with SMTP id 7so4703620pgr.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6YjYn6BXH7WqeHF++GS4XYMLYZO97EPFGU0VNZwjrk=;
        b=QWFVFaE6EG6SzUe0Eu0/AJopy/tBy+E4KaLiOzNNnKDZ+InzFBBH6d9y6oXDD1p0Bk
         DgRZhCPdjmnoHC8gJaeesBnfg7WTslxgGn6qMciqVrInUGxjgpZySbK6vkhgMsZ3EnRL
         I27zVPc6LFKVi3tlMz4jQenxam2h8nEcUqVDEylc2vfVbf4axxkPx7w3AIbHg6aOFmXk
         xFf29JGE2Bj4iK3+StRMju+AvC8PpmQ2TqWeZoQCDR2MuD5JlK6snBGaWrXEjHzmvVjj
         fFA4D4vA/AWXGU/711864Di+GJWxN4xSdx1IYcdAEgsQK89Tt/Wbbzjc+mroftqd3ome
         65Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6YjYn6BXH7WqeHF++GS4XYMLYZO97EPFGU0VNZwjrk=;
        b=Rp/lcmQFwNVgj+cN8BBKHgX7zORorTpsI8uRE+ifVDtfr9Ev/+OaxtiFvQwZyz3HsT
         6E8Dt9EVcCsioywGyat9m7hhurHszocZ3ozOOdry4S9dRhCTF6RNyawicri4M/5qKhhn
         9+IBwUzhjrt7zC2BLdoGXgaEMEtMm0iG/O/7c/88ggYytXsaiy1xf4laxcfVdXx7D49m
         15utnnyC+eZokh4tLwH7TEvIsuN1rWa3WnXb3ICoVXBk5HCXXUMWBTG4ncN+NJ0FeKXU
         FhRjVhVac1QzxBbpoXXwN2nUBnIu/KGpIxRIt94ah2IkJ0hs/CYQ5Cu1Bq1UiiQXsNCN
         5ryw==
X-Gm-Message-State: APjAAAWqT2TqQuMzpY6T+msmb/tGaIWyQ438ycYQ1TfVzreQJFFj9Ajl
        GrRx+VJmKAfWf3pHBu3tcQWRxQ==
X-Google-Smtp-Source: APXvYqzRu+CHaA3CEuPwT7EdTKcOZjp9SVoiuWVf99F/1ddFKSnoeTCu88q2tC0vX+g7emLnpfHBFQ==
X-Received: by 2002:a63:3744:: with SMTP id g4mr17835545pgn.424.1583119612278;
        Sun, 01 Mar 2020 19:26:52 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b133sm18435739pga.43.2020.03.01.19.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 19:26:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] net: qrtr: Nameserver fixes
Date:   Sun,  1 Mar 2020 19:25:25 -0800
Message-Id: <20200302032527.552916-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need to respond to the HELLO message from the firmware was lost in the
translation from the user space implementation of the nameserver. Fixing this
also means we can remove the FIXME related to launching the ns.

Bjorn Andersson (2):
  net: qrtr: Respond to HELLO message
  net: qrtr: Fix FIXME related to qrtr_ns_init()

 net/qrtr/ns.c   | 56 +++++++++++++++++++++++++++----------------------
 net/qrtr/qrtr.c |  6 +-----
 net/qrtr/qrtr.h |  2 +-
 3 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.24.0

