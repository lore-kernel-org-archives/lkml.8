Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DFC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46E020663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+If0UPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEFHX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:23:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC8C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:23:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d22so716728pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjwZKQ/MsOEoyrI1M9q54kkv4zKzlSrLRr8tdH7/u6g=;
        b=K+If0UPxcEszSaumR/NuK1/VhEn/oTDJddd23FqiNVVBAl32UGkD3t8Ahb2L7gAg3J
         c0BwnArx3xdme3E0yTCfDY0ITbByJRm4LJbTTpx9ASYux8G/7/spyYpAMKwpT5bhAMfW
         wO4gjMLL2G0vsIj4ftf3LKoYDTUnqKgV0rXAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjwZKQ/MsOEoyrI1M9q54kkv4zKzlSrLRr8tdH7/u6g=;
        b=D8IGz6M5J81UpeT8qrESZe/A1e3QmJYV2KsWfUw/KHJYid+Fxe/7WxI/A8Wv8bywtX
         qFgfQs15fEPgqk7tSvIEWv9IykeQgITqKxZv3QCFGqjqBxf/E0AiM2x0VljDNUOl3pKy
         YM8bkjsx356BtfLQx2HKbo8B1xxHPQzduTSqXfPdyIgCWebuhtC/wD1rSN1gpC5LU5Hl
         6fFt3AK8gFneeQUwmqKHCOybVdTyCFHSqbaVwydxypNDCA05YEhoWUnFKqtaoBPCQkLv
         qIxs+T3U3RWgsM9tNCIlZ+kwZW/A3L4VUA4BW8Gb6DBBfEOWugSEF/cPbJ9cppm5sOfv
         J/cQ==
X-Gm-Message-State: AGi0PuYaBXsWVd7eWiFUHrNeITZApAMOnVruWtVESy61FvfzXx/caiek
        eouLU4qKLHC5uCi/Sn4qqHmeWQ==
X-Google-Smtp-Source: APiQypIUf1EiFl44Et+u6l1H3cnWCYGcfkquxMyqGWV5GjOWfcnttjRAbg2g3LDbGI2TFev31Xa/pw==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr7000734pff.168.1588749808248;
        Wed, 06 May 2020 00:23:28 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id x10sm993142pgq.79.2020.05.06.00.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:23:27 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH 0/3] add wakeup_irq for in-band wakeup support
Date:   Wed,  6 May 2020 15:23:11 +0800
Message-Id: <20200506072314.112409-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since some uart controllers may be off in S3, add additional wakeup_irq
to support in-band wakeup.

Claire Chang (3):
  serdev: ttyport: add devt for tty port
  tty: serial_core: add wakeup_irq to support in-band wakeup
  uart: mediatek: move the in-band wakeup logic to core

 drivers/tty/serdev/serdev-ttyport.c |  2 ++
 drivers/tty/serial/8250/8250_core.c |  1 +
 drivers/tty/serial/8250/8250_mtk.c  | 24 +++---------------------
 drivers/tty/serial/serial_core.c    |  8 +++++---
 include/linux/serial_core.h         |  1 +
 5 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

