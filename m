Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C0C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A3F2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkKVdMsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633096AbgDNU1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:27:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633075AbgDNU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586896003;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=p9TpLNBdviwoTPvCd6HwdAiAsgTDf+tnQwjKV/KP1bE=;
        b=DkKVdMsdxiAQ9C/c2MnruuaA+2uTlks+gNzgTnKKCExRCzoVghSvRS07V9NUXh8KrSO2ci
        ++ySoAi2XjJH3jxtWwxFMqNBKUn2va0Fo5+M0UhkXFSeH30eVDTp/PutGmgZKPLfYp6+ZM
        bLlWj1M0MS1m5D4MUFb91iAeu26HFQQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-o4V66PmxPbGdz1vFjuCGtg-1; Tue, 14 Apr 2020 16:26:40 -0400
X-MC-Unique: o4V66PmxPbGdz1vFjuCGtg-1
Received: by mail-qt1-f198.google.com with SMTP id n89so13575443qte.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=p9TpLNBdviwoTPvCd6HwdAiAsgTDf+tnQwjKV/KP1bE=;
        b=uG1wY1md0LLxecFo55eGWjMpD/FS1xd2ruQ2YnMUdAZepdV0CeXZ69e8Vycm/OSPOQ
         MZ/UPbLXlH1UyDQQoqFRoD33ccFzWqNJpeSTFhW80/3PJ4rp30/0fNChKRn8Xvdb3JeE
         bY7pnCKTFUfd+V2ELFgNq01VzrRVOm2GK8V/T7hYTnDPPPdy5JIiFBTuQNIcb2JtHoiv
         ZmkkJXAJkDFDWd2d1aQOPpyAVDCUVZBPQfpixFGI9Oe3dHrcD8qxwknh+uUTUe8Rky3s
         CnWDOhXOT3WXRvQ2sZIfPWJFveW8RGc9d7Tnbhrp/PyGpK2kCLEMNeoPNqNq1OEnNtRl
         j8Nw==
X-Gm-Message-State: AGi0PubGsiFg21Gjk2vbHMI0S+UGpAyDasYo5y2ucQZEi+a6J+VM8ANb
        SHjs9e2Zm/NHeh7xjkEzVh1cPIrorpLjS8yrRW//+6LR4xfqP5S92kuQT9Tdw/q5UJ8znLvMz0q
        eFo6HaqDscNdjnAofury3CufG
X-Received: by 2002:a37:4d43:: with SMTP id a64mr21132512qkb.55.1586896000163;
        Tue, 14 Apr 2020 13:26:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdpcrABXmZxnkowDDGciffEPiMY56MFLXYSgsbGyO9CrWBD6FPOgLLxiNf1ltOhPEA3yvigQ==
X-Received: by 2002:a37:4d43:: with SMTP id a64mr21132489qkb.55.1586895999934;
        Tue, 14 Apr 2020 13:26:39 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p22sm1630458qte.2.2020.04.14.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:26:39 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:26:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        zhang.jia@linux.alibaba.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200414202637.bsr3yccjq6mpflmp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        zhang.jia@linux.alibaba.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Apr 14 20, Tianjia Zhang wrote:
>For the algorithm that does not match the bank, a positive
>value EINVAL is returned here. I think this is a typo error.
>It is necessary to return an error value.
>
>Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm-interface.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index a438b1206fcb..1621ce818705 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -323,7 +323,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>
> 	for (i = 0; i < chip->nr_allocated_banks; i++) {
> 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
>-			rc = EINVAL;
>+			rc = -EINVAL;
> 			goto out;
> 		}
> 	}
>-- 
>2.17.1
>

