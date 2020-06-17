Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9DB208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:25:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA3C061573;
        Wed, 17 Jun 2020 03:25:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlVGP-0006kb-Q9; Wed, 17 Jun 2020 12:25:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 65D6F1C0089;
        Wed, 17 Jun 2020 12:25:49 +0200 (CEST)
Date:   Wed, 17 Jun 2020 10:25:49 -0000
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix a NULL vs IS_ERR() static checker
 warning in rdt_cdp_peer_get()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200602193611.GA190851@mwanda>
References: <20200602193611.GA190851@mwanda>
MIME-Version: 1.0
Message-ID: <159238954915.16989.17873846610570577082.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cc5277fe66cf3ad68f41f1c539b2ef0d5e432974
Gitweb:        https://git.kernel.org/tip/cc5277fe66cf3ad68f41f1c539b2ef0d5e432974
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Tue, 02 Jun 2020 22:36:11 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Jun 2020 12:18:34 +02:00

x86/resctrl: Fix a NULL vs IS_ERR() static checker warning in rdt_cdp_peer_get()

The callers don't expect *d_cdp to be set to an error pointer, they only
check for NULL.  This leads to a static checker warning:

  arch/x86/kernel/cpu/resctrl/rdtgroup.c:2648 __init_one_rdt_domain()
  warn: 'd_cdp' could be an error pointer

This would not trigger a bug in this specific case because
__init_one_rdt_domain() calls it with a valid domain that would not have
a negative id and thus not trigger the return of the ERR_PTR(). If this
was a negative domain id then the call to rdt_find_domain() in
domain_add_cpu() would have returned the ERR_PTR() much earlier and the
creation of the domain with an invalid id would have been prevented.

Even though a bug is not triggered currently the right and safe thing to
do is to set the pointer to NULL because that is what can be checked for
when the caller is handling the CDP and non-CDP cases.

Fixes: 52eb74339a62 ("x86/resctrl: Fix rdt_find_domain() return value and checks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20200602193611.GA190851@mwanda
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 23b4b61..3f844f1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1117,6 +1117,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
 	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
+		_d_cdp = NULL;
 		ret = -EINVAL;
 	}
 
