Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823FC206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="haZm16Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgF3Sp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3Sp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:45:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD77AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:45:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k71so6343199pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36Pf7vLOoIjmkl5ILc1j+cAKoyh9jGyx3eicyZDkpLY=;
        b=haZm16FaN7L9wBGzn287iJdsYlLzqIRf1clHPgVmRu18KeNPfsyv3Mzx8qzBOvAWZ+
         ZEiMv7f0mBIn95G8IcVh8rewTPJUNMx5gqf7cNPBCuwsmwGfctuC2Gq/Hkb6XKVDAo+4
         6Q+6EhAhKdDq+8tAsPyclmZxtHDQeRaU94NiVLmuIEtzldU4qBjyUdFANxnJK1sw9zxG
         ZZPQpQojp6TyBuRyNGkR2jVdlEBFEwf7QRKSANrTSJMMcP5bo/Tceilwrcgm1vKO3wu6
         vvK2Z0z0SRFOH35GcASBAYR2wn6LNI1ZqTb6aRrJMJ0elkquw9/cDPrQRpjb1eug0OoA
         nEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36Pf7vLOoIjmkl5ILc1j+cAKoyh9jGyx3eicyZDkpLY=;
        b=AUj43ZpeEXWzS8NeKl0pygrRKh1C8AvrCOD/UA4rcKsxU9hpGHuSMy6wJg5ze5TVQ1
         bAPQQw8l6WqNaJw8rHUuKPAKoNZQFB1VgQwezeg/kd/PQsOi8KvqkmaTGmxf4QHIOvdV
         B2h2F7zgl/gypgF2DoGpf23Uvk0Uzx90MLsiPk28Q9D86XLGWEze9bmto3m/2x+UnJM3
         xNNVmUekjwXI5lJYSVOHSxKM4NozWJcG9M7OcmA8KgWS2hQ0el9z2TwurH9libcycEIS
         ft5ahHrSJ+vlzWYc6PzIXJdld+b39ZT9FqnnBcEe4upq8eumBC3YTVgspiYg4bLYvy42
         BccA==
X-Gm-Message-State: AOAM5326GqjbM6Vy7fBYFxIVof6BibZ0E4Av7JfFntw8yq49XUMCaAVN
        5sQWB++Uw2DoVD2FdyTw5MVeEg==
X-Google-Smtp-Source: ABdhPJwPaD/fLLXkzmsb4f+8hOMS05fApeg/LQl99uaMgVqHMvdpjIK/hEk3OxycS1sLEIU8isGIXg==
X-Received: by 2002:a17:90a:1acc:: with SMTP id p70mr13487771pjp.210.1593542724210;
        Tue, 30 Jun 2020 11:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id n7sm2898108pjq.22.2020.06.30.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:45:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     oleg@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHSET 0/2] Use signal based task_work running
Date:   Tue, 30 Jun 2020 12:45:16 -0600
Message-Id: <20200630184518.696101-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a regression in 5.7 with io_uring, introduced by the
addition of using task_work for certain async events. Details are
in patch 2/2.

-- 
Jens Axboe


