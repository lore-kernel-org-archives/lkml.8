Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C9920702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejk0jYim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgF3TQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:16:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgF3TQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593544571;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Mwn+YbY3lCFD0nRhYZ0J/9ZQb28iUEBrVkjj0x5okkw=;
        b=ejk0jYimK5o3BZkJ7Nkk53GnQPl4pXyuz26lTycrqdcbO05hbM5xAA+qRTXDbhfcK1b+Bh
        Bg7V0vKeZeZ7Yacih3W14l2NpDKyHjV2JJCnum+p6Wt5Ej8YkmguSBA/zN5O3yPUWhC+Ma
        OxI5Eoq/AQsrAr4bDkT7/sr69bvzjwk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-mOSIwN6xP3u9d9Z16cLovQ-1; Tue, 30 Jun 2020 15:15:18 -0400
X-MC-Unique: mOSIwN6xP3u9d9Z16cLovQ-1
Received: by mail-qk1-f198.google.com with SMTP id 13so503941qks.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Mwn+YbY3lCFD0nRhYZ0J/9ZQb28iUEBrVkjj0x5okkw=;
        b=DoVNBRVi5wBJJXqg2NGa9Ue567D4Wmy75VR+cIpDpKIHVBhVfPVNVFX11tDugRtGfW
         V/Ns6xxJzXpB0U7w9+IZcSiJgXMhjhA6V/DT3pp7Xje7EXhaupVInvGdHmFBKtgPzzte
         wsM4kakkHeSUcGBEEZxvzhzPvlGcKLEZxOUJZtqSMMu02CMT4fQl0uHYTdObJGALMD+c
         nbuR749jNlA4CmAcKpQtR4j0eaKNTW61pTj5kPKIfKmDQSfVKXD18T6Fh+kZb1uz0c8p
         2KiqepRvdvEOClIS5UDQNHTb15rIi8ZSd/H0pObs7UJmAebSUTGilm/S+RiuwRQg8X58
         pa4g==
X-Gm-Message-State: AOAM531Fvx2/Zu8t7b90zW19zskRT15s/7P8v5TYUbFLWJlUOn/FQHtx
        fNRqLotui7VmQ2I4+sJI0rS/0F/n5vvGT/uSZ73RIocZsjQPliFj6AHeuFz2YxEMXShKfueiquI
        N2aPBvLreG8GSUM62OzIM1zZO
X-Received: by 2002:ac8:b4c:: with SMTP id m12mr1796489qti.321.1593544517990;
        Tue, 30 Jun 2020 12:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHjEeEV/Zp7eB4dHo6T90utCK96FWHB2uNZoUKDQzH4ehEwW36m6TcSOBtvR80+MWgIMg8vw==
X-Received: by 2002:ac8:b4c:: with SMTP id m12mr1796465qti.321.1593544517659;
        Tue, 30 Jun 2020 12:15:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u6sm3840440qtc.34.2020.06.30.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:15:16 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:15:15 -0700
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
Message-ID: <20200630191515.m3hi6gmn4ya7hvji@cantor>
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
 <20200625211923.2jirvix6zbrbgj6e@cantor>
 <20200626130851.GA7853@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626130851.GA7853@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 26 20, Jarkko Sakkinen wrote:
>On Thu, Jun 25, 2020 at 02:19:23PM -0700, Jerry Snitselaar wrote:
>> On Fri Jun 26 20, Jarkko Sakkinen wrote:
>> > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
>> > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
>> > > > Acer C720 running Linux v5.3 reports this in klog:
>> > > >
>> > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>> > > > tpm tpm0: tpm_try_transmit: send(): error -5
>> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
>> > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>> > > > tpm tpm0: tpm_try_transmit: send(): error -5
>> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > > > tpm_tis 00:08: Could not get TPM timeouts and durations
>> > > > ima: No TPM chip found, activating TPM-bypass!
>> > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>> > > >
>> > > > % git --no-pager grep IFX0102 drivers/char/tpm
>> > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>> > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>> > > >
>> > > > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>> > > > mistake.
>> > > >
>> > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>> > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>> > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > >
>> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> >
>> > Bugzilla has an example of similar behavior with v4.15. I'll apply this
>> > asap.
>> >
>> > /Jarkko
>> >
>>
>> Any idea what happened to git.infradead.org? It was offline the other day,
>> and at the moment not all repos from before seem to be there.
>
>Now the kernel tree is back online.
>
>/Jarkko
>

Hi Jarkko, I still see your linux-tpmdd repository as not being online:

git remote show tpmdd
fatal: remote error: access denied or repository not exported: /users/jjs/linux-tpmdd.git

Regards,
Jerry

