Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D79AC2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484962087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599584426;
	bh=Jg8BNBodxDZ/GGpfckXL+ebbKwfd4lexIss3kIlGxE0=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=1gQzdRNS1VnTzQ03qzhqPVU9ywYquKthqNz2l6QOM+RDMH3+ZdCN5g6fwdTVyKl9s
	 ArRAKUnIbWuHc0uP7tzQ/yrcA5KA11/2n7Koyz6/ZFbSyT3fP0S8+z+TK+EzMfdV/x
	 XoF8zbmKFignqKrVTih60hag8A4+pAqbdTKnyhVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgIHRAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731855AbgIHRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:00:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D776C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:00:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z13so58923iom.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=zjq4DzIinEMqpDJU3zU+23BVrao+KvP+z5FcMsfqmE0=;
        b=Nb+n3/NHiN9bu4+RIqX6szk1vTvrTcd6sXWpCcI4yqQVb09LahRRNpE/lh2yA6Avel
         Fgh0/FolUbn8iFrRZpAHdVkidweTg7oSm/86i6DPegl1dutiGqgd2Hd1OrIrMts0N8dI
         09huBeg5qq6ZXf3vaMLVHJIjvUUBaeyCNd1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=zjq4DzIinEMqpDJU3zU+23BVrao+KvP+z5FcMsfqmE0=;
        b=udpkB1w/R28gDzmExpmBQq4vzW5NyPfaMQL9sUQnWsWTTIiR8TaMGx1OytVvYn+jRs
         9I/QkYnHKiqc9nlVAfT0OaOsRDQHmml+SiZMD14epQkUzAzogfbXHxD6k7sLvbiZMKFJ
         JJFbXzbNIBabbPcrUhZrK+LI5Uqf3BqmMLM5INFMo3UJb0ftxPPQh/V3Ok4/XQAPK5sB
         XE00aKBTVMYUZGjr96AtWIs7aapPdFwH0Mgi2CJJ2BRUQxzcQncKnYgtsFLvFgGIDpiq
         VPb0eZLleyrI3CiuVxo56EWt2fp0dv8AYT5NVV21P/EO0Pi7prAWzOJ9Q6icLSotwCj/
         Db4g==
X-Gm-Message-State: AOAM531kmOTeNX6oXPUkbi1BeBF1yFPGsyzfsnlcVY/zZTEbNUncBXsB
        4h198v6ER3ybbib5dLEtOC6diJwtuZ8Wpg==
X-Google-Smtp-Source: ABdhPJztZWe5lGNDj0ylu2qS3tuULJ0NRrAt+xkkHGboY3AFX7CH+Cf9DEjPH/a+NB5ZHflRxnee1Q==
X-Received: by 2002:a05:6602:2043:: with SMTP id z3mr20919824iod.93.1599584406537;
        Tue, 08 Sep 2020 10:00:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o12sm5559429ilq.29.2020.09.08.10.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:00:05 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.9-rc5
Message-ID: <12c8266f-de6e-176a-f45b-06b3887f5008@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 11:00:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9D366DBA0A3A14B11E39DC4A"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D366DBA0A3A14B11E39DC4A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.9-rc5.

This kselftest fixes update for Linux 5.9-rc5 consists of a single
fix to timers test to disable timeout setting for tests to run and
report accurate results.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.9-rc5

for you to fetch changes up to 5c1e4f7e9e49b6925b1fb5c507d2c614f3edb292:

   selftests/timers: Turn off timeout setting (2020-08-20 15:49:28 -0600)

----------------------------------------------------------------
linux-kselftest-5.9-rc5

This kselftest fixes update for Linux 5.9-rc5 consists of a single
fix to timers test to disable timeout setting for tests to run and
report accurate results.

----------------------------------------------------------------
Po-Hsu Lin (1):
       selftests/timers: Turn off timeout setting

  tools/testing/selftests/timers/Makefile | 1 +
  tools/testing/selftests/timers/settings | 1 +
  2 files changed, 2 insertions(+)
  create mode 100644 tools/testing/selftests/timers/settings

----------------------------------------------------------------

--------------9D366DBA0A3A14B11E39DC4A
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.9-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.9-rc5.diff"

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 7656c7ce79d9..0e73a16874c4 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 
 TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
 
+TEST_FILES := settings
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/timers/settings
@@ -0,0 +1 @@
+timeout=0

--------------9D366DBA0A3A14B11E39DC4A--
