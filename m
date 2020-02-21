Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A79C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017F724691
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273176;
	bh=UHTF/KQOikrcVa58Jc+AI++DU1+I2cfHGw4+SZ/+l5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Opp1q58AiICuEg2qDxMltJMHQ5Y0UYq6RKiAAJRG4hpoSoJq+NGmluItBW/+y9oc7
	 eO+dH67LHyoBcdh9YR4KlEw/XgWb/moQQknDf5uigA2PYBrk3hdfTQYCHIOb01ZadV
	 6xYC45yJT1pcVEL3UUYd+LG1BfrvPom7DWIpXMDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgBUITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733154AbgBUITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:19:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D56F24691;
        Fri, 21 Feb 2020 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273171;
        bh=UHTF/KQOikrcVa58Jc+AI++DU1+I2cfHGw4+SZ/+l5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrOPvMhU0AlSonBLOdRfEJhUjUwUGr/O0HaZntmiQ5dTArVpvymR+YBeOOLobdlFX
         9c93V3RBUV1BZ2N4YOW+44tQW1YtltJl1w2VV11YRf0DnJ4A1/cKBxoXUb9tZFB4VR
         npJoCZqA3+/O7yLOOD3661HmGCrcY7RYIhoeD09U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Olofs autobuilder <build@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/191] isdn: dont mark kcapi_proc_exit as __exit
Date:   Fri, 21 Feb 2020 08:40:45 +0100
Message-Id: <20200221072259.984793218@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



