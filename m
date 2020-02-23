Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DDCC35675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343F520880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9fa1iSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBWTZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:25:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727158AbgBWTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582485930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UU+BZ7vU0vNDbayPRMPpX1ixOqnikP7N9LBd4qlvCto=;
        b=J9fa1iSSexq4fp6Im+CI0P3qIra6ecVrwwNWAKAuvNkLpJTSKN3kdGjXCAufrePjilpqLt
        bbYy3alUe7kO/O82o+8hGIUuMYGdoioR0K+QOGlPNiWakWIvLvofd9Yz1/5sQfIAOUUhXb
        oVIlWqbFhJHGDQpFtKcr/Cw45ctLwYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-UwRa0Mr-NV2TRQOgVtHpPw-1; Sun, 23 Feb 2020 14:25:25 -0500
X-MC-Unique: UwRa0Mr-NV2TRQOgVtHpPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F85E184B121;
        Sun, 23 Feb 2020 19:25:24 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A42F60BF1;
        Sun, 23 Feb 2020 19:25:21 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: [PATCH 2/3] arm64: select CPUMASK_OFFSTACK if NUMA
Date:   Sun, 23 Feb 2020 14:25:19 -0500
Message-Id: <20200223192520.20808-3-aarcange@redhat.com>
In-Reply-To: <20200223192520.20808-1-aarcange@redhat.com>
References: <20200223192520.20808-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear why normally CPUMASK_OFFSTACK can only be manually
configured "if DEBUG_PER_CPU_MAPS" which is not an option meant to be
enabled on enterprise arm64 kernels.

The default enterprise kernels NR_CPUS is 4096 which is fairly large.
So it'll save some RAM and it'll increase reliability to select
CPUMASK_OFFSET at least when NUMA is selected and a large NR_CPUS is
to be expected.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..882887e65394 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -955,6 +955,7 @@ config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
 	select ACPI_NUMA if ACPI
 	select OF_NUMA
+	select CPUMASK_OFFSTACK
 	help
 	  Enable NUMA (Non Uniform Memory Access) support.
=20

