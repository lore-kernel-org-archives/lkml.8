Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90134C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B472076C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4sQ4Ar/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTBt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:49:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38370 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTBt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:49:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so2424387pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETiO7XhZXke6GDuUI6KgWzLWxeC6pDtcPaOKYiXplXI=;
        b=m4sQ4Ar/8AeFnghpsJxl9gzWUZo4dkOoUwggHTi6im5WlyMNlukpG8VR0Q2/aUzlme
         02l5QGH1Xrq+7tg/kjZPFQHGm7wKWT3JWEVQlGcCjcWqtMDhhJahpUJPnJ5E0aDmdeuK
         swdqraUeWGR9It54oI3HvYrX+c4TDyHbXzs9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETiO7XhZXke6GDuUI6KgWzLWxeC6pDtcPaOKYiXplXI=;
        b=DR2oBIQyXP1g7f3kwy0dVGldm5b3aEty4QbIZyp0rlIRmOlX+svt+pYVYJ323NwpMd
         Jz39rqJ42radzT+UJR2o1QAHdXlXT1sESr6TOaGirZuLQnCXk4lOg/pSpE4CTQSIkS5A
         Nr0jwAJTXc0Cdvbcxn02u2/Y1mj7ThQFFfrdbG80EqKyFA0HUGZ9xZ1qL9pTKDRsHN1v
         zN5jju02mHBG8qUx6q1RjmlIgF7xXPVUve09QW7MylQBooKSXPl2cVeVAaP7USCEIZjL
         TRCQ3PjP5UyN/srMOLuywSeDW1l6z6i+KjLNcNwB3A8YDSdqxR9Dhlx0QGjfmSK13fye
         kBUw==
X-Gm-Message-State: ANhLgQ0zEQlRTi4Iokc2HGrk6jQHiajHyFfo+Jko5aWastB3kUMHEWH+
        FXj+pa9qZKiOluMHdS/khJ7u4cfpGBY=
X-Google-Smtp-Source: ADFU+vvuzGeaFQfV3LmVCl2fYFHJkCPG3vQj22hjOiMNGRgRkQ8YWCLc+24CB5sgyp+JeL/7tHgiqQ==
X-Received: by 2002:a62:1946:: with SMTP id 67mr7337219pfz.0.1584668997488;
        Thu, 19 Mar 2020 18:49:57 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y9sm3450235pgo.80.2020.03.19.18.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:49:57 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH 0/1] Bluetooth: Set wakeable flag via add_device
Date:   Thu, 19 Mar 2020 18:49:48 -0700
Message-Id: <20200320014950.85018-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel and Luiz,

As suggested, I've updated the add_device mgmt op to accept flags on the
device and added support for the wakeable flag. I've prototyped an
implementation in Bluez as well that will send the mask + value on any
add_device and then clear it on the add_device completion.

This seems to work fairly well and allows updating flags during runtime
as well (for example, via dbus property setting).

Please take a look. I will also send up the Bluez changes so you can
look at how userspace would use this.

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  Bluetooth: Update add_device to accept flags

 include/net/bluetooth/mgmt.h |  5 ++++-
 net/bluetooth/mgmt.c         | 42 +++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

