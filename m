Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73627C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C74F20675
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7PHly2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgFSDmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:42:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45894 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729164AbgFSDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592538167;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=28QQhWqRGlKtVSPRIgoEL6SC7gfBRze3wXuD/kfRWpU=;
        b=Y7PHly2rEowpVxpZvXJrPPYJTtdl0EEhO9EhuO0gki3fTiNgmJvoAtO5LdPqkx3+rkmniF
        By/xc98hbLt7wG+KhSyus19Tc0Y3/E227ycjN8s5kBmpFnxxhof0Idbk1aXoTCpwx1XjXM
        nbB0ofnrp1eJVE1swRyD4PgUNvPctZ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-gr8hrb4oNYOYGcI1GeGtGw-1; Thu, 18 Jun 2020 23:42:43 -0400
X-MC-Unique: gr8hrb4oNYOYGcI1GeGtGw-1
Received: by mail-qt1-f199.google.com with SMTP id q21so6073478qtn.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=28QQhWqRGlKtVSPRIgoEL6SC7gfBRze3wXuD/kfRWpU=;
        b=tPjWc+iYF1//U7/E3I9BszWXGs4TZJh+9qV6LmMnaX7MSqq14c3i7UU5F9U6e+V4Au
         gwHmVBM4sZuc9mmNTX9gKtAJy0Fc0qMqLu+RDJ8WANiYroIW1B7UpJnR/Xe5Zy9cke1g
         BCdJayI+6qkYeFvvYq14CCFjX60sZ95by0PDQRBJsJE7UdTEGxbPiT4x9ECNEkpmBYgt
         9KD0zeZi5xjxTIMS1EVN2opPip9WVt0mKsLwppKajephf517jXqOQyXEzhU0/JQyQ5Rq
         85uQ8Sa7Gzp4O3rLuV+dvOYqCisCgKl9Tvhhgg40QGgKrUhijuZwgG7iZMz0WU2/ufz9
         jRNg==
X-Gm-Message-State: AOAM532sUGRuzVVa9ZMqKKYevBBl8YX86Cg/bIGn4W+V1xaOszrOudwu
        BjumZJsP/y27SZ3AN42BKyo6MFYeyOeVfkTONfsfg9AAOMT83gbJVWB/0KhfG9qnaRC3jB0s04u
        mejA83MIZX0nI23PFRl99DlQf
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr1701670qkk.120.1592538163402;
        Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEdCt+tIxvWhB4ftv3tYaBoyyRuWID8OfhggBjQxCeKOfezWy9w7oOYhRS+zMVygilIx2xyg==
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr1701654qkk.120.1592538163097;
        Thu, 18 Jun 2020 20:42:43 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id o144sm5112725qke.126.2020.06.18.20.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:42:42 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:42:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     jarkko.sakkinen@linux.intel.com, stefanb@linux.ibm.com,
        mpe@ellerman.id.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
Message-ID: <20200619034240.xcl56oboxurym4jm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        jarkko.sakkinen@linux.intel.com, stefanb@linux.ibm.com,
        mpe@ellerman.id.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200619033040.121412-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619033040.121412-1-david@gibson.dropbear.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 19 20, David Gibson wrote:
>The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
>which will need the use of the internal command/response buffer.  But,
>we're issuing this *before* we've waited to make sure that buffer is
>allocated.
>
>This can result in intermittent failures to probe if the hypervisor / TPM
>implementation doesn't respond quickly enough.  I find it fails almost
>every time with an 8 vcpu guest under KVM with software emulated TPM.
>
>To fix it, just move the tpm2_get_cc_attrs_tlb() call after the
>existing code to wait for initialization, which will ensure the buffer
>is allocated.
>
>Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
>Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>
>Changes from v1:
> * Fixed a formatting error in the commit message
> * Added some more detail to the commit message
>
>drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
>index 09fe45246b8cc..994385bf37c0c 100644
>--- a/drivers/char/tpm/tpm_ibmvtpm.c
>+++ b/drivers/char/tpm/tpm_ibmvtpm.c
>@@ -683,13 +683,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
> 	if (rc)
> 		goto init_irq_cleanup;
>
>-	if (!strcmp(id->compat, "IBM,vtpm20")) {
>-		chip->flags |= TPM_CHIP_FLAG_TPM2;
>-		rc = tpm2_get_cc_attrs_tbl(chip);
>-		if (rc)
>-			goto init_irq_cleanup;
>-	}
>-
> 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
> 				ibmvtpm->rtce_buf != NULL,
> 				HZ)) {
>@@ -697,6 +690,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
> 		goto init_irq_cleanup;
> 	}
>
>+	if (!strcmp(id->compat, "IBM,vtpm20")) {
>+		chip->flags |= TPM_CHIP_FLAG_TPM2;
>+		rc = tpm2_get_cc_attrs_tbl(chip);
>+		if (rc)
>+			goto init_irq_cleanup;
>+	}
>+
> 	return tpm_chip_register(chip);
> init_irq_cleanup:
> 	do {
>-- 
>2.26.2
>

