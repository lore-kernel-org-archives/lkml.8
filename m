Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C9C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5032075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360807;
	bh=6+PaLUkdrL9YIpHZRkQExO+4pmTux8rSySZ5aPWfrTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjAFoRNsK6OneG9GSGMqordB4JfqrT95HAj6zeEd+wReb2iOHtKBhK6ZOkGGwlWGy
	 nw3UwNtfAv5O7C+pty1Ply6YNSwTpH52HKjS+bcgmWVkw6974sXXbaIpsDj8fpXOWZ
	 01atE0XeQ8bt6/+mGVO7e6MF5KspDrCON0ARHq5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgDHPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C021221F8;
        Wed,  8 Apr 2020 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=6+PaLUkdrL9YIpHZRkQExO+4pmTux8rSySZ5aPWfrTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXM6mVVc6zpbzCxvNECW6ftqsz+ax/CHmUvySzX9hf5iPTOv7RYMT0YdtTUEXz7xY
         FEMwsd63okk+fEppiz2c+VBkeZKC0BShSi1jj4VWOcEDVVAIQ8hgWrsCE1MCXKNTlX
         NU6DdwTcrVGizEZjqIFzyrkbLXlMvdot9AiSGwUE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCj-7S; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/35] powerpc: docs: cxl.rst: mark two section titles as such
Date:   Wed,  8 Apr 2020 17:46:23 +0200
Message-Id: <cccd2886af9961aad2a69fce96c0cf4f06995d6d.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The User API chapter contains two sub-chapters. Mark them as
such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/powerpc/cxl.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/powerpc/cxl.rst b/Documentation/powerpc/cxl.rst
index 920546d81326..d2d77057610e 100644
--- a/Documentation/powerpc/cxl.rst
+++ b/Documentation/powerpc/cxl.rst
@@ -133,6 +133,7 @@ User API
 ========
 
 1. AFU character devices
+^^^^^^^^^^^^^^^^^^^^^^^^
 
     For AFUs operating in AFU directed mode, two character device
     files will be created. /dev/cxl/afu0.0m will correspond to a
@@ -395,6 +396,7 @@ read
 
 
 2. Card character device (powerVM guest only)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
     In a powerVM guest, an extra character device is created for the
     card. The device is only used to write (flash) a new image on the
-- 
2.25.2

