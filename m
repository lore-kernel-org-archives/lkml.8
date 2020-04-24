Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455F42075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmtQyiBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXEx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:53:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgDXEx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587704006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SYlgfxgP8xA9b/qpZI8ocxmaMtZMiVXOlBpcw4zbmWY=;
        b=XmtQyiBxREf/SPUL4FmX7j8fMilyzzblYpdlT4EMUsg1jhSiqGaCjiwtQkZZ9w3Rzib9nu
        YdtHzWKc7R40PR9tBY+t7q9/33qpmsigNp+2slhhLV++878RgG6AX8RT9GuWjb9i5QvOQR
        wA6e37KrLAU3+gP0lmooIp6cU1qP4OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-gEHt2BK4PhOOsngnp6_TgQ-1; Fri, 24 Apr 2020 00:53:23 -0400
X-MC-Unique: gEHt2BK4PhOOsngnp6_TgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F9EB107BEF5;
        Fri, 24 Apr 2020 04:53:22 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D31F0600E8;
        Fri, 24 Apr 2020 04:53:19 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64/mm: Reject invalid NUMA option
Date:   Fri, 24 Apr 2020 14:53:14 +1000
Message-Id: <20200424045314.16017-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA option is parsed by str_has_prefix() and the invalid option
like "numa=3Do" can be regarded as "numa=3Doff" wrongly.

This fixes the issue with sysfs_streq(), which have more sanity checks,
to avoid accepting the invalid options.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/mm/numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4decf1659700..bd458b28616a 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -29,7 +29,8 @@ static __init int numa_parse_early_param(char *opt)
 {
 	if (!opt)
 		return -EINVAL;
-	if (str_has_prefix(opt, "off"))
+
+	if (sysfs_streq(opt, "off"))
 		numa_off =3D true;
=20
 	return 0;
--=20
2.23.0

