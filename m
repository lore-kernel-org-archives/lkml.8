Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779AA20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203648;
	bh=cgffz8BCASr3lXXPg+dVmBMMDIINa1Dm7Cv2WHYeuAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyReDwcOFy8LYhromah4MDnWSNp40U/D8MS0hjj+jc3OYRvG9Ek2PwJaQmcDXnM/S
	 P/UcEiWqWRXNAMLb1NWIZld3HkK05dcmZIl/NkUQh5A5M/B7px9++cDO6iU46EvEVl
	 kgI8NKo3fV0SqjQF5Ao4BZv0mLtBklgLpMXIfJNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgFOGrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgFOGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:12 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC292074D;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203631;
        bh=cgffz8BCASr3lXXPg+dVmBMMDIINa1Dm7Cv2WHYeuAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvsCIOTAy6KPORoE9K10V1AzqDl8nL0/ffavKIR05qckzucW9OW3WVR/XqBZzq4Ry
         nIQhlRv4xqGTWG5wXGnlIkXRqF8Mjty12Gmy7JvHJ8OZmjxJZVbsi84Nbcf6bGCLTB
         D6OwXYiUfROR9RkzABPA1CPwzvrx1eR4b4Wka/KM=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmL-He; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: [PATCH 06/29] scripts/kernel-doc: handle function pointer prototypes
Date:   Mon, 15 Jun 2020 08:46:45 +0200
Message-Id: <10af56c5dc04b3c454244a62a49f08414e5c7be8.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some function pointer prototypes inside the net
includes, like this one:

	int (*pcs_config)(struct phylink_config *config, unsigned int mode,
			  phy_interface_t interface, const unsigned long *advertising);

There's nothing wrong using it with kernel-doc, but we need to
add a rule for it to parse such kind of prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 43b8312363a5..e991d7f961e9 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1771,6 +1771,11 @@ sub process_proto_function($$) {
 	$prototype =~ s@/\*.*?\*/@@gos;	# strip comments.
 	$prototype =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
 	$prototype =~ s@^\s+@@gos; # strip leading spaces
+
+	 # Handle prototypes for function pointers like:
+	 # int (*pcs_config)(struct foo)
+	$prototype =~ s@^(\S+\s+)\(\s*\*(\S+)\)@$1$2@gos;
+
 	if ($prototype =~ /SYSCALL_DEFINE/) {
 		syscall_munge();
 	}
-- 
2.26.2

