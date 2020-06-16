Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1202C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B249220776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgudgnzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFPDZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgFPDZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:25:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2275C0A88B4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d8so7756657plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=IgudgnzK6YOeQXxO/GhbZyRnD7yKsB19/poCwHH5zYg0DNwv/OjS7ClaVfKBcPYMJl
         gk02nAiuMCNLKeX/ZV8hAsNyo4xkNMZpUlVd73LjLWPTM3vu0gDsAt4qIgmqVBNttPDZ
         W8gmwOqh2kvJFeY1MjkoUB2YMUS901i5ZFCmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=NqNZ1ugoCyK5MnKWvesrIVS8V99V/PpK+t3XjcnBlKEjTGpdILJPPwcNG0KH11TEmG
         x7L0jTE5x3Jew4q9mgLKg3fiNv0XikDtbrCKWYN4caueCpGnDzObDttE8DjnGavAaotf
         QOB562oWGDaAXDES3KU9pjubOrTzjLOdNjPBrsALgLuxMt0x+CSmhom4qurgJCImR68K
         62nxkOysEYU4BbAV/wjUVlHHhEK/LTLT4Htf6MI3oCkoH3hJZcjiBJ+3wW/XLHIcesWP
         pJ20N7fyDVKXsq26OBcQVp6N6FOWBFizvitgcTdqIZGDlPfL92Wkf0mH3WpAYg0zmvMg
         ajXA==
X-Gm-Message-State: AOAM532eGvYncD9yYt5jszu5YIMXJnBmn3IzAQ6lUaobLI/2Ks8jMv2W
        gY12zngO4DMWeJl0j06yJax34w==
X-Google-Smtp-Source: ABdhPJw66Qb+fMMy1G2QTWCPav55PuClQnfisvC1pdmVOLwHIqdy34tq0HaqwNMimHEa+bRLc4w0yQ==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr329196pln.27.1592277930455;
        Mon, 15 Jun 2020 20:25:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm762715pjn.42.2020.06.15.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
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
Subject: [PATCH v4 04/11] pidfd: Replace open-coded partial fd_install_received()
Date:   Mon, 15 Jun 2020 20:25:17 -0700
Message-Id: <20200616032524.460144-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032524.460144-1-keescook@chromium.org>
References: <20200616032524.460144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sock counting (sock_update_netprioidx() and sock_update_classid()) was
missing from pidfd's implementation of received fd installation.  Replace
the open-coded version with a call to the new fd_install_received()
helper.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/pid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index f1496b757162..24924ec5df0e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -635,18 +635,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
+	ret = fd_install_received(file, O_CLOEXEC);
 	if (ret < 0)
 		fput(file);
-	else
-		fd_install(ret, file);
-
 	return ret;
 }
 
-- 
2.25.1

