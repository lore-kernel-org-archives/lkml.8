Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF68C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B9620700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GNK/XoyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGZAk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgGZAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5699C08C5C0;
        Sat, 25 Jul 2020 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZXXTvCw7MyTFpfF0XjQzv2rpyroBBUCNtgKUitCS3f0=; b=GNK/XoyJlAQavgmT4i6VaGFsXI
        VPYE81+StmjK8/1265UboRBm+WEJJ3JIPwn6MWKFN37E+slBfsszjbGc28oM53oxmSMYCd/nEl7/D
        9n7E0ysYJvFxb1qYOQwXHdvwoXWb50mhPgIWrD2FvbzD5TaE460oxo6FySJf2OImR4FU2laa+IC51
        owvlHcbb/tkewF+wrhp5/9xmC1q3wY4s8kANiDCg1YB4NdJpHr9LIcFeLpB85uWD3qovO4ES7MVdI
        Nh0sGQP+nkw9aYcRaDID36ZCkqmgEzwT7NcWTe/H23gH0tRFdlkrqHzFp9DtcvGj33LBeB35pV1mo
        88eIT4fQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUiG-0003NC-1C; Sun, 26 Jul 2020 00:40:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 4/5] ia64: uv: uv_hub.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:40:12 -0700
Message-Id: <20200726004013.20534-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004013.20534-1-rdunlap@infradead.org>
References: <20200726004013.20534-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/uv/uv_hub.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/ia64/include/asm/uv/uv_hub.h
+++ linux-next-20200720/arch/ia64/include/asm/uv/uv_hub.h
@@ -257,7 +257,7 @@ static inline int uv_numa_blade_id(void)
 	return 0;
 }
 
-/* Convert a cpu number to the the UV blade number */
+/* Convert a cpu number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
 	return 0;
