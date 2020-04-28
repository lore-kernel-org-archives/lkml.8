Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBEC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4A5206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099876;
	bh=5uFJuwjoC3VC0PyMXFwFPVXasdTIrZhH+bj1G/wKsGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RlIDbiaJ0eWIIGKjJwrQTtNa4+Cz2cvCsMvBDmZGz4tOiCx98yN+6vM4CSGfRX/MU
	 KEDySqRif4me/eNolDbUDD6+DFq7v/Sj+mwkUCPn1Kdy7G3YtkthkYjFUyFL86kE6b
	 uHNU+2PKfrF2YR9D0spmKvS2ZjwBG9HfHoW/FgWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgD1Sha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgD1ShV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5817A20730;
        Tue, 28 Apr 2020 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099040;
        bh=5uFJuwjoC3VC0PyMXFwFPVXasdTIrZhH+bj1G/wKsGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRq2nb0CeTplkQwaGCSZ+qtfZujxIDWW96MBy/A7tiHDeTd8me9OD1W3bnwSD+AyK
         fERe4KM1/mPWTMmX2VaP3IJylSFUqNYpizBQKE/U6mgJKwZBNG7CVew2EK8Xiyz8Sa
         4gdgC7nv8VqnhHhEKh8+Z22S6f7AsgiDJt/1F72g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/168] tracing/selftests: Turn off timeout setting
Date:   Tue, 28 Apr 2020 20:23:43 +0200
Message-Id: <20200428182238.091774270@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit b43e78f65b1d35fd3e13c7b23f9b64ea83c9ad3a ]

As the ftrace selftests can run for a long period of time, disable the
timeout that the general selftests have. If a selftest hangs, then it
probably means the machine will hang too.

Link: https://lore.kernel.org/r/alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Tested-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ftrace/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/ftrace/settings

diff --git a/tools/testing/selftests/ftrace/settings b/tools/testing/selftests/ftrace/settings
new file mode 100644
index 0000000000000..e7b9417537fbc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.20.1



