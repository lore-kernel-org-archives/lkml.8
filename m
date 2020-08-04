Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B69C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AD32070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQt5aV3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgHDEYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so21389468pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Fh1b1wg1VhKRLwNIQ923toSLIb3mbdk2tpYC0MEvyY=;
        b=aQt5aV3rz/b+HtB7hwD5gMNo8UJtEyx+Rf8f8No4mpWUNylreJTTXm+LhbvdzoBZi5
         ymZ9kxXAP3E9VF60ySmDvllUDwk2fquZ7N4Kld+AK7rHw/5MamHXn4zR/mgN1ufaUWdg
         RBxlXs5CDFTRyNFg16QGJat0l3cPJxvSB4a7vHRsHrMihvxUexs8RC1+h+89mHHPysxD
         ey4PwE9SDxNPjMrlFwdITFmCZQAOV3K54kiw0CwpNKK9TXJeSPz4wEM6kGI3MhopcEVz
         1npXBzTr6N3QD2c52qTqb8D9UhkPoUJuFUG8JTo/fwMa8C8p8sSiE53+rBj2L7iQwmYQ
         JubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Fh1b1wg1VhKRLwNIQ923toSLIb3mbdk2tpYC0MEvyY=;
        b=htdYCH7o5u/2HY/ulxfpxEWvpCY60mA3k4F8lyku/ecvGbR/7fTthVlNTXbjDMUw+Y
         vjEvycsEP05zOh4Vs9v/J3/DMs/XVJh96UD9KCRyv51OcyeMM/JCvSfSPxj92HiUHqPV
         LzwiuanQ911U0OggJyEvxDgSUPxkH0R4pZ2AM9yg8afxa599Uk54G1UNP+fTsAabaza4
         SEU8lvpm9ZPHvzxsQiZSb155qckCx4zmG/Anc33R1u5T+7bfbVmztlZRw/AZzvuAqmle
         CIYiWLgUESTpNA2tduLHiKr9tBA1gmmNXpZq4TgeiH0/8T/oiqxQNl+LNYlh6GsZ1Xd3
         5sQw==
X-Gm-Message-State: AOAM532k+B9d/Yev2otA7zoERV7/Dmqzq+Tt0OQiIVKbqjLUG/jGTqwD
        UelhW7wppUea3FwHXErIwdX2pfpW
X-Google-Smtp-Source: ABdhPJxZdZSHGCFXQmlKQI6YYAc2euRV1CPm+15ZQAHjd41lLcV40jQnmQ9gUnSQUFQmEmImmbSGHQ==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr18147337pgp.419.1596515047207;
        Mon, 03 Aug 2020 21:24:07 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id f3sm7522446pfb.129.2020.08.03.21.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:06 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/6] OpenRISC header and sparse warning fixes for 5.9
Date:   Tue,  4 Aug 2020 13:23:48 +0900
Message-Id: <20200804042354.3930694-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This a series of fixes for OpenRISC sparse warnings.  The kbuild robots report
many issues related to issues with OpenRISC headers having missing or incorrect
sparse annotations.

Example kdbuild-all report:

  net/ipv4/ip_sockglue.c:1489:13: sparse: sparse: incorrect type in initializer (different address spaces)

  https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/MB6SE7BX425ENFTSIL6KAOB3CVS4WJLH/

Also this includes a few cleanups which I noticed while working on the warning
fixups.

-Stafford

Stafford Horne (6):
  openrisc: io: Fixup defines and move include to the end
  openrisc: uaccess: Fix sparse address space warnings
  openrisc: uaccess: Use static inline function in access_ok
  openrisc: uaccess: Remove unused macro __addr_ok
  openrisc: signal: Fix sparse address space warnings
  openrisc: uaccess: Add user address space check to access_ok

 arch/openrisc/include/asm/io.h      |  7 +++++--
 arch/openrisc/include/asm/uaccess.h | 21 +++++++++++----------
 arch/openrisc/kernel/signal.c       | 14 +++++++-------
 3 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.26.2

