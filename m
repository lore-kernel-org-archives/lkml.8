Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC9C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572420708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581460102;
	bh=qr3w/Jk4E7ZCigNfuSnbve2ZaYJ6PJplvO36QBtgk3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CEQBewkSBGj3moSg6JxDxYY4DsnnsAuYkfIyvRZJIMGvo40mGuBGmbG+9MvaEj4EW
	 3Ys26LhyoPD7w0b3XPTaWI4eas04MX9auxc12QhuOkToVXMhCnUCmJojcu4l2IDd2y
	 sUISaOKXEoNYNQH12wS47YawVFjRLiILzAIMTNM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBKW2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKW2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:28:20 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38A421569
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581460099;
        bh=qr3w/Jk4E7ZCigNfuSnbve2ZaYJ6PJplvO36QBtgk3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NbhIRNqjUWMveUgY7a+SRNavuBLMaEJ0S2oXpbC09sQj8F1OxfAaPXKrzuWU3TF2O
         Mw+vNvdw9fNIzYXnERaAnsTNo8ZHS1QCAPy5Nvu8ouh1ktsRBH8DIULlWinJRU+cW+
         hVMAIhu2xjN3VS9wPKN+Ai4P976oR8rTNBaTMTcQ=
Received: by mail-wr1-f53.google.com with SMTP id y11so14568211wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:28:18 -0800 (PST)
X-Gm-Message-State: APjAAAVoK4HXr55oQarCrhcjbJbZ+kiJTuGvKNyKru+henQZj4VVxdkz
        GHU/uLmCiS+oxEb3PG768DotDAtmaiYm3s+bmK4Oxg==
X-Google-Smtp-Source: APXvYqxuwxNAwq4kzXKENcWaHlU1Oo2EBlzHy1k0fYPvxMGCQYfMlvTgvb3+mfAmlPcL+PPn6IOa2/0gfWBtQFH5zR0=
X-Received: by 2002:adf:a354:: with SMTP id d20mr10781683wrb.257.1581460097315;
 Tue, 11 Feb 2020 14:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-20-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-20-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:28:06 -0800
X-Gmail-Original-Message-ID: <CALCETrWecBK7cqgLTB72mMYRs10R1e+rkZh9mnzRNJc0N=XU2Q@mail.gmail.com>
Message-ID: <CALCETrWecBK7cqgLTB72mMYRs10R1e+rkZh9mnzRNJc0N=XU2Q@mail.gmail.com>
Subject: Re: [PATCH 19/62] x86/sev-es: Add support for handling IOIO exceptions
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
> From: Tom Lendacky <thomas.lendacky@amd.com>
>
> Add support for decoding and handling #VC exceptions for IOIO events.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: Adapted code to #VC handling framework ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

It would be nice if this could reuse the existing in-kernel
instruction decoder.  Is there some reason it can't?

--Andy
