Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70D720706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvLMDgYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgFWAqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgFWAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:20 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9805C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l188so4339192qkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FBwIr+e7jchXkt4H6NuRTDKCZPzK552qDXzcqbEDs6A=;
        b=KvLMDgYyXyMPI7eTp85e3a/i4y9HPaeqg07wSFPssZfnEXEecckD/ppMG6XW2NJcHU
         Xl/5cocxTIR91efDHjl/CCC//+USry2FvyNoKbQDRySIz1b1D+iawmDyxFkvH8lfGbNl
         DngNEmdT7aFQtMxwvBTJQ5fNtJcCyTtCv71CztBmsJ2uw3Mkq+cp4dnHi6Y7J8OAsiKO
         e3H/aHRoRVG/KAA8gP3B8BLARaoFHX4t+X7LUWRY2kk28c42kHbSNiP1q1GpwInNB5Gl
         xGte3AsxjbBgHA7aHstHMeDHaaJbh7GvL4fFBzOPzKnvsCzFGfSClnwA0xGa8bd1A74W
         QMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FBwIr+e7jchXkt4H6NuRTDKCZPzK552qDXzcqbEDs6A=;
        b=h2LdC75nflPRzZbIYSyAoH+P99p34+Qxhs0yWOkFyzuvhmte/o2YEMO54km6xJhsuW
         EdP0ArjfZlfJ2j4Zdxw+EWL8cOE2dfYGA54//Lp3/I2qMLE+pNZ3D1x55GVMqTpFHlDa
         kp0Hc7m0/T8UmYnufjGBVm4V6CgfYbBSy4q7dn3wlDIcCjNKhresVyxDLyUBFF9YecLl
         87nFLhpetJB7Gum9QjyAyhmb+eWh+59yzi0DvIyd8jvxRyawXthsp/25gYLqM4g53hh+
         mKmuOrFGqY3AW0PA4Rb2AOlAcQMEsHT00rOX8VwZhuNjrpmJoo+ObN+iR8ZFr26vLdvP
         GsfQ==
X-Gm-Message-State: AOAM53387G94bW+Vb7tPVcDRiH660E79XLE9R1gRTVulLiCPK5TRQdA4
        4HGnWGEa/5k3IoQr/OhE/WeBjFUc
X-Google-Smtp-Source: ABdhPJyrvMyw/vRiwaIk+6bsDB49ocS0y4w+9Qel4O1jM1875NmTOtCphmQoLZMRBTctpPG4nrtiNA==
X-Received: by 2002:a37:488c:: with SMTP id v134mr18322081qka.318.1592873125630;
        Mon, 22 Jun 2020 17:45:25 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id r2sm9493715qtn.27.2020.06.22.17.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:45:25 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Janos Farkas <chexum+dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 0/2] address romfs performance regression
Date:   Mon, 22 Jun 2020 20:45:18 -0400
Message-Id: <20200623004520.26520-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tree: next-20200613

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Janos Farkas <chexum+dev@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
To: linux-kernel@vger.kernel.org

Sven Van Asbroeck (2):
  romfs: use s_blocksize(_bits) if CONFIG_BLOCK
  romfs: address performance regression since v3.10

 fs/romfs/storage.c | 25 ++++++++--------
 fs/romfs/super.c   | 71 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 18 deletions(-)

-- 
2.17.1

