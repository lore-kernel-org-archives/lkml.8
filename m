Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE047C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A603920735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588585498;
	bh=p1TvFFk+CFSzztc7y+DlnQLt3T/P7TNPd3wObNHjD2I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FxxZ4zvgY+obpskoFTQe5ZkWro2vXcHX+vZPFZzTzrapcHEclBD12SVhUDRQEkeNB
	 toHn3yb57/AevO4tfNObwt0jcbZ9mx3/qTkoowqXvfhvdSuVlXOvzF/ig5vqo2Nuxd
	 ooK4x5X5c2SZxG3uf9Zy1u7GOif0OTuTa/Pmsa3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgEDJo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgEDJo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:44:57 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9240320658;
        Mon,  4 May 2020 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588585496;
        bh=p1TvFFk+CFSzztc7y+DlnQLt3T/P7TNPd3wObNHjD2I=;
        h=From:To:Cc:Subject:Date:From;
        b=wAAqCQLQ7jsLtYVmcioCSNyttgEwRpVhEVx+KRwb/Of4w07z89tMVv8gUGsUxTs6t
         V7kM4av7AFlKZ035ogI9rBMNBXIkjfYeH/r/98K4otzBCSExVqUmhnNZ4yedd+jdGw
         K3pvK2XFfce3x0eazUgS6+CoVZjdf8/+Is7h5Hxk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jVXeg-000KKo-9E; Mon, 04 May 2020 11:44:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/vm/keys: fix a broken reference at protection_keys.c
Date:   Mon,  4 May 2020 11:44:50 +0200
Message-Id: <d478a2fc5d204691d0cac6e2b416f0e07a26d3d9.1588585390.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1eecbcdca2bd ("docs: move protection-keys.rst to the core-api book")
from Jun 7, 2019 converted protection-keys.txt file to ReST.

A recent change at protection_keys.c partially reverted such
changeset, causing it to point to a non-existing file:

	- * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
	+ * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)

It sounds to me that the changeset that introduced such change
4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
could also have other side effects, as it sounds that it was not
generated against uptream code, but, instead, against a version
older than Jun 7, 2019.

Fixes: 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/vm/protection_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index fc19addcb5c8..fdbb602ecf32 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)
+ * Tests Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
-- 
2.25.4

