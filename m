Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0748C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C08A206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/7vx6X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEMD2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 23:28:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728488AbgEMD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 23:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589340530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRE4OFt0pi4qgIPXxiCcH4eekt5X7YxGUJZCZ70unDk=;
        b=F/7vx6X4NbxbD1qDnuwOhKHkLWpaJS1Wm50XBu8nyyIPs3Mlj3kmWtZAY8fyWKhir0un2f
        dprbl1Z0gUDqvnjWTsz/sGX/QlWd7wZNfOmgnTYQG3PoWqGUgkrBtV4XZ89bo0oDbNBaUi
        FzwXpSrFbCgarjTOisYLfs0AMuVUJ2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-71V8pT9QO0-rrJCT8ULhcg-1; Tue, 12 May 2020 23:28:48 -0400
X-MC-Unique: 71V8pT9QO0-rrJCT8ULhcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 003F71841932;
        Wed, 13 May 2020 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7685D9DD;
        Wed, 13 May 2020 03:28:40 +0000 (UTC)
Subject: Re: s390x: kdump kernel can not boot if I load kernel and initrd
 images via the kexec_file_load syscall.
To:     Philipp Rudo <prudo@linux.ibm.com>
Cc:     Dave Young <dyoung@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4d7ff4bb-f09e-7aec-964f-f5cc2412e5b7@redhat.com>
 <20200511111558.2d3e3db3@laptop2-ibm.local>
 <20200511170146.28eaafed@laptop2-ibm.local>
 <19903f1e-b3ae-730e-8a02-ed30fb47e9ba@redhat.com>
 <559a3c8f-9da9-a64d-aa78-434365c4b271@redhat.com>
 <79241fab-3299-1ba3-1c2b-a29eb4e0af7c@redhat.com>
 <20200512193956.15ae3f23@laptop2-ibm.local>
From:   lijiang <lijiang@redhat.com>
Message-ID: <426212ae-7687-87df-2275-f26ffd16fc8e@redhat.com>
Date:   Wed, 13 May 2020 11:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200512193956.15ae3f23@laptop2-ibm.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年05月13日 01:39, Philipp Rudo 写道:
> Hi Lianbo,
> 
> stupid me obviously never tested the kdump+initrd combination...
> 
> The patch below fixed the problem for me. Could please give it a try, too.
> 

Thank you for the patch, Philipp. Kdump kernel can boot on s390x machine with this patch.

> Thanks
> Philipp
> 
> ---
> 
> From 3f77088c9139582261d2e3ee6476324fc1ded401 Mon Sep 17 00:00:00 2001
> From: Philipp Rudo <prudo@linux.ibm.com>
> Date: Tue, 12 May 2020 19:25:14 +0200
> Subject: [PATCH] s390/kexec_file: fix initrd location for kdump kernel
> 
> initrd_start must not point at the location the initrd is loaded into
> the crashkernel memory but at the location it will be after the
> crashkernel memory is swapped with the memory at 0.
> 
> Fixes: ee337f5469fd ("s390/kexec_file: Add crash support to image loader")
> Reported-by: Lianbo Jiang <lijiang@redhat.com>
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8415ae7d2a23..f9e4baa64b67 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct kimage *image,
>  		buf.mem += crashk_res.start;
>  	buf.memsz = buf.bufsz;
>  
> -	data->parm->initrd_start = buf.mem;
> +	data->parm->initrd_start = data->memsz;

Good findings.

>  	data->parm->initrd_size = buf.memsz;
>  	data->memsz += buf.memsz;
>  
> 

Tested-by: Lianbo Jiang <lijiang@redhat.com>

Thanks.
Lianbo

