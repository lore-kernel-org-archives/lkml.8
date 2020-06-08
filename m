Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E529BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45602074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662033;
	bh=MbeZa4VffzmxWAR8MGy0BeRxIsWisBaIT8gBRIYAzuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsX8K+6pumngetEZ8/pt8IvWBMcGyXRi+xAtZT3L7I/q2E7YiWhomeEAs2e5raLUt
	 /uOpuuUt9zzE1yae6wsOn/FnB2aDPK0v6y8+6ixC0EU05EZJ0mW09YqmWoWwYet+Cf
	 1qUgLDr3QLA6SjckT401fS87YicgSbpl8+wkq4/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgFIAUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgFHXSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F5820884;
        Mon,  8 Jun 2020 23:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658282;
        bh=MbeZa4VffzmxWAR8MGy0BeRxIsWisBaIT8gBRIYAzuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GM8gBrklaLdDsH8u/vDjqO+Hdhp5D0szsTKUEQe074BCpTKqS+fDmUisNDMmKaPgj
         Y0SBoi8SHQvyjEKFRZUrSW/8giPniVq6o7o9Wgqi7Drf3M/W7Kyk15BulXRDOf6X0x
         q2avOR84LirNHwfwj3SbJzTbS4ple69R3NfVlZR0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 287/606] samples: bpf: Fix build error
Date:   Mon,  8 Jun 2020 19:06:52 -0400
Message-Id: <20200608231211.3363633-287-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 23ad04669f81f958e9a4121b0266228d2eb3c357 ]

GCC 10 is very strict about symbol clash, and lwt_len_hist_user contains
a symbol which clashes with libbpf:

/usr/bin/ld: samples/bpf/lwt_len_hist_user.o:(.bss+0x0): multiple definition of `bpf_log_buf'; samples/bpf/bpf_load.o:(.bss+0x8c0): first defined here
collect2: error: ld returned 1 exit status

bpf_log_buf here seems to be a leftover, so removing it.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200511113234.80722-1-mcroce@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/lwt_len_hist_user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/lwt_len_hist_user.c b/samples/bpf/lwt_len_hist_user.c
index 587b68b1f8dd..430a4b7e353e 100644
--- a/samples/bpf/lwt_len_hist_user.c
+++ b/samples/bpf/lwt_len_hist_user.c
@@ -15,8 +15,6 @@
 #define MAX_INDEX 64
 #define MAX_STARS 38
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
 static void stars(char *str, long val, long max, int width)
 {
 	int i;
-- 
2.25.1

