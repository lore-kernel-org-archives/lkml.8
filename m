Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF70C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21D620724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386551;
	bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLSXxY4JVxLe6TNnJo8W+ex3B77OSPaVQl7Ng/gU3uX+rB4j50XsIrweJaZAx1tPy
	 pJHBazaMCAVBtVeZgXKFaIsLcOTsC8adnGs2XbNe3Q580ZqJkRSMCrgxX87d7yMD1y
	 UVOTiylKcoxf7d/5Zdw3JFou8A6z6qKWEd3awJCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgDTMma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgDTMmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:42:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F96E20736;
        Mon, 20 Apr 2020 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386543;
        bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+XDTHnL5Wnrdx2/wPwvEYRCg0wlX1fQ0a6Oaik1o6ebFynhzmzmWlL6tUv3OvhVt
         Rn8KpUnZTVGActOityj9mMPgeG3fAWslAX5fbxXJre1Y/7NwlUs3rApzpBX+RNV0Le
         4LcuAAdR7futce0q9oyjOMOa8bh5cHthmDFHvKkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <john.allen@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.5 65/65] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Date:   Mon, 20 Apr 2020 14:39:09 +0200
Message-Id: <20200420121520.415015152@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
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


