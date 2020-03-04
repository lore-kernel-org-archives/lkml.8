Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA1BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5678321556
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7Km3cQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgCDTvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:51:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728278AbgCDTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583351512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ra5c/deVBpeBf2yDXKORW+EsDATadMRlpq+nR2VPF8g=;
        b=f7Km3cQ4pSUxDVHnTLDDaZnsxzdewnva77C8oYyCSuOzc2QU1HpgUWEneuhZEIOeXsxG6r
        vcd7hVehNpjQwSfuVlvAUKB8aTCU1bsQRGgCjLtPmmMn/Xj4EKZox8ea6TSOu8DN93u8rz
        JXhbM1EOPpBbgw/Z6iPCnKYgY+GNQyk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-eO15Aqt7PheaMdwqoMKLEw-1; Wed, 04 Mar 2020 14:51:51 -0500
X-MC-Unique: eO15Aqt7PheaMdwqoMKLEw-1
Received: by mail-io1-f69.google.com with SMTP id h2so1226283iow.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra5c/deVBpeBf2yDXKORW+EsDATadMRlpq+nR2VPF8g=;
        b=N6Ay0nDi/nANd6A8leDpnI2NFN1wDBIk6gQ4nRjcnElfbJQfN0A267WKleFl1yX0no
         prXisakzZ60WhPGikqCuLXVdP5sJI9ZGcWuJj+b6WYtg7aLz0pLzr56dKqyxafl0vY5o
         xDwhH230V9A+9IRsy+ZJXIzCuqp5RKQdVsqiU1qIMo4HXDr5N9HXnfTuTSotPEDgfYOg
         A39m2ePr28eIZFDljCi5SChLf+IczdwS27z7jnH+Iu1Nc/QMh+c/V559BCUed0Ab3qmr
         d6Vu/fGtDTAf/PEIC1fRQMHQ6H3Z789aOIJIQZ8OMJRsx/eWCYgKATVrDG5jORbugLeZ
         cFrg==
X-Gm-Message-State: ANhLgQ2Vfq+poDIM51Tgvp0dLfa8f58ui2KGt9W1M6aYPx+qI0OMQSX5
        8kfMf3HQhYa6VZx2NkLmJjtoD2iE5rsabrxOIlTTwaPGDAyHBGfIwvbA7AaYAwi6M03KD2gLC+u
        2aZPKyodcqJByMH6UViZLFtTeX6wYSsBNPenfmy9i
X-Received: by 2002:a02:86:: with SMTP id 128mr4197972jaa.3.1583351510744;
        Wed, 04 Mar 2020 11:51:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuy4R3WkHiT3ty4P0Jvz03EvpoMWk78M0iocJAbdZEkBb/I6Emb6ZcdDRdLsaS/8iLbqomC7mabXhiUazbqKOw=
X-Received: by 2002:a02:86:: with SMTP id 128mr4197956jaa.3.1583351510519;
 Wed, 04 Mar 2020 11:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 4 Mar 2020 14:51:39 -0500
Message-ID: <CAOASepNLGDGZ=9Rx5Pne5oK7QdQ0deonrSsdUKRsv0fzZtx1Eg@mail.gmail.com>
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 6:39 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> diff --git a/tools/testing/selftests/x86/sgx/sgx_call.S b/tools/testing/selftests/x86/sgx/sgx_call.S
> new file mode 100644
> index 000000000000..ca4c7893f9d9
> --- /dev/null
> +++ b/tools/testing/selftests/x86/sgx/sgx_call.S
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/**
> +* Copyright(c) 2016-18 Intel Corporation.
> +*/
> +
> +       .text
> +
> +       .macro ENCLU
> +       .byte 0x0f, 0x01, 0xd7
> +       .endm
> +
> +       .text
> +
> +       .global sgx_call_eenter
> +sgx_call_eenter:
> +       push    %rbx
> +       mov     $0x02, %rax
> +       mov     %rdx, %rbx
> +       lea     sgx_async_exit(%rip), %rcx
> +sgx_async_exit:
> +       ENCLU
> +       pop     %rbx
> +       ret

You need to push and pop all the callee-saved registers here since the
enclave zeros them. This code works today by accident. A future
compiler may emit different register allocation which will cause this
to break.

We might consider making it part of the Linux enclave ABI that the
enclave has to save and restore these registers. This would have a
slight performance advantage in a critical code-path compared to
zeroing and then restoring them. But the VDSO code will need to know
what the expectation is.

