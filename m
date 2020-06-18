Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B381B207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1r9Dysu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgFRSe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgFRSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:34:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87272C06174E;
        Thu, 18 Jun 2020 11:34:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so8516107lji.2;
        Thu, 18 Jun 2020 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyjKf0yQJUn797GKMZ1etLAj+edU1lvwjmQ9JIL+8zE=;
        b=t1r9DysuY9WR1DlGtMUGZrPyLQF56KrDnKvaUDbOrLHT7TlkMvo3vCkHFZLgj9ptIQ
         B1WGvc0ciZ8KGjnfYXcrpGyzcI1Lsb5hrEyM/StDMRpVCBik0zD1duVENIzW9xd6ggrF
         oYFwXcbQYeQAF46EYYQQDVOxYh6W65mmDgQL+169HYoTZHFteE22udkZBN1WMcBb+4+/
         0Zkrpl3RH4VjxdNRp9V1ukE7hIkT68Jmr97pl9GCyLw0V54MFmsor4kXez7XnQCtqQni
         YnPDTkGuIG/9uw2W9U2vZQ2iboBnMfmh9HUmuJ1+n4pyasorx96SWWaKJFufePWbE9KF
         H6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyjKf0yQJUn797GKMZ1etLAj+edU1lvwjmQ9JIL+8zE=;
        b=gTt+WdW4WgNODZHh1SfsjfTOP+Ss4E02tSqncHhcqrwHtt5S98WMla0xMgx7ToaAII
         nawGFjX0alVwdyAb8QzW118MP5hA9V5FQYYKxhGMWX9ivyMNpgdqoi6tTRhbd77sdjqu
         dZv7+RmgO+v8o8CWZbQxYk+k1QvRMgCgi8ta24F/dNj6xsCx3WgDAjaPYS3BTwgfSDJf
         f2ZgQSzfFHMOwJHrwgatdi9gjVR2ZylJfcl+FGQUDBE82xy0HX5t3oDU+fBLXgAW46rf
         JVDDc5ss6EK5dBmB0OvuvyGeQU1I/EOWtUg+oUlJJsFTwBQFTg+QarBPgnfTz98tXzdM
         fT5A==
X-Gm-Message-State: AOAM533K73r8Y8HUd5EL/FC9SEUi+mJonL8RBehKlgjswdarP28u9Qu8
        fCeLIRxYHrW6N2xTgmjm/TY=
X-Google-Smtp-Source: ABdhPJwzh+j3cZEie5IfRGMVB2dg3RSJkTKcAFJ/mEM7RixDYruHJh0QHZu8TiDk7/y/NtdyEQdzRA==
X-Received: by 2002:a2e:6a15:: with SMTP id f21mr2910443ljc.455.1592505266039;
        Thu, 18 Jun 2020 11:34:26 -0700 (PDT)
Received: from pc-sasha.localdomain ([146.120.244.6])
        by smtp.gmail.com with ESMTPSA id w20sm907436lfk.56.2020.06.18.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:34:25 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: [PATCH] net/9p: Fix sparse endian warning in trans_fd.c
Date:   Thu, 18 Jun 2020 21:34:17 +0300
Message-Id: <20200618183417.5423-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address sparse endian warning:
net/9p/trans_fd.c:932:28: warning: incorrect type in assignment (different base types)
net/9p/trans_fd.c:932:28:    expected restricted __be32 [addressable] [assigned] [usertype] s_addr
net/9p/trans_fd.c:932:28:    got unsigned long

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 net/9p/trans_fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 13cd683a658a..2581f5145a22 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -929,7 +929,7 @@ static int p9_bind_privport(struct socket *sock)

 	memset(&cl, 0, sizeof(cl));
 	cl.sin_family = AF_INET;
-	cl.sin_addr.s_addr = INADDR_ANY;
+	cl.sin_addr.s_addr = htonl(INADDR_ANY);
 	for (port = p9_ipport_resv_max; port >= p9_ipport_resv_min; port--) {
 		cl.sin_port = htons((ushort)port);
 		err = kernel_bind(sock, (struct sockaddr *)&cl, sizeof(cl));
--
2.27.0

