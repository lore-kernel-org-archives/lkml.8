Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40BC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CCB2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580951847;
	bh=c/QAJGFBDVSsnDraji7Se4DitpBF5jtF8Hj48+GNKlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GEmVHmcKG4H7cYjWTpVz/v7g4BKMckK8RX2mwj9pZcCP/OJGurj6rlYP2MgAnbWXs
	 /yK6KK+rc+bNSLFuYCFffo17lob+fuoS1QvEoNRDNxhZC7Zy0LJCuS/l0BQTq0B+bw
	 Ab7SSqwCZezIdVy9DG6ML77zn3qAcVSLlwSefj9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgBFBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBFBR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:17:26 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F092192A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Feb 2020 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580951846;
        bh=c/QAJGFBDVSsnDraji7Se4DitpBF5jtF8Hj48+GNKlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nAKF0vHsgBcp9G2cbZP3E+LGn1TMWXmR7VCiFam5tr8l8X2UfHu6e0qDj9/YBZsCw
         5iimwa9Sa4mt0kWK4TdZHgqvZpiND9iYPZxngK07Pehuvc4emoErgvDe85Eldne7Ad
         6B1uEU1xgOQGTY6fYI0FavT1oPPws0iz6YcBxw9Y=
Received: by mail-wm1-f53.google.com with SMTP id c84so5044356wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:17:25 -0800 (PST)
X-Gm-Message-State: APjAAAXw2o8w8g1QE8zzf86Oe1vRQXqNxEIsz1vB2/JRjL5pnyUePjuJ
        hAFaJT1qAkp6Ba9X5Kytb0jckeHhB1Hoto4zO8gK3A==
X-Google-Smtp-Source: APXvYqwFbS10N2WftuTlDwIzWSDLb9H6kCzWQcP3jbZxJdg1lQL3WQdMBg7Hp5BrowW1+nlTRrL8d3TJrkKcVqUXKr8=
X-Received: by 2002:a1c:3906:: with SMTP id g6mr635337wma.49.1580951844067;
 Wed, 05 Feb 2020 17:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20200205223950.1212394-1-kristen@linux.intel.com> <20200205223950.1212394-9-kristen@linux.intel.com>
In-Reply-To: <20200205223950.1212394-9-kristen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Feb 2020 17:17:11 -0800
X-Gmail-Original-Message-ID: <CALCETrVnCAzj0atoE1hLjHgmWjWAKVdSLm-UMtukUwWgr7-N9Q@mail.gmail.com>
Message-ID: <CALCETrVnCAzj0atoE1hLjHgmWjWAKVdSLm-UMtukUwWgr7-N9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 2:39 PM Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> At boot time, find all the function sections that have separate .text
> sections, shuffle them, and then copy them to new locations. Adjust
> any relocations accordingly.
>

> +       sort(base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);

Hah, here's a huge bottleneck.  Unless you are severely
memory-constrained, never do a sort with an expensive swap function
like this.  Instead allocate an array of indices that starts out as
[0, 1, 2, ...].  Sort *that* where the swap function just swaps the
indices.  Then use the sorted list of indices to permute the actual
data.  The result is exactly one expensive swap per item instead of
one expensive swap per swap.

--Andy
