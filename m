Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E4022D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915604;
	bh=ZmAVdYFN3OYsn8GaQ5qXLi46UhQNtMpPd4a8JIzOVmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dTL78tyzp3RatiNkmeaHeP81TCaYi41H4qCdhRFhbH4Xn179hOka9/MTX9ANyr4im
	 iIyrNjiKmNnmsOSXDYhi4jfylIQ/FO+Wt1fWjX3nVPLpExKuR2NZzfOJEixWw9UKNG
	 V2gxVSOj3puwFxoNWZz1oXuWOobEFF3Y4274OPis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHTJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgHTJ0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADAE22B4B;
        Thu, 20 Aug 2020 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915542;
        bh=ZmAVdYFN3OYsn8GaQ5qXLi46UhQNtMpPd4a8JIzOVmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnAQz8pKfA7uRfTIyGbkewnLHVTsfRZ2BmyeAAkEhMGYgF4OdOALe48aIk/H1sxMi
         2j4SePYUMxupDHXDdGIg6noIkkAfJfZwGsLIYdzBLA3rk3BHwU12T8Y/slsFuFIn8J
         DzPvsrApp1QidBip9fOxxch0Ior8M+pn2ChrUk1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.8 050/232] powerpc/ptdump: Fix build failure in hashpagetable.c
Date:   Thu, 20 Aug 2020 11:18:21 +0200
Message-Id: <20200820091615.202793136@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 7c466b0807960edc13e4b855be85ea765df9a6cd upstream.

H_SUCCESS is only defined when CONFIG_PPC_PSERIES is defined.

!= H_SUCCESS means != 0. Modify the test accordingly.

Fixes: 65e701b2d2a8 ("powerpc/ptdump: drop non vital #ifdefs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/795158fc1d2b3dff3bf7347881947a887ea9391a.1592227105.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/ptdump/hashpagetable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -258,7 +258,7 @@ static int pseries_find(unsigned long ea
 	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
 		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
 
-		if (lpar_rc != H_SUCCESS)
+		if (lpar_rc)
 			continue;
 		for (j = 0; j < 4; j++) {
 			if (HPTE_V_COMPARE(ptes[j].v, want_v) &&


