Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99890C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710682078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973156;
	bh=iN2d1YDRbUxP7JTdhoAffJserCjLl0RYqy9SP0O0Vdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GPvHJjWC5dHm5cNg+quT0WKu+YomT3lXq9J8XJN5lrJNVZ5IBaclLVoBfw7hY4bul
	 wevx6Rdcno4r2rb5G/3K3oy69hh7IBgard9G7CvwttNx62Lt3uMLc/6jRZeAL+T33L
	 aoRFCAYbMOiboEsg3cqDbYXmXqHp/LKpZtaX0eQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgIAPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgIAPM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:12:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279992100A;
        Tue,  1 Sep 2020 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973145;
        bh=iN2d1YDRbUxP7JTdhoAffJserCjLl0RYqy9SP0O0Vdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwwpqSWaeMfrwGnoM70hEuCn4HAqEwwyzpStjtGeF0wQBmFUKHxLqmvtFp2VFQu9L
         MleWNxZzRGoCh0c04QWuujzOt7Uizfu1lc7A0NmUlwnabXo5luoYaafGZwQX9AY6Kr
         IKO+y4d4Bu/yA5gIeRbqxax0mfGbga6Rk/BZJj5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 06/62] powerpc/pseries: Do not initiate shutdown when system is running on UPS
Date:   Tue,  1 Sep 2020 17:09:49 +0200
Message-Id: <20200901150921.033669215@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

commit 90a9b102eddf6a3f987d15f4454e26a2532c1c98 upstream.

As per PAPR we have to look for both EPOW sensor value and event
modifier to identify the type of event and take appropriate action.

In LoPAPR v1.1 section 10.2.2 includes table 136 "EPOW Action Codes":

  SYSTEM_SHUTDOWN 3

  The system must be shut down. An EPOW-aware OS logs the EPOW error
  log information, then schedules the system to be shut down to begin
  after an OS defined delay internal (default is 10 minutes.)

Then in section 10.3.2.2.8 there is table 146 "Platform Event Log
Format, Version 6, EPOW Section", which includes the "EPOW Event
Modifier":

  For EPOW sensor value = 3
  0x01 = Normal system shutdown with no additional delay
  0x02 = Loss of utility power, system is running on UPS/Battery
  0x03 = Loss of system critical functions, system should be shutdown
  0x04 = Ambient temperature too high
  All other values = reserved

We have a user space tool (rtas_errd) on LPAR to monitor for
EPOW_SHUTDOWN_ON_UPS. Once it gets an event it initiates shutdown
after predefined time. It also starts monitoring for any new EPOW
events. If it receives "Power restored" event before predefined time
it will cancel the shutdown. Otherwise after predefined time it will
shutdown the system.

Commit 79872e35469b ("powerpc/pseries: All events of
EPOW_SYSTEM_SHUTDOWN must initiate shutdown") changed our handling of
the "on UPS/Battery" case, to immediately shutdown the system. This
breaks existing setups that rely on the userspace tool to delay
shutdown and let the system run on the UPS.

Fixes: 79872e35469b ("powerpc/pseries: All events of EPOW_SYSTEM_SHUTDOWN must initiate shutdown")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
[mpe: Massage change log and add PAPR references]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200820061844.306460-1-hegdevasant@linux.vnet.ibm.com
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/ras.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 9e817c1b78087..1fa8e492ce27d 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -90,7 +90,6 @@ static void handle_system_shutdown(char event_modifier)
 		pr_emerg("Loss of power reported by firmware, system is "
 			"running on UPS/battery");
 		pr_emerg("Check RTAS error log for details");
-		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
-- 
2.25.1



