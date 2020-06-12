Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E98E20663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdkf0ilg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFLV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:29:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34088C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so11419905wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=snfMO5b6c1U6pIEGCoy7rx+lV4+ULX0l0cG6NiW0AsU=;
        b=vdkf0ilgGz4pz0tfmFHHL15RjT6iv1U85LYZia08qD0W7m39qc63ICGCRWGhMAOzVS
         us6NRmqKCgOO4GPZ75u5+vG2dFHkmIGU8MlIEYms86I5bIlOQ+83itC87y62Gqul2nTy
         50SyZzK1AvFpIQFJe1cFJhvSCAcCmI7Uqqyn1pfThoHPm6ixfv9OtACTG0UJCH62PygG
         JMm6k5auH0vp+0Vgr5kWKKfdiTFnYvSCCS2zgdG5jIFtXWcp2hw6IESdZFmWpnQKmkDI
         ljg9PPrqsH+JIzXz6wex324L7do7I11wILdoDn7Nu7BxYJ9+sQqcMKYbgNdW4BbQz1ym
         Unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=snfMO5b6c1U6pIEGCoy7rx+lV4+ULX0l0cG6NiW0AsU=;
        b=GlpCtW9aBr+4FZizqyorOKlj8wyZ77Dd4sGNzG0q6vLLURuRNdt7WKd/Cwx5TR7s3p
         sqq4KMCnsCVjB8LVcv1eKFE9aX4598lq+5j06c2nkNtoXizSxtYP4Z0b1gAQNyQDoEIZ
         re4XZ+bwD8C5ude0w+x34oWWtVCmo7HbxII+axR6HFAa/FVxvhxkCJb7AxHRto0ITVu4
         +5SJgaEw+0c2yof2BKA1L/JcphOGZ1aJRPi01sWsR8UsyPeBNSU3sQ/YF1aFMvdAj52A
         U7RWpqKTLwE9SYHN8B1Lq0BUL1c9YgRhoGQMfYGY+Q38ZYPjtWwERmYNXBBwrqNLH5dH
         FXTg==
X-Gm-Message-State: AOAM5306aJwR7DHdwt6pNH4oQq1ti3g9bBHYMXbX/18HJX6LDG7Ac5hM
        OQ0lV72ATNCqQ7ZWm4B2zks=
X-Google-Smtp-Source: ABdhPJwBIrsjDXb+JjTbUf07V8zjPgUb5Pxs4lh2oS/5SjUZonzl2Bk5GwCReCWvrtfuNSUbMSklBQ==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr17287961wru.252.1591997360804;
        Fri, 12 Jun 2020 14:29:20 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n189sm10442048wmb.43.2020.06.12.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:29:20 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mtd: rawnand: brcmnand: ECC error handling on EDU transfers
Date:   Fri, 12 Jun 2020 17:29:00 -0400
Message-Id: <20200612212902.21347-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2 changes:

"mtd: rawnand: brcmnand: Don't default to edu transfer"
- no change

"mtd: rawnand: brcmnand: ECC error handling on EDU transfers"
- Fix typos in commit message and clarify bitflips threhold use
- Fix typos in code comments
- change bool edu_read to bool edu_err in brcmnand_read()

Kamal Dasu (2):
  mtd: rawnand: brcmnand: Don't default to edu transfer
  mtd: rawnand: brcmnand: ECC error handling on EDU transfers

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 31 ++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.17.1

