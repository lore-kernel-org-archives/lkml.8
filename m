Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E87C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D50020E65
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nBQKq2tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgIDNyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbgIDNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:53:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:53:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q4so3847171qvr.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6QhKTbTEeY1hMpwGRn3I4+LPI2vg1nOM4QWM63CXncA=;
        b=nBQKq2tZPHnHW6+VjusqM7szXA10nJIkygMDcuxIOkW1Cr311hBbBCr2AU9gMR5Clc
         3C8/3M/R0g35KUMJ+X+SMr3E+wfpTlr1WHpcdCWuL0nssZaWcqyeERm25cn3LIyfPoQz
         fpMpl4DgjhIPtuz46UcOQwO7E9frYXls10Y1w4UsL2Pn76eFN4PtI3rfAHrAdgZrGhql
         M8DkLpjUPpoSva9fXKh9llb5tB1j8EpfNZBrOnWaKRpkuJctbiG4XiyypLCAf9Q81n95
         1drRRPeUEzVtEp1RwvYCBDIQPhxNTwsS9s/7JjfrzNbLFyrSEa0dpY+OHbnhKxNjM0Ry
         o5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6QhKTbTEeY1hMpwGRn3I4+LPI2vg1nOM4QWM63CXncA=;
        b=XG9U52zqeqkGaFR4oEzS2a8u3dyzJutKGRwZUJNXtW9IPRRPoW612E10ujDcEvuVXx
         k+i3l9wdfYunz1hyjNoE7Sp1o7B9YjvHZf1V8rlO0SpxpLYveRxIhgpJbB4OIQVY36ks
         bXNPMioNUXsrdxNidOvreDVwHk6XHy6zLvSrAhdUJRBzKUK+isTGxBJwvMAI+/DCpd/4
         4t+osh3DBIOxZpwY6CucjEHEGggfBxzwilsmIFZ+8dk51+2SsE6rz2a4HVSVaqEnjBmK
         aP30MFxZi1DggGqHTR8T8hJ9TVDhaeHtLvhkkBE35YmL4JmcNkDZamo05BvRUig/LdCh
         rQCQ==
X-Gm-Message-State: AOAM5312ti5VbVL/N/Xlv2UQMgpX8v5p3XTXU7Luaw1xg3RAIK15eYHp
        SN5haUyTfE5FSIKHV/ecX1Tp2H7C
X-Google-Smtp-Source: ABdhPJxQcGmIFWhXaDJlfBg9IY86LASa1SjfOzRlyC9IPT6aHtPDVbg/sEqfYFy1y9Rg9qWeo6OqFTmg
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:1ea0:b8ff:fe76:1e48])
 (user=brho job=sendgmr) by 2002:a05:6214:292:: with SMTP id
 l18mr6631318qvv.5.1599227623676; Fri, 04 Sep 2020 06:53:43 -0700 (PDT)
Date:   Fri,  4 Sep 2020 09:53:32 -0400
In-Reply-To: <20200728163416.556521-22-hch@lst.de>
Message-Id: <20200904135332.1130070-1-brho@google.com>
Mime-Version: 1.0
References: <20200728163416.556521-22-hch@lst.de>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] init: fix error check in clean_path()
From:   Barret Rhoden <brho@google.com>
To:     hch@lst.de
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, rafael@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_stat() returns 0 on success, same as vfs_lstat().  When it replaced
vfs_lstat(), the '!' was dropped.

Fixes: 716308a5331b ("init: add an init_stat helper")
Signed-off-by: Barret Rhoden <brho@google.com>
---

Andy: this was broken in virtme.  "/init: source: not found"

 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index e6dbfb767057..1f97c0328a7a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -297,7 +297,7 @@ static void __init clean_path(char *path, umode_t fmode)
 {
 	struct kstat st;
 
-	if (init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
+	if (!init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
 	    (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
 			init_rmdir(path);
-- 
2.28.0.526.ge36021eeef-goog

