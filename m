Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C44FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5F92075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gvbMCp6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE1DKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:10:38 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60366 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgE1DKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:10:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XXl12ZsHz9vKlq
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p3Pf4uCmRNjp for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 22:10:37 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XXl10lMFz9vKbW
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:10:37 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XXl10lMFz9vKbW
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XXl10lMFz9vKbW
Received: by mail-io1-f70.google.com with SMTP id l204so3524800ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IHcaKYQFAiNpjDs/H7x5QNmUSskJMpHECApqwdRwTWM=;
        b=gvbMCp6GIqQTfK/GiPhRiAmCDTkrNDaCfn8BnA/o0LRY3Wn260v7b4F4sHZ0kCKO34
         6LAjdtdpWJWEIsivJtWDXm9raSVKWLKACHfTjZSdRb8IfZmUob9sQmmgYumjSTDiA8NL
         zrrYP5xb8+HnxfZo/N8a3JaYeJb9NhH94CZqSMTovLyI+RoNae3riAFD7b+0hGJzvoYU
         ndUvLIhQ5wi+jm6yiqzbdUxjEUFIgj779zul63p1GprJu6KwxlP85Lyq+5g2R6K8EiG4
         ZuypldLfEQxx+2KfTBvGP+IakUO+HYeNXIdOmFVYXgb8LRZZfblBbSpk9lo5/8wP5+Af
         IGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IHcaKYQFAiNpjDs/H7x5QNmUSskJMpHECApqwdRwTWM=;
        b=T9HWkPAUYRyjCoorvscnVi4GCL2wbnFSso4xbEKhjMIpoBZCL/XVXalkiPVKjX/iZk
         y8gJYGhmV13NDXcI3vDgqkz870OJ7A2WZWod0UOs9bMCYv8Z4eM2QVQFKDajIFZEW6Ys
         6/e5kUF7gnKi8Wf5mCsDcVxEbnzzWLykGMJ4W8ld7G2j6GIz/m552n15QzZVrzFLdJf4
         +7N1kNYsydyLG447KyHlzLaM2tYO83PA9VU8LQuqiOHhKLTvGw+YoMfg56kr38HCtfuv
         /xh1eIoe5R5qSUK27rgYUWGYSsjYFTFUMkeLFrbbxWkWomR4CYsgCDWssERQaVe3DWsr
         KsIQ==
X-Gm-Message-State: AOAM530SIptuMiLQa1eRl3AbScHro8kcjeuujxb9HaiB/cJG+/yP/vXt
        DGWl/IKkzX2xoTMug/tUoAEjl6Ped5OFVBS12aSa7or+fhqmLkhdMIlN32fScTNPssepTyGfUPB
        Sx4uOMW8zH9qVnjCJ7oyDw0jBmqnk
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr748543iov.84.1590635436650;
        Wed, 27 May 2020 20:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPEPAGkAoZSYNeSa2XOy08F0GoMu7kvQ4ldrnc4xVMjlUt3rARcZ1w4aU3Bhyak/8uYIsdHw==
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr748526iov.84.1590635436342;
        Wed, 27 May 2020 20:10:36 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id n8sm2008029ioo.2.2020.05.27.20.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 20:10:35 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "sfeldma@cumulusnetworks.com" <sfeldma@cumulusnetworks.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bonding: Fix reference count leak in bond_sysfs_slave_add.
Date:   Wed, 27 May 2020 22:10:29 -0500
Message-Id: <20200528031029.11078-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 07699f9a7c8d ("bonding: add sysfs /slave dir for bond slave devices.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/bonding/bond_sysfs_slave.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 007481557191..9b8346638f69 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -149,8 +149,10 @@ int bond_sysfs_slave_add(struct slave *slave)
 
 	err = kobject_init_and_add(&slave->kobj, &slave_ktype,
 				   &(slave->dev->dev.kobj), "bonding_slave");
-	if (err)
+	if (err) {
+		kobject_put(&slave->kobj);
 		return err;
+	}
 
 	for (a = slave_attrs; *a; ++a) {
 		err = sysfs_create_file(&slave->kobj, &((*a)->attr));
-- 
2.17.1

