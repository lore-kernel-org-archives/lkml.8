Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE120BED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490503;
	bh=aj+C3qty4HdDe8GL8geUEloqbIzbEgqKD6KeLaYq//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2T1qF2wcg/0Vz0Vjk5idV/2Qm+L/sgzykaaf/POJ+sZtrrYJlaPETU6JbVtPoTiAE
	 6L4ogllp2feKnUSTQs+2jyGu1aXldlWJL9Zh1dExZlyenNhbaOr1Rcd1OOKVgSJNFd
	 tmNtQeJU+m8VRuTJ8Jwc+2T9KYS7vBF5QAXSYwlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgDJDsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgDJDsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:48:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4383A21473;
        Fri, 10 Apr 2020 03:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490500;
        bh=aj+C3qty4HdDe8GL8geUEloqbIzbEgqKD6KeLaYq//Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoHe3yZhagQ+JOYKaCIUnUu+nhBFtExVTpR6gF++GMkDibncCk2xzLfSIRO71TCtQ
         6oYSaaFrHnfUesJ5gkiaLg6TmNvRo+YYzehpb15pJR7NJT0mfF50PDk4iXPrMyfSUb
         6hn+O+fiC6y1115zBHZVDc0DvsR4Ck7frhlMweH0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 16/56] xhci: bail out early if driver can't accress host in resume
Date:   Thu,  9 Apr 2020 23:47:20 -0400
Message-Id: <20200410034800.8381-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 72ae194704da212e2ec312ab182a96799d070755 ]

Bail out early if the xHC host needs to be reset at resume
but driver can't access xHC PCI registers.

If xhci driver already fails to reset the controller then there
is no point in attempting to free, re-initialize, re-allocate and
re-start the host. If failure to access the host is detected later,
failing the resume, xhci interrupts will be double freed
when remove is called.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200312144517.1593-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dbac0fa9748d5..fe38275363e0f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1157,8 +1157,10 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		xhci_dbg(xhci, "Stop HCD\n");
 		xhci_halt(xhci);
 		xhci_zero_64b_regs(xhci);
-		xhci_reset(xhci);
+		retval = xhci_reset(xhci);
 		spin_unlock_irq(&xhci->lock);
+		if (retval)
+			return retval;
 		xhci_cleanup_msix(xhci);
 
 		xhci_dbg(xhci, "// Disabling event ring interrupts\n");
-- 
2.20.1

