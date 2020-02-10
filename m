Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0B7C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80FB21835
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f4x8c13M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBJF5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:57:02 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36532 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJF5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:57:02 -0500
Received: by mail-pg1-f174.google.com with SMTP id d9so3315141pgu.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/VM1VIJNzEuuZ+My2G7oPqQnJ6XIahBlQ6fOgNUJgk=;
        b=f4x8c13MAeeRWRE4cESjejgYpW8BMy89yubG0jl3pkGqZ1l3BpMaqE2eN0COkIjZXQ
         L2odcUesg5+HQEcK78+wSYQmtp8z8Gy4oXXGH6ZhnK21aX38Mvmu8hXCenb8tcz0xIBb
         EUcNz5ka3UfRLEwSpCXWCHcdZ8xpQRRRqzHwt4eUaUgq45T0ER6LNXqwaH/CSvlxohVe
         ija1t9Ak+H6jDWHFHZMDKzS9OJBaAtL5StlXtAod9aBIB51y9XxMhoI5D58KD/wIVV0o
         Jggs4xxJCmlQI+qMRdM5IpDaqk0NIjpW2HqHBpjPAzL20Dnp5nHt41LCCeJPnmJcCcH+
         J7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/VM1VIJNzEuuZ+My2G7oPqQnJ6XIahBlQ6fOgNUJgk=;
        b=qsJaJuzpjAKej3pgRcE1pVF0lEcY9EdGTQSAJ2YY1/vDPDGu4ptKU6+PV/SHIL2jiF
         QQwNRaMjaxXyJ7w0ELk6OZhXd0fW/uRIy9QeWMnJy1NayG5F19l4djuQwOw4jCBei3Pq
         a8tnHI5veSSBFgYZ2COKZr/4099UAdi1JhUPNmfL7+/WZW6TWYa8sKt5njpUhjFrqP4N
         zvbKuM+FP1WiLoA7SznlK1WANGpDsqWRLvLIMMOYRs7tzrrLSz/O/84LG0xzaCgKLtxN
         Z7WkmxGEJa7ez5OimS3qz3HGVDHoGpIzvk25ldwCCebSnDsOVR3oiIjxADnnDdczCvzo
         fD+w==
X-Gm-Message-State: APjAAAX73ue45XV1dYwooLWynO7lR2zavFYGDZyMUhAuCedNJnlvrqsg
        czs60LzLBgLqCNO664CIjGXANg==
X-Google-Smtp-Source: APXvYqzKCQtqeLg0NVznbLD0s02+5OHmTAlMqG17cDflWCMm42vMxyWJChROG2vETZe5m4r1mKU/rQ==
X-Received: by 2002:a63:d705:: with SMTP id d5mr12507113pgg.24.1581314221556;
        Sun, 09 Feb 2020 21:57:01 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s206sm11140234pfs.100.2020.02.09.21.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 21:57:01 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, nickhu@andestech.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] Fix the page table size of KASAN use.
Date:   Mon, 10 Feb 2020 13:56:52 +0800
Message-Id: <20200210055654.96725-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each page table should be created by allocating a complete page size
for it. Otherwise, the content of the page table would be corrupted
somewhere through memory allocation which allocates the memory at the
middle of the page table for other use. For example, if it only
allocates 200 pmd entries memory size for pmd page table, then the
original 201 entry will be used to other purpose, and cause the
unexpected fault when accessing the page table.

Zong Li (2):
  riscv: allocate a complete page size for each page table
  riscv: adjust the indent

 arch/riscv/mm/kasan_init.c | 52 ++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

-- 
2.25.0

