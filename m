Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13908C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3D024125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZBYiAK31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgAWQ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:59:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47005 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgAWQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:59:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so3862467wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8uUo0eaJeKJ0jdbXMjf43VAJdQstWVWgqdI6CSzlSg=;
        b=ZBYiAK31WOO0xPmTOkUDOEZRtghl3RzdtoEptjudCjV2kUxmHW05di8KVWAHgyu0/k
         1c8+KarUAPRv3AsK6adDHyUV2PPufffkYjy3iJkmEWZXLA2oquozbnezzeKzB9fVTCNp
         p0mcdJ74lP9u+fQLEDxTO47ildJS+I5mltKtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8uUo0eaJeKJ0jdbXMjf43VAJdQstWVWgqdI6CSzlSg=;
        b=mUzpJS1XCBCRXyWHda1SqxD0NSztjxqS+7IEqwxXEGoimJXRGPq3MNe1fsomm7nYf8
         UQ4FxdY/qQite3GwfttzoOn8lshV+G8EvjzlcBhmeKOlZ/yQvnDv3Ym2XS4AwfMfR5vI
         nTtBWUor7yzxn+Mr7USCgUuFC8/fyFYTVBrJufoZoy6bOzAOZ8aKlh0+D/39rTKdb6JN
         s0HiSwBVzIs/DlHKxFUIg1dvFlJLNfbKNrJg3V+0P7CMxahmm6VRTetJA+f4tSFZgIHP
         opvJhv+dkNPeeTEsLVlkdvrth7pvl3VOc1abA7EFUVNDbcvdeHe00gsO+DpIXfN9/84C
         DcNQ==
X-Gm-Message-State: APjAAAU/YPZfHT6ZcVLnK2FfTJaSu3eKr7xwnPv22S19Z9BmCmh1+qiD
        LUggPuphgbHeTiDAUQDeeBO5iQ==
X-Google-Smtp-Source: APXvYqztXSSZ2nYGIIOXGCU19AzvGz7ltbdVZS6Ad/z/XL7I6uqOCN+zAkxKcPOoy0Q+UnAyTkUoDA==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr19175902wrw.246.1579798781846;
        Thu, 23 Jan 2020 08:59:41 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:d0a9:6cca:1210:a574])
        by smtp.gmail.com with ESMTPSA id u1sm3217698wmc.5.2020.01.23.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:59:40 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/4] selftests: bpf: use a temporary file in test_sockmap
Date:   Thu, 23 Jan 2020 16:59:30 +0000
Message-Id: <20200123165934.9584-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a proper temporary file for sendpage tests. This means that running
the tests doesn't clutter the working directory, and allows running the
test on read-only filesystems.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4a851513c842..779e11da979c 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -331,7 +331,7 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 	FILE *file;
 	int i, fp;
 
-	file = fopen(".sendpage_tst.tmp", "w+");
+	file = tmpfile();
 	if (!file) {
 		perror("create file for sendpage");
 		return 1;
@@ -340,13 +340,8 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
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
@@ -354,11 +349,11 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 
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
 
@@ -366,7 +361,7 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 			s->bytes_sent += sent;
 	}
 	clock_gettime(CLOCK_MONOTONIC, &s->end);
-	close(fp);
+	fclose(file);
 	return 0;
 }
 
-- 
2.20.1

