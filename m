Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E625E208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520216;
	bh=UM7I3L47W25YMxxLcbxVxwSxQCi28EC5cb/SVt9U61I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DACtMDa9+1mSk5nWcfRSXv7LYKnkVws9+GoFMnh3l8Vw/QelD972pEaW7TYoCy4Ox
	 lxW6mrZQnGD5WNhFi/tfRyskbZVS+uNPlNM5S6qVoUI38svG4zAIWbOao0Mp6+f7N4
	 f500VD2FCvYa1vzFzqBdpN6SQp4LZTz9t0wx9VZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbgEZTKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391534AbgEZTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:10:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633B820873;
        Tue, 26 May 2020 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520204;
        bh=UM7I3L47W25YMxxLcbxVxwSxQCi28EC5cb/SVt9U61I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJsgAcyAcnaLvd7PB4SAmbhfh8/s1eH5n+QnVGsRVeg9zFGq39tMyMMEo3vrxhCYg
         qOhPgFUJfye+ozMErGpOj3lF4j9sszuXQXeeMEiceyqroay2xJNO8NvG+Y0C/8hw4J
         DQyKv3bsppkEmdxBNyf1Jf2wMMR9G+ui78rI3wu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.4 099/111] s390/kexec_file: fix initrd location for kdump kernel
Date:   Tue, 26 May 2020 20:53:57 +0200
Message-Id: <20200526183942.279942703@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

commit 70b690547d5ea1a3d135a4cc39cd1e08246d0c3a upstream.

initrd_start must not point at the location the initrd is loaded into
the crashkernel memory but at the location it will be after the
crashkernel memory is swapped with the memory at 0.

Fixes: ee337f5469fd ("s390/kexec_file: Add crash support to image loader")
Reported-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Tested-by: Lianbo Jiang <lijiang@redhat.com>
Link: https://lore.kernel.org/r/20200512193956.15ae3f23@laptop2-ibm.local
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/machine_kexec_file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct
 		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
-	data->parm->initrd_start = buf.mem;
+	data->parm->initrd_start = data->memsz;
 	data->parm->initrd_size = buf.memsz;
 	data->memsz += buf.memsz;
 


