Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924C0206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5bDGFyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgF3HoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgF3HoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:44:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so9534869pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pl+ivQzyTZFWjfiMczmUWs/8JK6z1fCNvXNXKidR1Rk=;
        b=M5bDGFygd1tmBJiJTP+BT5CtnP9TTXwFpjEryFSPhHSUZ3sMpqRDh7R3ZpjzBtEZlE
         0YLE70QmU2MaTu/56knV0rDP/OS3AIyy8+mDFNrCDAesDzQoifokO1zSJjPEhZbB/b3a
         jRemQ1oUpVArI5IQPxqSdA9jzE4mpckGaTA0GB2LzbgeSOCmCvFGdq6ciikKKC0OgtFF
         A2BuHJaZD69QbnQYd9Z5GqTMIRDPi385wlmbY0CbeeEKKF11sxLaYnvcFpdgNq2DZdmg
         wA3vWB+xrJ2bCp+qPxF1XO6J2+ZjVaTfI8jMa6T04uzlt0oVTkimBSd6QneIWPeU3mMG
         sTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pl+ivQzyTZFWjfiMczmUWs/8JK6z1fCNvXNXKidR1Rk=;
        b=Rk+IxYyG9SD4O4mFuTEXVi/NZIfIOwPFaAF33XhbNf5E40iG4g3K1bU89Um0YkXE0D
         PqlAqQjHkgimTpK82lUtID1l80HvtrluyEVwnnb37N1vSG20F7ddNa100Xl4aaeFuhbz
         n3wISe0I34VJMqdwK+EUpvSALVECBu7cEzcCS39+HHJxQqjIlqw7PcMmE0SKPEB9CQcy
         DEaaVCNxm4AJxhW/d6NXMKX/Cd2pyfLMoLfvXg0E1xkCKP04JbrJe8ZSPwW05n+X4x03
         lfJ0X1lY5WuKfcHFAxbnWzlXOJW52NgEaAFRBpjeSJLjIYnVnMLq+KeOjJSmwALRNGLU
         qjBg==
X-Gm-Message-State: AOAM530teF4CudaCr1JqN1tN2QvRnm+82JHL6iAAm08KcwKze5Y3XFjW
        rDIomfFYKtn02xIfrKbzSV8=
X-Google-Smtp-Source: ABdhPJxl+dRWQC+dLyZWXlMuchrOSBVSXZODFQ9NQMp3xoyIw07f+vKDkpi4poj+UZu6F8YeetrC4Q==
X-Received: by 2002:a63:5808:: with SMTP id m8mr13948390pgb.110.1593503051368;
        Tue, 30 Jun 2020 00:44:11 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.143])
        by smtp.gmail.com with ESMTPSA id w1sm1754276pfq.53.2020.06.30.00.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:44:10 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jane.pnx9@gmail.com, ldufour@linux.ibm.com,
        gregkh@linuxfoundation.org, harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 0/4] staging: kpc2000: kpc_dma: Few clean up and Convert to pin_user_pages()
Date:   Tue, 30 Jun 2020 13:22:15 +0530
Message-Id: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
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
	Address Dan's review comments to return -ERRNO for partially
	mapped pages and changed the other patches in series accordingly.
	Minor update in change logs.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>


Souptick Joarder (4):
  staging: kpc2000: kpc_dma: Unpin partial pinned pages
  staging: kpc2000: kpc_dma: Convert set_page_dirty() -->     
    set_page_dirty_lock()
  staging: kpc2000: kpc_dma: Convert get_user_pages() -->     
    pin_user_pages()
  staging: kpc2000: kpc_dma: Remove additional goto statements

 drivers/staging/kpc2000/kpc_dma/fileops.c | 38 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

-- 
1.9.1

