Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73126C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446B320719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jst754ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCXGqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:46:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36248 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:46:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so5958494otf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eW4tMn4FX+hsT8yqdVtaTKyglVePfRfLH2Gh1mT3r0=;
        b=Jst754ZEMPZZKo/tfiTpAjUUo9LUB9h1ZhqMTl6mYb05VxiWnWNBp+bjrJOzyvQCH1
         +oKGskgAXtUyatIITVG6JzzFZQSwh15z9Uid1fjPChwcLpLSsbtoBCB9IqurQtGu+VZ9
         5PSH45pTwE5R3lpqpzVtCRbCX2svlW/JY47tOtOW/TWmuJ3P9JgEo+n6ZCurvbQViAR0
         GZ1yWkyRPajjrUQ6L1oTJFzXg5qXm31Rx9SmFLf3q2o/bSmHhLosd1ozy0pr6kaJJ+di
         aV5t4WPe0uU1ljZjXdMF2FSsPTcgmIpXOHeqa+10DJKVkO/cOkAYRTiPnEUbheisoEHk
         9CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eW4tMn4FX+hsT8yqdVtaTKyglVePfRfLH2Gh1mT3r0=;
        b=PIHV95/ElR3mTDGhlGkq0aeh2yvD7kL8pmMmBld08z5hRMYlY32jVHnZw2yZqmBw0F
         4oC6fq9ITNC5jlRL4AN9LKnQZslI/yPIk0azqQHbpidXP+aPu8Dvumi0QwZHyg64RaFR
         GeUBHIZQBDDPW1WaZ9qGoqHLoTDvOopXzcXPHVFXtsYoR8SmFfZcR6AYmF4XEKSg1PU1
         88Tcq0DlGqfUe8Y0xLkIbZ+kcCO9jojxpNeB/JwuLGqSguxNWeZWEQh494G/dzTWe/r4
         EIJ1OFbei5+3q76BlEEfeZbJb+49LvRMSE/qTixVPtUQzvXteWInIsCSxHzBb6JLMwTQ
         zrdw==
X-Gm-Message-State: ANhLgQ2gTI5kWKBLAWALhsEP01xVBVi2o8DBhQyb13DrCPqjgG1uq/4Q
        VkvDeDKE4q1PrL6cRhsWrU8=
X-Google-Smtp-Source: ADFU+vvqZeYBZxXRd+XZTQYuQf7BCwkmcUoV939/28bSCLZHwGMZYqjEBecKjSiVhfEMx01PMTwoyQ==
X-Received: by 2002:a9d:7488:: with SMTP id t8mr1139265otk.219.1585032362970;
        Mon, 23 Mar 2020 23:46:02 -0700 (PDT)
Received: from localhost.localdomain ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id x1sm2910134ota.7.2020.03.23.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:46:02 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 0/2] staging: vt6656: change function from always returning 0 to void
Date:   Mon, 23 Mar 2020 23:45:43 -0700
Message-Id: <20200324064545.1832227-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change vnt_radio_power_on from always returning 0 to void.

The first patch in this series was originally submitted as a 
standalone patch. Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
suggested more changes to be made into a patchset.

John B. Wyatt IV (2):
  staging: vt6656: remove unneeded variable: ret
  staging: vt6656: change unused int return value to void

 drivers/staging/vt6656/card.c     | 9 ++-------
 drivers/staging/vt6656/card.h     | 2 +-
 drivers/staging/vt6656/main_usb.c | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.25.1

