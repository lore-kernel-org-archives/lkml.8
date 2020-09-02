Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A98C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D04206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="Tq/lIGre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBOPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgIBOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:06:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3AC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:05:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so5034608edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKCaTDiN4ta/y8Zq6Cx61ZhYRClgqJd4G2H2pspsSBc=;
        b=Tq/lIGreZyzBta8jpiSh/MMth/noJOnjTFclLyt4k3XcY56CCJBss69Sd1xTzIbqrQ
         kiDOjO+NGC5xf24koQEZy0Cq1t+klLa1tMdSF/Pv9XCpMe7zDtuppooLxT+gDZkXt1J9
         PGEvr6QUnt4S8H9GWo+m5wd9UACHwn/VUY0hSqGxR7Ra7+M88bTpMgTgk6///W9DBaCD
         QIokEmHDt5q1hqRACYCssczEEUe76fIn6YHMUSKLm8qWW1jjjnx/mmL0lVhoC6ZjX0jV
         jFHw8HuCf3gMwi5EWhUAUpooWIYHUWPvDOaFXAJNPDkuWm/gdgBOR+8a+u4mCuSpLh8k
         xnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKCaTDiN4ta/y8Zq6Cx61ZhYRClgqJd4G2H2pspsSBc=;
        b=l0XppKhKxjidFkXCfjAH3n418EwFE2NOHWltMizZdyU0se2lBsLwTSSWuJkRr6OAhh
         1i9aqnDyhfdxcdKdQ5/gur/QtsYuE4pMI2dlyvjpdSaTUgjKFj5xIa+OwBwvwQ8g/vLf
         uxs9DdPvPzEbqb5wjFYLlkFUWtR9UFZDkPZh7wajPzSC2j+z4ETtORo/hvQwxwP6wOFL
         U3TnjOBEhE8jrGCEr4RjilJNuD7OCP7FEEILhvv0k1mbSyNjSf9eoBzZ6BbVJl10XzaB
         2tSUi8VreCuwazRcrCHAg8/YNdxjgN3YWNetLCOBzEz2s5MJIiIB91dxQ9qVLiVYyawh
         sZ3Q==
X-Gm-Message-State: AOAM530i4g17q61qsFzETmeyzdlXJ/23NR9wDIfgtY3Yv0N/qSVmLO8l
        PGu6lv025QCLpxw/8UYCK7EemjUGAPO2guiC
X-Google-Smtp-Source: ABdhPJw63+s1mn/EDgaa/DWNwgguf64Cdy3vM/HLO7Xu86jRaaB/0GA8q/ZlnHU+KT/Dw+yg1pFjfw==
X-Received: by 2002:a50:954d:: with SMTP id v13mr192227eda.337.1599055556314;
        Wed, 02 Sep 2020 07:05:56 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw14oqa3w7cibjsc.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:8cba:3abe:17e1:aaec])
        by smtp.gmail.com with ESMTPSA id r15sm4119296edv.94.2020.09.02.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:05:55 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        matthieu.baerts@tessares.net, davem@davemloft.net,
        Tim Froidcoeur <tim.froidcoeur@tessares.net>
Subject: [PATCH 4.9 0/2] net: initialize fastreuse on inet_inherit_port
Date:   Wed,  2 Sep 2020 16:05:43 +0200
Message-Id: <20200902140545.867718-1-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for TPROXY initialization of fastreuse flag.
upstream patch was backported by Greg K-H to 4.14 and higher stable version.

see also https://lore.kernel.org/stable/20200818072007.GA9254@kroah.com/

code in inet_csk_get_port for 4.9 (and 4.4) is different from
the upstream version, so these backports had to be adapted (a bit)

Tim Froidcoeur (2):
  net: refactor bind_bucket fastreuse into helper
  net: initialize fastreuse on inet_inherit_port

 include/net/inet_connection_sock.h |  4 ++++
 net/ipv4/inet_connection_sock.c    | 37 ++++++++++++++++++++----------
 net/ipv4/inet_hashtables.c         |  1 +
 3 files changed, 30 insertions(+), 12 deletions(-)

--
2.25.1
