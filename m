Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDDC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343720775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTUuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:50:10 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:35623 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgCTUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:50:06 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 16:50:04 EDT
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 20 Mar 2020 13:34:55 -0700
Received: from localhost.localdomain (unknown [10.118.101.94])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 0D4ABB1E38;
        Fri, 20 Mar 2020 16:35:00 -0400 (EDT)
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     <linux-x86_64@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Alexey Makhalov" <amakhalov@vmware.com>
Subject: [PATCH 1/5] x86/vmware: Make vmware_select_hypercall() __init
Date:   Fri, 20 Mar 2020 20:34:39 +0000
Message-ID: <20200320203443.27742-2-amakhalov@vmware.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20200320203443.27742-1-amakhalov@vmware.com>
References: <20200320203443.27742-1-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmware_select_hypercall() is used only by the __init
functions, and should be annotated with __init as well.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 46d732696c1c..d280560fd75e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -213,7 +213,7 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 }
 
-static u8 vmware_select_hypercall(void)
+static u8 __init vmware_select_hypercall(void)
 {
 	int eax, ebx, ecx, edx;
 
-- 
2.14.2

