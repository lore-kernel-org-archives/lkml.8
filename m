Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0566C52D5E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888E220801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813168;
	bh=FIgjdj1w7IAWYyZl/p9F1x2kOjAClWaNTPRGjZiUd8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkxUY58B+vmuXzvQjRczJ9FtDJ67ay9+/dwyY9ReqDjSXX7AqEDC8cX/TaSD48J/r
	 eNyo4Jf/pJFKyE1XNyrnnyjsvQOAAELr1pxlhsfSqwyD2f4a7qvJGNxJKD/ui7S/Gw
	 rWATkMMKUQaSTWnqX77dJfko2zI8pdy1zCQI41NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbgB0OT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389985AbgB0OTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:19:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D21720801;
        Thu, 27 Feb 2020 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813151;
        bh=FIgjdj1w7IAWYyZl/p9F1x2kOjAClWaNTPRGjZiUd8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNnpfVXaZyGv9bVgQDBvOjBHClgJNKP4vxaPzoWwzdMguKQfgUeGrXenSHVkphIS7
         9YZltuWeeIE4tbr/uudLWCwWb0fmvMj5bVh73aMcaN51BTCKaK2xJVjMmb/8lYHoAA
         MpjmHAYF9IDsRVQdBvRHR9PICc4RrbCLAJccwvzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH 5.5 150/150] bpf: Selftests build error in sockmap_basic.c
Date:   Thu, 27 Feb 2020 14:38:07 +0100
Message-Id: <20200227132254.402971343@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

commit f2e97dc126b712c0d21219ed0c42710006c1cf52 upstream.

Fix following build error. We could push a tcp.h header into one of the
include paths, but I think its easy enough to simply pull in the three
defines we need here. If we end up using more of tcp.h at some point
we can pull it in later.

/home/john/git/bpf/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: In function ‘connected_socket_v4’:
/home/john/git/bpf/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:20:11: error: ‘TCP_REPAIR_ON’ undeclared (first use in this function)
  repair = TCP_REPAIR_ON;
           ^
/home/john/git/bpf/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:20:11: note: each undeclared identifier is reported only once for each function it appears in
/home/john/git/bpf/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:29:11: error: ‘TCP_REPAIR_OFF_NO_WP’ undeclared (first use in this function)
  repair = TCP_REPAIR_OFF_NO_WP;

Then with fix,

$ ./test_progs -n 44
#44/1 sockmap create_update_free:OK
#44/2 sockhash create_update_free:OK
#44 sockmap_basic:OK

Fixes: 5d3919a953c3c ("selftests/bpf: Test freeing sockmap/sockhash with a socket in it")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/158131347731.21414.12120493483848386652.stgit@john-Precision-5820-Tower
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -3,6 +3,11 @@
 
 #include "test_progs.h"
 
+#define TCP_REPAIR		19	/* TCP sock is under repair right now */
+
+#define TCP_REPAIR_ON		1
+#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
+
 static int connected_socket_v4(void)
 {
 	struct sockaddr_in addr = {


