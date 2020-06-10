Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD28C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DDC2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDBaKRt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFJV5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:57:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30932 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgFJV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591826242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VtM0DL68Z0YFosoxESBYhFToC2wio2RnB4Rs6A9Gq0Q=;
        b=PDBaKRt8MdOMk4G8S+3Mi9CmMg7+oSIi122aKidYZ5bQTEUPHqbVhH3h7rQFv7N4rJd9cr
        0kV4echZL8x7c/UPmcnoy0I5jf+0r9ku31vQa8PqCCDFBEQY1cxr4UC7KmYX0QaCrULTZZ
        i8aT51EdnqPpSU2EDejjkYw0k+IXkq8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-OecHuwgCOJe7O2BAfPgw6g-1; Wed, 10 Jun 2020 17:57:21 -0400
X-MC-Unique: OecHuwgCOJe7O2BAfPgw6g-1
Received: by mail-qv1-f70.google.com with SMTP id x16so2902150qvp.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VtM0DL68Z0YFosoxESBYhFToC2wio2RnB4Rs6A9Gq0Q=;
        b=cOaqsQ1hiFFMmBqhVfnQjR8qtQc2pmutfCFt3hg7rRNoGzsqKyWnvar90otxTFHVDA
         bPWmmF1RUOsAoCuW50ZQ/oa7zY4WcpeIEq0+EDwa/PcdJLdKWUjfZzOXIWajW3RArjxs
         Nxz276Ct065jCBopqqRfKFXDbnT8ikC3NdCeQ+dqEZyX9qVXd1llyvTU0C0aOyuEyuLE
         lnm/1h0zvga4xak5TvW/q1zlMVnx+z0ECAj1jW0ecR7NG4NIMSflL15Q6SmLfdosMTlB
         4GjBUixjolTH4LqGVsuRnqq4HN34C6MrAi3VRDRHBZUNMCqsY6PRfYzKtvV8TYPQdlLW
         I6nA==
X-Gm-Message-State: AOAM531z0AArRFXV27ywxKObCNij5qgHhXLIYS6UxdO6vvO2z4LVrV2W
        4UpJnpQqm+XSnuos9TEEpG5aNqZ+PcapRQMxwNU9kevVSqprUkYnZdb0NVePt8WncZ+M77UCGiO
        J7xS4VdsSKGt3qPvT9zEczGlM
X-Received: by 2002:ac8:724c:: with SMTP id l12mr5577980qtp.259.1591826240757;
        Wed, 10 Jun 2020 14:57:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUGaUnW2MRK/CuEdTtnHZ83OpYSRBECQomqVsEp7ut6CzN65E6n+gKJs8MBh4jIgj4Z8QUqw==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr5577972qtp.259.1591826240578;
        Wed, 10 Jun 2020 14:57:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t13sm934883qtc.77.2020.06.10.14.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:57:19 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 14:57:12 -0700
Message-Id: <20200610215713.5319-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200610

Running clang scan-view over linux-next uncovers many problem only a
few are memory related, this one looked like the most serious.

Changes from v1

Fix call to kfree
-		kfree(names);
+		kfree(*names);


Tom Rix (1):
  selinux: fix double free

 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.18.1

