Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E64BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264DA20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615783;
	bh=Ics9sg11UVNE6IzrEy6Dxtn4/1sV+IZozK9ffGF+YH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HnHF6lg+neFs4kVLRwwF02Ds9POVb0RvCGbHHp93cgOVf2h7bZKMqePCZR0+jJVfR
	 zMQhFh5uIPB0xRY+BSYbmhMSxgHvbn5+k5y4vqmyqt5YozZV37a/96jdWy18aLwiyz
	 ILyFsFydPnl+opEStmN+/qJETPdi1BObEm0FhILk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbgEDSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731933AbgEDSGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04BA206B8;
        Mon,  4 May 2020 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615575;
        bh=Ics9sg11UVNE6IzrEy6Dxtn4/1sV+IZozK9ffGF+YH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5byhlw5XGSuClkvu+6dMDQsNX6jSnMY4Pcp88YZDXmVnpvRNg8QD+zByhp0jzO1V
         T05in+ogExW+LpWb1BaS5E4gpgUD+eJrROP2yHu2QoZAlyCbE1kblHXO8X2wmzXlAQ
         QIYHjH0fChscAQjeGWgtGVT4U+ii8yQn+hNMo89Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.6 35/73] PM: hibernate: Freeze kernel threads in software_resume()
Date:   Mon,  4 May 2020 19:57:38 +0200
Message-Id: <20200504165507.610232347@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit 2351f8d295ed63393190e39c2f7c1fee1a80578f upstream.

Currently the kernel threads are not frozen in software_resume(), so
between dpm_suspend_start(PMSG_QUIESCE) and resume_target_kernel(),
system_freezable_power_efficient_wq can still try to submit SCSI
commands and this can cause a panic since the low level SCSI driver
(e.g. hv_storvsc) has quiesced the SCSI adapter and can not accept
any SCSI commands: https://lkml.org/lkml/2020/4/10/47

At first I posted a fix (https://lkml.org/lkml/2020/4/21/1318) trying
to resolve the issue from hv_storvsc, but with the help of
Bart Van Assche, I realized it's better to fix software_resume(),
since this looks like a generic issue, not only pertaining to SCSI.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/power/hibernate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -898,6 +898,13 @@ static int software_resume(void)
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
+
+	error = freeze_kernel_threads();
+	if (error) {
+		thaw_processes();
+		goto Close_Finish;
+	}
+
 	error = load_image_and_restore();
 	thaw_processes();
  Finish:


