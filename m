Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF363C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F472086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519861;
	bh=7HsHtOfOIO92SqxH1tjL1YKJ4Tg2tQOLPD/uimkOM+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcsHEFfVbQ8cRxsgyHw+QVKwqJrW8pv6Zo/jevwavxuKauB2XCUTcdR6mac9mBOgx
	 5ruXcE10RySaoavqoAQagddyVZiGj8pIEOTdtA/kDKBEzMNQsbqnOyVmtnM+PfBFq0
	 yQeNeE0fKz1O6GwjznKloN+t52mFDETFaiJxxkK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbgEZTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390536AbgEZTES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C47420849;
        Tue, 26 May 2020 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519857;
        bh=7HsHtOfOIO92SqxH1tjL1YKJ4Tg2tQOLPD/uimkOM+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rep29aMCyN670a8s7uh0ICTE/no34HVNuXYe6rKT2nvQSlr0VzhkUD+SLV3pyT9ns
         bm2oq4Ix2/EMWf7yI7CSKvnYJ5HEVfgg++PL0wdqxge39q+5APEraVcXSWbvf5u69M
         popPyesukJrads5nCt1RkmMqawPeI4DjdUSDprdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.19 43/81] apparmor: Fix use-after-free in aa_audit_rule_init
Date:   Tue, 26 May 2020 20:53:18 +0200
Message-Id: <20200526183931.877574026@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit c54d481d71c6849e044690d3960aaebc730224cc upstream.

In the implementation of aa_audit_rule_init(), when aa_label_parse()
fails the allocated memory for rule is released using
aa_audit_rule_free(). But after this release, the return statement
tries to access the label field of the rule which results in
use-after-free. Before releasing the rule, copy errNo and return it
after release.

Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/audit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -201,8 +201,9 @@ int aa_audit_rule_init(u32 field, u32 op
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
 				     GFP_KERNEL, true, false);
 	if (IS_ERR(rule->label)) {
+		int err = PTR_ERR(rule->label);
 		aa_audit_rule_free(rule);
-		return PTR_ERR(rule->label);
+		return err;
 	}
 
 	*vrule = rule;


