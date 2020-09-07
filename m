Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA3421473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P335Irno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgIGPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:35:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53602 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730095AbgIGPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599492754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Jx39sfWEMhw3yDr9IheMM4E9cWZEdDmaYIX39EHEZnM=;
        b=P335Irnowg6ZU1+11+HllhzpP/yQFSEpwnOzFRj6SIIyHFIpHrWpUyqCB4CQpUCLmDJyzx
        AmG3INjLLPN6IWkelYz74xk3kduDSnVa+JjAqcnVJAC0XUWsLYaTtL5jmTccPAB2c6vrrV
        ont3pi6PylfK9+5PO23kt4AibdPezg0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228--U7TJbd4M1OCjHus2cSwzg-1; Mon, 07 Sep 2020 11:32:32 -0400
X-MC-Unique: -U7TJbd4M1OCjHus2cSwzg-1
Received: by mail-qk1-f200.google.com with SMTP id r4so7710492qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 08:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jx39sfWEMhw3yDr9IheMM4E9cWZEdDmaYIX39EHEZnM=;
        b=TKSk+bc5DnO+MTo/lQVVgTnGI58HbBtPKF0c7mWrDguvoqs5jy3ryDwOiRlK49/pFm
         w1iT3vQ3pg7lF1kPLNW+nILa4SNHFh+rhBddxXcszU1OEJUPpuch48i9ex1vqlDCWzw+
         x0M0TlACRttCzOQ7OIovAtz40NSrlSZKDdsqBViO2FMClE2reOC5bvabojfkXHQEj5yl
         8vlxCDX5gjZV5xQOpRuPdDbDp4iuZjSVtHGVByz/HBvEYPsv/YfsCI6UkV3Wt741Grw0
         9pY1v81INz1uoHZqiJq11KXLmaMbpC5hoeM33AYq2ohj9D6rd7CekiHt5QzzyQPn4KeV
         33YQ==
X-Gm-Message-State: AOAM530dy0cNuXk3oN16g40G6Wl/51djYpafAbEsJr84wQlaVtu8RH6Q
        JD1xajhIhMse4NkYMvDbj5h8tJuQEHFzwn7hHJKFC1U8L7fsjeEq6xeiW+PKlBqXaaCqiacHh5A
        6J8ksyMoUSYUMi+97A8aV3/Ov
X-Received: by 2002:a37:a781:: with SMTP id q123mr6664209qke.436.1599492752078;
        Mon, 07 Sep 2020 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4XiUG7xnXgoW2XaQyu6f4KI5pGyBUvtb6wBvY8JCHhQfwcTR364I8VsYStslp0NVZLAImiA==
X-Received: by 2002:a37:a781:: with SMTP id q123mr6664170qke.436.1599492751534;
        Mon, 07 Sep 2020 08:32:31 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m64sm10888198qkd.80.2020.09.07.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:32:31 -0700 (PDT)
From:   trix@redhat.com
To:     tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC: sb_edac: simplify switch statement
Date:   Mon,  7 Sep 2020 08:32:25 -0700
Message-Id: <20200907153225.7294-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

sb_edac.c:959:2: warning: Undefined or garbage value
  returned to caller
        return type;
        ^~~~~~~~~~~

This is a false positive.

However by initializing the type to DEV_UNKNOWN the 3 case can be
removed from the switch, saving a comparison and jump.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/sb_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 68f2fe4df333..93daa4297f2e 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -939,12 +939,9 @@ static enum dev_type sbridge_get_width(struct sbridge_pvt *pvt, u32 mtr)
 
 static enum dev_type __ibridge_get_width(u32 mtr)
 {
-	enum dev_type type;
+	enum dev_type type = DEV_UNKNOWN;
 
 	switch (mtr) {
-	case 3:
-		type = DEV_UNKNOWN;
-		break;
 	case 2:
 		type = DEV_X16;
 		break;
-- 
2.18.1

