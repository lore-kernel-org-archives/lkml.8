Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCC207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258977;
	bh=fJ8NNjH3ZkCW8nghxtzb5HVti5kIN+YwOf4V+x2XJF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkLljajRB/UGoHlTGDzUGJOsWvrwxNw1qwIKigkeuhVBm8txR07wbDEbaEau8qHJr
	 beXneQXU9/7Ko/6Y1+EeLYPPMFUmDOx6P8uzlyF1V/ARnGKd6JWYeKaUcuPtXdNeJO
	 9o0lTGgW96/D+fqse+w/blDqP3FnF/fVSdQS5jk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHXItf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgHXIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6AD2074D;
        Mon, 24 Aug 2020 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258966;
        bh=fJ8NNjH3ZkCW8nghxtzb5HVti5kIN+YwOf4V+x2XJF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCpS4JM7IegswO2TLHHOpJzuWTGk0+2J7hf4E4vVlv7VPaWnj1ipktORiNEhnAiNE
         2xoo0wCxCGcOj4tNcOqe7LNNqBJn8Gct2HvzkllI+ysvEB+HeotQqIXAWuS7kZ7c2R
         B6fXr2teN3KuhLz/WZ9reADAlmjEKmtYGUvsx7Ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Li Heng <liheng40@huawei.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.4 103/107] efi: add missed destroy_workqueue when efisubsys_init fails
Date:   Mon, 24 Aug 2020 10:31:09 +0200
Message-Id: <20200824082410.193518492@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Heng <liheng40@huawei.com>

commit 98086df8b70c06234a8f4290c46064e44dafa0ed upstream.

destroy_workqueue() should be called to destroy efi_rts_wq
when efisubsys_init() init resources fails.

Cc: <stable@vger.kernel.org>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
Link: https://lore.kernel.org/r/1595229738-10087-1-git-send-email-liheng40@huawei.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/efi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -345,6 +345,7 @@ static int __init efisubsys_init(void)
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
 		pr_err("efi: Firmware registration failed.\n");
+		destroy_workqueue(efi_rts_wq);
 		return -ENOMEM;
 	}
 
@@ -381,6 +382,7 @@ err_unregister:
 	generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
+	destroy_workqueue(efi_rts_wq);
 	return error;
 }
 


