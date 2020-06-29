Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB57720775
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWLk6Vml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbgF2VSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbgF2Swu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE5C02E2D6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so16623446wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmkBl6CgYcKij/6z3M241pPTb33PjPTKpPi0m3JJzZw=;
        b=UWLk6VmlQbmgGn4fxQ9O9psVUunquWgTklcNwPDy56YobyD39DbRUDQCyVvdxB+o3p
         LGCnqchxFgFvLy1pT+ih5xMmrLS1HVNnYIK/pluBDZb09cz8AqhLnXfvEjPncFbmC13T
         p2N7ccpTgWZ7gkTeMI4Y64VGhLlUURWMObv42l0H+kk/Fq5rONWnaJ9Yn8s69opYrbdW
         pS2nx53E8qC4aQPhLC6IocEWs+ZOu/cxQ8ONVYrZPOfPsW6cwQK7vzt+9GGr+RChqZCj
         bjo/bWB+8L5H4e+VqyufDUV/kEx7SG2rQphbkfVZTatbY7LItp8tSL3kV7gDzh+dkST0
         OIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmkBl6CgYcKij/6z3M241pPTb33PjPTKpPi0m3JJzZw=;
        b=SkG0ZCunQyTH9ChiQBQZsn5nQFQ4zB3SFedaHv4oH1OlZNoW4dZ6pTlOapUJklE0y6
         LyHEwpKDsH/3j1RDCPsKo2IfM0wyv2wYHgIrHxmIFAi7E59sEJi+wknV0+JLHThos8mb
         Cenx3VJVL0rU2wEp7QCIuEeMiQGyxlOl4PxzjiZzrC0/e4mY6xBa5d8eJc1kBBwxrj7i
         s1WjzaXY5R4RHIy/lHRPBgG6fKNRVrlhHy+QduoPx2u3o7V/bJRY4olDvgBFEbTOukEZ
         nxenWt3pSazEJoBwOQgF1VRIshzfoCQJMF7LJnUKwxdqHouwc2KhSP0r3AJ7ZxmpGKy4
         FQUA==
X-Gm-Message-State: AOAM530FzDXICTwxtEN9NJfc4P0be8JWVjb345ROqJevNM4bG0qwxskR
        MJXSEwo3LW2QaUTd/2SZRsEybTC4lcc=
X-Google-Smtp-Source: ABdhPJyQRVI9EP39ZGYsTFc+3vc1D9TeBEYaguyI5hOW2INRl8vdxPpsYcnXAsNe5kQjL671fwMBlA==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr12582448wrw.148.1593439502968;
        Mon, 29 Jun 2020 07:05:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Masayuki Ohtak <masa-korg@dsn.okisemi.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 14/20] misc: pch_phub: Remove superfluous descriptions to non-existent args 'offset_address'
Date:   Mon, 29 Jun 2020 15:04:36 +0100
Message-Id: <20200629140442.1043957-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably a copy 'n' paste error, 'offset_address' has never been
part of the pch_phub_{read,write}_gbe_mac_addr() functions.

Squashes the following W=1 warnings:

 drivers/misc/pch_phub.c:450: warning: Excess function parameter 'offset_address' description in 'pch_phub_read_gbe_mac_addr'
 drivers/misc/pch_phub.c:462: warning: Excess function parameter 'offset_address' description in 'pch_phub_write_gbe_mac_addr'

Cc: Masayuki Ohtak <masa-korg@dsn.okisemi.com>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/pch_phub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 95ba82a8625b0..b27d826132915 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -448,7 +448,6 @@ static int pch_phub_gbe_serial_rom_conf_mp(struct pch_phub_reg *chip)
 
 /**
  * pch_phub_read_gbe_mac_addr() - Read Gigabit Ethernet MAC address
- * @offset_address:	Gigabit Ethernet MAC address offset value.
  * @chip:		Pointer to the PHUB register structure
  * @data:		Buffer of the Gigabit Ethernet MAC address value.
  */
@@ -461,7 +460,6 @@ static void pch_phub_read_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
 
 /**
  * pch_phub_write_gbe_mac_addr() - Write MAC address
- * @offset_address:	Gigabit Ethernet MAC address offset value.
  * @chip:		Pointer to the PHUB register structure
  * @data:		Gigabit Ethernet MAC address value.
  */
-- 
2.25.1

