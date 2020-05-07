Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702A3208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5Rqr2r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEGMXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:23:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA5C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:23:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so6262160wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ac6yE481fJDZ3o9Z63NMImFTDEyD3V8+Y3qKCMgWoPA=;
        b=v5Rqr2r9F+ff/FgvWLYFXpvnWQ6PGMIskO2UNNWwl4mAJXltqPslWgaZU2FN5YxE7l
         ES+Hl2QFacSzmjj05ohmJFSUlkQCB7aUHhDCBfaxUKlrJK6v8HfWsaCgL+r9cbuxtpFw
         JrboIZoWJjq4QecAkJ572bEkpx2iKXv9FYPZD94OoqA9gy0kN2jH+HJ7RSMUHls/jkxi
         V2Xs6Xvgn2NII7MFBOaaZJC5cpCM45m5s2mDOq0mUBsprBIY1m6CBcKTXNeLjpOSyQAq
         Fz7ZcaPUGgafuneVY3Jb9gTBZkphqwH1bVVZzGHEch4DwNQDh9KUG9zB1pz4LkCg2y9q
         thYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ac6yE481fJDZ3o9Z63NMImFTDEyD3V8+Y3qKCMgWoPA=;
        b=kTb9iO0ft8dGdvomt8tVwK7golJy9Njv7DKanFOHc3lIAeQC7LslEkBmxIDnV401a6
         +jmlBMCA2uAGOIE2A78Nc7oeEeQEDzj1cbbThiTTg9SOIYX6zyqj/+apYYFO64YPGhcN
         J23l2dHNawgzjPYHrphqIOrSsR8DiSZXbr5DcSWMbxk11881TH5y1wIoqpLP55fEh+LZ
         64/sYop94303wx9RGdSD1WbiwSIn7edMzjvowEKiS1PCf8iu6WiZ8/5XBju38mXIa3Qy
         aLHMH5QJuXK3CLzawXnjo1cjeqCqQbUHn/0epg9rc0nDdHKC7zG/eVyKyd6iN/DcQPPh
         /rYw==
X-Gm-Message-State: AGi0PuaQGVWWGkr9Ay+WHdarp+TT/tqlzHCfhG6rgYbEXNjOYpsuVK6S
        +yRfdEii2NHw5J+fyZ0/G6LiPw==
X-Google-Smtp-Source: APiQypLa2PmQTZ6UH9IRltoQ1UhHVIeZ6p3mcU1yFPbZDLuUORULrSexDujKp3d46J4m15kiQTVENg==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr10616291wme.77.1588854199140;
        Thu, 07 May 2020 05:23:19 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p7sm8202936wrf.31.2020.05.07.05.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:23:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] Add TI tps6598x DT binding and probe
Date:   Thu,  7 May 2020 13:23:50 +0100
Message-Id: <20200507122352.1773661-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simple series adds DT binding yaml and a DT lookup table for the
tps6598x.

Its possible to use i2c id_table to match the 'compatible = "ti,tps6598x"
and probe that way, however I think it is worthwhile adding a specific OF
way of doing it and having an accompanying yaml as an example.

Bryan O'Donoghue (2):
  dt-bindings: usb: Add TI tps6598x device tree binding documentation
  usb: typec: tps6598x: Add OF probe binding

 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 65 +++++++++++++++++++
 drivers/usb/typec/tps6598x.c                  |  9 +++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml

-- 
2.25.1

