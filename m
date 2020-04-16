Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B86C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050283;
	bh=17Azc/50V9kor3Bv5Su4JnoYQl5Ar9qKw0dpbNAFj3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2mpshkz20uZfYGSSQ6fomSOpp1vJPh4yhS6vnq595cAHL1nWJbaUZxR37I7Fx9Je
	 ivhJBlkqQHbKuvZu8HGmGQVpbCt4UIpmpd5dUJKpDH3K9gHBvCpzDckuF/6uD+7Ax4
	 MCnzNuGwGWzL9/p/OriU6yg0GO4fh/Fy31cK1shY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442370AbgDPPSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898753AbgDPNsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:48:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C68520732;
        Thu, 16 Apr 2020 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044916;
        bh=17Azc/50V9kor3Bv5Su4JnoYQl5Ar9qKw0dpbNAFj3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXmYyVPUlsF6gqcY5o92c2Xz/+qu3yWzCuLByh8WizI8UxLtTDYvOkPOmauyG9so+
         MTxU5/ULVRCiJZIwWU7E2H5AYK3VlhVxevg6tviTpzxNz23+EOsLpBD/UJnpFPE6Xt
         uluqu9BHzPoSB9eq5pQNWuhwZVtLQCttCOXIqNYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.4 154/232] powerpc/pseries: Drop pointless static qualifier in vpa_debugfs_init()
Date:   Thu, 16 Apr 2020 15:24:08 +0200
Message-Id: <20200416131334.282926388@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 11dd34f3eae5a468013bb161a1dcf1fecd2ca321 upstream.

There is no need to have the 'struct dentry *vpa_dir' variable static
since new value always be assigned before use it.

Fixes: c6c26fb55e8e ("powerpc/pseries: Export raw per-CPU VPA data via debugfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190218125644.87448-1-yuehaibing@huawei.com
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/lpar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1992,7 +1992,7 @@ static int __init vpa_debugfs_init(void)
 {
 	char name[16];
 	long i;
-	static struct dentry *vpa_dir;
+	struct dentry *vpa_dir;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return 0;


