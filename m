Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEBC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DE2206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEnpDexE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgEMCJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEMCJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:09:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:09:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so6209251plt.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30k3g7kfn7bIzbjqMwYYoV+lbQ2qdyHsMEbPQh3FmRs=;
        b=VEnpDexEnncojA2+uni+RuhZttreiRApv7RLWNpsKCikVkF04Yah550tFknZwIINV1
         6GvJgAjKm6vBp29dmG9cgiQ04WVeBL8YAROTIDsBvkWFoYubQ17yHCXSjqLJIiRgrget
         MkNmUz/X/UoBbR2e85L/34rpRNnmcIukW9New=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30k3g7kfn7bIzbjqMwYYoV+lbQ2qdyHsMEbPQh3FmRs=;
        b=muzu4ekZzTYwVV2xNtdvXBmOJLdergk33G5ftZgMQGvp+S2XxxigS0kC+onul21cQs
         KHkrHL6tnX68Rq7nKjajt+uS9SsxVOCn6DMgau2klU+BarfYp5NPLW1MgcavNnxXYrTC
         8Yvm/6sjMP8ovEj8uA0UdBFhm7B5pOSxlK8T2+QQ8l03Una8FNaF0pIxCAv39m62N536
         f+kDinAgEUT21U6gSj/iJ3wrqCngEAFPhvU/uR2/QhJppl9EgGKFxQtwz7v75h93VWpB
         r+KstK4Gb2C4DydjjmSUCMHf36BGPrtlvzq6CgSx8YY8l9/en0SuBak83DWJduVwFLXg
         u3ww==
X-Gm-Message-State: AOAM530TDzoc+HhQTtAHqH9Tl08JUJi6zlKVY8P+pbPw6ag4lR/WkQ6G
        RVRA1t38yWCn2QyQPrC8FvOchw==
X-Google-Smtp-Source: ABdhPJwzjFKyOAvQxlaI87Fj2o2dIZsts/LJ9t7/iT1YUdO5bz9fWYeXCjxBWM39gJxQgizwI/xFAQ==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13mr4543034plr.241.1589335780671;
        Tue, 12 May 2020 19:09:40 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id x7sm13456749pfj.122.2020.05.12.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:09:39 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/2] Bluetooth: Update LE scanning parameters for suspend
Date:   Tue, 12 May 2020 19:09:31 -0700
Message-Id: <20200513020933.102443-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi linux-bluetooth,

This series updates the values used for window and interval when the
system suspends. It also fixes a u8 vs u16 bug when setting up passive
scanning.

The values chosen for window and interval are 11.25ms and 640ms. I have
tested these on several Chromebooks with different LE peers (mouse,
keyboard, Raspberry Pi running bluez) and all of them are able to wake
the system with those parameters.

Thanks
Abhishek



Abhishek Pandit-Subedi (2):
  Bluetooth: Fix incorrect type for window and interval
  Bluetooth: Modify LE window and interval for suspend

 net/bluetooth/hci_request.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2.645.ge9eca65c58-goog

