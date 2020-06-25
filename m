Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5930AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CB6206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hdvl5q2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbgFYGV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:21:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728725AbgFYGV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593066115;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=RANWi8MsV3pCLZkoJfRG4MlBXvH11AYTJIWScwC3Zys=;
        b=Hdvl5q2v06DBNJYb69cENHECgC2JNkKj5rVGJWxwJ0cDNlolUauor8sb5gwO35vTHZ6Ilf
        DZgRktToE2Uindy1Ax2u8KgqbTb2vB0vNc5Rdze3OXGCQflkNElGUmYvxuZyC64M0kz9mV
        wgvHrjZxY0tCwQ2Dpb5YAx2EB6I9zqU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-kIVE8w1aPK-cXtJrqAD0pw-1; Thu, 25 Jun 2020 02:21:53 -0400
X-MC-Unique: kIVE8w1aPK-cXtJrqAD0pw-1
Received: by mail-qv1-f70.google.com with SMTP id bk16so3355774qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RANWi8MsV3pCLZkoJfRG4MlBXvH11AYTJIWScwC3Zys=;
        b=m4fPmUJBaiAJFpbuauelkXiTYN7wkv+qak+gtK/5HZJtAib4NOhMV30HntKvvrSK6H
         4fbX35A+3rm9C9zHwOXaFpSr5gap+8SGQ2Q/TNkFXvSaW2QV4E5gPFdSNOEWL/ItAjM0
         jqxLAspUq0RCxIQlB3EY1pZQCdXnbcBB1b8X+aKBidhfs9ExGJCMUvUEeeQ8kPdYWzZq
         HkDSgkBDRXttqdwcU2cMmXkLMlO99gyJyWBiSgxsMInLqjEtl7nrVLwE/4P6+5yZP5AL
         AxL9v0ac/sLWlnLLULly/fIzna1l+OVy9rMhoEXu4XItn5e4cZtA3D2+/gOXwP7oKAt2
         gTBQ==
X-Gm-Message-State: AOAM530r+HX8zzEapjnrWRrbmHZbk6AuthNed6gYpZxikNI8RtwjvyPC
        T/6CRjGtlk0zZu7YVrJ3dJ88Cg6kZSlsVYGHjL0yNhpwxCX0Bt11h03sqUUbniWOV8ArlrBCMa+
        fnsnsNysRgvnX0V1PjyE8whGl
X-Received: by 2002:a37:aa83:: with SMTP id t125mr30115546qke.231.1593066112737;
        Wed, 24 Jun 2020 23:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7DZxp3j6YwaiC9QEGZtJDfKb+Eetc7xPdd+bygMwcAVIIYh69HcGEphZuTg+ZeyNGB5yjFA==
X-Received: by 2002:a37:aa83:: with SMTP id t125mr30115533qke.231.1593066112493;
        Wed, 24 Jun 2020 23:21:52 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id y16sm5202042qkb.116.2020.06.24.23.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:21:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:21:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200625062150.idm6j3vm2neyt4sh@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 25 20, Jarkko Sakkinen wrote:
>Acer C720 running Linux v5.3 reports this in klog:
>
>tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>tpm tpm0: tpm_try_transmit: send(): error -5
>tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>tpm_tis tpm_tis: Could not get TPM timeouts and durations
>tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>tpm tpm0: tpm_try_transmit: send(): error -5
>tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>tpm_tis 00:08: Could not get TPM timeouts and durations
>ima: No TPM chip found, activating TPM-bypass!
>tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>
>% git --no-pager grep IFX0102 drivers/char/tpm
>drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>
>Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>mistake.
>
>Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

