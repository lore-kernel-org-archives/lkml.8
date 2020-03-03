Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5A8215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Tfjs5oLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgCCK24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:28:56 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21878 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:28:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B82083F881;
        Tue,  3 Mar 2020 11:28:53 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Tfjs5oLF;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s3blhQnFXu75; Tue,  3 Mar 2020 11:28:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5AF3F3F87B;
        Tue,  3 Mar 2020 11:28:48 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8D824360106;
        Tue,  3 Mar 2020 11:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583231328; bh=d4ZXiMRg8uF7RPcPj29OCuil/iLI6P2uZAb1Jx0dCfg=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=Tfjs5oLFNfSMESYwK4MTjhF0ZC5XKK+jn2UjEhRupIVIe6trMmNomtGfVUm9fiowd
         Yx68aLlwxuT1F1lbN7HuwESsU9FZsM9xko1a36YM5M5kCSRySqiPKr7cy1uXMOaq1h
         mTrypW3NnxirGzVFH+3jcydIfY9vZ5tUlNLmwQaw=
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: Ack to merge through DRM? WAS [PATCH v5 1/9] fs: Constify vma
 argument to vma_is_dax
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200303102247.4635-1-thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <4a49f27b-71a6-0e61-70d9-5fcb6cd58c3f@shipmail.org>
Date:   Tue, 3 Mar 2020 11:28:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200303102247.4635-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander,

Could you ack merging the below patch through a DRM tree?

Thanks,

Thomas Hellstrom


From: Thomas Hellstrom <thellstrom@vmware.com>


The function is used by upcoming vma_is_special_huge() with which we want
to use a const vma argument. Since for vma_is_dax() the vma argument is
only dereferenced for reading, constify it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
include/linux/fs.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..2b38ce5b73ad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3391,7 +3391,7 @@ static inline bool io_is_direct(struct file *filp)
return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
}
-static inline bool vma_is_dax(struct vm_area_struct *vma)
+static inline bool vma_is_dax(const struct vm_area_struct *vma)
{
return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
}

-- 
2.21.1

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel

