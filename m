Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBCBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200182078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLfC6UYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHMXRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:17:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2212C061384
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so3620515pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avc6yc7kzMjacgIGFQGvDcoJW2VT5v82MJin+mvldc0=;
        b=aLfC6UYu9UMx13JgFaIbJIYrdSm44IU/4IYDJlAO0DRGQk35YEfEKjMPviBuL4KqRU
         HaExMvImOCKpTwCMPvD2atLuDNJin6Qvr/Kity/oTu3g4I6SfTbtqDHLyD91nNPplujK
         iX64+oJCX7cpsClr8fH3s0f7K8Wq9zTG38xM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avc6yc7kzMjacgIGFQGvDcoJW2VT5v82MJin+mvldc0=;
        b=uKkIbQE8KxxoTEhSflYOOd2NuNBO8uORhIp0n+da73rPDsA72X9e9L16JnBYZb9cLr
         j7DLMCjHeodzcn3/d6mwx9GE0ppk6K4bctEpfxzIYb8ZICNydghO7wbCdYT2HOrZ7FvM
         GkcS3in5QOkcgpstqwc2AmdUa3qxB9lEMm7kpreRJ68tsLduMI+ksLb/UgqdIXTwMKEB
         KdQ6FdlWLhukKPIrfPMhAGah7aBjn9fdOyswmKeyzpyWkvf0TBPqvvzcn+5CdnKLZC7k
         ESLXtyjO0We5CW2KWqGlo0qWoUyZy+h+/LraWyuq/WBMR2hQw3TmnnVj87ots0BgtCkU
         ZTZg==
X-Gm-Message-State: AOAM532QqAKDwNUA8fDQxD5OlwdIK9lUP7B2W3LbpiDc1iWG6NUCRltV
        syels/0Xsy1oPk+LA4Ds69maVw==
X-Google-Smtp-Source: ABdhPJwedwgRy8a/KOfOm4UfYdsHSavcGAlnFwTouC13lrZRCjMPI1VJMqmNPrMJ2zsyk9VTQdGENg==
X-Received: by 2002:a63:5f8b:: with SMTP id t133mr5650060pgb.340.1597360652151;
        Thu, 13 Aug 2020 16:17:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d128sm7118284pfa.24.2020.08.13.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:17:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] exec: Restore EACCES of S_ISDIR execve()
Date:   Thu, 13 Aug 2020 16:17:22 -0700
Message-Id: <20200813231723.2725102-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813231723.2725102-1-keescook@chromium.org>
References: <20200813231723.2725102-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return code for attempting to execute a directory has always been
EACCES. Adjust the S_ISDIR exec test to reflect the old errno instead
of the general EISDIR for other kinds of "open" attempts on directories.

Reported-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/lkml/20200813151305.6191993b@why
Fixes: 633fb6ac3980 ("exec: move S_ISREG() check earlier")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2112e578dccc..e99e2a9da0f7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2849,8 +2849,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	case S_IFLNK:
 		return -ELOOP;
 	case S_IFDIR:
-		if (acc_mode & (MAY_WRITE | MAY_EXEC))
+		if (acc_mode & MAY_WRITE)
 			return -EISDIR;
+		if (acc_mode & MAY_EXEC)
+			return -EACCES;
 		break;
 	case S_IFBLK:
 	case S_IFCHR:
-- 
2.25.1

