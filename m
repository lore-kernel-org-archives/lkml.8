Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E54CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053B4207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261176;
	bh=k4RwoxkCN8nskMAMp2RfPf26Rb+qQSGzvcCGXFVAIdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xL1Ep2/8he6s7mvt70sHLztmpwkjoarvC+6pRKMAv+LEsq8k9LOx3eKXLl9Tf+FBD
	 R1VlLdUCkvYOB7vgK8vV8DBH0S0RGW0SxUeXEhFf3bZVlh9UlWdPjDgDEUE0DIX2BV
	 ky1mdRFfRWvMceimdeZNrheBa1Zoc4hogUkHzudE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgHXIxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbgHXIwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B182075B;
        Mon, 24 Aug 2020 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259167;
        bh=k4RwoxkCN8nskMAMp2RfPf26Rb+qQSGzvcCGXFVAIdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hakRlGnQrDRfX7ZlAtUzJX/farWgKns4ZDH4A87kYuk9Tw2I32KPt39JVcBiU+q3D
         xMIkhfcsr+S1Ux5LkOYmH/zYrc47WfW5fcmzZBk6kYG5LXDshsHhXsFD3X+Z9ZnThG
         F0sX75TMd7k1MOyJjf+y4x3PTYCvJ1iNxBWRMbms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 34/39] powerpc/pseries: Do not initiate shutdown when system is running on UPS
Date:   Mon, 24 Aug 2020 10:31:33 +0200
Message-Id: <20200824082350.272665157@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/ras.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -101,7 +101,6 @@ static void handle_system_shutdown(char
 	case EPOW_SHUTDOWN_ON_UPS:
 		pr_emerg("Loss of system power detected. System is running on"
 			 " UPS/battery. Check RTAS error log for details\n");
-		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:


