Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD607C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930A2246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582916495;
	bh=5/JpsAR+uqxe0YJw4UOUn2s7lUIYpYv9A7GOTDA8TMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xht84iAWj8QSeiSfZmjdJ98eamc34nHNSFF2PMC8KkVjvKvNiDHFPkqcXAhWOzGeT
	 DLGvtmeZs4kxpbq9fQrNYg8MuZSbc2XMddpW+u75cgDzVAnlFu20ISLZNhf6Kb9kkM
	 4dVf1WTnvlv3R6a+C0IivhLlP5V0LtRepVZ8OZhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgB1TBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1TBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:01:34 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2D4246A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582916493;
        bh=5/JpsAR+uqxe0YJw4UOUn2s7lUIYpYv9A7GOTDA8TMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W+ANFd2Ue4nbs6bJnEaRRiV4dOUJrsH4LM6TWVD8tMiCZQGgZzunWnZIX0WK15Hml
         KZzy5MuX8xnJjxsoy46p93QiPsmMLtFwz0l7YAC5jep41N2URxpQ4E5C+6Nv2IxoE/
         /tVtMMJRQ+QdBQfY5UStPS+XJ0YOT3/0lAQz99sc=
Received: by mail-wm1-f52.google.com with SMTP id i10so8873467wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:01:33 -0800 (PST)
X-Gm-Message-State: APjAAAX4zwAtyCZ46SjfLv7rBHa0ZrzFra3bLMgvjm44rsoWKd31Tgpx
        MumkbmSNFIWm3dmp4e3q8FalXAa+STdSL/pEv6BGJQ==
X-Google-Smtp-Source: APXvYqxjLKVQUK8KPNreHKTaNTlVlnchEJREV7DZwPNr9cf2tlFVohruXjc+EibHpPhCkh7Ejl90qmmDhR9yPxr8MVU=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr6146392wml.138.1582916492071;
 Fri, 28 Feb 2020 11:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-8-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-8-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 11:01:20 -0800
X-Gmail-Original-Message-ID: <CALCETrWB+-3uRBoGKhiH=xBVHLUMaoCaKrfBjxpgUduNG6oyDw@mail.gmail.com>
Message-ID: <CALCETrWB+-3uRBoGKhiH=xBVHLUMaoCaKrfBjxpgUduNG6oyDw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] x86-64: Use syscall wrappers for x32_rt_sigreturn
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
> Add missing syscall wrapper for x32_rt_sigreturn().
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
