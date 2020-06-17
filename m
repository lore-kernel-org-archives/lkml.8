Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69589C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F7821534
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR2ibRFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFQQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgFQQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:13 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n6so2121873otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=nR2ibRFyld6Rz36XS86tjc42eitAgfbejiTdip9ZguMq3wqm7ziUijlXmpjo9BfXvD
         G98UL8wF6HAgPs30xzmS9ue+62+TgJtq136xK7N2et6I+UyfdWVfvmV+57JIg3QlaP0e
         hBV6pSc9sD/OlAfWAHcqj83jV36tCQNT+lR5AJVBnCrGrjaTqoo/x2377u32/F2mEhqY
         PIlhfLi6glVOiOFLZNmyv5tmhImfupl/qEx79iNjQa5XN/aO+P6nk4hxrd5EolJs23tM
         K03IRS80EquWrZaU8am/mFZGK1GrG0Vkki3TAYyfTjYTduZISFYYnWjSMDX+lUIBTRYS
         UekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=nlTKxyKAHxcDlE5Fp9CnrEQoXKT6faI1/ZYTVcyAzADaTVXuu08enqiizXJzJviGW3
         Trj+x3w13enDp4EHKdp8OBG9cXelxf6fplWp4wZcZMb6dkA2XeQrogOhW3HYtq22dvs7
         MWIrYymAK0ml8DEfbWezW4g+NOntFOs+rewNOpCDafgoLFeOs3DGeqOXea9zamYGgsRF
         tMliragAcEdAdgu1dOnqpusIx1gTHD95g6l1262bYrobJ1WvHiUW2X7xJD37DANlpS69
         W8/guoEQyGJielC+BjWJCMIQzKzX1G8G562V0TsCqzRXrjX3lpF6Lj8RHKL+uQlsSiNK
         q3/g==
X-Gm-Message-State: AOAM533GLkQ/BjHjUy1SnUzve0ZkSfR4LRUTNJl8edVmn0qJvbo9EOlJ
        dklwxLj2xDbeRZGFDxnluBQ=
X-Google-Smtp-Source: ABdhPJxwxafwDPo9RTd51JKEjGLQwADhhhe0oeGreoK4zIk2mJG8SUR53URYQ9aatmNFtgEe42yNtQ==
X-Received: by 2002:a9d:7312:: with SMTP id e18mr7329252otk.182.1592411172994;
        Wed, 17 Jun 2020 09:26:12 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 10/21] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Wed, 17 Jun 2020 10:25:23 -0600
Message-Id: <20200617162536.611386-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loadable modules are the last in on this list, and are the only
modules that could be removed.  ddebug_remove_module() searches from
head, but ddebug_add_module() uses list_add_tail().  Change it to
list_add() for a micro-optimization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da3ed54a6521..e879af4e66e0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -895,7 +895,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.26.2

