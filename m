Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D173C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372B620674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgLVISRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbgCPXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:02:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46720 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbgCPXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:02:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id r3so647640pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aGyzT0vKIRT2g1z+Kny0oBSvm9om2Sv2iOSx84RwnM=;
        b=JgLVISRwkHnulOTANDZvp4F1lICL1CcLM91PYaOwIdPWmMMGuKxE+VaaPF9FZGRYbk
         1kCfWoVGMA9qfSF7M8wA4ZTwx0RoJkYjiNjp/hh8NbQk9KqNFDu+0r3e19gBnpwn14jG
         IUkYVEpameLZHQraw5z0FnpSZFJBtEDQX5YIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aGyzT0vKIRT2g1z+Kny0oBSvm9om2Sv2iOSx84RwnM=;
        b=gIuId1hb15DCotqnEt6uJ0R74Qbog4LTaEiFSPotpNZ+o1vAntCj9fCZRR+5DuAcfq
         zsxie0i8G7mLh8nVqgA5z0IwUWjkIG6/7Cr8ld2p8x7biswYDZ+T51ACT9w4X0gPA66E
         5jdHzSJmZUZ5KDvIqpQV3RS5yngyQNQzYyEJvgusfo8c9YBW6GIaHWuOZH1nknY3bToc
         4Z7RGPcCXP2e0b8EJ3NQmXpUVU6Z/efpX2zEO1FpUKkhz9UuQF6Bo16+zDyVnTixFHGM
         CzfUbnNoLnG9ciZ6WlW9wdgTjH4C1HmMd10dx89oJf7q0OL7BCw1es85MlfU7kWt9fRE
         9BFg==
X-Gm-Message-State: ANhLgQ1mnGLH5IroVXURRzIztnY7Y1Fl3faRk3WNqwybDBjFCHeIkZZ2
        XT5FyefDJdiSteazR18FfGEY0g==
X-Google-Smtp-Source: ADFU+vt33o+PyakPT1/b5Yylhsz741jk4pnatxgcie++xzQj4E+d/kcr8bZ9Kmn/9yhbZKKWdWYr+w==
X-Received: by 2002:a17:90b:2390:: with SMTP id mr16mr1899451pjb.149.1584399760563;
        Mon, 16 Mar 2020 16:02:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y129sm877405pfb.111.2020.03.16.16.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 16:02:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] Bluetooth: hci_qca: struct qca_data refactoring
Date:   Mon, 16 Mar 2020 16:02:31 -0700
Message-Id: <20200316230233.138696-1-mka@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series declutters 'struct qca_data' by grouping IBS and
memdump related fields in dedicated structs.


Matthias Kaehlcke (2):
  WIP: Bluetooth: hci_qca: consolidate IBS fields in a struct
  Bluetooth: hci_qca: consolidate memdump fields in a struct

 drivers/bluetooth/hci_qca.c | 467 +++++++++++++++++++-----------------
 1 file changed, 246 insertions(+), 221 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

