Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC5AC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F2206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRbhYx3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZFmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:42:07 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43537 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:42:06 -0400
Received: by mail-pf1-f172.google.com with SMTP id f206so2223709pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQM7DSJnjHZf4CMiJhUAhGzDJ0zvjdD0E3QxycNBJNs=;
        b=VRbhYx3wn1q4GGFQogVkUwG4QnAC0MybJ2vCo4QhLTY0RNDmCqTYLDB84jt+Nl3Vp/
         HGmu+TY/Wha5H9OLdR+9c9B6rXl3vHM99CWvFpbY4afVFknD8F8NV1JWIIbOMTDwur2i
         xWns3IVB3PkSCEYbXEv/to+XkiGcA3C+LZBDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQM7DSJnjHZf4CMiJhUAhGzDJ0zvjdD0E3QxycNBJNs=;
        b=FIiWXXRw0ciqSV3Mb3rBSOJKW7UnF3ETKfowCVorcYF7IgMt9RKhr7qrkihrxUja/A
         6NiU97ZfsRglzT+i52zdRSiKVGiZCSrfl2yxRxhHymVEB51UxiJBp5fQmlQmo8K0JwyK
         kWhUwLJf54rXsLspnJPpL6q/TGle6Wf1g3UpLFIYBfsuZCKj/Q/cFaRbG/7Wi9iYX/MF
         veW3Vhjmqqo2sS2QuUhQoXvTEyMGMoeXddE/OU9shCUsosbNxv3Q3H5XDrjOBK0ae8ii
         MZazfwMi9YykYkh0ZpA/OnTVnhOir/dZEbpSfzMZgJKUKLEq34rtYnU0OBv4IuI+B+Xo
         NwQw==
X-Gm-Message-State: ANhLgQ2eacYyG9DaZrtGYN/oAhDwOnkfX8773+sg7NFH7BVDLbS8ea5+
        bQAipCGaV1LPpzt56pwcLdq4wQ==
X-Google-Smtp-Source: ADFU+vs/AaE6aqlQY1TAZZCQG2Z+KY0trXhgyyzVOdBbs+3c2BgHS7P5zclsKKY9+PHHw4Fb+FfirA==
X-Received: by 2002:a62:7950:: with SMTP id u77mr7533442pfc.34.1585201325384;
        Wed, 25 Mar 2020 22:42:05 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b3sm710855pgs.69.2020.03.25.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:42:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/1] Bluetooth: Add actions to set wakeable in add device
Date:   Wed, 25 Mar 2020 22:39:16 -0700
Message-Id: <20200326053917.65024-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

As suggested, I've updated add device to accept action 0x3 and 0x4 to
set and remove the wakeable property.

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  Bluetooth: Update add_device with wakeable actions

 net/bluetooth/mgmt.c | 56 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

