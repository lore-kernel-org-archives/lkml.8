Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D8920814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cvpBD6MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFIGEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:04:21 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:35858 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgFIGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:04:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49h01w2yhxz9vHdJ
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 06:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wnMnS-L_qsDt for <linux-kernel@vger.kernel.org>;
        Tue,  9 Jun 2020 01:04:20 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49h01w1Jnkz9vHdL
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 01:04:20 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49h01w1Jnkz9vHdL
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49h01w1Jnkz9vHdL
Received: by mail-io1-f69.google.com with SMTP id l22so12313108iob.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qp1siVLk0nid8BSzHT63AObSAVlRWQN8KhFQ4rgXWZE=;
        b=cvpBD6MGcwov6zUSlrt8xsxr0/G+EN6CcO2938JEvuL876kUW4h/QOZfrUeryircsF
         A1GQtohroAxh9cv+nN1SjvEAEZ+9C79/EfG+6p7RCtZhsyE3dzmxrC9S8+yrR5JN7ctl
         zoYptSYdiCIg9fWf2RYga+TLqBJu1lo1nD/LfpiFeOBkHbzzvJB59OTpyH+YwPMvM0os
         5RJKDOohWfb6h5BgUnx9QoBentAj0reRTEkwNrzi7co6+JLYDhmgCG1bRP1HjLDPJH4r
         oYY7sxXrj8z8eHsMxe1jbJXKbowoBA+c+peNMtp3lnZToJCsvPHjlOrDrBweONlCeskE
         B2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qp1siVLk0nid8BSzHT63AObSAVlRWQN8KhFQ4rgXWZE=;
        b=sFCXsi3stcBEOWIGwB3dbpA/x++xtU9yXWNX7onv4MVWrjYrT6Y0XYOZhW9m7Ef7oA
         YAlqZ25+Df4CT0wmFbrtvSE+JMoGBtGtroCTvBlxpfoKiikdQzhk6lNRT/R1YxI6DOh9
         AREZkjSfduK9mqCKxLlRD6AUfwXTPyTR13/cS71hhbBAFcCp0Lv+5O2lU0fzxyn04NBN
         Snj/jdL37RTlRBGUS1GOErleMhSU3Egh16vN/UJJ53y9OA9/BfwYLBvxUjpKzHLhAT+a
         rqLPe+/R8qn3SFq4MAxzAp31bhGlYn40p5eCL8Ki/kvEeh7N1dvS1Dn7Xn+jwZa0cxPb
         rCsA==
X-Gm-Message-State: AOAM533p7A4VppKOuD2FUHTlg8QkiMUPLsTJJIab7k2CitjrgIe1ZkCQ
        AVhSG7R8iAQAyqnIkPSSZ8i4LtKxPNnt3UtDTWTzfm3goWZNTihE5G5+y4hIW+PsABDcc77szGG
        XI1PTRlFJ3G/eTq7K8nSNXruDze7G
X-Received: by 2002:a92:cf48:: with SMTP id c8mr5177123ilr.147.1591682659411;
        Mon, 08 Jun 2020 23:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDq11S3HVxoMsWpujNgvBqDksIorgsVe1JbXy5KSCpOa+e7sdI+YU4GkQ0TIZic29C5yJzDw==
X-Received: by 2002:a92:cf48:: with SMTP id c8mr5177100ilr.147.1591682659049;
        Mon, 08 Jun 2020 23:04:19 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id p11sm6967446ioo.26.2020.06.08.23.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:04:18 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Corey Minyard <minyard@acm.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: code cleanup and prevent potential issue.
Date:   Tue,  9 Jun 2020 01:04:10 -0500
Message-Id: <20200609060410.29700-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

All the previous get/put operations against intf->refcount are
inside the mutex. Thus, put the last kref_put() also inside mutex
to make sure get/put functions execute in order and prevent the
potential race condition.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e1b22fe0916c..d34343e34272 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2583,10 +2583,11 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 			*guid =  bmc->guid;
 	}
 
+	kref_put(&intf->refcount, intf_free);
+
 	mutex_unlock(&bmc->dyn_mutex);
 	mutex_unlock(&intf->bmc_reg_mutex);
 
-	kref_put(&intf->refcount, intf_free);
 	return rv;
 }
 
-- 
2.17.1

