Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C851C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF4021556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578944687;
	bh=iB8vGfDlaHIUZ2AV2rd53ZOdGWj2rHs6LWJYKBYRW+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tn7UTGzA9ykluCtD5SpDRiGxCqtX9p9eI9hH0fQ3y4rBNhq2j1LW7OnM1njNZBJeo
	 x/tMZid2XIY/enpv33uQ3YHuxRs71/X8qhHBU9XnVOb1fZX/3J0ZQwwfmxCo0ADzCz
	 7ayuEx8oZmLJkodZtiXJ+2SCnnOuNkV0DeWtsknM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAMToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:44:46 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35892 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:44:45 -0500
Received: by mail-lj1-f177.google.com with SMTP id r19so11512737ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPAvecB831XwECXLNHT/jipdJ8QCTyIHynNy8tewQr4=;
        b=FK0vItQAusk78N59VNKD5q6yeGqREAJio/AJqlKLNDwM1HMi9cvpnSNBm4zX3mh+ce
         7RXDwy4PHImlGjWKKoyeDH13SoA8NaJMAIEvXv3vHkgB93VujlAZhkGJOUJSQrNxvDxs
         8UBoCzWU2Dt7Re03GPBHR2VRz7rgkGuTbXhR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPAvecB831XwECXLNHT/jipdJ8QCTyIHynNy8tewQr4=;
        b=oOde9j/J9cbIw7hkm3M4WEMfeoJ9zhYBembqW4x+N9SoVet0wB6QKD0gMcXSLYd3+W
         MHbRWzUteN1ml1NZ9AaHZW19fuqMgDS9NgSXYbLhZ8ta+ozWg0oSlikoqiFS5NSE/zrf
         e6iOQyIBHw1OK2Y1uwttT9FUTUjZ7Jh/uo2eosPYaZDOqcZaCihZUQQkZJbkbjYL7B4P
         MpQFxIJj/XGmx0BPvGqVp5Z2h4kMiNIxq20bGYVsxIde5zXCDsuRsRGYqxSPHL51zea/
         nt7zkoiFAk8E7ei/fmPltRY1xG/YuYhXE1MP7zCdN+qDDrM97HD98rQx9VfNpzyoA02y
         0YaQ==
X-Gm-Message-State: APjAAAXtgqOqdBpNEFmIMMVt31VlGZIbDjDKZ2BiLxhvG3y1A0qNf1dV
        KQzuZ3/E3XixkTuhc9XzCOeDN8TdxHM=
X-Google-Smtp-Source: APXvYqy1PYrpOqEV7nbVwrXX+JAgZdMNuqmyT6SYora4oDD3qZRo5s3/KjvtUXHH13mRkuaRGusp0Q==
X-Received: by 2002:a05:651c:30a:: with SMTP id a10mr11698736ljp.101.1578944683321;
        Mon, 13 Jan 2020 11:44:43 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y7sm6130427lfe.7.2020.01.13.11.44.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:44:42 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id r14so7820058lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:44:42 -0800 (PST)
X-Received: by 2002:a19:22cc:: with SMTP id i195mr10887464lfi.148.1578944681789;
 Mon, 13 Jan 2020 11:44:41 -0800 (PST)
MIME-Version: 1.0
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <20200113154739.GB11244@42.do-not-panic.com>
In-Reply-To: <20200113154739.GB11244@42.do-not-panic.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jan 2020 11:44:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wja2GChi_JBu0xBkQ96mqXC3TMKUp=YvRhgPy0+1m5YNw@mail.gmail.com>
Message-ID: <CAHk-=wja2GChi_JBu0xBkQ96mqXC3TMKUp=YvRhgPy0+1m5YNw@mail.gmail.com>
Subject: Re: Fix built-in early-load Intel microcode alignment
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jari Ruusu <jari.ruusu@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>, johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:47 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> So I'd like to determine first if we really need this. Then if so,
> either add a new global config option, and worst comes to worst
> figure out a way to do it per driver. I don't think we'd need it
> per driver.

I really don't think we need to have a config option for some small
alignment. Increasing the alignment unconditionally to 16 bytes won't
hurt anybody.

Now, whether there might be other firmware loaders that need even more
alignment, that might be an interesting question, and if such an
alignment would be _huge_ we might want to worry about actual memory
waste.

But 16-byte alignment for a fw blob? That's nothing.

                Linus
