Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411ED20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520579;
	bh=UM7I3L47W25YMxxLcbxVxwSxQCi28EC5cb/SVt9U61I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kIcI8ie0jjZdKmyu9nNPd61tG3VvPoBeSpnb/oo3xZeVhc830Zs/S7D2eiDhDLSCh
	 bLZPV8MbWVTuvb6kMnf1ZvPOs/sLKwsN14wAopq/kM3FZPjuc2DE5DQSKZeySSBQ49
	 429gDObhdClcDOPnAyzID8j22Br23ooWceIg2Hvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392286AbgEZTQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391809AbgEZTQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:16:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E96C2053B;
        Tue, 26 May 2020 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520571;
        bh=UM7I3L47W25YMxxLcbxVxwSxQCi28EC5cb/SVt9U61I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hO2nhI3J+Tq3cjkCU/RGjDW5rm+LIK43WOdgve4M47G8ZDU1ImS4e2bM7VX7boOZh
         Q5zbHzvJRP7W6jJ72DN7EGHK6j8+D2MJl0PfsCbpvHbXWsqaqYMzXV2FxIkT/UPXG3
         M1kZ3lQnzjTgUdVq6zp7p7er5oTSgc54xA+QbvNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.6 118/126] s390/kexec_file: fix initrd location for kdump kernel
Date:   Tue, 26 May 2020 20:54:15 +0200
Message-Id: <20200526183947.339223846@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
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
 


