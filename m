Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2152C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852252076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552721;
	bh=y4RlWMVlN8oehwrTES2hNOCCguSeHdw5uT5nth+Xwdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DevUpaBiDzKaXMAoIkBTjuWqX7xqMzjQMBh6hDMt1TUQWbBs3sdmSf8yj1dDMZvmr
	 rLVOMZyEmmDIClR7RhqAq2hysGtmk6/c2bvxDQgdRqILwRdrkCmDEpUZQd9Rg0g1LK
	 DybqVoj4/iKlXNp4b5YMYYuME88f8+gt50WjlGpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgDVKwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgDVKKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4A920780;
        Wed, 22 Apr 2020 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550243;
        bh=y4RlWMVlN8oehwrTES2hNOCCguSeHdw5uT5nth+Xwdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJVcS15d6uJSraH9e7NgGfg7i9678zPiFcAtl+xvWQF8z1SE4OpYHjlgtb2+7qRY6
         2E3e5VlwUJCSwftHndV3wrGCk7QgYjfKShMsV+Ks6cxxzQWHUelhnwNv5i7Qi0yiCY
         DbMy/llwlsUjrfTJrzCGdVkft/Rg6Yx4CV0kOqv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 068/199] powerpc/pseries: Drop pointless static qualifier in vpa_debugfs_init()
Date:   Wed, 22 Apr 2020 11:56:34 +0200
Message-Id: <20200422095105.002965848@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
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
@@ -1060,7 +1060,7 @@ static int __init vpa_debugfs_init(void)
 {
 	char name[16];
 	long i;
-	static struct dentry *vpa_dir;
+	struct dentry *vpa_dir;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return 0;


