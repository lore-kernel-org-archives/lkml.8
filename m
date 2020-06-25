Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C835C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F42120768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOkS937Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405909AbgFYVTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:19:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33304 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403806AbgFYVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593119975;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=2lclZavUqG1NJdj5nMJohBdjSpQQimkahY/d0zlVvwg=;
        b=QOkS937Q84NISzTHQnvS6ca0Rptfq9LL8NTBTxNHKBLCUC+xjhhe4on7eL/Ly8FqC91K7b
        69pQO8t38kkC1PWezAztNew0JGIKIyW52Ofr4SJJQP5rWcKQzhULaq4m1X9o100TxYIWut
        4Y11FoUU4yUdowGB2jgmPuifua84e/w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-otYmmGa5OwKVVJ70B-cQCQ-1; Thu, 25 Jun 2020 17:19:26 -0400
X-MC-Unique: otYmmGa5OwKVVJ70B-cQCQ-1
Received: by mail-qk1-f197.google.com with SMTP id 16so5078982qka.15
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2lclZavUqG1NJdj5nMJohBdjSpQQimkahY/d0zlVvwg=;
        b=CddHAh9Udnv6ikMNkRmCnHz2RHmCz900rOFbNp4AZDR8gZ9ZLZMy9iGPXB3A3chIVD
         0bRwJs9vPAi7rb1EQQk/0PjpnIYFmFE7Wf2+5na82rzX9XAeUr1Rd6lhS38eGEttBLnI
         YDKZWgKy1luwZHYF2aj/wrRgkBpnP2dIrj+2jsHHsDw7PWpfUt1WppgeAxKNPkYevBco
         /UBBbUhCPHtMO/P2h0ydJII6MGGQD9ANrXaNOLwXYLcCm1hL4fsk7w4587By3PS+HXTp
         A27v2iFJxgk7+O3EGe2YIbhGsNrd9bbNaUT4xIPT02eaK/4NNFyjwgaMvKfGdlfyUTmL
         vdFA==
X-Gm-Message-State: AOAM5319uskvHDB4KGqqPZLahKoL1Nr1OkObrFONzEMYGHLeDw6uG5bd
        Lg1JTx578E0GV+E1uc6Kr/69gBi+qHUaolueouu37d8QagR0NX/8ft7BDChFPIfPEQgJwdv7A3h
        enX8Pvm2Gyla23klKp6pt3qjB
X-Received: by 2002:ac8:100b:: with SMTP id z11mr35104071qti.157.1593119966252;
        Thu, 25 Jun 2020 14:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLsblqiQ5p6JQcg9nR90CbIca50stzT8Rss65J3PKeFju/t3M5PIfwaG5G288ynT70MLHDYA==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr35104052qti.157.1593119965971;
        Thu, 25 Jun 2020 14:19:25 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id o145sm7078267qke.2.2020.06.25.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:19:25 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:19:23 -0700
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
Message-ID: <20200625211923.2jirvix6zbrbgj6e@cantor>
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
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625210202.GA20341@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 26 20, Jarkko Sakkinen wrote:
>On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
>> On Thu Jun 25 20, Jarkko Sakkinen wrote:
>> > Acer C720 running Linux v5.3 reports this in klog:
>> >
>> > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>> > tpm tpm0: tpm_try_transmit: send(): error -5
>> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > tpm_tis tpm_tis: Could not get TPM timeouts and durations
>> > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>> > tpm tpm0: tpm_try_transmit: send(): error -5
>> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > tpm_tis 00:08: Could not get TPM timeouts and durations
>> > ima: No TPM chip found, activating TPM-bypass!
>> > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>> >
>> > % git --no-pager grep IFX0102 drivers/char/tpm
>> > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>> > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>> >
>> > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>> > mistake.
>> >
>> > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>> > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>> > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Bugzilla has an example of similar behavior with v4.15. I'll apply this
>asap.
>
>/Jarkko
>

Any idea what happened to git.infradead.org? It was offline the other day,
and at the moment not all repos from before seem to be there.

