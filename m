Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B2C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BB20769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360884;
	bh=qbLirr5OJzkGy9BaDKpusPauYxAyPeK4aOYcI5WQ1pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pbgO+uD8zNZ75EN7ZeezY94Ic5VZJLth/A+Ai0hhvpkW4X+eMPDbEwsSN8fkRaS7z
	 UgoXI+/o4LgLrrQomvX69/CBeQY/j/Roe4qfk/11d/G7chDisNDfxCMoTySB5GD2Tf
	 4vAiSaT66l08gg2eDtQdmDU2TKBWWO07Kyp0myBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgDHPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A1321927;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=qbLirr5OJzkGy9BaDKpusPauYxAyPeK4aOYcI5WQ1pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMMcazz4AvVcJzJ3VI5y9jhVCwiFxY/Nihb4o/E/xiFYwgplIk6Sg4seV9oK1yQoQ
         JqNxA4nVZ/HR2JMukK3bHaSNOUIU8dTABP6qmdDtQ7FoZP+6vtgL9XcbtQJZazynLa
         4fkgh1PWFRs1pfFR7K/+xc8CHXA2n3pjwLcrHxfI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBX-Lm; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 16/35] docs: ras: don't need to repeat twice the same thing
Date:   Wed,  8 Apr 2020 17:46:08 +0200
Message-Id: <9d3a0429368077d51a8ff1a160f89ee0f67bf8d4.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to say twice "for the first time" at the same
paragraph.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ras.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 22b31bc7e129..6cbaab975ee5 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -212,7 +212,7 @@ EDAC - Error Detection And Correction
    purposes.
 
    When the subsystem was pushed upstream for the first time, on
-   Kernel 2.6.16, for the first time, it was renamed to ``EDAC``.
+   Kernel 2.6.16, it was renamed to ``EDAC``.
 
 Purpose
 -------
-- 
2.25.2

