Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466AA206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099505;
	bh=SuW/bMeNfeTOi8oPIOlRFwzT/BVrAzPDe9cMItAubWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxMU8RgiM/gQGX3Mh/htD5QsmH2nDf3wIRIJMzeHrjrYPyCIR+9XTvPGCQo/LEdY0
	 fLcAsps/+mZWV0Z5SHS1LmjFvnO9ZEjpjQ+k4xze15nCFsewx+Z/v3R92BezJd6aFr
	 uVZWkrqhrTYnAqXRq8xPQOFwua9EQYLNiNxFss3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgD1SpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbgD1SpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:45:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7BF206D6;
        Tue, 28 Apr 2020 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099501;
        bh=SuW/bMeNfeTOi8oPIOlRFwzT/BVrAzPDe9cMItAubWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18KlJNNyF30/B9rtD4+3J82Xiw1i107tiiFGuKxZBfqMLBhFH/f8bNRmmnm2XO6Q4
         ej2etiCCOOhmuAer8sArzv1nvOwbiyOPZ2FS0CDgYeetql9+bbg8rLrnt6+E2NOi+X
         tWp5eOfUzrSo1tP9JNbmrhaMdYjrPYgSwoGCTsKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.4 137/168] staging: comedi: Fix comedi_device refcnt leak in comedi_open
Date:   Tue, 28 Apr 2020 20:25:11 +0200
Message-Id: <20200428182249.191390018@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 332e0e17ad49e084b7db670ef43b5eb59abd9e34 upstream.

comedi_open() invokes comedi_dev_get_from_minor(), which returns a
reference of the COMEDI device to "dev" with increased refcount.

When comedi_open() returns, "dev" becomes invalid, so the refcount
should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
comedi_open(). When "cfp" allocation is failed, the refcnt increased by
comedi_dev_get_from_minor() is not decreased, causing a refcnt leak.

Fix this issue by calling comedi_dev_put() on this error path when "cfp"
allocation is failed.

Fixes: 20f083c07565 ("staging: comedi: prepare support for per-file read and write subdevices")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/1587361459-83622-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/comedi_fops.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2725,8 +2725,10 @@ static int comedi_open(struct inode *ino
 	}
 
 	cfp = kzalloc(sizeof(*cfp), GFP_KERNEL);
-	if (!cfp)
+	if (!cfp) {
+		comedi_dev_put(dev);
 		return -ENOMEM;
+	}
 
 	cfp->dev = dev;
 


