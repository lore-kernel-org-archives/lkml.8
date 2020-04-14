Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2B9C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F07F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586882983;
	bh=djdizYUF8P2UkZPkY2sLJI5bKLZqZSwRhGddHALE768=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K55LHy6NF+fCvZrzIM+baT701w9mrJAVulRcJYHpr2b56jCLtyxsotCPimxwYVq2R
	 geQNnm7wxbDZUF3at1WZ0TfnUhfE87JxkuWeWbLslJD3D+8ZS2lapfvA8cZrm7nh4L
	 55DCx79gk1bH78Z6uslfKtrHyZynhvG6Pr8R3O50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440502AbgDNQtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440039AbgDNQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AB9206E9;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=djdizYUF8P2UkZPkY2sLJI5bKLZqZSwRhGddHALE768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4XN7WrjzpxG9AxvfJtBCH8/8FERTXOgG4DArjaXR++OXdzc+YPkwLuTMQVz4OV4G
         Gz9LaIllvV4K9BGSq6PaQh51cUPHGGNWBEf22Yvu5f94d+NCG3cYb58MFw1iKFmko9
         yirlOlxbKT/MKPM+iL4CiFWy7/GCKCYT60RvtjGs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068ky-Gi; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 01/33] scripts: kernel-doc: proper handle @foo->bar()
Date:   Tue, 14 Apr 2020 18:48:27 +0200
Message-Id: <48b46426d7bf6ff7529f20e5718fbf4e9758e62c.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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
2.25.2

