Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA17DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68E821473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv6jHtpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDTOLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:11:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbgDTOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587391868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=juxlCNjhUGoVaucv5IlBSUfH1PKTujMrazy+xkLY5Ag=;
        b=Dv6jHtpFdhiY5QpWmY6aItPw5LncJXyQa/Grcl7G+vEL/GFD0tjjkNQrvLI7OndIsnKrqk
        XAsmgxdLY15CuEcF8aIotISp/hTi9pzBOISiTm7GYsyWOVisifldn+Y+cGXIMoJpsqRqii
        3GMknkxPfmp+0ZdX7ged/z6WzgGF5To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-KcCg_TM8PDOH2bqnDHoZDg-1; Mon, 20 Apr 2020 10:11:06 -0400
X-MC-Unique: KcCg_TM8PDOH2bqnDHoZDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65089801A07;
        Mon, 20 Apr 2020 14:11:05 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B4B0129FA2;
        Mon, 20 Apr 2020 14:11:02 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] intel-speed-select: Fix speed-select-base-freq-properties output on CLX-N
Date:   Mon, 20 Apr 2020 10:10:54 -0400
Message-Id: <20200420141054.26173-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CLX-N, the perf-profile-level's output is terminated before the
speed-select-base-freq-properties are output which results in a corrupt
json file.

Adjust the output of speed-select-base-freq-properties by one on CLX-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/po=
wer/x86/intel-speed-select/isst-display.c
index 51dbaa5f02ec..f6e2ce181123 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -470,7 +470,7 @@ void isst_ctdp_display_information(int cpu, FILE *out=
f, int tdp_level,
 				_isst_pbf_display_information(cpu, outf,
 							      tdp_level,
 							  &ctdp_level->pbf_info,
-							      level + 1);
+							      level + 2);
 			continue;
 		}
=20
--=20
2.18.2

