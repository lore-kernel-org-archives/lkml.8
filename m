Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhqNs3GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391585AbgF2Vzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391558AbgF2Vz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:55:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA957C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w73so4028565ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9u5EsjGLPEPDvUYGsAHJToD2oE+5JpanjVzeW0Wj+U=;
        b=lhqNs3GAXrIZjDtSneiDuNkZXasiD3BYohOiGRdLPEhmj0v6fK1XGeq7Nujg6ictRc
         pwZfzeTqvI86p0Gk9VZ+6gBrWqTnIozJsD/FZED2Zx6HAGKdmSzOheVaEU4r9UID/DSY
         XNyEJerhr0HJ+mYq6hlK4cvgM/B7eEC1swxRTC6KvgcWjYonUlKH1eBevDYSyB2YkRqf
         DiYcTHpaTitkwdHuYLKcM3tWb7ev795IMDZ6exg8ZcaoBoYrlWm3DrNOCbOykjALRACC
         aG+lPKcazbO/vwcKm+2rL31NYSVXJ2ovdVFiz5v1NESTKJEBI48fn/ZS8KP/l1N3WFgj
         QWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9u5EsjGLPEPDvUYGsAHJToD2oE+5JpanjVzeW0Wj+U=;
        b=BAA+XEfI2OK1XS+NvJrk4lj3a219b9cWiF+4L5Tu16MqaPvNjCBfsgXmm6/gbHLkQT
         GgUU0RYO71dFuPv3grifTJm7/uuUynN8M2PDwBlgT65vQhbrrOPR/f8snV+LrvHymJIC
         ZEJ2j2MKzOiQOy8vGQLtqaz1s7RVIOQXmbo1NTxqiqDdM4VI9fJ7V6Vl8EvxvCwiTgs/
         5UTQLnIwPeo99FWwYWIL9mwI/UYDO0cmP/18SYfH6PR0Or8l0Jx4GjOjUtfImAQXNcjt
         HlV+f+cuDEf1C8PUob1HT4kP/mHAGAr6QgYOr58t+S83h+5zx/v+rFb7cpQ84f8G984G
         kTxw==
X-Gm-Message-State: AOAM530mxoebO4ArkhDVakWC+zNqNJMoomZECNIjJP24iWxLa/StoSbe
        jXlYBfuivOvuueSMck4t1SEYfQ==
X-Google-Smtp-Source: ABdhPJyAR3Ravl+6q9AlqAsDMDA2+UgpelD8cpML3OShTfC5xlDGv5qKeVc6I5uaKbFlVKzyt/PBlw==
X-Received: by 2002:a92:cf42:: with SMTP id c2mr18802507ilr.13.1593467726103;
        Mon, 29 Jun 2020 14:55:26 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a187sm543221iog.2.2020.06.29.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:55:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: simple refactorizations
Date:   Mon, 29 Jun 2020 16:55:20 -0500
Message-Id: <20200629215523.1196263-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes three small changes to some endpoint configuration
code.  The first uses a constant to represent the frequency of an
internal clock used for timers in the IPA.  The second modifies a
limit used so it matches Qualcomm's internal code.  And the third
reworks a few lines of code, eliminating a multi-line function call.

					-Alex

Alex Elder (3):
  net: ipa: rework ipa_aggr_granularity_val()
  net: ipa: reduce aggregation time limit
  net: ipa: reuse a local variable in ipa_endpoint_init_aggr()

 drivers/net/ipa/ipa_endpoint.c | 17 ++++++++++-------
 drivers/net/ipa/ipa_main.c     |  5 +++++
 drivers/net/ipa/ipa_reg.h      | 17 ++++++++---------
 3 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.25.1

