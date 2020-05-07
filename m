Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E6C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E82F208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6h3fRoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEGTOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbgEGTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:14:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29344C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:14:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so5786399qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIiwVFpw4ZhZjwUQ6twbeuIA8JamFmPyOdxqKvsHNzw=;
        b=i6h3fRoK431NaGcWuZSoiubFhXGK4ascXHQ81NTAzyKnO1veaUBwv31Lnx87SCzFsj
         EFJbIdZluGhNvnZ3GRpFsmn0MFqxMkqMvMzZifYQ7O0MdGVsjQR25EqQs53wBYlGNq7Y
         Jv//aZOfa9zuoMFSXaCBOmPfG+qAap5Jz+KjxrEkpn6s/xL0qJQKvldi/z/6vw74tAQt
         JA7mF7WIywRS/FGyhElTrSXA9FfuQkcjih/ARA7MDApK6AGqziN9mx9fBZidhoA44Xm8
         HBlzTTk7xav1f835DSM/2RcyAIL2bSfTmeLgvhh3X6RI36+6Q8fQIZRYRXd3CIX9adkD
         O5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIiwVFpw4ZhZjwUQ6twbeuIA8JamFmPyOdxqKvsHNzw=;
        b=HYe5d5KIwQQXvs2/Uw4RP9H2opsL01F9EVCbpLbSut89VyVjw1ejKNBVs5QDanLpAZ
         zrqacDy7i0mjdY9ukayOAy/GBAoB8BoK64+252eJ5QOvQRt49MmfcwSi1EU+BYltDGby
         N/esMvFXLICm0ta3XwQvs5R8gybHvuE3XTsjxA+mro0RYMr/AK8pTFDIQ3NVTwayUXAc
         f+85CNT3XvRPaiIJivIfo/0TvzkZZ2t1gqub65oXHeqiW5TWCCzYC8TtKcE4RHDuDpHH
         AdTw8zLNcBNfD6HCntnXRAyhCG/RnVMgT2PCYo3rng7sY47noPFqpbcH7gZdB5Mp7+2t
         jzQA==
X-Gm-Message-State: AGi0PubXnWvROpJj5Cj2u0H4+xN3n3v5Jqb1s/2J4BP+FcNBvJB71h5t
        XFyP4UI5RuK4llIBU7zZLYC1yw==
X-Google-Smtp-Source: APiQypLJj9gJVm+wPLLoPXnfggd+adXxW0v+bEwlFIia6pFfvUorxPaafp+9n1kJvQH7IrC7JMDeBg==
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr5639914qtk.29.1588878849189;
        Thu, 07 May 2020 12:14:09 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j8sm5094236qtk.85.2020.05.07.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:14:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ipa: fix cleanup after modem crash
Date:   Thu,  7 May 2020 14:14:02 -0500
Message-Id: <20200507191404.31626-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series fixes a bug where the size of a data
transfer request was never set, meaning it was 0.  The consequence
of this was that such a transfer request would never complete if
attempted, and led to a hung task timeout.

This data transfer is required for cleaning up IPA hardware state
when recovering from a modem crash.  The code to implement this
cleanup is already present, but its use was commented out because
it hit the bug described above.  So the second patch in this series
enables the use of that "tag process" cleanup code.

					-Alex

Alex Elder (2):
  net: ipa: set DMA length in gsi_trans_cmd_add()
  net: ipa: use tag process on modem crash

 drivers/net/ipa/gsi_trans.c |  5 +++--
 drivers/net/ipa/ipa_cmd.c   | 14 +++-----------
 2 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1

