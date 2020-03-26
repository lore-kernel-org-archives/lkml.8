Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F8A20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585255228;
	bh=OpsX0BVVX/MbLcpNYEOALd6pH4ONA6HFN2w5pBSQwds=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2kp0493YzH+t0QMjAMig2uaoTzZFs3QS/2p5r1Y9mvGVhlZ4yhdTyuavii54//JxN
	 10jPo8izIbQPjiFdErdBv7FCZbcI0rQVgg06nYv43lj7i1Li8kAlkDjYVq4gE73NMQ
	 gaP6IY32m2hkv/8S+ybphGwa+idCd2r0m956IBdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:40:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34820 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:40:26 -0400
Received: by mail-io1-f67.google.com with SMTP id o3so1996932ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JEJetyWGJGy96lwMPJU0+igkVS0ypH4j2FzDTChyzo=;
        b=OEQdDJNZshED1yhUmt5ICPHbOvz75t/WmRQvfBEC6zByHW51O8a3KtxO/w7s6QAOet
         W++49YIusYUfjHTX+VTJ2XZbdk4On+5Vq9JYoqDC0fpqw1X13KU2qLvQgtylWoTD93rp
         zBoSMaEWm6CebkVgTW7P8i96T+r67AFimKd9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JEJetyWGJGy96lwMPJU0+igkVS0ypH4j2FzDTChyzo=;
        b=KikK85O69xAjqIamxrRTcL38+FZPr4fbrYQZ5kWuLKBY+PX1rbOvZiNPGNXL3g1WDH
         gVhH0vYOCBI89Hn8uo9wCZAJcq38bidt8+QCuiLN7F/1gyJeEDAEwKoGrFM0S7Ot9TlX
         e6ak+NPyJxsxhAVowqXXV3jtcvlQSxo8F2Z3SwieJicJ61CIo/FLgV/nPmQ70FBZ1NaG
         8gP9r8LnN3jeWoiKxoL1yzX2f24jRNCUQifApG7dgUdoRRxCkI2eCBjsd5ZhiA+uHknu
         ambBsbEcyzwAq5rBi+h8QRej8FVbH9U3J0b91023aI8Rn0Wzkii38jhgv52805K9Hevk
         Xu9Q==
X-Gm-Message-State: ANhLgQ3OxPIrtYoUrzq24T7/oI2jNZO6clu+RTz1N+4s0NLSYLlkwxYW
        zD4o1u1jlngqVHvlE7Sdiq3acfCxE+I=
X-Google-Smtp-Source: ADFU+vtndZILVdRreeVQOFlhfRs/W6kdhD+6FFbZev/31X3NYUyOGdRTkbAHlJfz780pL2N0E6LkJA==
X-Received: by 2002:a02:9988:: with SMTP id a8mr3335550jal.3.1585255223957;
        Thu, 26 Mar 2020 13:40:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b6sm900867iok.19.2020.03.26.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:40:22 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     federico.vaga@vaga.pv.it, mchehab@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: fault-injection: Make failcmd.sh executable
Date:   Thu, 26 Mar 2020 14:40:18 -0600
Message-Id: <20200326204018.31862-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make failcmd.sh executable.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/fault-injection/failcmd.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/fault-injection/failcmd.sh

diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
old mode 100644
new mode 100755
-- 
2.20.1

