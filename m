Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA85AC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5427206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhhyvvVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBREEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:04:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41263 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgBREEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:04:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so18206247otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 20:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=vY7fH5iDeVgQ09OH+F6dLJt4UbcEen0dlqaa+tULjdE=;
        b=JhhyvvVnW/WJF6OWpshfuCwPF3Of9bbZrhhG6XRf0E86J3/7v/RkhOzZX6CIdYzsv9
         SvxjYNrN9wEg5HI49WAJVQ9IrZaBt0AU9Dt+RIqXGlUMwCQsLHDWootAPODDw4SoVkNZ
         oeOmn+NM41WHy7dcKokNWxfAcTYyCFhsLDUPALuQCB6tIplfrefz+/qzgTNjDKeiTt6G
         +72dFPbt5QOlM/QAjxWs+WIBnXsJAxhHGq1nDtHN4AlMLNt6JtTPEQxLW+vQC+sTDeT8
         8uvxbsQZyBesOwM+YyWQIBrdKfPIg5QHCKM4Xlr6iWvJfRdm5tLinWJ0SZGuDujl6CKO
         dzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=vY7fH5iDeVgQ09OH+F6dLJt4UbcEen0dlqaa+tULjdE=;
        b=EhLzCsuMZGYK2GOd/2QWzlrqppCCA/XdKHZV4+/rWgAzR2sqTsWH9JZkgWIVEG1xhh
         nVJagEgSDVSL44L/q0WaDVkFziBzYJkTHhia3SJ+kBGFqfjnkhRcqXlsJYXk3Gb3E0n3
         108BlB39Px5MvsWYe1+qfeDyebdqz0nY3s0zSR3KhUwb6hT1OtekIK9I24hnOGuK1/5A
         OiGg8ldZfmE1xFM2RdgEoVUozu8Lo2k8ciRPnyEgZmZ4d6hqvnX/22NTtqu2guthXxYo
         cLqi2aAr7H5gbBhfGBRlvK8ytGQ53+y2MzzyfkLKM1OXmT5HG8E1Lz1l86JOFgepWzpS
         3pMw==
X-Gm-Message-State: APjAAAWA6LLxd3iTGiDvTZlRfGomH861vSazwsEI5syVNsYPoVW8Abal
        4OdLO8wiFtshNBsr5dLZU1OiW9C9FlU=
X-Google-Smtp-Source: APXvYqzGVwnh/QBmIZAY4QuYaMyw23I2NgYCmapOEl3zBDDR4M/if/GIOZCJoulZu7tq0lrlVMtIMg==
X-Received: by 2002:a9d:7:: with SMTP id 7mr13839013ota.26.1581998690798;
        Mon, 17 Feb 2020 20:04:50 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r80sm821143oie.41.2020.02.17.20.04.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Feb 2020 20:04:50 -0800 (PST)
Date:   Mon, 17 Feb 2020 20:04:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: deny and force are not huge mount options
Message-ID: <alpine.LSU.2.11.2002171959001.1412@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.6-rc1 commit 2710c957a8ef ("fs_parse: get rid of ->enums") regressed
the huge tmpfs mount options to an earlier state: "deny" and "force"
are not valid there, and can crash the kernel.  Delete those lines.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |    2 --
 1 file changed, 2 deletions(-)

--- 5.6-rc2/mm/shmem.c	2020-02-09 17:36:41.798976778 -0800
+++ linux/mm/shmem.c	2020-02-17 19:27:22.704093986 -0800
@@ -3386,8 +3386,6 @@ static const struct constant_table shmem
 	{"always",	SHMEM_HUGE_ALWAYS },
 	{"within_size",	SHMEM_HUGE_WITHIN_SIZE },
 	{"advise",	SHMEM_HUGE_ADVISE },
-	{"deny",	SHMEM_HUGE_DENY },
-	{"force",	SHMEM_HUGE_FORCE },
 	{}
 };
 
