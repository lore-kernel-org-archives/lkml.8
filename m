Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DE0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC1820857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fXqbT8tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgDUGNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:13:07 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF7C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:13:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v18so6014327qvx.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBTmKfCIXzIngtyufdXUhtBs7wtsPlplAmGYEm2d3v0=;
        b=fXqbT8tNzz4SoUsw1oZcdb0sGfCsv1ODvtBztn0qxA3NC43KDEPIWxIvEzpNMmE0Kr
         3YByCbB4nLaYCcJByVAd7VvnJtq53GVNVHVhmkRBkneVZ58Ljzvbt1voaPXDBU5UTvar
         3nqocgmlotR7hx1gr+5GYVI8UQtl9Kjry+7ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBTmKfCIXzIngtyufdXUhtBs7wtsPlplAmGYEm2d3v0=;
        b=dTrnXi28KCrMgcW3zV6TG9r3uhEyKmvPkNAfJi3Wc3GbysLKiUxpPgO9GzCj8IVEdy
         AVVmv1gdSIkjR3fQRGPIFL0yuAANau77DHHBVMcgbeSPRU9H+zcojgz8XEmsgemCkpjl
         2yxL94lA7T51Xm/lTrwjluqBGExIuDF0lqHg7mWiyU4x0RHyZEaaHFrbmDLvw4IurPKl
         MFMLQmzgp67SzxJaaEpjGd3/H3bkJL/NaLqqlMpVbPT1LTEQwzaK1KVgQlXSAM+kdfNc
         YoHpP5c0HrIdzDLE3enp4kZfTzL/G0tvCxu0U8oRxeC9L0Ww2OmvFtdX0T+1kISCJqbu
         BpJw==
X-Gm-Message-State: AGi0PuaVk7WPwv2g/n1HNEbQzHNCUmQSkfF7b2PYfkGa9ILrn2AdeTQj
        q8rtY7dpFiQsl9G7W0zj7ZjAkYO0MtWB5Z0S2eH3DQ==
X-Google-Smtp-Source: APiQypJ1/Zw+DrPrY6ElI32Q3lBy/mBaGEXzNpzZWV5hiyXRpJMue+Et8OJTTHKQqxmILXre9E5E83vqjWKvHeOcycE=
X-Received: by 2002:a0c:e9c5:: with SMTP id q5mr19203866qvo.238.1587449586850;
 Mon, 20 Apr 2020 23:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200421034101.28273-1-yanaijie@huawei.com>
In-Reply-To: <20200421034101.28273-1-yanaijie@huawei.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 21 Apr 2020 11:44:32 +0530
Message-ID: <CA+RiK65vudpB_YEM07ydUACD601n4gC-3VSoYA3mJDATAm6L7g@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpt3sas: use true,false for bool variables
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Chaitra Basappa <chaitra.basappa@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Thanks.



On Tue, Apr 21, 2020 at 9:12 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/scsi/mpt3sas/mpt3sas_base.c:416:6-14: WARNING: Assignment of 0/1
> to bool variable
> drivers/scsi/mpt3sas/mpt3sas_base.c:485:2-10: WARNING: Assignment of 0/1
> to bool variable
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 06285b03fa00..4544ba4bf47d 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -413,7 +413,7 @@ static void _clone_sg_entries(struct MPT3SAS_ADAPTER *ioc,
>  {
>         Mpi2SGESimple32_t *sgel, *sgel_next;
>         u32  sgl_flags, sge_chain_count = 0;
> -       bool is_write = 0;
> +       bool is_write = false;
>         u16 i = 0;
>         void __iomem *buffer_iomem;
>         phys_addr_t buffer_iomem_phys;
> @@ -482,7 +482,7 @@ static void _clone_sg_entries(struct MPT3SAS_ADAPTER *ioc,
>
>         if (le32_to_cpu(sgel->FlagsLength) &
>                         (MPI2_SGE_FLAGS_HOST_TO_IOC << MPI2_SGE_FLAGS_SHIFT))
> -               is_write = 1;
> +               is_write = true;
>
>         for (i = 0; i < MPT_MIN_PHYS_SEGMENTS + ioc->facts.MaxChainDepth; i++) {
>
> --
> 2.21.1
>
