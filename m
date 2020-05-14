Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2C720675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWM6Cil1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgENQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:02:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B1C061A0C;
        Thu, 14 May 2020 09:02:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so12639127pjb.0;
        Thu, 14 May 2020 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnRbc31NNtJk9tFYJKwcEqOlUSl+vuVKarKs0i2/PM0=;
        b=cWM6Cil1GSYHTo1M0pZ3oFkajjBsCJZsgLupozV/22XkpDN9n+dwxVACbGKEcRqwzG
         +IeR5qCbzhTXmsl4QhGPB3Njp5wnk+N9OHbNtWlAg4szvy2F5DsmeoF3WOXseT7Gygez
         LWNBa6oBN7+0ASqRQRNHFyp0WjzLLuejUZ1gGhmoTVvPMZ+J/rsbYLdauwMF4d+F0tuN
         s3i/t/HR/pcKAl/CKFI1WhmFIe55w6/9yYullim+UwmFTgyYxiFY+cUoyfDJTvXC72s/
         JFAfGMBAMpMoBE4Q2lopRNRhZT1G6gbXy5E1o75ZBtikglp1mZJAOWj9Arizxlxd6PYt
         zaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnRbc31NNtJk9tFYJKwcEqOlUSl+vuVKarKs0i2/PM0=;
        b=DSg+zeZ1T/nIoeEgPTiZofkl6D1Kw1roe2V7AVcyVgbOiTvE61VEh1gNVqrHPmdKKH
         6MF/IHL2MCZZRNnE/o2jVcGzsJK4qwaS/gBdEajs46Gm5Suktm1kl950Id63uX/R1SMI
         e1+Uz0AsHnJ4mh+CR79fI6M/2PZi4LB45/66O7++KQc7QZnlnepwYS+zZOU1QppY4+9q
         AugcSGzI5JLgtRa+hTRTY1Y3vGdfeMaQwRZdKLZVHsc8/mxAks1N7TByuNvjyvsdRJBk
         be2I95OZwb4l3rYqkspb/iFmJflQiBjlOq2J2yIDrDG0+aTtwjof5GD5nZDea0ui+4zp
         qxwQ==
X-Gm-Message-State: AOAM531HxP1BPvNuWCFeDZV8OD5S9uvPbjFhOhxAg1ZAP0S4o6XRLpFb
        HLozRxejlZP4Bzzz/h7TfDw=
X-Google-Smtp-Source: ABdhPJyEOpXzs7cbcSVjDSlUeR6mxqwNO0lH+67oQUTKg3KFm9trgf8wKVG2yFGUh1xOHbnS7mllRw==
X-Received: by 2002:a17:902:c406:: with SMTP id k6mr4492717plk.203.1589472132868;
        Thu, 14 May 2020 09:02:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y6sm18178691pjw.15.2020.05.14.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:02:11 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 01/14] videobuf2: use explicit unsigned int in vb2_queue
Date:   Fri, 15 May 2020 01:01:40 +0900
Message-Id: <20200514160153.3646-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514160153.3646-1-sergey.senozhatsky@gmail.com>
References: <20200514160153.3646-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

Switch from 'unsigned' to 'unsigned int' so that checkpatch doesn't
complain.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/media/videobuf2-core.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index f11b96514cf7..9e522bd2acc7 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -558,15 +558,15 @@ struct vb2_queue {
 	unsigned int			io_modes;
 	struct device			*dev;
 	unsigned long			dma_attrs;
-	unsigned			bidirectional:1;
-	unsigned			fileio_read_once:1;
-	unsigned			fileio_write_immediately:1;
-	unsigned			allow_zero_bytesused:1;
-	unsigned		   quirk_poll_must_check_waiting_for_buffers:1;
-	unsigned			supports_requests:1;
-	unsigned			requires_requests:1;
-	unsigned			uses_qbuf:1;
-	unsigned			uses_requests:1;
+	unsigned int			bidirectional:1;
+	unsigned int			fileio_read_once:1;
+	unsigned int			fileio_write_immediately:1;
+	unsigned int			allow_zero_bytesused:1;
+	unsigned int		   quirk_poll_must_check_waiting_for_buffers:1;
+	unsigned int			supports_requests:1;
+	unsigned int			requires_requests:1;
+	unsigned int			uses_qbuf:1;
+	unsigned int			uses_requests:1;
 
 	struct mutex			*lock;
 	void				*owner;
-- 
2.26.2

