Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A7CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D2E20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyUZBOOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgFWAnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgFWAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:08 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:43:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b4so17334276qkn.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FBwIr+e7jchXkt4H6NuRTDKCZPzK552qDXzcqbEDs6A=;
        b=gyUZBOOzt670fE92C1H0iaD0YACDowMWCt1Yg0vHM7ewn375tV7lJPyuf9yyJMK1hU
         2TVCWtSpSQZdhiGiAbXjOayedf9NICfebY6TTZ3kqGgqvQF/asjbyXr4pkiBu/LhK122
         DKm0saOCl+8vEE0dM7mZksUpIIl5h8zR60FZ6qzno3Vp/w42ULGGhY/Zb/KuFGRHhB2f
         4Al128UAiE0YOrGQOl+fiDpwoezJDDBYRe+NEFVxpj/F1DRL8QGLU+MxNWfl0cd9TkLq
         3BTGmSB3VNi+PVqVpuJoR+bGC3Smkt5U0aECRwLS7jX901sFjestTpB3cMGYRHFdK0oN
         13mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FBwIr+e7jchXkt4H6NuRTDKCZPzK552qDXzcqbEDs6A=;
        b=ElV+Eg8F/twOW0E1GhXZpyYpEOrJWf2xIPtzxDIimLqO+++uISNaezKqpIUfHWI6+S
         IQX1q5txtUHE2Q5uhsWRYZXMicjlwzOpy1GhvS6LnikpeXD9fx89TO5npIVF9MlXHdRA
         TX0KPzdTDWSJ6dXxBCMYgBhvkHlaHdBtXSUH6e+k8hqq+0AIiN2IzWkFu52E7uyLAc4o
         B9JX8h17twjzweijjm8MabR2pBT1nkscy8rHVJLD5YApzoOp97vibetSsjcCS8C0jcyg
         JJUzkrBw09H57JCpfo+nRuZ16VqKJDiFDHzlrHGxvJRLVjyV2mXVcR3/JPjUQOnteJ65
         zYPw==
X-Gm-Message-State: AOAM532UV9Dvme667CCbBH1DYE220RfnMIjFs1nTRu1NtiAgEdxCqotK
        1YBuPrSRs19vCsEV6sfOrX/yREyS
X-Google-Smtp-Source: ABdhPJy8yhN8dEOHDWjDvJKogoT9P6faHK76jOSvqXmfq56hqURheop/aYNpu9v8b7kCBZT13YPisQ==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr16239706qke.296.1592872987098;
        Mon, 22 Jun 2020 17:43:07 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id i14sm14544702qkl.105.2020.06.22.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:43:06 -0700 (PDT)
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
Date:   Mon, 22 Jun 2020 20:42:59 -0400
Message-Id: <20200623004301.26117-1-TheSven73@gmail.com>
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

