Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADAC35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D25120732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgBXXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:32:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgBXXb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHc4FLjz9sRN; Tue, 25 Feb 2020 10:31:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587116;
        bh=e+3S5c2g5Nka9xFqjuZ71WCKyjhhE+9WODC+LK78bD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnsO4rESThUzbouiP/Ygtw9wkEaYY7Tu9u2nvdJOILEdxeoPcT+rkxwa35wyNoYwY
         O/7R81Ij+KqHvu6v7/AHce+9syqNu+emDTOX0x2GRlo7Ip0uCISfYjhiGW/052iudU
         P3hsWzqJaDbsh942QuA9YmETjLxe9TxQwej5s1C6Ttd1TzMiEvRttnG8YqL3ViQxdu
         VZHth2JulDJ7DpLRxUWXawl5WzRJiiKKdjeqDoyzanP1V6DakM9TyMAAp9rcsX9DNA
         uraTO/ZHZ4XDphJCiLfV3yT9mux9zT5U7Cqdl4aBvV8JeXe4nt/dZ+bign5QVIAZak
         D5mka8sRLtKoQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 8/8] powerpc: Update 83xx/85xx MAINTAINERS entry
Date:   Tue, 25 Feb 2020 10:31:46 +1100
Message-Id: <20200224233146.23734-8-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott said he was still maintaining this "sort of", so change the
status to Odd Fixes.

Kumar has long ago moved on to greener pastures.

Remove the dead penguinppc.org link.

Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index febffee28d00..2e917116ef6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9650,11 +9650,9 @@ F:	arch/powerpc/platforms/44x/
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 M:	Scott Wood <oss@buserror.net>
-M:	Kumar Gala <galak@kernel.crashing.org>
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
-S:	Maintained
+S:	Odd fixes
 F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
 F:	Documentation/devicetree/bindings/powerpc/fsl/
-- 
2.21.1

