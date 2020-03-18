Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D4CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DF020724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="bK7HSU7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgCRBnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:43:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38398 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgCRBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:43:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so36208235qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8mUgYv+VKT2lr8NVjxyrZkvepp6x+zOsg4I0gqSpQ8=;
        b=bK7HSU7nkxVi8N68R6DfHPbiWxaVW78DHfW/0t4Y0v+5qyL8eg51xPR3nZ0Wzg6Bt7
         Qhv7Ahge/U9gbih6y8vJA57rgTTXLEzfHKO2gxOZ7hl0RL6//bv80luVlUmheoYwj9JQ
         IgG7O9rlJvhbh+Rni//aek0qY84uUPEVJiNaWVbt2spo9UOr3ILhXYqBZPgHCMrE706f
         6QdqN74tZAqbnqTLQpHRwyL28Kf8xiqEwo/xXtIiVwBIQosDann+ji+kwB1FNGZH5uT1
         +Gi+Ruwakj7VqvwX1dxSpZXAJFQAvEoL/7mbZyYRdOKXTCA9HTEabCWLiFqRitq75pGD
         odMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8mUgYv+VKT2lr8NVjxyrZkvepp6x+zOsg4I0gqSpQ8=;
        b=hmyPJjg2mumlOm0CO9ZUbpybtxfaKWcrzhTOkNJp5PmmRAp4SJsOc3RGwkYWkgjSNw
         70VS/cy3DXTsb/2D2SJ0aBsl0VCEeibi7rpRHFaIhQO19Waum/mfMQglhwiri4LsB7Xs
         ZW03nS2xf59biJFQy7gNtY1Rc7dlv+4kNWFcyQlYfMZNW7PsbY9x/yUmRQYPovw67NnU
         YF6ERL5Z5XUa5mBxXrXx+aixhsHyApHxTWyGlOEVC/uZ0eU6/s7b04T/0WGdN2DXevBZ
         3ILERWdmRZvhj5L7LqAhimtRGdZI1ovTKsBnJkx7VcpAGeOBbdx6rPjQtvf3Om48+cCn
         hzbA==
X-Gm-Message-State: ANhLgQ2t496lQcg2fUgSvxHegoNRGzWeYikTfcUVcgFHV81zEXZhLm/n
        uyuKgQ8+glMqZHavVTNCMFuz6KlFitButT2N
X-Google-Smtp-Source: ADFU+vv33OmGqzWo180ijpGFSaQFry+2s8NTwr1853i6DLNMIoAIbKnqoq618kLR2Mp5a55kGPz7gQ==
X-Received: by 2002:a37:d285:: with SMTP id f127mr1829475qkj.107.1584495792610;
        Tue, 17 Mar 2020 18:43:12 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id m1sm3740883qtm.22.2020.03.17.18.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:43:10 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH 2/2] xarray: Add missing blank line after declaration
Date:   Tue, 17 Mar 2020 22:43:03 -0300
Message-Id: <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1584494902.git.vitor@massaru.org>
References: <cover.1584494902.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: "WARNING: Missing a blank line after declarations"
in include/linux/xarray.h:1504

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 include/linux/xarray.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a7dec1ec0967..61f83aca2326 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1624,6 +1624,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
 		if (offset < XA_CHUNK_SIZE) {
 			unsigned long data = *addr & (~0UL << offset);
+
 			if (data)
 				return __ffs(data);
 		}
-- 
2.21.1

