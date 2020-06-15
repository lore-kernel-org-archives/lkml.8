Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FD0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2732920739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203720;
	bh=3Gxzi3odujNooQsOeSbFi1mnMtuTq2tKDZVxg9QIULA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGEjDGO0uWcD8iXMsctC24rAQIMORzH1dID4nlm4WvfwGvEL1czXSQ7ZICDFP2ZJW
	 tk1u74AH7VEKhSYGWXCExnVR7t/Z+s+zAcDzT4w7y0CwEBPinVsHzQ0OWHI7b1Yb6K
	 kko0NyYYOCk7vvykdjHCq0x788i/5evNOzY7ISX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFOGsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2F5208C7;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=3Gxzi3odujNooQsOeSbFi1mnMtuTq2tKDZVxg9QIULA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vbgG0LFXB+Tkvvp78bHWEeUqp8+P9Xhps7SEeJ7dwCbSVmjCCiveFIsJq4NTOlG1V
         EA9Ien2y7gjO90cAL9FEg9YwbrNLp5tX5Ye3+UJ7BhJohT9MhSis/A7q22SVkaALK7
         8UiuO8onFOz0Jcsvq3ltdAMOVW6vE3bnpDzB8B+E=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnk-5R; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 24/29] docs: fs: locking.rst: fix a broken table
Date:   Mon, 15 Jun 2020 08:47:03 +0200
Message-Id: <d07587312c105780d2833ac8be0e27ea4a6d88e9.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx:

Documentation/filesystems/locking.rst:443: WARNING: Malformed table.
Text in column margin in table line 8.

==========              =============   =================       =========
ops                     inode->i_lock   blocked_lock_lock       may block
==========              =============   =================       =========
lm_notify:              yes             yes                     no
lm_grant:               no              no                      no
lm_break:               yes             no                      no
lm_change               yes             no                      no
lm_breaker_owns_lease:  no              no                      no
==========              =============   =================       =========

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/locking.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 318605de83f3..d9116f725818 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -433,15 +433,15 @@ prototypes::
 
 locking rules:
 
-==========		=============	=================	=========
+======================	=============	=================	=========
 ops			inode->i_lock	blocked_lock_lock	may block
-==========		=============	=================	=========
+======================	=============	=================	=========
 lm_notify:		yes		yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	no		no			no
-==========		=============	=================	=========
+======================	=============	=================	=========
 
 buffer_head
 ===========
-- 
2.26.2

