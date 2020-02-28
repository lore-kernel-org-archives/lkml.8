Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E6FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940462469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582915005;
	bh=dIabrkXE6WVZA/XCjFPcYlF0xHEB0WUA8O7er4hsQf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RqtIv4nCgD3jKtDSm8A3QPfWGjAi+lH2nwkL/NKIUTK9OJMf7/0Ni+Zg2vQH93zir
	 oFMxz1LqOIF1OkZIX1hNWeTts0qBP5PqEXywGzxvw8xX4C7GkHnGahxvS4k9JY5YuT
	 9OSYF/A7C3I4HQi2lt2RLwnjmBNx0p/iNba3DYuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgB1Sgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Sgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:36:44 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD902469F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582915003;
        bh=dIabrkXE6WVZA/XCjFPcYlF0xHEB0WUA8O7er4hsQf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FFRonQFA4lTfCYNGxvawtd2v0I5vOZsWnCBKKYmyZkBx+e69SGy0mG6zniIqRfxIE
         x/CZ1E1CEY55pPn1zEqFUVHaNi+M4qClKhXUdOKzd2AAs+LlBfB53Br2zsTX0YXGx1
         BLl0uq6htV2tSQMrMHdyviyoP9l8pFnmS3OiBVOw=
Received: by mail-wm1-f51.google.com with SMTP id n64so2987500wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:36:43 -0800 (PST)
X-Gm-Message-State: APjAAAUf4ViEJmK3AvTc68hsOuTBPZploUNjZuw37SojkzL8OGQIPZxt
        AQjnoXLv8Og75A5PXEl6bNk75vv1Fhhwq0Gf81HhzA==
X-Google-Smtp-Source: APXvYqxGdQz1fpnCuqbxxCPEsxzEnfDsEg0tfUtfAgK/Qh2thelCO7U4P8Rq3DdkJcPE7Pfr9wPipODKhXXDpr15wlU=
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr5460626wmc.49.1582915002081;
 Fri, 28 Feb 2020 10:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-4-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-4-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 10:36:30 -0800
X-Gmail-Original-Message-ID: <CALCETrU9xeKg=6t+kBVTDzad=gvVR40Xbmn=GPVDse551zhVSA@mail.gmail.com>
Message-ID: <CALCETrU9xeKg=6t+kBVTDzad=gvVR40Xbmn=GPVDse551zhVSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] x86, syscalls: Refactor COND_SYSCALL macros
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Pull the common code out from the COND_SYSCALL macros into a new
> __COND_SYSCALL macro.  Also conditionalize the X64 version in preparation
> for enabling syscall wrappers on 32-bit native kernels.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
