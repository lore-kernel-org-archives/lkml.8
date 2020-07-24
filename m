Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDCC2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ell91Ymr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGXHPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXHPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:15:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA22DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j19so4741230pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xT4oXHKFs33Hnu3ETYzDTC2JWohi+9AnAW8YedR0gHo=;
        b=ell91YmrlG1qUNUAWDqyelSayLSTL8p0TrkSHlTsQHdGDhkMjLn8GWvsqdmk/sCqy7
         tKhMfOIgWs92luRCGNmAETyMS9olFdaUEPOdIASqWZe/xWR0EY56DHDZC73+Kgbs8S+I
         PaLXyayQgDvDxWxtWPXMv6LL7neiLlRP9Wr7E0GW03LeFiL4WQQw9XB773Spi7BMYIW2
         U6JTOl9rHaZlF5fN48CzwOAgmf5QtHtKhwq2jGsN2QVURhcrn8V6Dg90CNoo1tgXUTlO
         biBvSgW3+gGZwrnqUrEaCPc9M0Th6txVUIkB39KVNGb/erDN8br8xKjqQXHyFGbMLgNp
         8VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xT4oXHKFs33Hnu3ETYzDTC2JWohi+9AnAW8YedR0gHo=;
        b=bmP+5J2hp5YAW+hmvwKPdxg8qijXLjd5IJx7JN9qcCKI2pi0L0vhCyW8/fCs8SAVFf
         7DePdL7v19hAy033Ckp2JEM88A64avpcdavqYSlSn9b8Mk+Qb9p0XeTH2lAE9zG2RpxH
         V5RnvueuITXYLWkIXv8tyJZ8y27ZMrMELs5UAB7i71ZcxeGBctapVsU3w9tYiXjUF0ls
         pbjfUs6CEBA9gbVMa75QJd5Z+bdqx4Wl2c1EVzmwiBjx/4Ya2tUqMhvbkOFWIcoF3IIH
         gqiubciGtkyoyYimeTTAGo29pon/cxf/dWTu8kQyVJLtunFysikr6QHglk4dTvXO5Fi4
         veag==
X-Gm-Message-State: AOAM531iZPyqN7cgguCvBB4TtPA7bbuuYzlJG3jOMju+x0P2g7Qtxp1N
        dms7Zs/HDEx88Bu3kx3yOWw=
X-Google-Smtp-Source: ABdhPJx4qvExCRx1KpJIVC//DrP1/QTQxxI8np2An9uUYld75tkrtzNVSxm+TK/Dw+KJGAU1ZJDw4A==
X-Received: by 2002:aa7:9ac6:: with SMTP id x6mr7657029pfp.326.1595574948358;
        Fri, 24 Jul 2020 00:15:48 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id e20sm5206216pfl.212.2020.07.24.00.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:15:47 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     linux-fsi@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] fsi: SBE FIFO fixes
Date:   Fri, 24 Jul 2020 16:45:16 +0930
Message-Id: <20200724071518.430515-1-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two SBE FIFO fixes by Joachim.

Joachim Fenkes (2):
  fsi/sbefifo: Clean up correct FIFO when receiving reset request from
    SBE
  fsi/sbefifo: Fix reset timeout

 drivers/fsi/fsi-sbefifo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.27.0

