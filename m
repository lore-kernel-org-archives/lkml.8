Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B45C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE90206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbhW5x5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgENUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbgENUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:40:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA01C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:40:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so13081749pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ShLHCjvXE5CC05PHmK2XoqTLK7MtzkzghArKGHtan0=;
        b=PbhW5x5zfvK7CT1lw2rJjnTpTGhFpvIGG2nIm0gjiYMHZaNuoex89UcQiyXrL+RTVt
         LQAmVSG4A4o0AlxzIxjnahjAE/gTAfWQiAAylmz9Gfbc6UJJiZKuCb3S67XzlyiinOPB
         M3EUcqB4RwyOGubsFfvx6EAox4Hi8KHSN/ENdZ0g8ydlQKhsiAEeeXXwAvlh7aL2+VcY
         kAzY0nhQJGGOeDFR1yTrRNKVYyhf1ciWLKMw+ket3XMer9nmiYn8dN64Tnnyw6Wd6n5I
         33LahBp2w38lWSCWHeLyX3Fmv1ODnntZXv7VlC+vnByVIxjEG9OqC1JujiK0CcZwpVha
         7pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ShLHCjvXE5CC05PHmK2XoqTLK7MtzkzghArKGHtan0=;
        b=GpBmrcSaAcGzevF549NLB54HhLlhzs4o4hdFs1HwNCCmFbqSoNcJtpwKBHBXANiTtn
         GWBP6C6v9nYkn87nmYUASNEm5XxRVa1UcN15xxJTCTgInyz6RmDNfwMiPYMqmJfaKzT3
         YzI/Tandqj0VCOS+uoSo4oQQm4mpZRlpeTY9VyI6gyqB25u9CkAPyjWFx5XoMlA9zK3B
         AcJdXNBu2RB6/sju7pUlESR7Ptu/hr35cFH7sR9yEsCHGhtlGUgzkm06YO+bTBQTHFGM
         eEl3nDye2aUG6zvb8kOey9sDJE+dty2bJFfbdsRNvAYqQEpJ5FWX5abBz3VPAyrqLt4n
         Ms5A==
X-Gm-Message-State: AOAM530PnTAWvbgjGsURS9GwD7wPE4HtGOLwzgfVCPqskRjYWrTJnq3V
        p9Pl34aYIIuNdHBcroGc3zkFrg==
X-Google-Smtp-Source: ABdhPJwjkZn2TxedarCJgzq9tQN35yVP/QBf0FK0TqaVBZ6NHPCbCNQ6ePPyBE/alOLnlemR59nlxg==
X-Received: by 2002:a17:902:b906:: with SMTP id bf6mr352723plb.169.1589488823674;
        Thu, 14 May 2020 13:40:23 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d124sm76062pfa.98.2020.05.14.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:40:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] rpmsg: core: Add support for name extension 
Date:   Thu, 14 May 2020 14:40:20 -0600
Message-Id: <20200514204022.24233-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the capability to supplement the base definition
published by an rpmsg_driver with a postfix description so that it
is easy to differentiate entities that use the same name service.

Applies cleanly on rpmsg-next (4f05fc33bebd).

Thanks,
Mathieu

New for V5:
- Return error code if no match is found (Arnaud).
- Return a pointer to the rpmsg device name rather than
  duplicating it (Arnaud).

Mathieu Poirier (2):
  rpmsg: core: Add wildcard match for name service
  rpmsg: core: Add support to retrieve name extension

 drivers/rpmsg/rpmsg_core.c | 115 ++++++++++++++++++++++++++++++++++++-
 include/linux/rpmsg.h      |  13 +++++
 2 files changed, 127 insertions(+), 1 deletion(-)

-- 
2.20.1

