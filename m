Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEAFC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566DB20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnyDyJBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgCKR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:28:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:28:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so3348560wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3JMWOohEOglJnCxDGJQm2HXAwMgJdlNHA6nzH4I16Ns=;
        b=jnyDyJBrF45Mzm5J91GJHQcBk8N4qxCHoH0H1OxUoRCxm7ZFEfKba4e/0Bp7jQupXk
         uL9AJ9PTzbHO/0YZG5dF8olO8Bt6nQ98B18XHjPX27mGLJVC3mfSJcSERME7rG/V0esP
         JDcmN5/UNcCd/TkEBxR5SlIin9/AbdAmAwtdt41nycrVtmrX1oZTMh+IcIG43r1jqKEH
         uF2GKpEAfkBzCE+OeGcHNv1RaEIS1kxvq78W11WRWCChBbikLtjZK6GTalCdv1cU4dU4
         6s3GKGwtD8RemXUVT6le6+F6bJ27AnM2ryovtl++e8eDTA2IRhOxb8sx8pDVVmOCv7QC
         rs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3JMWOohEOglJnCxDGJQm2HXAwMgJdlNHA6nzH4I16Ns=;
        b=NmKHVmNV6B5y38UMcZzbroSe8M91AhNXjUw3uR9HtOQrndzt7VkhjQRVY5pFrfYZ7P
         +OIvTU6fZ/2yf0vq6pX8lS0ljc/szsK8BcJStmDeXysFkQqpgImjMUVZ8Z+28X7wCbPX
         YdcgQm2RupiPjC6vtxlWR903jYqdEU3j2O//428dTmwSAl0HOz4rD6VHb/wbDML7y9Zy
         2gUx9aaCFfVP+opuY/lHX33eCeH1mohNqjY3+MQFABJq4NEqN1ueQ+Ktr+lKZPSRl3Fs
         th834c9by3N2zaL48W2zvwIxiGttKkaMrBhAucuy7NRB3HlwCJuuT+Iy91bYGQ3CLbtz
         ngVQ==
X-Gm-Message-State: ANhLgQ1P20vwlIAoAG/OIqpceBN++C0x1mIo+Fmj8kmJn7+c/0E81fu1
        dcZ1AkLWCNUFIgGNRgZIpmyceiUKwMovpLsjuii2AA==
X-Google-Smtp-Source: ADFU+vt+pTaifsSijhSS7lj4JsDzcGDu1eeb/9yZybGXSx8IACh9v9FBFG+TOLLgNVUMN1iNwwrJxsAGjBdQq0Ipnl8=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr5499838wrp.200.1583947733319;
 Wed, 11 Mar 2020 10:28:53 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Mar 2020 18:28:42 +0100
Message-ID: <CAG_fn=WOJb7bsP2JfhH+PRmhZ=4WY8U+vUugkTpXL4F5sz752g@mail.gmail.com>
Subject: Reason to not use __GFP_ZERO in __alloc_zeroed_user_highpage() on ARM64?
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that certain arches (alpha, ia64, m68k, s390, x86) have
__alloc_zeroed_user_highpage() defined as:

  alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vmaddr)

, whereas in other cases it is defined as
alloc_page_vma()+clear_user_page() (see
https://elixir.bootlin.com/linux/latest/source/include/linux/highmem.h#L182=
)

Is there a reason for this?

I'm asking because on ARM64 with init_on_alloc=3D1
__alloc_zeroed_user_highpage() appears to initialize the page twice.
Adding __GFP_ZERO and removing clear_user_page() seems to work (and
remove the double initialization), but I suppose this code was written
on purpose? Am I missing something?

Thanks,

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
