Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B68020842
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmnpfePX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgFJSKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:10:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbgFJSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591812636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=u9aakgaaTX8ly9LiyA2N/fiL1n/d0S5lnU2rxVugXIg=;
        b=KmnpfePXqHTpLIv/wdPv9weYyZ4fl7bvjTeVVlIMN11n1QVfifb/Q2/BT+hMIas4XFEvhg
        KWBoRfbCAIzBNVS97aeSKk3l32tUTuCFOmyASIPnyMQGQLgR9qPUfVgJSogULNJKM3SQ1c
        eb8zKUIfF1he5Di4bT1QLDgUIMZ5Ohg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-xEDH3VkzO4q9WvLZi17xdQ-1; Wed, 10 Jun 2020 14:10:32 -0400
X-MC-Unique: xEDH3VkzO4q9WvLZi17xdQ-1
Received: by mail-qk1-f197.google.com with SMTP id 186so2858546qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u9aakgaaTX8ly9LiyA2N/fiL1n/d0S5lnU2rxVugXIg=;
        b=Dv+YZYL1vaPn5jlToBXJ/y/4/C/V6jN5Mj2caK6S2es3eGi2blmn8KzmgmHDyg4SLy
         Vq8oJQMm/rDjzq9Xy51XFyyDXqLtQzcumjEw+al/lADKZzxdhuOOh39OjlILBDV3G4z5
         MLT13KI20F9/7r9Huc/515JPaiu3S2ZT9Ir8MLGNXw5dNscVfHoc5Dz0xVQfs3oOy20n
         hS9GOtqdgDU38yqVn8XzPNyMIpTKuQluo60VRB4hZ9cr+7Q+lynqDQEJpxyre9Tx65Dg
         Pi13HZTIZJ88uuJ/PGBHUTzYRH3HR8P+9uhU7vUdOwt0Y80UIcyM611MzLsXeYr8vx6G
         9xXw==
X-Gm-Message-State: AOAM532F07rJCo8WOnOKZw+ahl66IVXirB0u6F2KdVrnvvJw6ALWj4DG
        kDSU2cjLtQGDHNaGOFr516ki0NQthoQHIBmKi7417Zb0vZr29q6pZcbG5WIAHWnrk4IiF0Uegl4
        7ZgmnVNLV+MXQ4BNdROfyBYH+
X-Received: by 2002:a05:620a:753:: with SMTP id i19mr4454560qki.357.1591812632216;
        Wed, 10 Jun 2020 11:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiGLjzH3TEYF1nhaOQq4roesXZjGCZf/qfdPCDbNyCZZyRGNUo8BRVa3clJbMeqd8czo5HMw==
X-Received: by 2002:a05:620a:753:: with SMTP id i19mr4454542qki.357.1591812632028;
        Wed, 10 Jun 2020 11:10:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w13sm339047qkb.91.2020.06.10.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:10:31 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 11:10:21 -0700
Message-Id: <20200610181021.19209-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200610181021.19209-1-trix@redhat.com>
References: <20200610181021.19209-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang's static analysis tool reports these double free memory errors.

security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
                        kfree(bnames[i]);
                        ^~~~~~~~~~~~~~~~
security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(bvalues);
        ^~~~~~~~~~~~~~

So improve the security_get_bools error handling by freeing these variables
and setting their return pointers to NULL and the return len to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 313919bd42f8..2dffae1feaff 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
 	if (*names) {
 		for (i = 0; i < *len; i++)
 			kfree((*names)[i]);
+		kfree(names);
 	}
 	kfree(*values);
+	*len = 0;
+	*names = NULL;
+	*values = NULL;
 	goto out;
 }
 
-- 
2.18.1

