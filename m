Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64BC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5668F217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581543783;
	bh=/5bgUjnXfKX/YnWj2CVZ6tzhbOUyGqaE9iljMsoLSUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wYrL05JTJoUcTSkofyA9Zu9u2EAOJ9VxlB2xHbuUsAhEMXpDiKLNMhmUID5nDTdVw
	 lMLaK2FgRjle9AOVfdjJRh01JXDGdxUM9BXZNu+vrmJBP3YaMNdsB24d3dKdDYrehM
	 Zkd5HLTO94OVsM6mvviHuXGGX3ic/BV5u4YRkce8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgBLVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBLVnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:43:02 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74AD424685
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581543781;
        bh=/5bgUjnXfKX/YnWj2CVZ6tzhbOUyGqaE9iljMsoLSUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Do9dVLKHn+WmiWvVm5KO1giK1zzBjXFPv4K+0KaPaAU+ZFrJMbe3xrdYLXsMD33YT
         HT5tMqSNvg8QkYnRPtiJswNABvk53TkuOMS9PFoWqhT46b6TsoN0KZCIMozqIyV4K8
         NqvZraXBlBMH2RxKnUB6a9FkfLoo3qPSZvOOkYtM=
Received: by mail-wm1-f54.google.com with SMTP id s10so4008383wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:43:01 -0800 (PST)
X-Gm-Message-State: APjAAAUgiHuW6NRh5Bqf+w3bXSRynjsQuXfJK0NblsTOr9gayHea1OzC
        HedqGcNdV+ZbZ1L4wZEHDbSQkgP9//wZvMjRqJeIEA==
X-Google-Smtp-Source: APXvYqx80blFuMGO5xbOx9jMb15X8saJRfGQ59bhxN5COt5T4RVqjZzy0EMpurQDrd8Sxj4YjZioVGr2wj1eLccaOos=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr1155941wml.138.1581543779800;
 Wed, 12 Feb 2020 13:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-39-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-39-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Feb 2020 13:42:48 -0800
X-Gmail-Original-Message-ID: <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com>
Message-ID: <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com>
Subject: Re: [PATCH 38/62] x86/sev-es: Handle instruction fetches from user-space
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> When a #VC exception is triggered by user-space the instruction
> decoder needs to read the instruction bytes from user addresses.
> Enhance es_fetch_insn_byte() to safely fetch kernel and user
> instruction bytes.

I realize that this is a somewhat arbitrary point in the series to
complain about this, but: the kernel already has infrastructure to
decode and fix up an instruction-based exception.  See
fixup_umip_exception().  Please refactor code so that you can share
the same infrastructure rather than creating an entirely new thing.

FWIW, the fixup_umip_exception() code seems to have much more robust
segment handling than yours :)

--Andy
