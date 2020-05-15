Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46491206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="n+0DB1yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEOP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgEOP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:57:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:57:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g12so3207135wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krFaMC2lrT1K+Syr+4jZzZaXrSNEEbWrNktPCbVpWWo=;
        b=n+0DB1yDdrPo3rONQX55pP3UNCh19cfqvwxzJbGBzQBQG4oSwLqaKdYgFVhrJS0ojP
         nK1Ls+rQumWp1kuyW9ghf3tPuMvN5sVKeZryhy5ksdnf6e1DsoUm863fY9yYk7TNZfBm
         tbwwdTsazS4dOvLQQ/oMBOB+6rF3mFkRn7w8m1pD+kuN+QegIsc4J2MsBMFbj09QyAzV
         MZ0jcChuPjMm5+5nKSWN233VzdEY36sl9mgqAEjUeoyjr7EL1nAk88DWwI1gqgDICwNo
         c7yvxiREo4o0ZlZ8dqzzytIkyJqWLpOdQjiSgPVnYbNlzujvbV29TMisrHuENn/Na2uy
         I4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krFaMC2lrT1K+Syr+4jZzZaXrSNEEbWrNktPCbVpWWo=;
        b=I/bPzCrgX17eyvK1yrloYZIwu1RAjZsDh8cbotYyO4L9P6N6H6jeXhWWpfFVYPajwU
         5lbLUKc413uClCmEav/9IhT/MgCmS93XxzGLwo1pXLqbEUZ6LDwcCTYI51+xapC6Kbho
         SQv+ouiDN5fn+5KsKMfaj6NzEwBY025LABmgdEOSOt5yJp3ZnEFVDQqst1rB0vSd7gcR
         ZYbZPidm5gJ0x5HLy40CX+1tfRdIveBltfMHpKGTaFPRfKaH40b1iLjAKPNQBnXDX59w
         7rAFgOfNyKWAilpiuEBKNj4R1KCRNGE91EwSJOOjNAtBt6joWx0o7oGi1R0S2fcdY+GG
         NhJA==
X-Gm-Message-State: AOAM532Fh2Ami1/VR6rLAc+jCRmdvU00UFPxlZpyU/pf9p9KTidZjUZF
        ECqQHD/OsPD3wp8eWLiaQ0hrWQ==
X-Google-Smtp-Source: ABdhPJzo3onjocej9ABk9/r+VRRJsPU2Cpyk/e6mUFDGMEYA0ncCB8AXxGth8wlFlL1R3sLC2BicBA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4610992wmk.168.1589558218375;
        Fri, 15 May 2020 08:56:58 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id w15sm4006033wmi.35.2020.05.15.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:56:57 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     netdev@vger.kernel.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        mptcp@lists.01.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests:mptcp:pm: rm the right tmp file
Date:   Fri, 15 May 2020 17:54:41 +0200
Message-Id: <20200515155442.1910397-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"$err" is a variable pointing to a temp file. "$out" is not: only used
as a local variable in "check()" and representing the output of a
command line.

Fixes: eedbc685321b (selftests: add PM netlink functional tests)
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 9172746b6cf0..15f4f46ca3a9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -30,7 +30,7 @@ ret=0
 
 cleanup()
 {
-	rm -f $out
+	rm -f $err
 	ip netns del $ns1
 }
 
-- 
2.25.1

