Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA90F2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1Kutge9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgGaIZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgGaIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:25:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2848C061574;
        Fri, 31 Jul 2020 01:25:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f9so7152676pju.4;
        Fri, 31 Jul 2020 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ujf+KrybvrGWNqpJo703c72loRmmDkR+AgXb4PTVmEY=;
        b=V1Kutge9JRHoOGpa5eXYHmJyjYnrikyrK2a0/JyNFD9q9aYjKvoBncuSeSd6c3Wfwg
         VZzBaf+FtDsxM3y8wiQvakUVvc1fpgFsIGWhY7mrjwllA3LdBEiV2DQP+92Pc/vjzhxa
         /zCI12KrA/mJ7xw/oRMcjm55R4DqXV9Fu4Ezf5TU8JOT6MBhC6/k72C3Fs9+RziDJ+Vs
         U/lp48osPOguALFnkI0JLqq48VjaThS76X4TZ51iEsvnFBbM6OEKGOUZTrCryQCQICIZ
         JxRmYv5NRe95kijUlqlk1QCF6sIRBSklcLjPTOv4kH+9GavQ7uUFBj/qHZD2GBlQYNhG
         JLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ujf+KrybvrGWNqpJo703c72loRmmDkR+AgXb4PTVmEY=;
        b=bWjSgFg5kDR2IvEl71zn+TmVQBZLb7LZAw17Ompnmvy1mKkC+ipvh1gMYUPzwVvm0Y
         kmbNMA8QU9FZjQ5W3SNm23SIVmazfr91jWtNgs4sRssLaLEbUsEgPDvQxEOvr+jQt1MR
         ZdK47+IxgH3xty32eVas3SkJ3S/m5RtgQhS8e5kiaKnKvhXufkv83Q2YIFAqgFHGZCh5
         RUt0JLWqkZqY1J0s+3bG2NT8J5ZIYN6xX5CFikziZuvYm6TCEAwU9nT665ClEeWBUYJm
         Vnp0jJFsMMtrdC7eTG8qJOREu7wCcxQYxg+ivIUY2mWZNAXCLkGVEhx69LB/TNJQv3Xd
         kXsA==
X-Gm-Message-State: AOAM533+UiWiJHheSz7NqVJK4RNT0/5GsWAE2RcnXiyfoIFmnHvoAA4A
        7iMsaBovuqGTwzUXPEFefM0=
X-Google-Smtp-Source: ABdhPJzaURoENwRSTLbAWicrq/tfjS0G7CIfepV2KdYp+Aoz/71owoqEbOSRVbnV89SsoV1YcvEl0w==
X-Received: by 2002:a62:86ca:: with SMTP id x193mr1311209pfd.152.1596183943444;
        Fri, 31 Jul 2020 01:25:43 -0700 (PDT)
Received: from localhost.localdomain ([122.224.153.227])
        by smtp.gmail.com with ESMTPSA id u15sm8628579pju.42.2020.07.31.01.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 01:25:42 -0700 (PDT)
From:   Yanhu Cao <gmayyyha@gmail.com>
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
Subject: [v2] ceph: use frag's MDS in either mode
Date:   Fri, 31 Jul 2020 16:25:13 +0800
Message-Id: <20200731082513.11806-1-gmayyyha@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing some tests with multiple mds, there are many
mds forwarding requests between them and then the client request
is resent.

If the request is a modification operation and the mode is set to USE_AUTH_MDS.
Auth mds should be selected to handle the request, and if auth mds for
frag is already set, it can be returned directly without the logic behind it.

But the current logic doesn't return directly because the condition
'mode == USE_AUTH_MDS', and sometimes frag's mds is not equal to
cap's session mds, which then causes the request to be resent.

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a50497142e59..b2255a9be7c0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1103,8 +1103,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				     frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
-					if (mode == USE_ANY_MDS &&
-					    !ceph_mdsmap_is_laggy(mdsc->mdsmap,
+					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
 								  mds))
 						goto out;
 				}
-- 
2.24.3 (Apple Git-128)

