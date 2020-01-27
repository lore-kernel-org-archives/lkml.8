Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E05AC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8332467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd5pRzRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA0Utu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:49:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24236 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgA0Utu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580158189;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=eOdBLphukmJU4mzfUFyXShD49tL7waQ2ooxqyy/1xSY=;
        b=Jd5pRzRZD7ZUsRWwP3K1eSJR2cHnziqJ18yEn0Ic8xyYmsZ2x1pLStoYQ3ZYyeWb1MT3iI
        jqsgjGKQNTxFlUDk121qnYFMpLUctPlRfxH2Yb14571enCmvP+qan3PlJuf8HlC6zbwA7l
        oIOqILsc5E86jHNdPVYmHvql3hEja00=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Guxeq_eQPjWD9sqwd2bU9g-1; Mon, 27 Jan 2020 15:49:44 -0500
X-MC-Unique: Guxeq_eQPjWD9sqwd2bU9g-1
Received: by mail-yb1-f198.google.com with SMTP id o82so8558629ybc.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 12:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eOdBLphukmJU4mzfUFyXShD49tL7waQ2ooxqyy/1xSY=;
        b=Ht4cAvg3lexnrBLSOB91ta5g6lNjlhH18G1VrVaZq6x60HSBTGr4sP83hh3N+BUJxL
         RyZ76K2ILBGLgirC8bdN+vMShvetcU/hs758U7OflTAq4blN8tjt7rRJpfQX2Laytt4A
         zI8ApalksG4m7QmZTEsfhhcc4H1PbPro+HvjoKAEhTBVHAblJXT/0lvdgb2yGd0uaSsq
         RHljMqELlQqJcCJoaB0PQCwkKbwWgCy7DxWgN6MwMHh1vNBDlK85IY+cd/mt2FxdhQBT
         C2nfqRy3yqv41tOCbKSbJ3OnCWwI5PKRw6UVfGJaeKvVrLkBZBpTJ5Yu0XnCcZL6Tm9o
         sTPA==
X-Gm-Message-State: APjAAAXEHxp1I0bskVr/HFrLvKa4iz+h7Y8Pc8Ri6oLyV5wzTcelQrJQ
        q3AjcUuYZ615wV7pvLqyv2m1ulzkPJn8oVV/ty6cVB197jYgMwHGnvPUb+YyUhJuhBylXmAF2sk
        xunLujCvfHP5xnOCfcZu+vEQd
X-Received: by 2002:a81:6d13:: with SMTP id i19mr13118083ywc.461.1580158184072;
        Mon, 27 Jan 2020 12:49:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIxgvudpxq5FJW0DOdzpF/weeH63baE9/zI41VqoRhfH8WAhIODUXGb9+7F2QnEZEwxlEdeQ==
X-Received: by 2002:a81:6d13:: with SMTP id i19mr13118074ywc.461.1580158183807;
        Mon, 27 Jan 2020 12:49:43 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n1sm7173736ywe.78.2020.01.27.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 12:49:43 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:49:41 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Message-ID: <20200127204941.2ewman4y5nzvkjqe@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 27 20, Mimi Zohar wrote:
>The boot aggregate is a cumulative SHA1 hash over TPM registers 0 - 7.
>NIST has depreciated the usage of SHA1 in most instances.  Instead of
>continuing to use SHA1 to calculate the boot_aggregate, use the
>configured IMA default hash algorithm.
>
>Although the IMA measurement list boot_aggregate template data contains
>the hash algorithm followed by the digest, allowing verifiers (e.g.
>attesttaion servers) to calculate and verify the boot_aggregate, the
>verifiers might not have the knowledge of what constitutes a good value
>based on a different hash algorithm.
>
>Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>---
> security/integrity/ima/ima_init.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
>index 195cb4079b2b..b1b334fe0db5 100644
>--- a/security/integrity/ima/ima_init.c
>+++ b/security/integrity/ima/ima_init.c
>@@ -27,7 +27,7 @@ struct tpm_chip *ima_tpm_chip;
> /* Add the boot aggregate to the IMA measurement list and extend
>  * the PCR register.
>  *
>- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
>+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
>  * assuming a TPM chip exists, and zeroes if the TPM chip does not
>  * exist.  Add the boot aggregate measurement to the measurement
>  * list and extend the PCR register.
>@@ -51,14 +51,14 @@ static int __init ima_add_boot_aggregate(void)
> 	int violation = 0;
> 	struct {
> 		struct ima_digest_data hdr;
>-		char digest[TPM_DIGEST_SIZE];
>+		char digest[TPM_MAX_DIGEST_SIZE];
> 	} hash;
>
> 	memset(iint, 0, sizeof(*iint));
> 	memset(&hash, 0, sizeof(hash));
> 	iint->ima_hash = &hash.hdr;
>-	iint->ima_hash->algo = HASH_ALGO_SHA1;
>-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
>+	iint->ima_hash->algo = ima_hash_algo;
>+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
>
> 	if (ima_tpm_chip) {
> 		result = ima_calc_boot_aggregate(&hash.hdr);
>-- 
>2.7.5
>

Tested the patches on the Dell and no longer spits out the error messages on boot.
/sys/kernel/security/ima/ascii_runtime_measurements shows the boot aggregate.

Is there something else I should look at to verify it is functioning properly?

Regards,
Jerry

