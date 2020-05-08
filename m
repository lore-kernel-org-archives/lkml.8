Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F5C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C512495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942694;
	bh=/pCLZHYr2OmVi2mS3ZUGZ80/NyMpK1+qw2ThEw/BWPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Es/VO4/YMrQuzIFGWh2JTCM0mOlc9f7r7fUr4TchfUwk3hRR34+g3Pud5PvcRK4p6
	 a3Bd4RCe36JLM5VHnqfGUVIF20t9mD2uIP3uSWiMwzEtgELpBBT3n2+jesgq02GsbQ
	 tce0ULcsCAMAjALSL3/hErZTQNF7fbrTT0+bp7JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgEHMys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbgEHMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:54:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF282496A;
        Fri,  8 May 2020 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942483;
        bh=/pCLZHYr2OmVi2mS3ZUGZ80/NyMpK1+qw2ThEw/BWPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv5u1iYUByJZp2gee8o/BTCUGEtEjlH8T74u45eZTQa3GWoH6vqOdW++lMli3jUba
         EHNp8BTeajA96JaOTPSfSCQx4SO1G7TZjbvuhgbgnAIn6p+CguFiFQcVNG4yQpXjlL
         nkrRTh7FEk5hyMXLEl00PZzkCeoJfZsNXQ6jeRcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyler Hicks <tyhicks@linux.microsoft.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 13/49] selftests/ipc: Fix test failure seen after initial test run
Date:   Fri,  8 May 2020 14:35:30 +0200
Message-Id: <20200508123044.904724531@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@linux.microsoft.com>

[ Upstream commit b87080eab4c1377706c113fc9c0157f19ea8fed1 ]

After successfully running the IPC msgque test once, subsequent runs
result in a test failure:

  $ sudo ./run_kselftest.sh
  TAP version 13
  1..1
  # selftests: ipc: msgque
  # Failed to get stats for IPC queue with id 0
  # Failed to dump queue: -22
  # Bail out!
  # # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
  not ok 1 selftests: ipc: msgque # exit=1

The dump_queue() function loops through the possible message queue index
values using calls to msgctl(kern_id, MSG_STAT, ...) where kern_id
represents the index value. The first time the test is ran, the initial
index value of 0 is valid and the test is able to complete. The index
value of 0 is not valid in subsequent test runs and the loop attempts to
try index values of 1, 2, 3, and so on until a valid index value is
found that corresponds to the message queue created earlier in the test.

The msgctl() syscall returns -1 and sets errno to EINVAL when invalid
index values are used. The test failure is caused by incorrectly
comparing errno to -EINVAL when cycling through possible index values.

Fix invalid test failures on subsequent runs of the msgque test by
correctly comparing errno values to a non-negated EINVAL.

Fixes: 3a665531a3b7 ("selftests: IPC message queue copy feature test")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ipc/msgque.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 4c156aeab6b80..5ec4d9e18806c 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -137,7 +137,7 @@ int dump_queue(struct msgque_data *msgque)
 	for (kern_id = 0; kern_id < 256; kern_id++) {
 		ret = msgctl(kern_id, MSG_STAT, &ds);
 		if (ret < 0) {
-			if (errno == -EINVAL)
+			if (errno == EINVAL)
 				continue;
 			printf("Failed to get stats for IPC queue with id %d\n",
 					kern_id);
-- 
2.20.1



