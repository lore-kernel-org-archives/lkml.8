Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336F2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36F42070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339744;
	bh=3s5tlKd8Snhp+dVdyUVfC6ozogRCiz+RFyrMWOQVRdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDWMJjfoy9QGq0HI6iKVTehB6Tyk3jBc7yxRhopOmlUI1urj4jltZ0du5GYPjdWYM
	 jpFGl/ql+nkAuPkX9WxcPfcspP0x5fcTsc8Id+xUOcxEJPhZ/wakzkdl94du/bRZ37
	 8w6EOsgpkO/W9jGlWr6i4z3kpCWxtf4f/9mhQwns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgBJNCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbgBJMkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:36 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5144620873;
        Mon, 10 Feb 2020 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338436;
        bh=3s5tlKd8Snhp+dVdyUVfC6ozogRCiz+RFyrMWOQVRdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnbJy+8PCTgJYyLfY8oM1dht3a8HwzA3W0+ExbHXscrJ793nhKePMVgWKA/6Uh8Eb
         lL8Bx1+uxZC+0frGrP9FH3rGD6M0k9LGlDVy1WfNntZrrkW+ky7bdz8kW2gXbzB1s0
         +RN4yjWZ1JB0wTLEL9yeCRU4BIXeh8BU1TXo5BRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5.5 170/367] selftests/bpf: Fix test_attach_probe
Date:   Mon, 10 Feb 2020 04:31:23 -0800
Message-Id: <20200210122440.573633852@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

commit 580205dd4fe800b1e95be8b6df9e2991f975a8ad upstream.

Fix two issues in test_attach_probe:

1. it was not able to parse /proc/self/maps beyond the first line,
   since %s means parse string until white space.
2. offset has to be accounted for otherwise uprobed address is incorrect.

Fixes: 1e8611bbdfc9 ("selftests/bpf: add kprobe/uprobe selftests")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20191219020442.1922617-1-ast@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -20,7 +20,7 @@ extern char NAME##_data[];						    \
 extern int NAME##_size;
 
 ssize_t get_base_addr() {
-	size_t start;
+	size_t start, offset;
 	char buf[256];
 	FILE *f;
 
@@ -28,10 +28,11 @@ ssize_t get_base_addr() {
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%*x %s %*s\n", &start, buf) == 2) {
+	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
+		      &start, buf, &offset) == 3) {
 		if (strcmp(buf, "r-xp") == 0) {
 			fclose(f);
-			return start;
+			return start - offset;
 		}
 	}
 


