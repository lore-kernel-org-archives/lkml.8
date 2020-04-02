Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E34C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA56220784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knbC2o+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgDBFgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:36:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41001 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgDBFgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:36:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so1224876pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do+aDibkJ+9Nk2xPpC10tUF5bA+dXnOz/2cqO1MNak8=;
        b=knbC2o+pyAfJPn10/x4p+jSPwqEdUM5vaqMNWU9Le4dYwA55h3tFjJus5wlFnZGXoZ
         iGGn+aIDrle8DsEd44/Qdz4R386IugeGaclIfFzf2HFdt+Y6thv2a2X4/Jfx5eiga5QP
         0UbSPz0O/CuSiDzcPtGx+OWOkQFOq3AgKX3CGZqnrYwDRJYt2KjJNqFkKOcTFUwmxXCt
         7roz2uoNXTY7WGYf7DXRHsW7TIUMgljMou2mWXCbl6lmu9uMIwnkJaC7mSa6qKqo8wWz
         E8zCOCMXjx+vPaKhSL8kfPtiu7pYDIFMQOwdGG5CshQD5A8QqNoFRIUFmnxgBHgbHmNg
         aQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do+aDibkJ+9Nk2xPpC10tUF5bA+dXnOz/2cqO1MNak8=;
        b=IsCnZlM+r59os3a6bzRz3mISW7hemc3VxAizpmR3Phtk8NRQDGsPbhZnk6q02eQRnk
         KDmdNpPfCtK1Hxl6Xa/rJ0dAh4ZBqx5h2PeHCgvocrredjX8kZJ8qKn92P0/XS0CjRiS
         tL9Dn0blbs6biWN1mS8cVzCTNQJHSWxDIIwcE2+uubVzF6T+SqzsgcHI6VZLPv/VHqOB
         hFF8pb+rf06qZNRhnXtzwUgoytbHcpB3E2UNp5KZWk1bRVcQ0kvUh1PN2+lD/yt5XWcM
         CsCaSUQ8BgiU7qX6O27si9Ma6rJfaPmZAyOKIjKEL9LStJOJwh6ina9tqzvtTNQvGXLC
         5S5Q==
X-Gm-Message-State: AGi0PuaJiQdoIV00K8q5i6I4dV8BBPgRdxWOHXwoiu050hY+hHvaDZY1
        CKQU2UrHDw7DrhxaoqpL4Wo=
X-Google-Smtp-Source: APiQypJ7XgKegTqXz2SvnZioxcFnmfMvDfpsG1M7dXD4R47yFprVfkXESUJeU0R4FYl3Ew48HDoU6Q==
X-Received: by 2002:a63:e210:: with SMTP id q16mr1785491pgh.26.1585805781730;
        Wed, 01 Apr 2020 22:36:21 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id y28sm2863136pfp.128.2020.04.01.22.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:36:21 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 0/2] staging: gasket: Fix style issues in apex_driver.c
Date:   Wed,  1 Apr 2020 22:36:15 -0700
Message-Id: <20200402053617.826678-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache long enums as local variables to fit under 80 characters. Fix a
comment character limit warning. The goal is to comply with the kernel
style guide. All style issues were identified by checkpatch.

John B. Wyatt IV (2):
  staging: gasket: Fix 4 over 80 char warnings
  staging: gasket: Fix comment 75 character limit warning

 drivers/staging/gasket/apex_driver.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.25.1

