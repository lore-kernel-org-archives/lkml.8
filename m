Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37869C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B3721D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047277;
	bh=gCFa4uuwm4XERH0jUZR1oplIf17Y25xXY4RyOKeKdfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDADxRP0Gg9Obio83w5o5C62QWAqVSxDhmjzmlxr0Zo5wwKbKKBzfYU3PwXFwhKtY
	 GF57R4YLAxIzAzZuhYfG00KVtg3dGKyBCIH2bjPlIskOGLFZ8GPcrh9Ljw4bNxS6VW
	 PTbzNhu12ltaepfEIfab1Rn1ln7G9DQKv06aUoOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409859AbgDPO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409043AbgDPN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7F62078B;
        Thu, 16 Apr 2020 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045588;
        bh=gCFa4uuwm4XERH0jUZR1oplIf17Y25xXY4RyOKeKdfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJdOH8Skh/valhlFFREfGbz+o+ah2bz8K7Be8n9aBF8HjajvEgbKDeEm4fHxskMb3
         UFt9uw2gYD2j8YQmT3bft4dlGg943XJMMKP8n0B5BdSi8gQKc0uPlesvA3xh7vomJb
         9QlzzgTx4KlE7Q/tCr8pRb2jGOYWkWLXIcOZXNco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.6 197/254] selftests/powerpc: Add tlbie_test in .gitignore
Date:   Thu, 16 Apr 2020 15:24:46 +0200
Message-Id: <20200416131350.820126586@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 47bf235f324c696395c30541fe4fcf99fcd24188 upstream.

The commit identified below added tlbie_test but forgot to add it in
.gitignore.

Fixes: 93cad5f78995 ("selftests/powerpc: Add test case for tlbie vs mtpidr ordering issue")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/259f9c06ed4563c4fa4fa8ffa652347278d769e7.1582847784.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/powerpc/mm/.gitignore |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -6,3 +6,4 @@ segv_errors
 wild_bctr
 large_vm_fork_separation
 bad_accesses
+tlbie_test


