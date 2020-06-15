Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A94C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28A920714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592214660;
	bh=A26YdtcMO5EoTHkY2IHnWM1hBmnk9M6SQJKgiWRdLzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1g5LmxZG7p0QVXmdCSTTntwpZ4fHljEdEYI1RepCFOroUcB+YpXpPqm9PHa4syjIh
	 Q0HOlnuxi2dZLRzeqXl0TzZGYxbzok+rxM8gTBOD2QKZkfyEAir2FIWLgP0VVLjRW/
	 2xqdEnmCD+SnDZmiexlB4JyISNPO/SPXvq6bQrqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgFOJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:50:58 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F5320714;
        Mon, 15 Jun 2020 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214658;
        bh=A26YdtcMO5EoTHkY2IHnWM1hBmnk9M6SQJKgiWRdLzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3DB+IJhQLY2steW72c+upqB6h4pCcWaC0dSfZ2Z/qUOs7w3FPw3+sK+ATQeIKVAC
         jxb/+jvv49J21MH7gBhmi4oleIPN245oWmRA1HcUH3GwAD6LLT3yq4JxhrL9BAamv0
         Nu/BKxPS+FrBiVewxPo5r7bV408dGYwHystmZLlk=
Received: by mail-ot1-f52.google.com with SMTP id g7so12606614oti.13;
        Mon, 15 Jun 2020 02:50:58 -0700 (PDT)
X-Gm-Message-State: AOAM530cUj3PY2vr7nGzt4HeP8SYIfC/0h//ofwbEy7UpAtCuAQzgiaq
        cfDNkQYpzhF6IXZDfgevlTYGo0LqGWQNGd1peT0=
X-Google-Smtp-Source: ABdhPJzRYgBFibVOL7zsd1hhbsa+nVHN/DZnaqbXDkXqSMjIfxSX4zw6EmbZCy4MxgVdCCGifEFwKPqzzqUXTVMDdug=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr20732898otc.108.1592214657897;
 Mon, 15 Jun 2020 02:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200528194905.690-1-tony.luck@intel.com>
In-Reply-To: <20200528194905.690-1-tony.luck@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 11:50:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGOpFP7TRLOFQ_KjPpbVBZP-yXdv_=9dEaTe9S9C-u6fA@mail.gmail.com>
Message-ID: <CAMj1kXGOpFP7TRLOFQ_KjPpbVBZP-yXdv_=9dEaTe9S9C-u6fA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Couple of efivarfs fixes
To:     Tony Luck <tony.luck@intel.com>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 21:49, Tony Luck <tony.luck@intel.com> wrote:
>
> 1) Some apps want to monitor changes in EFI variables, but reading the
>    file and comparing is inefficient.  Just have Linnux update the
>    modification time when a file is written
>
> 2) A rate limited read can return -EINTR ... very suprising to apps.
>
> Tony Luck (2):
>   efivarfs: Update inode modification time for successful writes
>   efivarfs: Don't return -EINTR when rate-limiting reads
>
>  fs/efivarfs/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Queued in efi/urgent

Thanks,
