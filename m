Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07452C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BD920724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="qgSndENZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCRBnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:43:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38090 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:43:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so142436qtq.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0b5WLsdgfiR/hAFOY1sB2eFKdHn+83f5OZv1AD8it0=;
        b=qgSndENZddrIR2I4cydy7JaMW73b0CxPToIjxG1ZE0TTzbN2xWQkQgAB/xpbnei++o
         8+ebYrUn4HIId2ID/7hF/AT+Py0Cc51GHAs1RWc1vIiTAdFv8daz1CDkgCdfuRTLAEJJ
         vSbTLizg2KByfTFCtEKLzEypie6jjTJfLM3jP7Y8Cafouwlpj7hsDhIZCqGGCaMmccqU
         uJGQ+Xaj1pDqnqXaCVL8fQiVRKzSrFa50cCMrZuLfYEOuyvk5B6cYrQDbc4pqZniw/G7
         bflk1ORZkn5pn4F5zVGX1og+bhSnpOoc/FHNp8IKXCqmP21ru52ngcV3/jJRP7h3Pbek
         BNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0b5WLsdgfiR/hAFOY1sB2eFKdHn+83f5OZv1AD8it0=;
        b=t4e//WtG/NrNRYXdtbs50KE1b9+jVREJd4Q6JoectlQ5vG/xAoMIb1xRFR6OnXeBkw
         tZ2elVnlIAXifo6faph/WBHfvlktsHIs3mS3CmTE28CrSGDLresHGMj2AvPTTHjzyWlD
         D9PpAfQW95EaGe37yqooWSJpRl1wcen0MicbZOH0HXWlqj26rzQGo8qN7mDw7pI+t2wg
         9UZfxb1Lyl5FCAR5imoh/ra45VlSHwHtw0LQdNV0quuKUgj3I8qRDZuBVQwPsCkqwQPC
         dasx5nPHI5qEa0dFek3f3tqO3C9o+GnC2XKultZjfvnghsmsd+ReOwj+60LWF/JEDpDk
         HcjQ==
X-Gm-Message-State: ANhLgQ25+2k+c9+v+w2SU5Ea6fBC1u8jojfpf6D/Oh6Wxo91Ykn9/RL3
        mBDGTakJIs+rVlXYmb79oPLvnQ==
X-Google-Smtp-Source: ADFU+vt4qdtqYNp0md5miZ5EokE2sD2apk116S3hvJDV9bEIEBdSJqnmsCcM5zkMCg2rdg2MlKSUKA==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr2212557qtd.268.1584495786865;
        Tue, 17 Mar 2020 18:43:06 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id m1sm3740883qtm.22.2020.03.17.18.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:43:06 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH 0/2] xarrary: Fix warnings reported by checkpatch
Date:   Tue, 17 Mar 2020 22:43:01 -0300
Message-Id: <cover.1584494902.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series fixes checkpatch warnings in xarray.h:

 * Add identifier names for function definition arguments;
 * Add missing blank line after declaration;

Vitor Massaru Iha (2):
  xarray: Add identifier names for function definition arguments
  xarray: Add missing blank line after declaration

 include/linux/xarray.h | 88 +++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

-- 
2.21.1

