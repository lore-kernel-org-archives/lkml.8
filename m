Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4512CC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BA120752
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVCV1RM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgEER3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEER3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:29:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:29:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n11so2684384ilj.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy0GdGgxyPD00QqDkyUEiOPwjQ3So7k/pckviAaq4FE=;
        b=NVCV1RM5ClAIH/6mqNJ7trrSjA5zx7rqNmi1XAPBnUwH3G84JzpFtbYEhIS1TxN+Nh
         ZvBbY6NXJMbQUQyw5h7dUQ4HYy0dAKwUqNy4VxrOltngn/CwJWwyu1Lay3aCoVaHMbJS
         zx+guv1/Av6Z+kVoiQOO+cuj9PXoEMG1/W5BZh45EcYWL6/aFmmuLFyKbsnhylrBuH9Z
         PsHBYYEZZOXF3Puv5guv58xdg8/9xQmU2wWKhXQG0Szv9o3uOFLJuNAPpgxvV5LSusSF
         MenQ8NxLweqZS4NvxVqAlhDxGVmzYhllAA0Y+ndyzOX2qIRNHJC4zoQjISeDKsxWKSTP
         3AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy0GdGgxyPD00QqDkyUEiOPwjQ3So7k/pckviAaq4FE=;
        b=jY4aHam9aolYIurJSiVW/O5fhxnokAyb3+TTxvOHysus9nGSGuh/XrGgWvwI35OcDI
         IVzcBAAuzSFR85uFOdyxR0EkTKDtPtqntcftykZ1hBd6kv2DLy1rMUk6Y8VOYbPfq0Xx
         oxGRWXpTYeGe1gTbmOOjIAc0ML5AiHVRcTr39vlzk4+pFrI45bzkGCYPlJ2e1IWc2m++
         0reW2TesXdc0qynX99l3hFKgdNMgXcIscv0iPse414SXzpAfB7uHWTiD0m8n4Qm105BO
         oEPaRJpouBvSMicjQ2jUXtjvR0CgvQY5CO/v/KutqkS6+aaL+1OMgRXt6+bozqp5ebZV
         LU3Q==
X-Gm-Message-State: AGi0PuY4PklWqhmp3UXalYg/6ceWDadO4A8Xu/qlg8epuqxRPSshWofL
        WMk6IBQ1inYqU4GGMcRyAj4wsXsAqQabflbKMQ2ni/F7
X-Google-Smtp-Source: APiQypI4jYvugc4TUYQVRke+ITxljwe+0qzc+gd6lvUOSCwaOtsQ6YyqzZd+izTlmcgOBXehrSe2YaYjXxtYVldeJa8=
X-Received: by 2002:a92:1944:: with SMTP id e4mr5031740ilm.46.1588699756509;
 Tue, 05 May 2020 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200504232132.23570-1-daniel.kiper@oracle.com> <20200504232132.23570-13-daniel.kiper@oracle.com>
In-Reply-To: <20200504232132.23570-13-daniel.kiper@oracle.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 5 May 2020 10:29:05 -0700
Message-ID: <CACdnJuszO1_aNXdgKt0_5XigC-AeuBT=gKkECszk7xX2p2TpkA@mail.gmail.com>
Subject: Re: [GRUB PATCH RFC 12/18] i386/efi: Report UEFI Secure Boot status
 to the Linux kernel
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        eric.snowberg@oracle.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com,
        "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>,
        pirot.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 4:25 PM Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> Otherwise the kernel does not know its state and cannot enable various
> security features depending on UEFI Secure Boot.

I think this needs more context. If the kernel is loaded via the EFI
boot stub, the kernel is aware of the UEFI secure boot state. Why
duplicate this functionality in order to avoid the EFI stub?
