Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A63C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1F20DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIGDuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:50:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgIGDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:50:23 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kF8Ae-0005v6-ED
        for linux-kernel@vger.kernel.org; Mon, 07 Sep 2020 03:50:20 +0000
Received: by mail-pg1-f200.google.com with SMTP id 184so5372570pgg.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3g3V+QNt3GCtg2Hc+UJaZtxoWISK1rJHJzXJXHO3wbk=;
        b=nlHyLmmBGSb0SAk+2GvAWTEE+364wfBZawdoDCthZeC7xyo96PdiwtNyEgv7nrq9Gf
         JHMjRnIHoR9xT0+2cynTyRDwY386YbxufdX+PWeJyLEkO4yjrke/4EeV+D5ZGp8jE7kl
         ceKs2TsiTfcLMEikV5g5PG6T1smIqgVlQIfKeFztxWYz/MMb96YMx+GQyciibX1IzZ9f
         5y9WoqutVYkfG/XSTUu2rOqqAqSFsTixRpAFjPs6niwdUXx8Qx4Y9uDQmv5LZUvWHZaL
         H1kjM9cC4oTtTwBHjuEcjiOXCW5yGnFp3CiYicFsB2wS/2j4W4b7bodbT0mncY6jkHXd
         qyRQ==
X-Gm-Message-State: AOAM532FJSCjkkm2N0XmvDEIBzOj2MIwRzx3aJGVKSUvoGV9QHQgWNCl
        KXT/e6ICGd/QHqNrKyqfnmW0qp5qAEkRgNyxJc0hUlbq4GCwGy07enw0ShYw7OYvZmjMsKWv602
        rrZ9sQTtqTmDNsVtgBcpNVq9ypAmJ20StC+luKY9T
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr17326308pfd.59.1599450618942;
        Sun, 06 Sep 2020 20:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiw6zva7WG2JalWfZO5CnnUA49jrjPIHrcrSaL3UTwr1qmqpBYYx79C1OGaVQ4e1GVoN+a1g==
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr17326293pfd.59.1599450618608;
        Sun, 06 Sep 2020 20:50:18 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id e1sm10828706pjv.17.2020.09.06.20.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:50:17 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     po-hsu.lin@canonical.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCHv3] selftests: rtnetlink: load fou module for kci_test_encap_fou() test
Date:   Mon,  7 Sep 2020 11:50:10 +0800
Message-Id: <20200907035010.9154-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
needs the fou module to work. Otherwise it will fail with:

  $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
  RTNETLINK answers: No such file or directory
  Error talking to the kernel

Add the CONFIG_NET_FOU into the config file as well. Which needs at
least to be set as a loadable module.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config       | 1 +
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3b42c06b..c5e50ab 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_NET_FOU=m
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 7c38a90..a711b3e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -520,6 +520,11 @@ kci_test_encap_fou()
 		return $ksft_skip
 	fi
 
+	if ! /sbin/modprobe -q -n fou; then
+		echo "SKIP: module fou is not found"
+		return $ksft_skip
+	fi
+	/sbin/modprobe -q fou
 	ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
 	if [ $? -ne 0 ];then
 		echo "FAIL: can't add fou port 7777, skipping test"
@@ -540,6 +545,7 @@ kci_test_encap_fou()
 		return 1
 	fi
 
+	/sbin/modprobe -q -r fou
 	echo "PASS: fou"
 }
 
-- 
2.7.4

