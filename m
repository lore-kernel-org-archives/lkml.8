Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFBC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93622054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942739;
	bh=7iN2FQF+Ed1iKKEZKKAl6raBAdxVzHmDVQBjaLOBjgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eobcEiz3t9y09S39tTmxmAXxZ6eqOgSP3BIYKWILyJdZz56DtlgZXCIBYzv6kKA3f
	 /YQQiSNfPwCHkHA94FC39aHjPxb2L4+ncr94VyHruRzyX4oPSmQaWZ3vlRW9LSjEbh
	 R67nocErwcNLnSr6q+TIN2BCxPJz5/1Ckm1nxAYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEHMxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbgEHMxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CFAF24964;
        Fri,  8 May 2020 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942428;
        bh=7iN2FQF+Ed1iKKEZKKAl6raBAdxVzHmDVQBjaLOBjgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThcszKYFnnqPavdriDEuDvn32cVZvED7ZL3IFtKefwCAJCTbC74o9gYutgIrI34fc
         zMpcOUUPn6/L4nUNYNJV5jp+XT6dSSc9l5UJfTzIkAh0IoPq7aB8q2WUzubYgF7cJK
         46UZU3k9eX08ZhN5HkCBV/WFsAm3vhECLLw6o9Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 42/50] ACPI: PM: s2idle: Fix comment in acpi_s2idle_prepare_late()
Date:   Fri,  8 May 2020 14:35:48 +0200
Message-Id: <20200508123048.932531154@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 243a98894dc525ad2fbeb608722fcb682be3186d upstream.

Fix a comment in acpi_s2idle_prepare_late() that has become outdated
after commit f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work").

Fixes: f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sleep.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -979,10 +979,7 @@ static int acpi_s2idle_prepare_late(void
 
 static void acpi_s2idle_sync(void)
 {
-	/*
-	 * The EC driver uses the system workqueue and an additional special
-	 * one, so those need to be flushed too.
-	 */
+	/* The EC driver uses special workqueues that need to be flushed. */
 	acpi_ec_flush_work();
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 }


