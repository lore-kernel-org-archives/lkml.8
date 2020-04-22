Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB14C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550408;
	bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xh/ifS3feJ0hI0LOV1Im9Zi8LUKRu8RSrO1sRlj0+v+Zprvb9hLNNxP6VKVedEvDh
	 CALStovwqSCfr+vSJVd1TzA7l1uTbCYBihyDzglF2e5bvL+OpPiKVdTg15a/iJliVI
	 tvSTpieujJN8WBB4jqMRIS+jsE9/VIhTJc4oTseg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDVKN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDVKNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D9720575;
        Wed, 22 Apr 2020 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550398;
        bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQwUWEYsdM1a04HqI/sutsBj48VBpxhVWOxRd0quxz+JDuyhjzO76SaBfx04pJJnX
         OKitXWNzE2Nvgen+3bnqcRmcdAGDpLkWTAwR8VB4dBhNcuC/HQcb4E1vnhdE1YiNaR
         ZshZAG5TNl4HsbSHdgD402w0PdbyNJGyACAPBYBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <john.allen@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 129/199] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Date:   Wed, 22 Apr 2020 11:57:35 +0200
Message-Id: <20200422095110.749884551@linuxfoundation.org>
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

From: John Allen <john.allen@amd.com>

commit bdf89df3c54518eed879d8fac7577fcfb220c67e upstream.

Future AMD CPUs will have microcode patches that exceed the default 4K
patch size. Raise our limit.

Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org # v4.14..
Link: https://lkml.kernel.org/r/20200409152931.GA685273@mojo.amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/microcode_amd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,7 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
-#define PATCH_MAX_SIZE PAGE_SIZE
+#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);


