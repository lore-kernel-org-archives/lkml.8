Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B4DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479342070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339741;
	bh=2KSZvAr+IyHAjeIc+3VTcq72D6D4Tk/d4gs9sP8MKEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sUJtNIgLfKu+/GJnfgswILvhkpHBZT3QTIYihGSLjdrERENI3HQnR6uQElnRdjL3G
	 LpeiZlAFejFXWU1RTlt3f8MWxIBDyoYIpwiw69DkSe4ksVREqdbRnIRtVvgePnVRwI
	 txMLOKgvcUI17uIn3XAJJuOUtZ4kNk3dFlqSVr1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgBJNCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbgBJMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:38 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E8E20842;
        Mon, 10 Feb 2020 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338437;
        bh=2KSZvAr+IyHAjeIc+3VTcq72D6D4Tk/d4gs9sP8MKEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlLF0PdA9LXbr++l8F8hPFfGgL7rOoeeNo2aR6OaNZRWAM3dR9EKgtwtJ/sb/UyJv
         ovNK3h4G87Pyf7ocJ6xZN0h40/FsNnfADlnOpzy/I5seB1P2MGJ4bR8f60tVSHgCMA
         YKm/Va9GijyRuXEcXccdQvm1rytlUvHq69/44+EM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 5.5 172/367] selftests: bpf: Use a temporary file in test_sockmap
Date:   Mon, 10 Feb 2020 04:31:25 -0800
Message-Id: <20200210122440.744162726@linuxfoundation.org>
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

From: Lorenz Bauer <lmb@cloudflare.com>

commit c31dbb1e41d1857b403f9bf58c87f5898519a0bc upstream.

Use a proper temporary file for sendpage tests. This means that running
the tests doesn't clutter the working directory, and allows running the
test on read-only filesystems.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200124112754.19664-2-lmb@cloudflare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/test_sockmap.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -331,7 +331,7 @@ static int msg_loop_sendpage(int fd, int
 	FILE *file;
 	int i, fp;
 
-	file = fopen(".sendpage_tst.tmp", "w+");
+	file = tmpfile();
 	if (!file) {
 		perror("create file for sendpage");
 		return 1;
@@ -340,13 +340,8 @@ static int msg_loop_sendpage(int fd, int
 		fwrite(&k, sizeof(char), 1, file);
 	fflush(file);
 	fseek(file, 0, SEEK_SET);
-	fclose(file);
 
-	fp = open(".sendpage_tst.tmp", O_RDONLY);
-	if (fp < 0) {
-		perror("reopen file for sendpage");
-		return 1;
-	}
+	fp = fileno(file);
 
 	clock_gettime(CLOCK_MONOTONIC, &s->start);
 	for (i = 0; i < cnt; i++) {
@@ -354,11 +349,11 @@ static int msg_loop_sendpage(int fd, int
 
 		if (!drop && sent < 0) {
 			perror("send loop error");
-			close(fp);
+			fclose(file);
 			return sent;
 		} else if (drop && sent >= 0) {
 			printf("sendpage loop error expected: %i\n", sent);
-			close(fp);
+			fclose(file);
 			return -EIO;
 		}
 
@@ -366,7 +361,7 @@ static int msg_loop_sendpage(int fd, int
 			s->bytes_sent += sent;
 	}
 	clock_gettime(CLOCK_MONOTONIC, &s->end);
-	close(fp);
+	fclose(file);
 	return 0;
 }
 


