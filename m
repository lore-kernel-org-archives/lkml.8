Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B21C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD960206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnhpLZp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgFESqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgFESqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:46:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C9DC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 11:46:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so5577433pgb.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJNgAE8W4L7bDdkEn/de45xF1mTctBl3JZOgDeiH31E=;
        b=SnhpLZp4Omylm5YzCyZ+OziHEXjtNTiqVN8OXyS3vg3li2fxjVapcJ/c5vgfnrWGM3
         4Ab3R9zlXs8J5L8+wANYt4y6QbjY1rI8meKI9a3WtyPJ34oBIu5M/WqJzGSG0/8+e0B0
         isJK3X9mHFI0PyyRNU4nDwhw+z32JYnn5ySqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJNgAE8W4L7bDdkEn/de45xF1mTctBl3JZOgDeiH31E=;
        b=QuWzfzwX3VGkyFyNerDzcZ4g1rh+ik3SMCKuHvMnPe9SEgv6M/3N2ruk3Yg0R/GTwY
         ATCU79UscNzXwmhPOIEhHen64yjzp4VNGrlfSXCdp/JNoxqt8PqgQ8nG7sizip6Mp+CL
         BAQyBI8MqqENSP+then/tb/HEfdz1tpRuBVMbYGuxQsBbfzVR3f8psCG3kUywsWz7FrP
         Du7TmDIA3WFzi9LcEDtoD5vHGm41VZil8GaI64OKFLsTb7dQcNwz9dWveqnZZELeyKCt
         LfcCe5+exw4buzcuFld/jQ79IIN7lfQbkK4h4qM6dCApg1oBHyLNUwGnGZ+G/Au2JXpt
         SNDw==
X-Gm-Message-State: AOAM533/u2EmBZREC3yiFKGzQj6va092za20YqPbSURK2e2lhZKfbGXu
        kNheAd/d//lz/dDnLUyO94L5Pg==
X-Google-Smtp-Source: ABdhPJwA+d7fJQcL5nPsCQ4cEYnUF+r4G7dUXN+b7g8/2ykdGsMs6nbt78RG4NKopns6i2hTyJ/7aw==
X-Received: by 2002:a63:fc0e:: with SMTP id j14mr10998607pgi.264.1591382778281;
        Fri, 05 Jun 2020 11:46:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id j130sm312505pfd.94.2020.06.05.11.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 11:46:17 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/3] 
Date:   Fri,  5 Jun 2020 11:46:08 -0700
Message-Id: <20200605184611.252218-1-mka@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a fix for a possible race in qca_suspend() and
some minor refactoring of the same function.


Matthias Kaehlcke (3):
  Bluetooth: hci_qca: Only remove TX clock vote after TX is completed
  Bluetooth: hci_qca: Skip serdev wait when no transfer is pending
  Bluetooth: hci_qca: Refactor error handling in qca_suspend()

 drivers/bluetooth/hci_qca.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

