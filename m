Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F998C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3521707
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyjNmVfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDUNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:23:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728479AbgDUNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587475413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytKxWQADMe1hxsp4ibPZrOFawU10CTLZrsg1UsU9JN0=;
        b=RyjNmVfj6ci8EF4vJjWb8BJF05EPTfKkCLzJJAZcf99lb4/B0apcSPBXdTgBPgLXzbXp1K
        LDlKGZd5x+juirC9eFI0Y80f+18eKHxUwdKGKQMt/CMS02tPxZYQIglR9ZJRMXpENfKB99
        CJ22nZNgjYa9ioCEjglxSRMeZS9jwGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-9zWUdhfNMGyKgbOUH8wTXw-1; Tue, 21 Apr 2020 09:23:26 -0400
X-MC-Unique: 9zWUdhfNMGyKgbOUH8wTXw-1
Received: by mail-wm1-f69.google.com with SMTP id 71so1355903wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytKxWQADMe1hxsp4ibPZrOFawU10CTLZrsg1UsU9JN0=;
        b=GzAbeGTA2StCVr7SBHTAjOJHcBcjavvUsr60dhOWB1H8AoYHIkatI5xGSUk6/EBaK7
         Bn3nrjvmCtMoQcjyUn8VGmf/GNxBDHS3jTaRA5RUJk9ywKkSrcDEIM4kttA3xtxugYw/
         A9hFqkQC4UJpBm9jJfSNEM+8A1dQhSdQ393TAJL3DyxtLUiwegqVW6rt/Slp2OqBO+4J
         9C2koqMrNRRxW4pi7kUx9gznlHmdPGyYpAZgjJnYD15qzQRYTSE/z3KwKt4d63Ks9+ei
         /9vZTburCJvj6mQg9aVgmSOkXNXn3Et3al/QCPTwHi0sFJ/oB2AFSBCgTVNSbB7KrPfQ
         /NoQ==
X-Gm-Message-State: AGi0PubNFuIwjZYqjD+vwIfy16g2cCP7zZPQgcncznMMye0KPXauyGrH
        K46TW2qX2zv31xeh8I5s58Kg/jgOxlOd3DvQHDQUSMcUwgYC+ZH/Q0gHTm/ekChto8WYShQof7P
        v5Un7quTUTA5KUuzTpPYlQX2r
X-Received: by 2002:a5d:4283:: with SMTP id k3mr22796310wrq.238.1587475401067;
        Tue, 21 Apr 2020 06:23:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMNn2YfNcf4IPaf9IVmkV32oOcmuFaDha8DPqw36FZ9/e+P6Z7Ojyc8EbM6VEDrhDoQCcs1Q==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr22796294wrq.238.1587475400901;
        Tue, 21 Apr 2020 06:23:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 185sm3947160wmc.32.2020.04.21.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 06:23:20 -0700 (PDT)
Subject: Re: [PATCH v2] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200416160751.180791-1-jarkko.sakkinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fa25cd78-2535-d26d-dd66-d64111af857a@redhat.com>
Date:   Tue, 21 Apr 2020 15:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416160751.180791-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/16/20 6:07 PM, Jarkko Sakkinen wrote:
> Call disable_interrupts() if we have to revert to polling in order not to
> unnecessarily reserve the IRQ for the life-cycle of the driver.
> 
> Cc: stable@vger.kernel.org # 4.5.x
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I can confirm that this fixes the "irq 31 nobody cared" oops for me:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   drivers/char/tpm/tpm_tis_core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca031e23..2435216bd10a 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -433,6 +433,9 @@ static void disable_interrupts(struct tpm_chip *chip)
>   	u32 intmask;
>   	int rc;
>   
> +	if (priv->irq == 0)
> +		return;
> +
>   	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>   	if (rc < 0)
>   		intmask = 0;
> @@ -1062,9 +1065,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   		if (irq) {
>   			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>   						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>   				dev_err(&chip->dev, FW_BUG
>   					"TPM interrupt not working, polling instead\n");
> +
> +				disable_interrupts(chip);
> +			}
>   		} else {
>   			tpm_tis_probe_irq(chip, intmask);
>   		}
> 

