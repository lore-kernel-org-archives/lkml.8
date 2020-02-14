Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65843C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A62246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696869;
	bh=UHTF/KQOikrcVa58Jc+AI++DU1+I2cfHGw4+SZ/+l5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTo01coTQ3J1b/5G0QHOJ6mD1hdMKd38RtWc31Vsb/OZTeL5ms/WXPCgBYAn4bA7G
	 cCH9qOJvO1U+AvqfnBnc8TMoGOglk5j2Vf0mvHjDjOX5tqmwpID0vn9A3MDzippast
	 CvU3tRltwEVLmpdVc4/FD4h+5AW/fOSdzWK/3H/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392322AbgBNQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403957AbgBNQNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E9F246CF;
        Fri, 14 Feb 2020 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696834;
        bh=UHTF/KQOikrcVa58Jc+AI++DU1+I2cfHGw4+SZ/+l5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVrlZtebWonY5SiOvGHCUyKRGPu50xGzzv5F7fqcuyYzzKrR0sxAeHPJj/GocJ9Zw
         3JBCQ/7RMhV+n3CWeRQeGFRD/t1sttukVm91BMoRoJMjwIaec5jcjs188t3I3QHemb
         +BcuhGiaHZB8PmM7aCCuoB4D0PH8Ap4OnYXnykLk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Olof's autobuilder <build@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 099/252] isdn: don't mark kcapi_proc_exit as __exit
Date:   Fri, 14 Feb 2020 11:09:14 -0500
Message-Id: <20200214161147.15842-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b33bdf8020c94438269becc6dace9ed49257c4ba ]

As everybody pointed out by now, my patch to clean up CAPI introduced
a link time warning, as the two parts of the capi driver are now in
one module and the exit function may need to be called in the error
path of the init function:

>> WARNING: drivers/isdn/capi/kernelcapi.o(.text+0xea4): Section mismatch in reference from the function kcapi_exit() to the function .exit.text:kcapi_proc_exit()
   The function kcapi_exit() references a function in an exit section.
   Often the function kcapi_proc_exit() has valid usage outside the exit section
   and the fix is to remove the __exit annotation of kcapi_proc_exit.

Remove the incorrect __exit annotation.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Olof's autobuilder <build@lixom.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20191216194909.1983639-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/capi/kcapi_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/capi/kcapi_proc.c b/drivers/isdn/capi/kcapi_proc.c
index c94bd12c0f7c6..28cd051f1dfd9 100644
--- a/drivers/isdn/capi/kcapi_proc.c
+++ b/drivers/isdn/capi/kcapi_proc.c
@@ -239,7 +239,7 @@ kcapi_proc_init(void)
 	proc_create_seq("capi/driver",       0, NULL, &seq_capi_driver_ops);
 }
 
-void __exit
+void
 kcapi_proc_exit(void)
 {
 	remove_proc_entry("capi/driver",       NULL);
-- 
2.20.1

