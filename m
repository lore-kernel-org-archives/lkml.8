Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF082075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICz1DdUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGJUBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:01:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728582AbgGJUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594411289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+C2myllbgYXs+g99CIHc8NDHrLcr23lDtc9CD243bBo=;
        b=ICz1DdUaaR2CFTk90z+/6bHzqTuBdzK84lekcVNSqj1oSOkEw2AxyHszNu7ZyQbihjG8q4
        JKbvN91+l0//ZbHODVQz3rpFHd0v6vC7bm/YlmGeVL1Tdd9xPUNUmb7yI9Do1UESB5wn0j
        QAMVVCSr99fo7zrmRI+5U9dpEmnM+zA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-TeOTyJH9Pk-dLxsJBjChGQ-1; Fri, 10 Jul 2020 16:01:27 -0400
X-MC-Unique: TeOTyJH9Pk-dLxsJBjChGQ-1
Received: by mail-qv1-f69.google.com with SMTP id t12so4421589qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+C2myllbgYXs+g99CIHc8NDHrLcr23lDtc9CD243bBo=;
        b=FEj7DcaSntG0V/F8C2Npv6GswG4JcyCWOt7kU9686R22EnbjTMq/fNLJRUWAc4UA0E
         YhA9okCSA+5CpJI0pFHQcI3r5uOUDH1wS+Q3u0m0ZN3n4SuhOxKbZmCyuc4j5iC7N4N6
         IaAS2i4dAlW1AR7K78KqoEDYJYeZM3qQmFPXdE4tKRABVvQ9Pk1iAz45S9awVMFCL31S
         3LE0ij2/iL4gFKMsBDixy6E8lpnR5Pv3Bm/UiAevR4Fawda/8pymI9AWfHpIgeSn8gMY
         3O2GW06/sheAbqHMc0J79fbFKMLiFAk3MLzKVusd8I9RSZxTR71s+t3C7zWmqNhVmVF3
         H+Jg==
X-Gm-Message-State: AOAM531zPrIUMcIhhsDX53Cr8jdVVe6f22WnB9hVkXmqEGeJSIiQVrLp
        VdsIYYjsWjUInslFSlphvNn19Oc7YKbdLJBnZfpZZ0fPMBsBpBf/CGp8AuXPTf2cLUOGqobAPHM
        8yvQBtcMzkhUQJjjJd/4Db8vj
X-Received: by 2002:a37:a785:: with SMTP id q127mr67258144qke.334.1594411286798;
        Fri, 10 Jul 2020 13:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwklCrfU4uCNNPvT//9/MhCMu829xHS+A0xi5HVdKiVFOgP3sesoeTEoTKpkzNpXzpLZQe67w==
X-Received: by 2002:a37:a785:: with SMTP id q127mr67258119qke.334.1594411286528;
        Fri, 10 Jul 2020 13:01:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c9sm8380430qko.24.2020.07.10.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:01:25 -0700 (PDT)
From:   trix@redhat.com
To:     corbet@lwn.net, jacobhuisman@kernelthusiast.com, robh@kernel.org,
        grandmaster@al2klimov.de, mchehab+huawei@kernel.org,
        konstantin@linuxfoundation.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] docs: process: Add an example for creating a fixes tag
Date:   Fri, 10 Jul 2020 13:01:15 -0700
Message-Id: <20200710200115.21176-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

To make it a little clearer how to create a fixes tag,
add an example based on the preceeding gitconfig setup.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/process/submitting-patches.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index e58b2c541d25..5219bf3cddfc 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -196,6 +196,11 @@ outputting the above style in the ``git log`` or ``git show`` commands::
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
+An example call::
+
+	$ git log -1 --pretty=fixes 54a4f0239f2e
+	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+
 .. _split_changes:
 
 3) Separate your changes
-- 
2.18.1

