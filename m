Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5892C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F91207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="cXyDHg4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD3THs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgD3THp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:07:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B569C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:07:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g26so2144796qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8AiLY8Jx+agzN5y2seIrLqYvcvctf8hMS4XCT7biTg=;
        b=cXyDHg4BakW/zjntd3RnSJFCetFIj31VQCU1kvleuvXtwnusFYS06s78v9XCBEWsPR
         Rb12gH3STnUJLri7F0qha7uZOZQVUfiZUOy+QHzbRNHlHeGmhjr0X3ZWUH3m9+/GqGof
         5hDErphgH7MBfeyqsL6/JIusJ2LIPidxn11mmzFMwCWom1EHzuQA+al0DZN9RNCDvEAB
         ZJ4V4LP2TDESxVa5boJbKQj3OG3BD09b0OwUyJ2BCu0M3L4ZV2T0KCUCgWyJ8u4zVOX3
         LqChc2GcYqLJGg1788YK50Gk6Svdm20KkViMySeEYv9rkpGfBxgOi8MPbn7M7dFdTtPV
         eviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8AiLY8Jx+agzN5y2seIrLqYvcvctf8hMS4XCT7biTg=;
        b=q0BcoFj035X+wblbMtPSb4YlmMqwH8K686CCSSb8uIL90rcfn2n26ZA7ygYv+ptQXj
         OhrwAKhMNZMwcK+eg3yP4FWOPxsqLxQ+0oRyW0mEBK0VZjk9pE899jwUpEEy62L46yIF
         GP97LQyC3vOYXlzi5Ht3W7qI6Tr7Qphxmmqc7L4wvbqxUO9YSTb58pvxumYdGpQ3/fKe
         IVKGg4MTuT1hdRtyf8NJcSZlGz0mEjqdmpaaiZw14JzRRDefxCEO6Sov+fun2i4K9xF3
         RAAJ7+iffeLi+GlGLzXAkLsZul/9iUD7OLijRBjecxY9P6fDlnQuB6fDddxexixflnM4
         tZSg==
X-Gm-Message-State: AGi0Pub5SIWeNdTG8d6SIsPBdgP4jxYf8J/XAd26ow98HgebeVYMPZx+
        4xjYEXi9EssXr7IbmDysiqQAHg==
X-Google-Smtp-Source: APiQypI/UBx9Y5IWGpPtyBWd0nldKr9Js+rAqO9ame/KRp8gaD9ERM3xMuLiSYUC+W4jilxrmZD9Eg==
X-Received: by 2002:ac8:3102:: with SMTP id g2mr5266361qtb.349.1588273662712;
        Thu, 30 Apr 2020 12:07:42 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id z4sm501252qtq.5.2020.04.30.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:07:42 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     hubcap@omnibond.com, martin@omnibond.com, corbet@lwn.net,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] docs: filesystems: fix `make htmldocs` warning
Date:   Thu, 30 Apr 2020 16:07:37 -0300
Message-Id: <20200430190737.80950-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make htmldocs
Documentation/filesystems/orangefs.rst:124: WARNING: Literal block expected; none found.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/filesystems/orangefs.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/orangefs.rst b/Documentation/filesystems/orangefs.rst
index e41369709c5b..628dc220567e 100644
--- a/Documentation/filesystems/orangefs.rst
+++ b/Documentation/filesystems/orangefs.rst
@@ -119,9 +119,7 @@ it comes to that question::
 
     /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
 
-Create an /etc/pvfs2tab file::
-
-Localhost is fine for your pvfs2tab file:
+Create an /etc/pvfs2tab file. Localhost is fine for your pvfs2tab file::
 
     echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
 	/etc/pvfs2tab
-- 
2.25.1

