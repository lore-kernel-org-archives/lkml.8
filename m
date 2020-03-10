Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711812468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845236;
	bh=B9PFaMli9uM7nog+zc9NrAEfWprE6fi05I1j4+vXZ8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wHxzuFxeS0JAI4C8tjnZW0BUGWcfnLdSA3cbCyghLEK66pb8CmjrCqqor9ptRKLqY
	 qxECa23HUOi8GC+7HnH4Dbj2JPB+kZchqLcl9szR7vKulOfUvO+HzUyKbHFrDG294g
	 4mKLE6QF36oly15kGiKUEZKJ11WXuMfi1+mPCkC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgCJNAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730147AbgCJNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5F32468D;
        Tue, 10 Mar 2020 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845232;
        bh=B9PFaMli9uM7nog+zc9NrAEfWprE6fi05I1j4+vXZ8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyuiLthmImV3ug86h9fvjsKwucyM7N0ui18Ve8th86nTaYVrl0snK8aAOyiUv1yqp
         kV6IYD+enhT0vsJfpl0+NiLmTiZqsREgtYC7cLBs1wX+6kPCq4znN3z54L0gWJDKe3
         C9AffPC4/ir19bQWv253tfrHfFLDtm1Mlhe+hEZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.5 108/189] selftests: pidfd: Add pidfd_fdinfo_test in .gitignore
Date:   Tue, 10 Mar 2020 13:39:05 +0100
Message-Id: <20200310123650.629562564@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 186e28a18aeb0fec99cc586fda337e6b23190791 upstream.

The commit identified below added pidfd_fdinfo_test
but failed to add it to .gitignore

Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/pidfd/.gitignore |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -2,3 +2,4 @@ pidfd_open_test
 pidfd_poll_test
 pidfd_test
 pidfd_wait
+pidfd_fdinfo_test


