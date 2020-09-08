Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38352087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="osadIcsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgIHTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:08:04 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:52273 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731444AbgIHTHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:07:35 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 087a7bc0
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=v+IaKqTzajthwRuBeL8SUc47y/0=; b=osadIc
        sxEsxJYoLQkcN8ueOwsO2hJkvpqCKOEKAetdJO2vr8+7hIO81q1YJelVd6yrdZbh
        F2oyKFJcfsL4tkB7sJYYbIL4pkfW5gVPJ/iWoI3L27IS6RHJD7WrJhuSpf0gh2zs
        wucK7kLHGhK2zfOiA7x4YcQ5CoDk0Tdbd9QkyIoyDKMJRpsxWK5MBSRONoTuXydg
        0kz438jbR0QrrsM9kuB1Ixy5IgwCiA+UjSW/4+D1+nnBIcdIpAu9gei253gy75Lk
        9gvGw6SO0YcgsMxbl5hYviBpX+gTkYMMt07/6Tp0r3lHFXEOLRCUg3esykz+o0Xb
        /Q1iQR0hvs6+3jwg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21954bbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 18:38:37 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id y2so16470169ilp.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:07:32 -0700 (PDT)
X-Gm-Message-State: AOAM533hJYeVwg71o1R1f8uQFbzUQS6qp9FsEkfcnhjmXq4yHCIpb3IX
        sQl7eOZ0vM1v3rpqGGSbMZe/ZFKJpmMQvk3TFAA=
X-Google-Smtp-Source: ABdhPJyoPSCQWdVbTbi2jdo1d14h4gnPzGryAJ/aLbRzniVKIRbBl7Okl4RY5iR6bRxaG0EmnhV1ziz/3OTjzv0lGNI=
X-Received: by 2002:a92:58cd:: with SMTP id z74mr226562ilf.224.1599592051270;
 Tue, 08 Sep 2020 12:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic> <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic> <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
 <20200908180112.GK25236@zn.tnic>
In-Reply-To: <20200908180112.GK25236@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Sep 2020 21:07:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9rMbuXfR+eNhopX8FyeXerUrPo4vaWpF6Dx-u3NnTmrVg@mail.gmail.com>
Message-ID: <CAHmME9rMbuXfR+eNhopX8FyeXerUrPo4vaWpF6Dx-u3NnTmrVg@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:01 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 08, 2020 at 07:42:12PM +0200, Jason A. Donenfeld wrote:
> > Are you prepared to track down all the MSRs that might maybe do
> > something naughty?
>
> I'm not prepared - that's why this MSR filtering. To block *all* direct
> MSR accesses from userspace in the future.
>
> > Does `dd` warn when you run `dd if=/dev/zero of=/dev/sda`?
>
> Yah, because that's the same as bricking your hardware. Geez.

Nobody is talking about bricking any hardware. Sorry if I seemed to
imply that before. In my experience, undervolting improperly results
in the CPU calculating things wrong and eventually crashing, and
overclocking usually will trip some thermal limits where the CPU
powers down. I've never experienced bricked hardware as a result of
this.

Jason
