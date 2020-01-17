Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED5C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B920748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiQopRVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgAQS4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:56:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37871 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:56:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so10217273plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zn7SJiodXnAwOg5M6Muzhm0ONI7OtNZPEkZeDUFiNfY=;
        b=LiQopRVJ79gp4QihuIs/56C85VEBfc0tdcq/ZgxIS6Nr4okL8hOAwycduz1da4uuen
         IjFccqYHY70TfTsbaqU0oabyk3KOhBKG1vuxVisln5QjVH0RF7nMYJePxZlIAHO7Mulc
         Fg7M34K7AfSAlnTm5IrV7SRjIZ44pI72TpfbeHKWM4lOeQHjY1k/Jn1y6QGVgXsFp2Fb
         8NyJiat5ZAawoUfbqY2nGtnXnRCyqgbwgXGuYaDR2TdwAFzeDoHRhnmtPQgEJqqP2qwa
         avXzln/SbP7lSTegyZKUsSVatAtRzYZHbrswySZokdYw2eijVb7eVIpS32/quHfv0mWp
         c59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zn7SJiodXnAwOg5M6Muzhm0ONI7OtNZPEkZeDUFiNfY=;
        b=TvbuX9LVo5DhTJhUPh5mDIMo/PYvFizqxVn6kdX8xKoCwn1YiPq1dn+Mart7Je78FG
         A/mNjDWUL0+bLpN5mVlmiZTTF2zcCadC6vHv5pyeEig8YTE6iC5J039fcs6hFB+Zykyo
         eigtRcZYpL5tNRW/q7u8meeXPNHUjGxykV46xZ1MPVzUjpLr0bRR8yyjAAY7r9jO0hRs
         L7QikVWzxSBnvPueh0+vJLMH2nlzBjzw+ghBs7j9GukNL0EBiTv0SvF3QTn9piL63Teu
         oeUXEa7fUOqYRXSMQM1YJ1HoOZLjcM3/7UokGqTR/6qzB+htYkwy5eLwTzwlWVgX25NR
         OPeg==
X-Gm-Message-State: APjAAAWQ3VKIlEiycjj3zK6q7ZIUo1dfwLWVCanCdGaZvBLLAjyvW9Vl
        da1fEZHvaTxmtGeVhnmuwUpW2g==
X-Google-Smtp-Source: APXvYqxs4M+WSzFFsTzfyFwfBPyHM4lFK9mhQvoymIreNN/aRyASSCvsttkCeQ/pAyyHPKDqXnLp5A==
X-Received: by 2002:a17:90a:3747:: with SMTP id u65mr7261536pjb.25.1579287369456;
        Fri, 17 Jan 2020 10:56:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm5899181pjo.22.2020.01.17.10.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 10:56:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] coresight: next v5.5-rc6
Date:   Fri, 17 Jan 2020 11:56:06 -0700
Message-Id: <20200117185607.24244-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Just a single patch to add for the next cycle.

Thanks,
Mathieu

Arnd Bergmann (1):
  coresight: etm4x: Fix unused function warning

 drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.20.1

