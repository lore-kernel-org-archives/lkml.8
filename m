Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2084EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08B92078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8wvdwHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGIS1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGIS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F2EC08E6DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so1382564pfh.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrMTIMXp8JCVs/UG6kwzV643qisCcMSwknnEo4LkN2s=;
        b=L8wvdwHte5JVfRo/XP6SiecvNSKuxO96e3Iw4DgEORXlBX29wHcKcTekzMu5ehRLxC
         PIZpkxQVThGY9I3o0Km+Zf3dqPVcYYFtmIF38pEP/OnDYBtw9U/C/nd8IeDdy4CeBbvR
         knaPAcSaS1ZiArDzFLG+JuglPL174w7ZWohI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrMTIMXp8JCVs/UG6kwzV643qisCcMSwknnEo4LkN2s=;
        b=ggl6XAHFOzSlyJl+LzuTOzv+1Qfl+eH7jWKyP53A3enTFIUu7t9QY5B2ugiCQP3WKA
         5PZK/Lv6eauhXz992tw9JgaifNLoVw9B0Qa52kATWWqNMEGJAKIB59poeowgIZQJiR7Z
         XFEU0MNkBLBR7ZM+G7KT60B/3OvpngUABG4c2aSslBKWWS8vf+vHuWAa4j0DfeKkvhMm
         31omhz/TvQKjESWEToc5O/oe/jUmx4WK+dPHeqTeAzWH99a3GQn9r1hQd2+OZLc2dbmR
         iAnxHoUUUS2uFZzfS+7o5cw1qTjdTSOamtlsL/5jKMGUcmbLjP5xAr3IbDGzHlRpY7o1
         1Efg==
X-Gm-Message-State: AOAM5308Px30dP8D2yu5yzSohRJrDfrH3W/nPjP3nhxGTgLBmHv4R79h
        NRZUx73/V75sQzYUegqf0gtbow==
X-Google-Smtp-Source: ABdhPJx65UJ0x1t95RO9v7FuFc02woWGGDxWRTXPyPbUQ6AMj/WGTj8FXr741XZhs+0+z7kyxYCdSA==
X-Received: by 2002:a63:1f11:: with SMTP id f17mr53506078pgf.217.1594319213298;
        Thu, 09 Jul 2020 11:26:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l191sm3238744pfd.149.2020.07.09.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 6/9] pidfd: Replace open-coded receive_fd()
Date:   Thu,  9 Jul 2020 11:26:39 -0700
Message-Id: <20200709182642.1773477-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709182642.1773477-1-keescook@chromium.org>
References: <20200709182642.1773477-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded version of receive_fd() with a call to the
new helper.

Thanks to Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> for
catching a missed fput() in an earlier version of this patch.

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/pid.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 85ed00abdc7c..da5aea5f04fa 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -636,19 +636,8 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
-	if (ret < 0) {
-		fput(file);
-	} else {
-		fd_install(ret, file);
-		__receive_sock(file);
-	}
+	ret = receive_fd(file, O_CLOEXEC);
+	fput(file);
 
 	return ret;
 }
-- 
2.25.1

