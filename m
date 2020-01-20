Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E9C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C112073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8ebzKQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATKaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:30:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34933 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:29:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so6979270pjc.0;
        Mon, 20 Jan 2020 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FKeRoWbtpH3GQd1MvAO8wOuIsFl83eh184TfzkflfXM=;
        b=M8ebzKQ5TqreXmbsCMKOkrVY/wMQ+edovEFOvr+AoJWQuaVayEA4ujDJCYyOGIjePt
         3t/ZurljrfGJ4Nu8qDitcYm9vy99uHexynQVOWYiSuX1EchK/fycL6gNEov2Ofjo/TrT
         C9fj0/Xu0RDEk5qPfmrDiOFMtYIsqT9ARXsjF8JO3hAC4Axd87ocRxN26wZRowZdhTTY
         pQVrnhC+Q/opB1NWueuURSBoBj8a5ppFtwy32YBqAyJ5kxAp0oWbqxCP5V7AdfbpqMb+
         pLye7wtyg5faiZA9xjRbXBaTvp2DF6z0s4RxlxWzTlrvqtCtktzgh9L0fe65HhoQCQfr
         MdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FKeRoWbtpH3GQd1MvAO8wOuIsFl83eh184TfzkflfXM=;
        b=UYW5uhiUUN1itOMltzbN3rI5mIFOiet525DU3M37Abp0hSPTsOE0kN6OHpM0r1VZfU
         V3uxqoqOHi9xOGqoM8BWOzh+mKW9SdaUX8RqqxCkxR10gx5THNfpLk/6Hua/KlfsEc7K
         dcljWz1wiQTBuQIunMtg3t4Qyg98j4joUOetfL50yfc5xL8ShHSY4W5BRygVQ1N3WSDC
         mxLm0jBEkopWiOtVq/lb8NuKsvCXBn5dcFMeV781CVU3Rc1I23IP3E2V/wN/KMblNyQZ
         jAzKE4eugdeO/+IygJi4nfK6CE/nkIWs6by/UaA//xDq+3OUQa7+LUNL1cRR1EZ8sX5j
         hHiQ==
X-Gm-Message-State: APjAAAWcyu6kPUNp41huzAQ/OvT4UofpZvMpPvUG2+kJhcRvX+/P0Ya0
        +rWe+bfYqLCOxotMH4DePSM=
X-Google-Smtp-Source: APXvYqwkjXOjJc+BT0pc8UupcSbuNnLHm0aJ+pe9+9+kqT6uG/LGOHrFmXiqJz6XgDI9L69y7234MA==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr14558696plp.304.1579516199000;
        Mon, 20 Jan 2020 02:29:59 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id s18sm38825418pfh.179.2020.01.20.02.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 02:29:58 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH] zram: correct documentation about sysfs node of huge page writeback
Date:   Mon, 20 Jan 2020 18:29:49 +0800
Message-Id: <20200120102949.12132-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

sysfs node for huge page writeback is writeback rather than write.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 6eccf13..3966db6 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -318,7 +318,7 @@ To use the feature, admin should set up backing device via::
 before disksize setting. It supports only partition at this moment.
 If admin want to use incompressible page writeback, they could do via::
 
-	echo huge > /sys/block/zramX/write
+	echo huge > /sys/block/zramX/writeback
 
 To use idle page writeback, first, user need to declare zram pages
 as idle::
-- 
1.9.1

