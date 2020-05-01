Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DBC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A08824954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340502;
	bh=GMXiiPQKHX1FTn0hWKLhX1Whtb//R682Rms0uUbCt50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wY+kXI59lbmUwmDd9ByhzVBTD5g0UNRbTdYwWP+OguTbusbC9cR1zPiBSibzK4pnP
	 mV1QiIior0gthKoSQjP6IOuejdnFF7veoYajIzKFFUOBs9tK5Oe15GoOG2KU4XgNvn
	 BTECzztxx2A/+b4OFgv+XqdkUCm8LWiwd3hHqUJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgEANll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbgEANlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:41:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7494A20757;
        Fri,  1 May 2020 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340496;
        bh=GMXiiPQKHX1FTn0hWKLhX1Whtb//R682Rms0uUbCt50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cpomy3zLwclqGx6TLqkzowSp41YzkplC4+ARhqGmNyc9JVWKUUkNbnx9/BlZxRiFv
         jctezUT3GImsTM9WV7FIYkzUiMnvhx1gfg+52S8/iR7IIgbqAFSczBi/YqmVDIIVVJ
         i2815iZfnqSZVcEJmXWfy4RJETouuonm2hNNk3Vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.6 006/106] kbuild: fix DT binding schema rule again to avoid needless rebuilds
Date:   Fri,  1 May 2020 15:22:39 +0200
Message-Id: <20200501131544.262669852@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 3d4b2238684ac919394eba7fb51bb7eeeec6ab57 upstream.

Since commit 7a0496056064 ("kbuild: fix DT binding schema rule to detect
command line changes"), this rule is every time re-run even if you change
nothing.

cmd_dtc takes one additional parameter to pass to the -O option of dtc.

We need to pass 'yaml' to if_changed_rule. Otherwise, cmd-check invoked
from if_changed_rule is false positive.

Fixes: 7a0496056064 ("kbuild: fix DT binding schema rule to detect command line changes")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.lib |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -308,7 +308,7 @@ define rule_dtc
 endef
 
 $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
-	$(call if_changed_rule,dtc)
+	$(call if_changed_rule,dtc,yaml)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 


