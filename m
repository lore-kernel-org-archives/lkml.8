Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD71FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A11820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEOMjOJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBCVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:22:21 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:40471 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:22:21 -0500
Received: by mail-qt1-f201.google.com with SMTP id e37so10903029qtk.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dIcgoknJRV2xvDzVGBwxmNoSCRUFhrMkWDv+f+nsEKk=;
        b=iEOMjOJXdHuEfLB1vNdA8MV5ITFgbImLjQ27HHaP+arX5Of+fVrR86W67FhfMctrQh
         KO8BJbUXpEm4m2HF33GhVRsVUGZHWsmV9KL6EHRj3eDiZeSM2L4dioUjnngvsNuth8Ut
         9gQ80srvPKZ6iAlCVDG8pkoF0L+HkEBEs5Uqfis+eyBvE+PooIFZlCQF5EXg0WCVwP6q
         u67RpDXPKEvHVvZJeEpudPHwXIJaroogdQWUeV9imt1Jwr0YdIdzcEFgAOvNhv/Bdipq
         uo9OXH8x2NAHHfbuVAOERxe4Kwrvp59yjiMzYr4XkxWJssCSJZFVB8KBNSDQN2+215eC
         Tamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dIcgoknJRV2xvDzVGBwxmNoSCRUFhrMkWDv+f+nsEKk=;
        b=OJKSlYM5XV2CqW6OUkvbmFL6PHHD2Gw0Hzwwz2pPH7JntNOjLZuknUxQz/uTKzXpTv
         5smvRxaPl4rf6udfR7dj/0GWBQze+wHVM3tayFc5KMLxulk6GQ07TOjlrQ9ge5Yd6V4T
         f8TaTTtpnGinUJ9m+qWmxsAaqK+yfS5jGeTLdlOXXIBJYBwye8QEvU0BmSxtDNpfdTHu
         o0C21wGQ7POPbuGtAZKlCfPFB9eRVgdFszBHdqW0TfEtfbd5Bzw1PSbvx6zL8K+ZjY8c
         xIyUr9fM7eW+w9T0dTtweOSJ52DKUmW482G/WJ/80Jz1d4AdBPS394m9YTSOu1z16Lt5
         oTug==
X-Gm-Message-State: APjAAAU0DquAkQ4XnEe3A6/66qI6XnY0x+XrA+zARiedREEnE7l1KLdP
        m0c0kol6uBn4cEAGf+E6bTIqb+S6qAY=
X-Google-Smtp-Source: APXvYqxsv5BuPak22kIWOvDp7Np5+XpAKhf0D8xk6cww+xO6CIw2HNp4zsS73Ly/4Q/Ln0bXW8oUqwLbwmo=
X-Received: by 2002:ac8:6bd9:: with SMTP id b25mr25583707qtt.347.1580764940186;
 Mon, 03 Feb 2020 13:22:20 -0800 (PST)
Date:   Mon,  3 Feb 2020 13:22:16 -0800
Message-Id: <20200203212216.7076-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] psi: Fix OOB write when writing 0 bytes to psi files
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issuing write() with count parameter set to 0 on any file under
/proc/pressure/ will cause an OOB write because of the access to
buf[buf_size-1] when NUL-termination is performed. Fix this by checking
for buf_size to be non-zero.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index db7b50bba3f1..38ccd49b9bf6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1199,6 +1199,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+	if (!nbytes)
+		return -EINVAL;
+
 	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
-- 
2.25.0.341.g760bfbb309-goog

