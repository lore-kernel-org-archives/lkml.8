Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300BC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5511E22314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dZsSCFPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgBGJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:52:51 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33172 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBGJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:52:51 -0500
Received: by mail-pf1-f173.google.com with SMTP id n7so1027704pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMYeHp7izR4Rb+xnGWV9UyZpsqdqC4NZ7xAtUKg6nOo=;
        b=dZsSCFPZ6VJiIDvAbOx4Ve2EgnwGRXr46b6Y1/xwbiLJvTF5vygoQCqnkbsBrcvGov
         Bcwx38z3A+tY5HBT2Q9jU7pbvCmkXxe7FXJsOTwgQP872c46YUBTPbDRfTmZMSJRwSLO
         oloeKyRxz4FyfqxIdncKLha8rEWZ/7efv5WBzL3cpwh1Q0CQl/VuuHXmvKrmx2x/eLEr
         ULHlbbpsliyF78QTJk1aDfMB1fPejrsuN0rf0dt5KINdsJ4h6VltGbm9cxEy1SDnWtUo
         Pf54CclxtPYULjx5Vdh4T90InxpgK5Xa5KGfQL3MZeGni5+0VG/+7QUF/SfzDWJPSeuQ
         1kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMYeHp7izR4Rb+xnGWV9UyZpsqdqC4NZ7xAtUKg6nOo=;
        b=FYTSC3eGvacjdiLC7FN2A8UtTda0Hs7elGx/lodItQQOL1c8Iu/CKlUXlMXQEjFmmi
         c+xTz75bsBOkefsgtiL7Dk2D7oiIY3kRn/ih02Nex7jPa/bu3HhWmy+fEjAyxC7Si1Z8
         lB3Y+YcvPdp+wNIGEJWULm/bslLONp4ediitCiJpDfEjvzVlHUXArLrLeTsmuR0VOp/7
         5B6je8M2fr08e65Ru7gfEyMSx+rawuhZc2GDr5/MIQy8ecsHDn02VE6BJ49EeegSIhu4
         Adcuvb/imc7YSvkAjsE5lA4TpqzKI4MXZAaZhHSetvtuBPfEZY8ug2jBeEw0iaqb9qk4
         yooQ==
X-Gm-Message-State: APjAAAUJ05Y2KQaQCCVK/J2HkbmvuNTlIuuGFpY4scG76s00p4l0j3Ps
        uOkcFRq/+hqDsjbd2gyiDf4HOw==
X-Google-Smtp-Source: APXvYqwc+9MWfFdCvGYIjKIg008oiz/1mXx5sSVztqfuEmUvdF/+sXiLCabKvglhpVvpCaC28PNY8A==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr9337393pfi.10.1581069170055;
        Fri, 07 Feb 2020 01:52:50 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s23sm2060934pjq.17.2020.02.07.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:52:49 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] Fix the page table size of KASAN use.
Date:   Fri,  7 Feb 2020 17:52:43 +0800
Message-Id: <20200207095245.21955-1-zong.li@sifive.com>
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

 arch/riscv/mm/kasan_init.c | 53 ++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

-- 
2.25.0

