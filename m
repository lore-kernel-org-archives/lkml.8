Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922FC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F1521D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056368;
	bh=0CiL0ngTLIrsFbDJVGFNrI71BflXTKRxxmu1f1m5Yew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EDUBufkvRg5SAJoKvkKFvKLVh0CF4lsENAwJZyDVjjBDsBHsQ/vMp5+1XC93FMFib
	 QUCYh0kMZVFi8RXRS2SSkUfWNvZTlNkSpabwFdRv3EXjrg630jDLkSe/iJvf+kAPtC
	 aBEsxQFVVkCuDAz0hgLmWKZKmVa09lyNfV7I8d30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgBRUAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbgBRUAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C6E24125;
        Tue, 18 Feb 2020 20:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056048;
        bh=0CiL0ngTLIrsFbDJVGFNrI71BflXTKRxxmu1f1m5Yew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnCxz2Px478OGpR6JO7fGThcND/Ahwu8IgxoR7fPzn6rL77igdvW8mmzkVAnkrmrn
         OUfEl3Sh7cv7qJDhz1D4faIQ6NWawdGIIiGBcqh+WTOaJQIv4d5pwlU60A9eRJqBlP
         RTf1oyf3earWuM3CE/l0sSFl0Mu9lJlMvflrOjmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.5 15/80] ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
Date:   Tue, 18 Feb 2020 20:54:36 +0100
Message-Id: <20200218190433.549986040@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit fdde0ff8590b4c1c41b3227f5ac4265fccccb96b upstream.

If the platform triggers a spurious SCI even though the status bit
is not set for any GPE when the system is suspended to idle, it will
be treated as a genuine wakeup, so avoid that by checking if any GPEs
are active at all before returning 'true' from acpi_s2idle_wake().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206413
Fixes: 56b991849009 ("PM: sleep: Simplify suspend-to-idle control flow")
Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sleep.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1003,10 +1003,16 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
-		 * If there are no EC events to process, the wakeup is regarded
-		 * as a genuine one.
+		 * If there are no EC events to process and at least one of the
+		 * other enabled GPEs is active, the wakeup is regarded as a
+		 * genuine one.
+		 *
+		 * Note that the checks below must be carried out in this order
+		 * to avoid returning prematurely due to a change of the EC GPE
+		 * status bit from unset to set between the checks with the
+		 * status bits of all the other GPEs unset.
 		 */
-		if (!acpi_ec_dispatch_gpe())
+		if (acpi_any_gpe_status_set() && !acpi_ec_dispatch_gpe())
 			return true;
 
 		/*


