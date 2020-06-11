Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5258B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAUDD2Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFKTsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:48:38 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:48:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so7763320ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDDrr/NQDj6ybLizJRwqRnWp4a3Jj0ud89QSXqdxrfg=;
        b=dAUDD2Db2HUmwxvxWn3e+TZvpfaM8TP5nup4C728yyrukfIudVQ6QMGBzh1pS7zVXz
         6GXc5XO7P7tvf8pTuhPpgRNE6h5j+1ft9YnzbSFJHtlyihd+Rc+YoAUXshG471WTufnl
         3bjpOtWm5t51j3tYGDQ7dPqIDqm89n/Zp51H/NprSHVmfFDAnT1PMJXYMo3Gtv5zsfIm
         uNtm9/Ozz//1ckNS56B2bnLM1KrUoP8GgZ3L+fT2XNmmC3mHflRfP8rgCEd++ApYAl8d
         +oaTYntW9q6nP3/oWtaiELJdL2DqMbNGO09Uc82rtYOOTXP5pBXUL2Hjs+cllFkH9WDI
         O5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDDrr/NQDj6ybLizJRwqRnWp4a3Jj0ud89QSXqdxrfg=;
        b=MbHsxNcUp6ajtNE1BGnETWatgPizJqQR0h20mmAk2yzEhWCXRMQhO6N3OcinGQ3ep5
         nqG0A6lu7vGu20Tr3R67E2FqUQvigLoh+O/U8yMstECyOptBVN7+EGgQlrOXfYZemm84
         WeHxA+YKlJUTUh/ugp8E3H2gLB3Gb7DU9LAORh8v9xjz45h/LExmbZRel/26xgcd6iIp
         W/HPHB7vqw/xkXE99njDtf/E9aJ+RBpuwrzGiOvD6zPpQ6EVWN/8tvkstedHyPDVEASD
         d0zGjvveSEs6J3MCi+vyDDwSctzr6crDujwDlGWj5F0ISgbvpzgyOujgQAHSxOSvfaHe
         Rbyg==
X-Gm-Message-State: AOAM532Zlm+K3GhHvP4ao5C2fB9QqBli3CxOG6Q1OJR20Mdgi4ZRQGdY
        Zw6hqkgjxJf8ZZci7YJWu/BxUg==
X-Google-Smtp-Source: ABdhPJx0eeURyBNb6xwGY65ZL/56pFNcRcsY80hRs4ZMTasZ3I6dikE9YB1hpK8qhCAR58tRQS1XdA==
X-Received: by 2002:a02:c848:: with SMTP id r8mr4625643jao.15.1591904917587;
        Thu, 11 Jun 2020 12:48:37 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d13sm1981397ilo.40.2020.06.11.12.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:48:36 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/4] net: ipa: endpoint configuration fixes
Date:   Thu, 11 Jun 2020 14:48:29 -0500
Message-Id: <20200611194833.2640177-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes four bugs in the configuration of IPA endpoints.
See the description of each for more information.

In this version I have dropped the last patch from the series, and
restored a "static" keyword that had inadvertently gotten removed.

					-Alex

Alex Elder (4):
  net: ipa: program metadata mask differently
  net: ipa: fix modem LAN RX endpoint id
  net: ipa: program upper nibbles of sequencer type
  net: ipa: header pad field only valid for AP->modem endpoint

 drivers/net/ipa/ipa_data-sc7180.c |  2 +-
 drivers/net/ipa/ipa_endpoint.c    | 95 ++++++++++++++++++-------------
 drivers/net/ipa/ipa_reg.h         |  2 +
 3 files changed, 60 insertions(+), 39 deletions(-)

-- 
2.25.1

