Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC72FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF37620882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6KvstmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFPOiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgFPOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:38:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3831C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:38:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n24so21802096ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I0NvXcxMumO5ln1pcxq8IrXZMMunSbwaH93Ozqoo2qY=;
        b=D6KvstmSk0YXD0i8uqQdJ61DWUBsCQ27FLB+4FCQRrzhNH+ZCO/wpDxjf7p3BFownW
         lbmzCSOQpb1IgDGdLNO+U6TQPRAKTYDp3651rvcsLKGWrWunKUKQ8OplQwTTJBzvNY9N
         hLB2WbtoAVTnYXI4iVoPrH+9agYQ1yRbPiS3PnVQXWRXOmUy5iqOfuRlbb6dgb/NFdFJ
         llMTwyoip/IQJZ9lqIzC9ZOY/nqmfKBuTfBiPo1cR27g8b4c8yx4Jm+1p9ZPlwpbCPa+
         emEwIbYV0iHCJGf/Jwo7xUX0ES4VFzi7MCKZs0R/pUsN+1hSl2PxkOtJXBYNXUsTZ1Ft
         fVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0NvXcxMumO5ln1pcxq8IrXZMMunSbwaH93Ozqoo2qY=;
        b=D7etqtLm2MACpWur3NYi47btAUrWo6ujah4Dzx137DpMBub3JJ93o3FD3tqxfThlRL
         5Dhp9Fr5W7JmmI7ZHPpjuzTUhHn+oBoiqoAqZHKB6fYbxlGamquWsfljz0RANQzYM0yQ
         6f/yb8fy+QMWqW4AIeynjDd0athAuCd3KCIL6guY8OKmqD893+OYeCBO2g/p8aC5aT1M
         5E9n+qDgW6Wk4VE7oFARvSC0b7smX1NQAQNyD2XDgcm1ELweWL9K/Ge2MN8pFqyUnNtD
         ohqvtmXiNFNwIgx5EA1CgJrbixnH6mC/z8Gr1iQk1nBwbrHPxhwqEhNs7yjl7bIwbDu/
         M/tg==
X-Gm-Message-State: AOAM532tvwxMJjF7mbt91bP+Ko8CWxP6Iv1MUv62SSR8G3FB37xxLQGZ
        oQi2F2ePYM0ZuiNr9GS/zz8tEg==
X-Google-Smtp-Source: ABdhPJz7yNrh0gZ8l9DxrKI/HoDUZRuCF3F+xxWp9QNDNI7P4YgiNcbHvQ8pnJdsfu2HCjV5WezYhg==
X-Received: by 2002:a17:906:cd06:: with SMTP id oz6mr3246023ejb.434.1592318287131;
        Tue, 16 Jun 2020 07:38:07 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.gmail.com with ESMTPSA id a8sm10163348edb.29.2020.06.16.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:38:06 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] docs: dev-decoder: Add one more reason for dynamic change
Date:   Tue, 16 Jun 2020 17:37:35 +0300
Message-Id: <20200616143735.21766-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit-depth change as one more reason which could change in the
middle of the stream. For the worst case the stream is 8bit at the
beginning but later in the bit-stream it changes to 10bit. That
change should be propagated to the client so that it can take the
appropriate action. In that case it has to stop the streaming on
the capture queue, re-negotiate the pixel format, allocate new
buffers and start the streaming again.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/userspace-api/media/v4l/dev-decoder.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Documentation/userspace-api/media/v4l/dev-decoder.rst
index 606b54947e10..45b31262f360 100644
--- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
@@ -906,7 +906,9 @@ reflected by corresponding queries):
 
 * visible resolution (selection rectangles),
 
-* the minimum number of buffers needed for decoding.
+* the minimum number of buffers needed for decoding,
+
+* bit-depth of the bitstream has been changed.
 
 Whenever that happens, the decoder must proceed as follows:
 
-- 
2.17.1

