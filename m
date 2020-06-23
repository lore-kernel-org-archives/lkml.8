Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3422073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943465;
	bh=Qrr1m8gojHbUX+fhFTpH2yIQvrlfbVIgli/PbtQG+OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFEnMFZ7VJ7uD5GFq1Ib61qIce14UTFkKEMmQAMo6e1O3eGBQ+9+gRKvqYa1nPtZq
	 wTPmvY+FP3kos+QcXF/fd4PSUXKS2rmevFc+Ycl3YbEeVdYpfaTZgJLwEcibzCi4eU
	 VocIOCIpm1VKGrFGTXy9oFlxj/v6pSJTXdJ5+BB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbgFWURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388755AbgFWURh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E5B2137B;
        Tue, 23 Jun 2020 20:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943457;
        bh=Qrr1m8gojHbUX+fhFTpH2yIQvrlfbVIgli/PbtQG+OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KwX1hnh9JiAUTh+p24ak/TFTxXLYFUR79clGEsgVhH/iVuCh964ydX2h/g/JgpRl
         0+rQmz7xckme0lpOoQFGj88h/LyomCCbnR3HY2Wm6W1Jd3bGrvy4Pr2Bw2Dq8gU93s
         nrc1hAqIor0K4ySrybad/9/Gu16gkhpLspUiL+BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 398/477] afs: Fix the mapping of the UAEOVERFLOW abort code
Date:   Tue, 23 Jun 2020 21:56:35 +0200
Message-Id: <20200623195426.342537958@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 4ec89596d06bd481ba827f3b409b938d63914157 ]

Abort code UAEOVERFLOW is returned when we try and set a time that's out of
range, but it's currently mapped to EREMOTEIO by the default case.

Fix UAEOVERFLOW to map instead to EOVERFLOW.

Found with the generic/258 xfstest.  Note that the test is wrong as it
assumes that the filesystem will support a pre-UNIX-epoch date.

Fixes: 1eda8bab70ca ("afs: Add support for the UAE error table")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index 52b19e9c15351..5334f1bd2bca7 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -83,6 +83,7 @@ int afs_abort_to_error(u32 abort_code)
 	case UAENOLCK:			return -ENOLCK;
 	case UAENOTEMPTY:		return -ENOTEMPTY;
 	case UAELOOP:			return -ELOOP;
+	case UAEOVERFLOW:		return -EOVERFLOW;
 	case UAENOMEDIUM:		return -ENOMEDIUM;
 	case UAEDQUOT:			return -EDQUOT;
 
-- 
2.25.1



