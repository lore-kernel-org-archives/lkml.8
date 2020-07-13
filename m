Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A3C20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm73Hz1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgGMM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgGMM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:27:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:27:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so5452511plx.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B5fC/VSpjwy0J2AgPE2pfNPefXcs6+XE85WC452HsHQ=;
        b=Gm73Hz1KOqgIrGThMs1484OyaDZq9vZzjZurtmpdZ2GhKEo66WRqzFHZGE24Oj4WHQ
         j8CiJfOZHOxYV+OanBPV1WiEVIznXZQRpDSuoRrfV1Yym0uDoTp3qM5NRo41AoYkEwnL
         YnWvESyNrksaaODvzUn2YOyZoRB4CRKJVOQX0xpFv/C/D5E156S/JlUCWt4zxLjXCccd
         zzjck1g6GgNN2/aIVSLDc43v+g7wghMHcSlPgMi6aujWcy0ZmjdBKbvCc3IEoG3664Kx
         jyg06FBPnFhbanV/GzQ+NPxTkvQylDq+LUo/74JsbY6KRtCDQDplRn4wrexLumJbr6IV
         sF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B5fC/VSpjwy0J2AgPE2pfNPefXcs6+XE85WC452HsHQ=;
        b=JOM/oe2FO91GYex3A9Go+7cptA8Gd/j05EcZOPAJhYzZpzTBBawxwqlHZbcp/cgcRC
         f4Hi8yRvCd5kNjF/uv3NbjptyeuTL8tUlCW4ydSt7weMyVVgFzQXNe92cd24JBXZkcKB
         Hw4U8u/ML2YFJlfprlA/MT7GkUeH1DAWaHZmhkGeYhlI5D77/y+Aqn8lX5YSh4FwgcZt
         u3tvQ9BfQJQ1c9IB0g5zYRpl8Re+08QMl/2etCLi2kNiV3phQmce9guk7xyoe89Ep3Mo
         JYT/+UaYd9T/X1YBkMpJj17s/sSWjGus8JqogSq/5EBmbocXgM0x5D6HeCWZjQInNZyQ
         rp4A==
X-Gm-Message-State: AOAM530pz4HVsvd62Anwhq8uQg0jjlVlngcvFV5R7NIYt815pLDmop5y
        ghe7hgNjv2zIE7IxUcfpUoU=
X-Google-Smtp-Source: ABdhPJwRseJb/T0TsF6O5SADNMjjo/qYxg9ui4DclsJjyZSzJVxpa0fuXrgqdCXKvnc9BXuIVxZnug==
X-Received: by 2002:a17:902:6544:: with SMTP id d4mr27503826pln.138.1594643254872;
        Mon, 13 Jul 2020 05:27:34 -0700 (PDT)
Received: from hyd1soter3.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id p1sm31891839pja.2.2020.07.13.05.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 05:27:34 -0700 (PDT)
From:   rakeshs.lkm@gmail.com
To:     sbhatta@marvell.com, sgoutham@marvell.com, jerinj@marvell.com,
        rsaladi2@marvell.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rakesh Babu <rakeshs.lkm@gmail.com>
Subject: [net-next PATCH 0/2] Interrupt handler support for NPA and NIX in
Date:   Mon, 13 Jul 2020 17:56:38 +0530
Message-Id: <20200713122640.4155-1-rakeshs.lkm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Babu <rakeshs.lkm@gmail.com>

Different types of error interrupts are reported by NPA and NIX blocks like
unmapped slot errors, RAS interrupts, memory fault errors etc. This patch
series adds interrupt handler support for NPA and NIX functional blocks in
RVU AF driver to know the source of error interrupts.

Jerin Jacob (2):
  octeontx2-af: add npa error af interrupt handlers
  octeontx2-af: add nix error af interrupt handlers

 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  12 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 202 +++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 230 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  33 +++
 5 files changed, 481 insertions(+)

--
2.17.1
