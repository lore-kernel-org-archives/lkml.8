Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA2C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D5520675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF3HkiCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgEKTGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:06:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731246AbgEKTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589223996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqf/KDuLojDbfB1GjtcgpUnIV6apc16crSMVbd9O8A4=;
        b=hF3HkiCxEokQvbcfLJFHOnWB065PxvenqNv4KUTlHwLFXk7zj2jbh0Q8MejIyZ7uWE5JkW
        rN1Ww5mIJEx543IDDhZ/EYSA/5IW5ksRkUNU8yiEI/q0fOUeGMSi70pdJXUAhIIwGaL4zc
        ng1d9emnZ9NVhTmBOVeoFvVpHKAllz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Ee0psfbIP7-P37Lvb-TSBw-1; Mon, 11 May 2020 15:06:34 -0400
X-MC-Unique: Ee0psfbIP7-P37Lvb-TSBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F6F8005AD;
        Mon, 11 May 2020 19:06:33 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3A539CB9;
        Mon, 11 May 2020 19:06:32 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] intel-speed-select: Fix json perf-profile output output
Date:   Mon, 11 May 2020 15:06:28 -0400
Message-Id: <20200511190628.25661-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'intel-speed-select -f json perf-profile get-lock-status' command
outputs the package, die, and cpu data as separate fields.

ex)

  "package-0": {
    "die-0": {
      "cpu-0": {

Commit 74062363f855 ("tools/power/x86/intel-speed-select: Avoid duplicate Package strings for json") prettied this output so that it is a single line for
some json output commands and the same should be done for other commands.

Output package, die, and cpu info in a single line when using json output.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 .../x86/intel-speed-select/isst-display.c     | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index f6e2ce181123..e105fece47b6 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -316,21 +316,31 @@ void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
 {
 	char header[256];
 	char value[256];
+	int level = 1;
+
+	if (out_format_is_json()) {
+		snprintf(header, sizeof(header), "package-%d:die-%d:cpu-%d",
+			 get_physical_package_id(cpu), get_physical_die_id(cpu),
+			 cpu);
+		format_and_print(outf, level++, header, NULL);
+	} else {
+		snprintf(header, sizeof(header), "package-%d",
+			 get_physical_package_id(cpu));
+		format_and_print(outf, level++, header, NULL);
+		snprintf(header, sizeof(header), "die-%d",
+			 get_physical_die_id(cpu));
+		format_and_print(outf, level++, header, NULL);
+		snprintf(header, sizeof(header), "cpu-%d", cpu);
+		format_and_print(outf, level++, header, NULL);
+	}
 
-	snprintf(header, sizeof(header), "package-%d",
-		 get_physical_package_id(cpu));
-	format_and_print(outf, 1, header, NULL);
-	snprintf(header, sizeof(header), "die-%d", get_physical_die_id(cpu));
-	format_and_print(outf, 2, header, NULL);
-	snprintf(header, sizeof(header), "cpu-%d", cpu);
-	format_and_print(outf, 3, header, NULL);
 	if (str0 && !val)
 		snprintf(value, sizeof(value), "%s", str0);
 	else if (str1 && val)
 		snprintf(value, sizeof(value), "%s", str1);
 	else
 		snprintf(value, sizeof(value), "%u", val);
-	format_and_print(outf, 4, prefix, value);
+	format_and_print(outf, level, prefix, value);
 
 	format_and_print(outf, 1, NULL, NULL);
 }
-- 
2.18.4

