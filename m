Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C417C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E452070C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c11lPSmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGAGJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGAGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:09:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE89C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so10576826pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VEa2mK1n/Z1NoMOue5fFCZgphszoFRdqQh+jray/Ymk=;
        b=c11lPSmAMoAEy2A529Hpm4EzH5oHccsXb3BCAdT5PUbURFnIr6mNCLnvwUhtKZaEA4
         /nxq2gw0/An90b7CHsizv3AhdLTF13GhXeT2ux60h4Tj0VLzVty6EuVSqyPk2G04rbV6
         RxPVHgq+jEXxWR79rfRPcaEBYFVQK3xWBMaYSZpWiQXmZ3vcplmsIcEfM9je2egvcArc
         T79OLPGWXACcwNnR7uNPjYpNVpWT53k1iKfQ8LBfWk0ljkCHgTtmIvaJH8a4r7J9CBPO
         njE0Yz7N9NfUmI6C3cQxxVKSU9xBX1VlSWofsrMyroVtIAPV032uL6HcSZOyaK5M/Gkh
         4IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VEa2mK1n/Z1NoMOue5fFCZgphszoFRdqQh+jray/Ymk=;
        b=fmbN6u9CVf9P3wHmF60f8gGcgIgQ+057ReVGE9vhyQCyYSXY7cWoyxf7qpZ1uZV2jm
         aXKeuH3C7fn3LSBhctcsmmKQYTt8fGUbBHiYwwKwGvRwXRhxBZIWxWwreiXm2FYGPKIZ
         EC9wyMIl/8jvQ0HcX8Rjbio9Q9koPLgLs/5iUrw1+p+UzGthjf0IvoCZcbOxmb2ZY1oR
         FkhepORiU0vl4d4MbcN7a0RwH5jLz5hGlq/VeZ/vif46QlzxnNqrfIFGH9M3e50jF+9c
         zbS/VpV7AtiG1plaCO/+moV6pLnU2yqgM6g1Ddx+pYcCbibSGSl/whQEEQoyuFhQXAeI
         R3UA==
X-Gm-Message-State: AOAM533ryPU+Yjscs43bRPU5iM9TFxwDhYPkN6d/WYKzd32rIqZysTI5
        GKk24L7E8gsPGmnhQKj+n3rJeUIC21E=
X-Google-Smtp-Source: ABdhPJyU2iRrphLhP03x6tIKHUe9ucsydFbuAFwrHlTHM/WJNn9tnpiYuZVjoaZYDSuRf2zpt5SVpg==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr21265664plq.125.1593583772969;
        Tue, 30 Jun 2020 23:09:32 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.42.200])
        by smtp.gmail.com with ESMTPSA id 127sm4694073pgf.5.2020.06.30.23.09.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:09:32 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com,
        daniel.m.jordan@oracle.com, simon@nikanor.nu,
        harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 0/4] staging: kpc2000: kpc_dma: Few clean up and Convert to pin_user_pages()
Date:   Wed,  1 Jul 2020 11:47:40 +0530
Message-Id: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
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

v3:
	Address review comment to invoke the right goto level when allocation
	failed in patch[4/4].

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

 drivers/staging/kpc2000/kpc_dma/fileops.c | 39 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

-- 
1.9.1

