Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF85620732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt+OFGnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDMKEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:04:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbgDMKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586772280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvtpikoyRBKdoFcJ8GEU4zwmH9E/dKn5BixvwyCzFc4=;
        b=Jt+OFGnKk4d16E/qOD+X7Vz8+deENVuQf1EA1HF/4vgvQLjRZyZc4etnTS9pIbvqS6SP5q
        Sr6QYjVVCVtJJwNmfRLLKHS9iP8b7m8P/+lHWjzdZD1d4ki7H+6CTKkrqxOsbDTIHmEcUQ
        n4mmL7sFwTgZQKLFlrLSjl1zv4E+uz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-kV3_HmjJMSSrsk5-hkenyA-1; Mon, 13 Apr 2020 06:04:38 -0400
X-MC-Unique: kV3_HmjJMSSrsk5-hkenyA-1
Received: by mail-wr1-f69.google.com with SMTP id m15so6510584wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvtpikoyRBKdoFcJ8GEU4zwmH9E/dKn5BixvwyCzFc4=;
        b=sc+1fPionAIfvXUPpsPSVEI56dLpatx+/cKKe8TqNzJzVwO4jtJb8UxVGS6z0whm2y
         hnau0A8qJ3S/7vuD6Jo2FbzTk2YQPph6uwD90aH5TiHVUZM4+upiR9tPl5XOIhOyGitm
         Pdl5nHKmQ+gAqYy0mCpcc746nBS7GlwNuFY9e4SyylyIxXdhw0PGPEL84bhfqYIqWlMC
         6T94CRYD/3/S+a4vn/R3/kMxGjqgknOOgaOtShNHM+xeHb48yPO9RDDQw2IxRbN7U/+T
         O3guLn7Lp0/O1htUPvXhMiWq6q0YAxDbmigMZIHvAE9/HJWp4ozAHPWTDH5vtqCNl7MU
         UFaQ==
X-Gm-Message-State: AGi0PubjLEKuJjWhNGiAoYzdH/T1dLlssQnsbv7b1qDyC8qsorb9Dfe+
        ZRLj/HJahzaceicWgeiLURXbnHftEWk/Admef5ovdw31ceMD6G0BZzQP3fLwZUq9qLJ9SBxhvw8
        fTZ3FTVOlak+fvFAmQn7Bdhh1
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr17506956wrg.305.1586772277044;
        Mon, 13 Apr 2020 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypKLf/U31JZjFRkBRGJHsrPosoMp6/myT/NeT+ZxS/TXQH3VpqNomwC6Nks6u5GBINnLmnW9Sg==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr17506398wrg.305.1586772268328;
        Mon, 13 Apr 2020 03:04:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v131sm14332473wmb.19.2020.04.13.03.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 03:04:27 -0700 (PDT)
Subject: Re: [PATCH] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b909aaee-3fff-4dca-40f4-4c5348474426@redhat.com>
Date:   Mon, 13 Apr 2020 12:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/12/20 7:04 PM, Jarkko Sakkinen wrote:
> Call devm_free_irq() if we have to revert to polling in order not to
> unnecessarily reserve the IRQ for the life-cycle of the driver.
> 
> Cc: stable@vger.kernel.org # 4.5.x
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca031e23..ae6868e7b696 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   		if (irq) {
>   			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>   						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>   				dev_err(&chip->dev, FW_BUG
>   					"TPM interrupt not working, polling instead\n");
> +				devm_free_irq(chip->dev.parent, priv->irq,
> +					      chip);
> +			}

My initial plan was actually to do something similar, but if the probe code
is actually ever fixed to work as intended again then this will lead to a
double free as then the IRQ-test path of tpm_tis_send() will have called
disable_interrupts() which already calls devm_free_irq().

You could check for chip->irq != 0 here to avoid that.

But it all is rather messy, which is why I went with the "#if 0" approach
in my patch.

Also we will currently ALWAYS hit the "TPM interrupt not working, polling instead"
error because the TPM_CHIP_FLAG_IRQ never gets set. So if we are going to do an
interim fix (and we should) we should really also silence that error.

Regards,

Hans

p.s.

I'm currently in contact with Lenovo trying to figure out what is going on
here with the always firing IRQ on the X1 8th gen, I guess the fix for that
might also help with the T490 issue.



