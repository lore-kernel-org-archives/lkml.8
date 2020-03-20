Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B0C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC23206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LY7Fc+nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCTAHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:07:33 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46704 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCTAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:07:32 -0400
Received: by mail-pg1-f169.google.com with SMTP id k191so1001440pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLb0ZW3Gt56un5tXJnGrDhWNvjh5tVVZUmrjKBTkr+I=;
        b=LY7Fc+nlEVtHs0x3b9ctNL+6CrOSlcR+dUMnjqvjQwijmEnKO6WMGSwm7kxpjqqoOP
         rQrvu1SMuG56ettv/vRNoQUuSnEvkfcvf9DdCO+i+sU1NuOcoAkGsBA2HbbgokioRHFt
         OUg11p+DIaNLmdcadaLQASLwXes5a1rc+XT9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLb0ZW3Gt56un5tXJnGrDhWNvjh5tVVZUmrjKBTkr+I=;
        b=N2Fw5Kqfkmidfjewds7OwuAh+s2QM07I89k7KqkTnJ7W64yPWgX/REBP787bpJdp4t
         mmky9w7wRZalgOLh+1s16j+K8xX/e1cXbciP2EY/NXX4MLTGJEthoYHWuyatcmWdHVkZ
         MIOeBX4uQh3fYlWKrVjr1K+6jM45nyLi+qHi6opcvtxXbSIf+w2Hd9iarjktEDTvu0f6
         gHoKyoo3r2nqTRyxP5zaZ7p4qYbewiycnqLEOM4WdCRiJZULWsIXXB7DSZl/BXLTgEPZ
         m/DxabXkmeyr6ptN2bZJX1UYvZ8wgvqXs0+fO71tBWauw0idYW0lD7QmOnOqz9emaaAW
         rrkg==
X-Gm-Message-State: ANhLgQ1BKuV4LF4ksODkdQeRuq+wWMReJig9RUblwwDVEug/hB+tCzdv
        0rQxNOlKGBb5q6NNJsZLhT9SpQ==
X-Google-Smtp-Source: ADFU+vu+R8yEHZtvdwQOflPfI/ieY4C1RoRUB74THQ9itVUwbo0VQhUooKemv0uAcyg5F8tYTYvIFQ==
X-Received: by 2002:a63:c507:: with SMTP id f7mr5766872pgd.278.1584662849286;
        Thu, 19 Mar 2020 17:07:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id m12sm2928292pjf.25.2020.03.19.17.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:07:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/2] Bluetooth: Suspend related bugfixes
Date:   Thu, 19 Mar 2020 17:07:11 -0700
Message-Id: <20200320000713.32899-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

After further automated testing of the upstreamed suspend patches,
I found two issues:
- A failure in PM_SUSPEND_PREPARE wasn't calling PM_POST_SUSPEND.
  I misread the docs and thought it would call it for all notifiers
  already run but it only does so for the ones that returned
  successfully from PM_SUSPEND_PREPARE.
- hci_conn_complete_evt wasn't completing on auto-connects (an else
  block was removed during a refactor incorrectly)

With the following patches, I've run a suspend stress test on a couple
of Chromebooks for several dozen iterations (each) successfully.

Thanks
Abhishek



Abhishek Pandit-Subedi (2):
  Bluetooth: Restore running state if suspend fails
  Bluetooth: Fix incorrect branch in connection complete

 net/bluetooth/hci_core.c  | 39 ++++++++++++++++++++-------------------
 net/bluetooth/hci_event.c | 17 +++++++++--------
 2 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

