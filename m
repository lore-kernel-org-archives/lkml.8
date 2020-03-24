Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED803C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F5820724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyOhGHxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgCXEP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:15:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40773 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgCXEP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585023328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=n4RxvffG/7IgthqLXT54eLe3yEn0o9kSt/husDShtPU=;
        b=NyOhGHxvFwP/nXALD6JAHjAQTshzYRmrZyZqgOHFjjj/9zSbUqSC9twjUB77xDIaPrjG9Z
        W/eWsRkjS0WDRuGrC/2jR/5NC2eCVyfckCJcMTgX/53rEHbDzzEMsu/Ri4DAcgIpJMgzil
        DCmNumqKbnbZ9jY4SQfFCe4cBlBDep8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-V0B4BEPsNgCU0Ga8yp8c_Q-1; Tue, 24 Mar 2020 00:15:23 -0400
X-MC-Unique: V0B4BEPsNgCU0Ga8yp8c_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A1C813F5;
        Tue, 24 Mar 2020 04:15:22 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9135C1B5;
        Tue, 24 Mar 2020 04:15:20 +0000 (UTC)
Date:   Tue, 24 Mar 2020 05:15:26 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] drivers: firmware: psci: avoid BIT() macro usage in
 PSCI_1_0_OS_INITIATED
Message-ID: <20200324041526.GA1978@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BIT() macro is not available in UAPI headers, so let's replace
it with similarly defined _BITUL() macro provided by <linux/const.h>.

Fixes: 60dd1ead65e8 ("drivers: firmware: psci: Announce support for OS initiated suspend mode")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/psci.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 2fcad1d..87afdeb 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -12,6 +12,8 @@
 #ifndef _UAPI_LINUX_PSCI_H
 #define _UAPI_LINUX_PSCI_H
 
+#include <linux/const.h>
+
 /*
  * PSCI v0.1 interface
  *
@@ -100,7 +102,7 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
-#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_OS_INITIATED			_BITUL(0)
 #define PSCI_1_0_SUSPEND_MODE_PC		0
 #define PSCI_1_0_SUSPEND_MODE_OSI		1
 
-- 
2.1.4

