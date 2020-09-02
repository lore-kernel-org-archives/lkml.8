Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E60C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0807520773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="StgYX6WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBOS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgIBOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:05:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06977C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:05:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b12so5042167edz.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgidSd24Zz8hlurLEhIlaHA9MiqL30gKJkyfF1ZIoik=;
        b=StgYX6WEyNguJD78wKYoIc6Bzw+h1h27+/lHbg8EEcbJLQWRdtTLBBo2MvJLB0JA0t
         2caDPPZvN2//8XqW34Pr9rzgXIq2uZf4ppROnvkJ/9k0I/WQUEfjInuFmYgrPh8h4QGu
         /qGTVuI7qoYn8+VkcBDVd4cR5QATBjsET5R/+G6lI4HFHqjjSFwWHf0uTBBazCX+5H1P
         iqOv/FiQAUevHmNdZuiGuiualTDluCi9wv2rGAF3vs8tAlUzL/sMiay2Uw2AH0dzClta
         f264i5ORJ8UI/S6kL9tKAZE8KikP0FsnYFeEd4Jze8N6N+fdp5ucJic2l80+hiXHC8LT
         HuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgidSd24Zz8hlurLEhIlaHA9MiqL30gKJkyfF1ZIoik=;
        b=hUEdMAuJAETQbTZ/5AVCB38rOYsYu7Ej6eFBYaLmiPN72fB1vbLoDdP51AjypLjerH
         2Q16Gd3XP6IzKMOGDMs6ILyCmAkmGzCKH45jshS1IgEsODNUvDPh5YbFFkDPCxe7UHa2
         b3D4qTmNQ5wo9cSXFTkfoj58PRO3ZSH5ER9FkiPxjS5QWKvFxKxoV2WzBIPFgVD3MwO7
         OAlIEwogM3EFCYkDGHLtzSmSyRcYO/0xg5iJvloeqRhR0ulC4BfsBSKQYIyXEH1slJSP
         7A8qXifO4dLZLN9Ymhr8ahlmTkSKKOWmjrvGrWt/9SSs6piSDSXUO+JwCfU7c6TqfRem
         3oZw==
X-Gm-Message-State: AOAM53361bff7qQ9TsOGhVd69YCMu4vCUwgJe3g2QnBkWibDjpvwr2XC
        sEMkrZ7Wdkij50xglBe4WpUUMfAm2AUBZb99
X-Google-Smtp-Source: ABdhPJztMFzXGv+nvq1KeuMgIijPAhD16TI+0vCZRXdeRoRtJ+KR5eRiK0oQrCc5mxuqp+TRU0lkYg==
X-Received: by 2002:a05:6402:489:: with SMTP id k9mr192758edv.287.1599055534860;
        Wed, 02 Sep 2020 07:05:34 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw14oqa3w7cibjsc.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:8cba:3abe:17e1:aaec])
        by smtp.gmail.com with ESMTPSA id os15sm4354775ejb.61.2020.09.02.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:05:34 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        matthieu.baerts@tessares.net, davem@davemloft.net,
        Tim Froidcoeur <tim.froidcoeur@tessares.net>
Subject: [PATCH 4.4 0/2] net: initialize fastreuse on inet_inherit_port
Date:   Wed,  2 Sep 2020 16:05:11 +0200
Message-Id: <20200902140513.866712-1-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for TPROXY initialization of fastreuse flag.
upstream patch was backported by Greg K-H to 4.14 and higher stable version.

see also https://lore.kernel.org/stable/20200818072007.GA9254@kroah.com

code in inet_csk_get_port for 4.4 (and 4.9) is different from
the upstream version, so these backports had to be adapted (a bit)

Tim Froidcoeur (2):
  net: refactor bind_bucket fastreuse into helper
  net: initialize fastreuse on inet_inherit_port

 include/net/inet_connection_sock.h |  4 +++
 net/ipv4/inet_connection_sock.c    | 46 ++++++++++++++++++------------
 net/ipv4/inet_hashtables.c         |  1 +
 3 files changed, 33 insertions(+), 18 deletions(-)

--
2.25.1
