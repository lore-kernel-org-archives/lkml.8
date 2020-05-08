Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C29C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD1021974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941397;
	bh=tlN6HRNqgl/D19qLWJqs7D5lNc+/y7fQd8JarpZtVfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nY/XJha3xUuh5xFkTS0lH1zfywn4fETm+jTC7Rde9+35dxmxYjM1Its94sODNQg64
	 Kf9j1SnarRrpMKmDhUMkpcDYTXh4n33Masea+edkAlJH/VpsWB3hO4IvQQVU4/pnoE
	 1gcQqiDoYBbTR/KRtWMtig+i9DASU7puCdSm7gBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgEHMgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:36:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32B721582;
        Fri,  8 May 2020 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941392;
        bh=tlN6HRNqgl/D19qLWJqs7D5lNc+/y7fQd8JarpZtVfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9fAS4nhncjyedgqFQBbZocNhphmxCSaQ6lmPihe7PDHtk6m10rE4r60yV3qnnDav
         dZrQJFyxmznIVMnmV4G6K9NPnmDtjUHxtV1xNV1wUW6f2imiQtPuiSRBKabCqSqntY
         gDtccXcC9rp4YmjI8HZlQFNezDmWyTwLxKixQYtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 014/312] MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
Date:   Fri,  8 May 2020 14:30:05 +0200
Message-Id: <20200508123125.503268790@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit c130d2fd3d59fbd5d269f7d5827bd4ed1d94aec6 upstream.

BMIPS5000 and BMIPS52000 processors have their I-cache filling from the
D-cache. Since BMIPS_GENERIC does not provide (yet) a
cpu-feature-overrides.h file, this was not set anywhere, so make sure
the R4K cache detection takes care of that.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13010/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1308,6 +1308,10 @@ static void probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 
+	case CPU_BMIPS5000:
+		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		break;
+
 	case CPU_LOONGSON2:
 		/*
 		 * LOONGSON2 has 4 way icache, but when using indexed cache op,


