Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF6C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C8B2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxuukOBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH2IEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2IEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:04:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E5C061236;
        Sat, 29 Aug 2020 01:04:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o18so2096746eje.7;
        Sat, 29 Aug 2020 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ql+WOXwdgxNLfQ1sECNYaCpdsIZEKSXtdOYw6sEb0jo=;
        b=sxuukOBouIGbqcnyPbDELgtyxaOIzM92AipBx/rtd+9pIUlugIOBawrPO1usiXtWUB
         rvc/EG3KPn9BbdXeqvnN4Na6kB/0UQqKT2rpdITfnPOjqHaYui1WyGf0Ws+sfs4Ct3Mu
         /OT13hrWjztFPj5dsAt/R+kb91KLcKPQhS7YyEE7C4sqbkWj69c9gXG4vVQFVNWYxhQ/
         4E7B11V32EvTOnIlY+CQmVma/97AZ9oYbHu/IwBm7PMlWtK/a5WO0mur0F3qZwQq3ql6
         oshn8EuLJJKrKzQm74zzc9IwHL/a/tbXOEErTp26eVxajvqBrTl8EhS5YMBFbPEyRrCn
         oDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ql+WOXwdgxNLfQ1sECNYaCpdsIZEKSXtdOYw6sEb0jo=;
        b=aoT/ppVuin0ENYDYSBQqR8W+ErFdYXRXQLC86cYJGj6456jq3HRvXZ9UfbZJmQulz3
         yABaXRhyM0L3uq6nSr+4Yl1baDNdzBKbQqmEPiD+FEpdW1gZNpIY3eFoAs7Nf70udfRv
         ku2cJJ5kfcapEQCHBZebcF6XZmv+wce0et2w0syVXTVtJa+Gaqu6F12R990kRB+kLuBa
         BqlErNxj+ccxF0DFgXpeUoD369qS0yo/kmP/wt2EMJCwiIC53lSWe9/BPpgrnG6CHLKS
         mn4m13HJtOIRVrkDhv5Xq7QBcKJ44KZG5YJbhZkXEP0cK3xL/msuazGZUELrHd5/6Q2V
         T3hQ==
X-Gm-Message-State: AOAM533sNZLb0VaU8OQ2HbNzM7QS576+bT+kc7Z8PHNbeh5ChtTMjCIG
        0dq6avbYGOqanGsgEUOWREA=
X-Google-Smtp-Source: ABdhPJwAx0c7Zv9qm1ogjqP0GNTqMVYFy1pSXAm7yL31uaUQgA1hHrT0pqhzjrXH8wW8urtH58t9Ng==
X-Received: by 2002:a17:906:957:: with SMTP id j23mr2544488ejd.344.1598688281262;
        Sat, 29 Aug 2020 01:04:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id ec11sm1512036ejb.123.2020.08.29.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:04:39 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 0/2] howto.rst: Sync with original
Date:   Sat, 29 Aug 2020 10:04:26 +0200
Message-Id: <20200829080428.1219-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset syncs howto.rst for recent changes to the original doc and
fix some trivial nits in the translation itself.

The patches are based on v5.9-rc2.

SeongJae Park (2):
  Documentation/kokr: bring process docs up to date
  Documentation/kokr/howto: Wordsmith

 Documentation/translations/ko_KR/howto.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

