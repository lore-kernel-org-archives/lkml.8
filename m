Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27181C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027D6206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e81AHB0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgGHXEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGHXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:04:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E82C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:04:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so570141ybz.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DGZPPrMYqbRCPGw2ruf3jlWhBumhoZFbDjrq5vO0KsU=;
        b=e81AHB0M7I/PdrDpXEVdir4Vbd2bU0r/si3mFB3blJtI3pLFKCRIMOWgDXge/ue+Pg
         qYMCtAzEHc/TnYqS3FckXRo4TTLF49ulJwEY9oSO5TF0AfMoEr7V5dcwR1y8wS6lPznS
         NEvSB5AsHTo7YUNns1DjLZ/1vsDFhzSl9bmksVrTUsc0qIg7jzO5RCUIXC1oxR19td+i
         38ZWOu8vlpyysjcXSnH6KzmMYAPXHdVWxRLFjLptT9E+Ub2w8o2Prbr6ihRrfsCMarI9
         r2B7LDw3CtCIWWuwHPXj6kj4yXFmECdBYD9JMQe/ApU1+I5kCFFMmbt+c9OsSGoz0Nsx
         LzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DGZPPrMYqbRCPGw2ruf3jlWhBumhoZFbDjrq5vO0KsU=;
        b=fzlYPnEsTTMvHoxoetvSHCfDhqH3yppS7eXnKoW62WI2XiAmunk+HhlmqIax6ewBFm
         SMSETJJnc36WFuvpDPE0OHdPmPwcpHwXsk6jzXdBcwHiFz3HQQqTEvld9Ap4y61lpQ4b
         wDTcfLGP6w99mjMgp7W8eojEIypyBGxi6drLPjxtfhQcnoL92pXpCmUhUleamLCo/8AG
         O4icmiWIlgBvizxOc5QFCJyQFoZnMSnw50R8Na7U5yHdA73cKXO07rpZYJxtpJWj5xlu
         EOxDdCH+lpsWNon3iwh9Wm6lkLs61B5TXBuc0uedRfMKh+RH/N6hJuEQ17aFPAIOOP6Y
         KSyA==
X-Gm-Message-State: AOAM530GBLxw9ZqiGDGcJjbAhWkKL6PwHHKEt5NwH6Vqp7xXAkLdwL8M
        5Jb/lsVDWwl45PfBo/A62AVpYF1mgt3c9ag4ZoM=
X-Google-Smtp-Source: ABdhPJxeWlmFLpDzIvAFDZA1lYGg5W3qe7GiM9Qo2YujZOQwNNRn0hTf56+Fhu5QUdcxssrXYfAmtZiU8AxSXJ8bTDk=
X-Received: by 2002:a05:6902:102e:: with SMTP id x14mr46384111ybt.461.1594249450038;
 Wed, 08 Jul 2020 16:04:10 -0700 (PDT)
Date:   Wed,  8 Jul 2020 16:04:00 -0700
Message-Id: <20200708230402.1644819-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v2 0/2 net] bitfield.h cleanups
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches, one that removes a BUILD_BUG_ON for a case that is not a
compile time bug (exposed by compiler optimization).

The second is a general cleanup in the area.

I decided to leave the BUILD_BUG_ON case first, as I hope it will
simplify being able to backport it to stable, and because I don't think
there's any type promotion+conversion bugs there.

Though it would be nice to use consistent types widths and signedness,
equality against literal zero is not an issue.

Jakub Kicinski (1):
  bitfield.h: don't compile-time validate _val in FIELD_FIT

Nick Desaulniers (1):
  bitfield.h: split up __BF_FIELD_CHECK macro

 .../netronome/nfp/nfpcore/nfp_nsp_eth.c       | 11 ++++----
 include/linux/bitfield.h                      | 26 +++++++++++++------
 2 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

