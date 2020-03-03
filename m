Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A15C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67E3208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257675;
	bh=lOAFURSgOaTT+A5J8jUDRQ8v5EdHCuVrQdNESG6ru54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1HVbgfjIRLIFQFYe9IHprdhCbzfMR3INg5CQKFe8Cg25XoTYwzZJNS/cR1WRr+Qkk
	 fXcp1tILKoms/WWKZ0kt6qfAzkyOxTiQJuRTEFUF10oOuJft+mO/8lcy034ywp7nUF
	 Txc/N138+jAWCmU7UXFRb7CbQRsARX/nA2tMK8pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgCCRry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbgCCRrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:47:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07023208C3;
        Tue,  3 Mar 2020 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257667;
        bh=lOAFURSgOaTT+A5J8jUDRQ8v5EdHCuVrQdNESG6ru54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxOtlqhXIGGW6QKFG3jmqLUAuPgjZjw44Lfv8vV6D6geHV4W0SSA/oMF+DsVe081L
         ubxVuOR1NLwsq3ycO8Qb1vnOT4XZBc4NxokpdCejNmTWwi7PpsmedAcnNTgpRuELK3
         Z4d1hpgsSxXrMTDQSFKU39he0Kkn13iANZrvKGJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.5 083/176] docs: Fix empty parallelism argument
Date:   Tue,  3 Mar 2020 18:42:27 +0100
Message-Id: <20200303174314.249200773@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit adc10f5b0a03606e30c704cff1f0283a696d0260 upstream.

When there was no parallelism (no top-level -j arg and a pre-1.7
sphinx-build), the argument passed would be empty ("") instead of just
being missing, which would (understandably) badly confuse sphinx-build.
Fix this by removing the quotes.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations are made")
Cc: stable@vger.kernel.org  # v5.5 only
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/sphinx/parallel-wrapper.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/sphinx/parallel-wrapper.sh
+++ b/Documentation/sphinx/parallel-wrapper.sh
@@ -30,4 +30,4 @@ if [ -n "$parallel" ] ; then
 	parallel="-j$parallel"
 fi
 
-exec "$sphinx" "$parallel" "$@"
+exec "$sphinx" $parallel "$@"


