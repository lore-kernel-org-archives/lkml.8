Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF94C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D607C20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB7yDVdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389292AbgAXPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:51:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387665AbgAXPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579881094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4DKa2RCme1P41CH+DPjy2k3enALw+kJPL2/93xPmuuw=;
        b=RB7yDVdjSvbu/Nn+KekH3ia9ZVijhydb0W+qfJH1dpg27yQMmeDTtbgOXTsCRJNcbXSyCw
        yLvWmYA/HK9Hv9sY1no521bJu1EXzvW2EUHMMvvZAkb7QGXlcwVF6/cdMu/UsjmhuAhETa
        5UV+rq4O3XpDku0uYyI+OjpmiCnQxLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-GvDgaOuUP0-dJ7frTSNFeQ-1; Fri, 24 Jan 2020 10:51:32 -0500
X-MC-Unique: GvDgaOuUP0-dJ7frTSNFeQ-1
Received: by mail-wm1-f72.google.com with SMTP id u203so769698wme.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DKa2RCme1P41CH+DPjy2k3enALw+kJPL2/93xPmuuw=;
        b=QziINwDWOjaANaZTulDHD4Ua9sUyvlvdQiMYkoxrREDveMGEHt3iOZIimpETDsb+86
         Msean9mDC4EdUymz0q7aN4FS/knPrBmDYeVpTLzn4sy79f2g+XJtryuNRC14TANbG/9O
         qORVGgvvLJvwTMQM2lee+O+0gkpMSP/N5IT/6oCEZSwLPMgZoblODo0ZDXvxl0VpQFCa
         8YiPQhTzgPolrvE7w/No/aJ/8+9HZySxMyIuhVwlBc/oHHk4MC6/G3hfj31BBHqj5epT
         BSS/4mZJRyZgoBVL1ue1Pgw83zz2RHRz9Nu4R/N68/2oN1ldMMj9t++twoZ9S7zk+iba
         oOSg==
X-Gm-Message-State: APjAAAVql5dme2DzjWIQj6eIFW0vTn9ZeCOvRyQo/KD6p9NNtzo0KUUB
        7Mxm33P9y/VhciVCx65OlF7c4jQavqNheVxKew5LktoOP0NbNvAJj1sn/oSu7/lfvV2HSKLnMMU
        0mSYWhGQYlRF+8TbcFrjDFkjH
X-Received: by 2002:a5d:4983:: with SMTP id r3mr4730741wrq.134.1579881090184;
        Fri, 24 Jan 2020 07:51:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEpH2fUn1KY2XXa2vIqzGr5XJb+gapkXkgKKAD/xDUf7n3F9nAgqP4XiRNnOLvkBYcMZ8ZKQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr4730722wrq.134.1579881089861;
        Fri, 24 Jan 2020 07:51:29 -0800 (PST)
Received: from mcroce-redhat.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id o4sm7793147wrw.97.2020.01.24.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 07:51:29 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: use shared sysctl constants
Date:   Fri, 24 Jan 2020 16:51:27 +0100
Message-Id: <20200124155127.6645-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use shared sysctl variables for zero and one constants, as in
commit eec4844fae7c ("proc/sysctl: add shared variables for range check")

Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kernel/process.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d54586d5b031..1398d78891b7 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -608,8 +608,6 @@ long get_tagged_addr_ctrl(void)
  * only prevents the tagged address ABI enabling via prctl() and does not
  * disable it for tasks that already opted in to the relaxed ABI.
  */
-static int zero;
-static int one = 1;
 
 static struct ctl_table tagged_addr_sysctl_table[] = {
 	{
@@ -618,8 +616,8 @@ static struct ctl_table tagged_addr_sysctl_table[] = {
 		.data		= &tagged_addr_disabled,
 		.maxlen		= sizeof(int),
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{ }
 };
-- 
2.24.1

