Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1AEC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F352073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DP1iuLWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD2KT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2KTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:19:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E6C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:19:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so1396443wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfUu2nGeZvzugtRyZe9k3R2yz/otRMYIvyVDLh+8gg8=;
        b=DP1iuLWxyltMrKD5hRdymIQaeg/XxsXT6DwZipDEUi3ZKGr0RsGIT2wo/nffLiYxYj
         WbiG5JaK3LZ5X51v5H/9nIWlXuyoizWVOmXFeVDm9xHubI+CjdoPKwsKWZgmDiL910o0
         K3QsEAXG0B3WClIpnnPggb3sjNiuV0uDG0mllN8LqNphnGvOwmCjUxVEEqUe4VE9Di5u
         U/0tq3N9YBOMwJvRWlSCzNa7CCLVI5epWrQggussR8csPX7yJi0+9ypR7ZYgrly8/SdE
         cxuG5+Kl0wjr3XkAVqLhTiKso62Q6TBsZ6nQxpSPa1ObjIHyHAXjL52XBrDwMzkL1PnY
         YDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfUu2nGeZvzugtRyZe9k3R2yz/otRMYIvyVDLh+8gg8=;
        b=M1EY9jap3pl7jS87JoO661LynKl7yObLPmDK8l2xe4Mmc/hDHySZ5D2xpZeUwx7M/8
         0XrISav8tl1hRHBO9Z+Au0ezsviJlolF94PRSDmvBDg5gS6SdVuEFyq6CK5eJrx1MymW
         ZSF1XgzsN2a+z0F3ZXQ8+sG7SLa9LOA38bd4zrAOvPe5oXPJL8YZ2ZZoo/3hyg3UZJwa
         tzGcCdqATgKB0T6OEJMCLE0eFH5UxWF7MaeSLZqf3LhOHh07gc9UlrU/BQT8ba2hGvoy
         OBRebGoyLhV0M6J4ZeTqIh/+CI1bWZ7sb54KPRUjLmYQ5xpO7NYrRFopevdtY3kplfMl
         QPbw==
X-Gm-Message-State: AGi0PubBPu0n4Fo6PFfxaf3omFd7TKHq5bOvSc1cwks7u6/fHwUGaNyn
        14CFADJc+ngIGBWjfbYbil7GoA==
X-Google-Smtp-Source: APiQypJ+MyKY5nD3uene1XQI380We3nDNzwAwN4QMjzpSHxtKl1+2GyiaefmR6A8G2/wYT2R0Ai9uQ==
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr2396402wmf.23.1588155546054;
        Wed, 29 Apr 2020 03:19:06 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id c20sm7504873wmd.36.2020.04.29.03.19.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 03:19:05 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/1] interconnect fix for 5.7-rc
Date:   Wed, 29 Apr 2020 13:19:03 +0300
Message-Id: <20200429101904.5771-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is another patch for the current release, which fixes a compiler
warning. Please apply it to char-misc-linus when you get a chance.

Thanks,
Georgi

ChenTao (1):
  interconnect: qcom: Move the static keyword to the front of
    declaration

 drivers/interconnect/qcom/osm-l3.c |  4 ++--
 drivers/interconnect/qcom/sdm845.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

