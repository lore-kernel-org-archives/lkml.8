Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD9C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579320637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4KNQOE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCWMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:19:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43819 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCWMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:19:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so7408816pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dt6PjsXXkmjyYjxHswpt9KD4Aj8ipQbf1fRd+H4wNcg=;
        b=L4KNQOE9x5PNNVZC6xAz5XleH+XgwKJnZJkjMlyN/wAdzyjCN0iSke2DqB3e0WdQ0U
         aUtoO/z/CTgo920Vkf7jQJmwySDBgTk0qIAUASia7rdXOEEwd7x2sDSRBfZWGNDtjU27
         xVxNe5Na/4LY1Waf2peIEzYRXv0MlPyr/fl+NEvhfwRD3AG1f7uoTrz/WcxxHOuNZH91
         37GBhxqQiRJAS8oRScZ8oiwy4uEvAdazxIucGtrNe2n6Mi2zQf1Rr+3eSIdEIYmq96gT
         c/4sZcYOgAgNMNfPgsGYhV/PkvQ3VD1V2cdnFYldVxKkK/TVTmEdWKawwpeVcczpl+xS
         3B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dt6PjsXXkmjyYjxHswpt9KD4Aj8ipQbf1fRd+H4wNcg=;
        b=nQNVTaRIUckacKC0jl0Fry+N9axnmjS0dDaWk+Uqp3fy1qSOrcm7lRZfB63TwFCTyx
         Q6lN/wfr/1lUEkYmqExa2jVLbUU7hGBP1jHrjgVth0K7EpeDG5c5fa2PNEgBlzgFvlwp
         7fyvtHmgqvhh7wNlms/sHZ3L+KTKA9gsY9L/lNhyAjRe9KoHPcTlQjNDPtDV/eAaiosw
         F8QUQWZcK0kVda5rr0HlZ0hjOZ84zaKwKSLOVeUj/5x6k1xq+SssHZBiK1ORaDfMSccW
         L+5KOFokRMd/PdRHMe+U7kgzoGP4eLLxXK4EKsyHJIGzihE+myLb7dDH+jp7rEmzhPzl
         9lhQ==
X-Gm-Message-State: ANhLgQ2P0dOb4MC2s7y9Z6bzJsLx65XpFcBneoOAhP8SOE2Q8bIrbG7P
        6fJ6u459tHrjVVXUO8BwPGQvHQ==
X-Google-Smtp-Source: ADFU+vu9j5S5tKK6JQyIfS0EJ9iA4nTbNufYMspfuT+/fQY/nHNkHSdl9NTbkMMHKU0KlX7TVcAtNQ==
X-Received: by 2002:a63:2fc1:: with SMTP id v184mr20863695pgv.97.1584965961521;
        Mon, 23 Mar 2020 05:19:21 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id f15sm2964597pfd.215.2020.03.23.05.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Mar 2020 05:19:20 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/2] Enhance TEE kernel client interface
Date:   Mon, 23 Mar 2020 17:48:28 +0530
Message-Id: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this patch-set was part of TEE Trusted keys patch-set [1]. But
since these are completely independent enhancements for TEE kernel
client interface which can be merged separately while TEE Trusted keys
discussions are ongoing.

Patch #1 enables support for registered kernel shared memory with TEE.

Patch #2 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly
access TEE service.

[1] https://lkml.org/lkml/2019/10/31/430

Sumit Garg (2):
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients

 drivers/tee/tee_core.c   |  6 ++++++
 drivers/tee/tee_shm.c    | 26 ++++++++++++++++++++++++--
 include/linux/tee_drv.h  |  1 +
 include/uapi/linux/tee.h |  8 ++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.7.4

