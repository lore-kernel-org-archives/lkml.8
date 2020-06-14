Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B3EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD9820775
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="HjEBQvjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgFNMjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:39:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF72C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so5641245pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vV7/CZOj4kPeW+wCZqP9Gsy8CNwb/9mPsDlLoU+DEo=;
        b=HjEBQvjqCXIpYO6Fe5tmfKnl21F7mDxU0JW9p45BhcepYQo5axuDiM8oeTxXhqGVLz
         ezPBsDcDzXzs3Iuuh6tiu5sZ0iz6LJg7LowtFEayJbfVrXkTQiW1GNiXOpLicIun188F
         0rNBTTzB0jRXSc7NFKzLC0cuTlxaaW9t8bCr5KsWCVLlStrbRHpM9Oi8eQg9epbgpM3Y
         +UZwGkp46JkdNB/obuPCe62hDrLDFIAbzOIi0gV4ROcb8VheQRpxRCMtzvk3OHvwsXFF
         G3aofrb2CAkZ03rnFbwcZhBAbEjezfzLkhPJa8Qk+CwHw4sFyp6TH4KZTCih/7Lm7b9n
         DEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vV7/CZOj4kPeW+wCZqP9Gsy8CNwb/9mPsDlLoU+DEo=;
        b=YOvB8Kmx3K3Xsh+mNP1m/3aSVYk5j+/JukdxDzgwQ5LdC6Y5KAgPGCpER5y9wkW6PC
         /sS8+6wmWn79lUV3hVnQOlBJGrWUgkmupphmThQ1uT1TMueI3nIOkNNXiZExJZj0sgJE
         CoCtYrGxxTpE8wJ8Ow+PtPNyPb2TH8qOKF+AOjwldTa/mhnpl38AhC94En0Vz3E0wH8h
         T6/1gixdZaEARjUqleIMtYo2zaPAPIFjXvtz77prwq5bDVnJsca1g7t3RJqyY1C02sdD
         edImEi9UQfGt3ckSjLg9FjgyH+r+iSkiGg0QOK5pfso+ziniXO3l+IPvkisauyoUx6zH
         UiWw==
X-Gm-Message-State: AOAM530kjJi5hohgi6xlujB5ydyLQ22XiPnBns9wzSfeNeUbitTlxEdY
        IxthRWQrsPEOEXYXSiYS6khKEw==
X-Google-Smtp-Source: ABdhPJyjuvjj++xRj9MW/3qcHeLL9ewjJZ1jmZvaI/Z0ep4lQa7sE2fTBXOkRa/NqXW9WO+QthE6nw==
X-Received: by 2002:a17:902:b493:: with SMTP id y19mr18014748plr.186.1592138377189;
        Sun, 14 Jun 2020 05:39:37 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id hi19sm9776606pjb.49.2020.06.14.05.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:39:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] mm/slub: Fix slabs_node return value
Date:   Sun, 14 Jun 2020 20:39:20 +0800
Message-Id: <20200614123923.99189-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
But some codes determine whether slab is empty by checking the return
value of slabs_node(). As you know, the result is not correct. we move
the nr_slabs of kmem_cache_node out of the CONFIG_SLUB_DEBUG. So we can
get the corrent value returned by the slabs_node().

Muchun Song (3):
  mm/slub: Fix slabs_node return value when CONFIG_SLUB_DEBUG disabled
  mm/slub: Use node_nr_slabs() instead of slabs_node()
  mm/slub: Fix release all resources used by a slab cache

 mm/slab.h |  2 +-
 mm/slub.c | 93 +++++++++++++++++++++++++++++++++------------------------------
 2 files changed, 50 insertions(+), 45 deletions(-)

-- 
2.11.0

