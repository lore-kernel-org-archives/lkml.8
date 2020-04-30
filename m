Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C7C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665B2206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY696NEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD3VcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:32:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3VcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588282342;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Jzrv5wRZ4K7XtvWDWWDISsbmjMxGQe+9BSaROBXcFYM=;
        b=GY696NEo5LOX3ASixzG+GHdHN+8eAJkHbSETwU1emugMOKwlUrepykj0WMYwIkNt/w3DyG
        nTRBz0+ikVppz4QgeD1GOECWvewksqD4SyXxKEy69NVvpjK+Qu88O8qaX2zxKL7gTGdZHn
        +Ntj3yxQ4xWd/7cE8Y+J2lm64X3+kNc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-pNke-0I0PzK6aSxeZP0gMg-1; Thu, 30 Apr 2020 17:32:18 -0400
X-MC-Unique: pNke-0I0PzK6aSxeZP0gMg-1
Received: by mail-qk1-f197.google.com with SMTP id k138so7915601qke.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Jzrv5wRZ4K7XtvWDWWDISsbmjMxGQe+9BSaROBXcFYM=;
        b=oG+ObIccwN5ucGpCPnlwhf7P0J7jHgd6uTvlFI64LW69EPZjIuDOVk+BBY1cklvG4B
         1XI0xk1c1nqwLGaq309EgjIlte9/o+pFDx1dcIMuXxkxADRCglBoTkWxHhi9fHsJNBkW
         ZlQdUmyGGhqco3KzLzH0Ll9TSFKBZFvYpDPVB3mxe8iNgG240gpnoqSrR2VDsBQC9HHu
         q73JSj4+nCiq4Uvxr63HFfYbx3N2ayCOWZ8uG9GpBsXbH3HP5Q/ObfQMrj9RqGNRrd7v
         jG9jjfKp4sd6iEdzXJwpvI/vBBV/0+LydTg73z4pKH5emRL4o/H30eWd8WYssQLmkpGG
         U04g==
X-Gm-Message-State: AGi0Publokydn+DQQxixc9Clg3pQq8w+0rUzja228uEMm6zajxwc8GUD
        nLufAkQrXs4L1z3V0BGKPbMAHiwEzOV4hMADu17NcwPK/zhSC6d9pebszQi6xdWZXSkFz3HZRq1
        xueH22M9jfqmxj1iYZ3fJd8w/
X-Received: by 2002:a37:5846:: with SMTP id m67mr569354qkb.78.1588282338108;
        Thu, 30 Apr 2020 14:32:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZ/+p/l03HZUTw9TAzxeelMsC2X0K+JlusH68UBd280GrosJOpL9Xmkh0soQ588iZsWL59bA==
X-Received: by 2002:a37:5846:: with SMTP id m67mr569335qkb.78.1588282337907;
        Thu, 30 Apr 2020 14:32:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x16sm1077258qkh.14.2020.04.30.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:32:17 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:32:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "# 3.4.x" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/tpm: fix section mismatch warning
Message-ID: <20200430213215.jqt2rj452hawj3j7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity@vger.kernel.org, "# 3.4.x" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200429190119.43595-1-arnd@arndb.de>
 <20200430211516.gkwaefjrzj2dypmr@cantor>
 <CAK8P3a1xk9b9Ntsf302EUP2Sp+yWe5UEsbf973=xmYRkiN1KuQ@mail.gmail.com>
 <CAMj1kXHc0uzzTKp7oj23_=X9ek2KNrKMq1gL09X7cTnjhV=nXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXHc0uzzTKp7oj23_=X9ek2KNrKMq1gL09X7cTnjhV=nXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 30 20, Ard Biesheuvel wrote:
>On Thu, 30 Apr 2020 at 23:21, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Apr 30, 2020 at 11:15 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> >
>> > On Wed Apr 29 20, Arnd Bergmann wrote:
>> > >Building with gcc-10 causes a harmless warning about a section mismatch:
>> > >
>> > >WARNING: modpost: vmlinux.o(.text.unlikely+0x5e191): Section mismatch in reference from the function tpm2_calc_event_log_size() to the function .init.text:early_memunmap()
>> > >The function tpm2_calc_event_log_size() references
>> > >the function __init early_memunmap().
>> > >This is often because tpm2_calc_event_log_size lacks a __init
>> > >annotation or the annotation of early_memunmap is wrong.
>> > >
>> > >Add the missing annotation.
>> > >
>> > >Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
>> > >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > Minor thing, but should the Fixes be c46f3405692d ("tpm: Reserve the TPM final events table")? Or what am I missing
>> > about e658c82be556 that causes this? Just trying to understand what I did. :)
>>
>> You are right, I misread the git history. Can you fix it up when applying the
>> patch, or should I resend it?
>>
>
>I can fix it up, no worries.
>

With the fix applied:

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

