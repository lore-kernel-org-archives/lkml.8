Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8386C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB73D206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6JkZQta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbgDCQGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:06:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34075 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgDCQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id c195so2452155wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzEeNyDala3uxeELxLxO2MZRdXlX5SVQ04E7X9m3Duc=;
        b=d6JkZQtavCBUiM+OFTMbdv5z7W1TYsbqGQbf/cANOcgTNdFDzWgRGfzuN9QQESrjxC
         9bH4H5MmHF8JeFjkX7Sk7RmbqJiC54ZaQPQx5kofJJch1sxLGxh9V/jFmeK7HNvXbRcF
         4ayrMqbbWlfac3oJNmSJZhcqcPUiiQJ8RQ4Q9LiT3ZhPkJ2ACKHj7d6r9Z0e8zSTGc6g
         owse44CHkzTayYBwJXcL8gCkmzbqdqcR/BM1IavzXzBptp9STxUNFZX/2SIJVTElvyK6
         Ei61Z1to2qD/ULto8H0wbAHD1kwSchAaeLXSht2qR5pHzHm29CrszPK5iJN/irikH6Qh
         3UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzEeNyDala3uxeELxLxO2MZRdXlX5SVQ04E7X9m3Duc=;
        b=ZhtC+FavkF6Cn0gxEilVFzHNPtkZY3fjhXQYasTRMEgKAY5tuGRW/J+KK48VpHpUOV
         f9YEp42E6ROHKGbLHkzZT1EOxfQ7vRExoN80Z21pTcXIQS+YRXIZOwjF8CqIubmClNeO
         zXh5oiyPTkGYRwPTMODGmriMjLsB6YNF82LIzrwjt9/rn1+h0VsfiIwp4FIwnd19RSoB
         C5JJEV9kFa8XIVTRbShqzKqlLkw1f/m0+W3nsL5SHWedi1okl1Yo3LInP3bdU20ozv6j
         lwENZwqsX6fw7BTJIytxTUWURZVt6x+7a+lSiXa4l2/KD3X61mzsjBx6HDp8bnhI+j2/
         a/VQ==
X-Gm-Message-State: AGi0PuZk7ia7MEKZOEK/R43quDpcL0CmINgyRYwJewhMukuxn6v6sINm
        HckkvBwIBib51ZSNXL4ZXg/3SMMv1Q==
X-Google-Smtp-Source: APiQypKXKJoJZrGS1SrYH7hAWSC3wip/kiZezs8zGvut14Bp7EdRAFcXcnbNBxqmnaLtGV6i0TJHKA==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr9316654wme.90.1585929955178;
        Fri, 03 Apr 2020 09:05:55 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:05:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com
Subject: [PATCH 0/5] lock warnings cleanup
Date:   Fri,  3 Apr 2020 17:05:00 +0100
Message-Id: <20200403160505.2832-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/5>
References: <0/5>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to various functions,
that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings, improve on readability of the code
and give better insight or directive on what the functions are actually doing.

Jules Irenge (5):
  ipc/msg: Add missing annotation for freeque()
  video: Add missing annotation for cyber2000fb_enable_ddc() and
    cyber2000fb_disable_ddc()
  ocfs2: Add missing annotation for dlm_empty_lockres()
  libata: Add missing annotation for ata_scsi_rbuf_get() and
    ata_scsi_rbuf_fill()
  ipmi: Add missing annotation for ipmi_ssif_lock_cond() and
    ipmi_ssif_unlock_cond()

 drivers/ata/libata-scsi.c         | 2 ++
 drivers/char/ipmi/ipmi_ssif.c     | 2 ++
 drivers/video/fbdev/cyber2000fb.c | 2 ++
 fs/ocfs2/dlm/dlmmaster.c          | 1 +
 ipc/msg.c                         | 2 ++
 5 files changed, 9 insertions(+)

-- 
2.24.1

