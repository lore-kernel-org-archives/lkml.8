Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF89224677
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582915086;
	bh=3EUTcM7sUm213W98UX9zAtOyghgixz9C4eXchXsb+zI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XXVA4TYJOnIiDi/iwTP0arysLNKZTjpsCC5PNos2WV/KILj/KQEcjFdvVLT57/x7b
	 nawJD0EM6ogsJWMybnR+Fer2DKVtsOBXLFoQtYh0HPo9FstUkxxY2u5bayYGF6bGrp
	 J1VOvUb+boNUbr5kVL3ORqfZ5MEMCS0uGL1u9WkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB1SiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1SiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:38:05 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62F9246AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582915084;
        bh=3EUTcM7sUm213W98UX9zAtOyghgixz9C4eXchXsb+zI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=leHHakXNZ7PsmZJtgkVcsGUK9dut+QSWeKAy5RpYWhToHTxx0CeRrwayAGggbDGX3
         Bc1JlohbkbvsQdmUJfDLElmS+p8P17PR0oe4N1N6RBCGjthUsKfXh+8caHA3hsyZEV
         a2e2TwPBrTfhB/TbA9Chq+EB5rtqj86a2Vpcw6Us=
Received: by mail-wr1-f44.google.com with SMTP id e10so2675305wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:38:04 -0800 (PST)
X-Gm-Message-State: APjAAAUT/iQLye3PfP8FKFH34YR1znMo0JTfaZnp6M4EiPBvtJCJLvM7
        i1njFDxeCiiTjJA5lsaeh2BPNnrwKMOJMfgsvTqV2w==
X-Google-Smtp-Source: APXvYqzb3hrJPfqUd4HzV/YyPRcMTqbqHc/r8Mvdgb07o/4r2fyRq7BeYCWcMB0Xytc05aChRS4gchv2AS+CZZ+0dFc=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr5900558wrm.75.1582915083141;
 Fri, 28 Feb 2020 10:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-5-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-5-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 10:37:51 -0800
X-Gmail-Original-Message-ID: <CALCETrX-dNgJJJpWc_J85ss8YOSo4zkrMRX4n4u2EGgxa+eefg@mail.gmail.com>
Message-ID: <CALCETrX-dNgJJJpWc_J85ss8YOSo4zkrMRX4n4u2EGgxa+eefg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] x86, syscalls: Refactor SYS_NI macros
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
> Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
> Also conditionalize the X64 version in preparation for enabling syscall
> wrappers on 32-bit native kernels.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
