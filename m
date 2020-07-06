Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCC0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548B020739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDiOOarH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGFXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGFXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:10:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E9C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:10:14 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a12so41215174ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvdQAtR2qLs6B429J/6XsvbOWOPlty7E5zuF1Tgl9m8=;
        b=GDiOOarHp+MEQ+Uu3HqUP9PHZ4Qz4Gf5zVG2X2eXXv10rUAE4NTfBuWeMk/yrxDiji
         hi0Kr7CpTalp92Fzx1ItR+NxhhtCqqUmG/FQXrM6QsNJJpl6GcE4KZrf3l0PN9gmXUaC
         NR343QyAF+vR2ilpU61weijHo5fLVIc1nyNAXdkzizkQVyPL60YEakmOf9ABVESld1TK
         XDseO0ZGtFD7hVSYWIn4510XRPHrHPsoA/Lav71I703H6JOhU27zH1c6CB5nI6q5tV+C
         L6Kh/CewEH77zMl7hr9YvDFKj+mSRvRC572C55NrvjPBtg4zby149VvxvbgbUXb1bILy
         K6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvdQAtR2qLs6B429J/6XsvbOWOPlty7E5zuF1Tgl9m8=;
        b=l8JCVw1Ff6kBNIlIkdS5hG46uwB6Em1uOzRJzWcEXul2+5Tf2gdtqAGIhvIqvyHcTt
         nigNdOncz5bg3njKOW4KlnVg2Z2pcM8Xua8739PzDhLAdeEeVEFD5PnjySn2UTUSHO73
         +CqR8tDi+zSw8XV+1HHC0pNZld+cXnofcaQFAAIfOkUaqBMuxJ2qP30P+xSiSE5V6VDk
         39tD6maw3j77WLsr2OEKk5aJZMeV/svM/qol4S7XrVYfjNPYW9O+JTZx7xxWvQnApb67
         U7XGyvQ2D7DZdDnelL+HpgZE5yFAqu1Gx4JdUR6HmTBrCeNIWMRcapFTmLBs72hoyxin
         nW8A==
X-Gm-Message-State: AOAM531GocRiLNCtuzrkRUsTKCYF2z+WThbJ3HaTDcMR9RFLvB8ISTI5
        L0JSk9tPzxa6m9UU95UWE0uf9Q==
X-Google-Smtp-Source: ABdhPJxHTuxCo5/s7nKOrl258qMT98b9xIBsONO5xuPusMwKd3AOokf9GdfhUGWXvusnGV1JY66HBg==
X-Received: by 2002:a6b:611a:: with SMTP id v26mr14884468iob.22.1594077013475;
        Mon, 06 Jul 2020 16:10:13 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w16sm11523029iom.27.2020.07.06.16.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:10:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: ipa: fix warning-reported errors
Date:   Mon,  6 Jul 2020 18:10:07 -0500
Message-Id: <20200706231010.1233505-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel with W=1 produces numerous warnings for the IPA
code.  Some of those warnings turn out to flag real problems, and
this series fixes them.  The first patch fixes the most important
ones, but the second and third are problems I think are worth
treating as bugs as well.

Note:  I'll happily combine any of these if someone prefers that.

					-Alex

Alex Elder (3):
  net: ipa: fix QMI structure definition bugs
  net: ipa: declare struct types in "ipa_gsi.h"
  net: ipa: include declarations in "ipa_gsi.c"

 drivers/net/ipa/ipa_gsi.c     | 1 +
 drivers/net/ipa/ipa_gsi.h     | 2 ++
 drivers/net/ipa/ipa_qmi_msg.c | 6 +++---
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1

