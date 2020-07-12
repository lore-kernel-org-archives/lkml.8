Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89070C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577B020748
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ZQrb71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGLDba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGLDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 23:31:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138EC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so4541999pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SNT1YRB7yGxFXAfJITtoOOG8C2EkzXWjMU3CGAepd0k=;
        b=k+ZQrb716nrHemLK6iqV7smPv77pw/GKXxXxuVENsQJXTAuf3uFvj6HLP5Quch18uy
         2ZsN4C/E23HahZ6bww+zVyRTrm+hKZ6ZNucZLA/dlPSfZ2SADETxSGM6oC3nuTKG7/rA
         MPuJMVXIEMOpAartu7zdD9dWKLGtHyr0Rif/zDUJjMQ0CSFmJgbgIA6Sf4Tpr+iIAk4g
         9w8rfln7yKkZedfZwbJo4pyRdAlTAOZ245dMl7LOJP3oLxse0hgi4Y+Edkabn2FFoQkx
         E33hXyDjxtFVKVPik4ao3wtz5nj9wKv0i5lEYAkCFT7nviQmF3KpJGm9EnrZJTbPPxgu
         gr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SNT1YRB7yGxFXAfJITtoOOG8C2EkzXWjMU3CGAepd0k=;
        b=YgJX7B7IRgWiJUAYLe+ZfQR6TTnTMIlwRYztRmGv5bGsafLbb2GsJRPY/a1JKB9lH8
         bqGTVHRf9jy44Gsl04KyTJsXxriqDa6A3u8CTHR7wK1yaUe8KIFlMDQ5LXftf3FQaFSc
         7p0oD4ZSuJQbpBKBlrRbgAR33eb/H4ZtuIcwtBeyzSBkgRgGldkBV8iDun9cNJSY7x3q
         sqc8tImUEhHCi7NmCD4lEMZH6egoR+HScgOQLZU5GaAKDbxGtmmymP+BRmJmCSJ0yNkj
         nEi6MVyxfFSR8SbJVPYU+/BI8UWMEDFXs+mWS9djt102oTrFJ80jvJMiztXZbjiyLKa3
         aBtg==
X-Gm-Message-State: AOAM533vzyOp1mPP2y6o5kWR+b3LrRFMTdLi5/n4V6Eao8g2vGc2AiSj
        AkVIfP4FG9oNKpNh2sVe3no=
X-Google-Smtp-Source: ABdhPJx3aQQO00Kcd3gxYPg+782A3wemaoqS7dDv8UmKUj3KOWgupYZB5ltmp2SDc0bqfCs5Nc4XNQ==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr47938844pln.113.1594524688860;
        Sat, 11 Jul 2020 20:31:28 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.224.89])
        by smtp.gmail.com with ESMTPSA id s89sm9750271pjj.28.2020.07.11.20.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2020 20:31:27 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v3 0/3] Few bug fixes and Convert to pin_user_pages*()
Date:   Sun, 12 Jul 2020 09:09:52 +0530
Message-Id: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains few clean up, minor bug fixes and
Convert get_user_pages() to pin_user_pages().

I'm compile tested this, but unable to run-time test,
so any testing help is much appriciated.

v2:
        Addressed few review comments and compile issue.
        Patch[1/2] from v1 split into 2 in v2.
v3:
	Address review comment. Add review tag.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>

Souptick Joarder (3):
  xen/privcmd: Corrected error handling path
  xen/privcmd: Mark pages as dirty
  xen/privcmd: Convert get_user_pages*() to pin_user_pages*()

 drivers/xen/privcmd.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

-- 
1.9.1

