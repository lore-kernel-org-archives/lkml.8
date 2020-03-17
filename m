Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD5720724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456885;
	bh=IcrlfQvgKmeYInQEb1V6SDbd5RTpr3lZF8EoWwbFokY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OZ/hwgsJ6dcD6eBpKPrdvrSQubW2kAQ8gKeCHmIvqJv2FIBwxe514fVwE2Oi+mDv0
	 yzCbSKl1Kg2geAq/EhAIT9jh13sU8CEe8z7Rdangu4zXIC3ar8yb75s2E4ZZuQPQyE
	 99p5pRaEKZ/g4TwS90ClFwHUPeJ6lCtxZvMNOXbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCQOyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6311D20738;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=IcrlfQvgKmeYInQEb1V6SDbd5RTpr3lZF8EoWwbFokY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbEbEZt+bsHAesAtxuLzRRMp6+HiKS9NfSGqHVUtA/O42M2b+O7Yn1Vky/Ip9kQ3w
         ZIhLTlovd2OpUUhVK4sDF89+b+h4Sj0k+c9U+OhiWB1fegd8SpQTgaFQfT7ae4OCIb
         ky4lnaiHHeW1sGF89rVAsDUsBuQGqtCNC6t1Fyoc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMf-Jb; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/17] scripts: kernel-doc: proper handle @foo->bar()
Date:   Tue, 17 Mar 2020 15:54:16 +0100
Message-Id: <69af92761e5e286f00c29105615de20d1dcab9c3.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern @foo->bar() is valid, as it can be used by a
function pointer inside a struct passed as a parameter.

Right now, it causes a warning:

	./drivers/firewire/core-transaction.c:606: WARNING: Inline strong start-string without end-string.

In this specific case, the kernel-doc markup is:

	/**
	 * fw_core_remove_address_handler() - unregister an address handler
	 * @handler: callback
	 *
	 * To be called in process context.
	 *
	 * When fw_core_remove_address_handler() returns, @handler->callback() is
	 * guaranteed to not run on any CPU anymore.
	 */

With seems valid on my eyes. So, instead of trying to hack
the kernel-doc markup, let's teach it about how to handle
such things. This should likely remove lots of other similar
warnings as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f2d73f04e71d..d15c8ea95d93 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -214,6 +214,7 @@ my $type_constant2 = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
+my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';
 my $type_enum = '\&(enum\s*([_\w]+))';
 my $type_struct = '\&(struct\s*([_\w]+))';
@@ -249,6 +250,7 @@ my @highlights_rst = (
                        [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
                        [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
 		       [$type_fp_param, "**\$1\\\\(\\\\)**"],
+		       [$type_fp_param2, "**\$1\\\\(\\\\)**"],
                        [$type_func, "\$1()"],
                        [$type_enum, "\\:c\\:type\\:`\$1 <\$2>`"],
                        [$type_struct, "\\:c\\:type\\:`\$1 <\$2>`"],
-- 
2.24.1

