Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C82C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB6420810
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591052566;
	bh=XhbBifJQqvdMwwetAuiKQuVmgGTnDXXsKzXhsC/UIuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mgxZcph2quGKdAsUPlRQS4QD+2IiXKulidJFsdhaPilhO65pOx4xQ4n1cYXyMu+oD
	 YpgxLmZ+oGfO5IbrfCnYR6w/Biwp/YBykKjczIuPAyIbKXt2whECasdQOxC4Y7fQhV
	 hYSYp4FrasopewGt4rT6ZyKFSF/hIyY3WDniN73w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFAXCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgFAXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:02:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CEFC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 16:02:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x22so4958619lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSHwQ0uPZoaHMKtYLAn4QPLBbehuBaSVR98Wt0x/7aE=;
        b=EuKWpEBiPS7K4/uT67dyk3jcSYd2f0NPX+CKAiHHpYSf+EW1K6JH9XuZpYMPFm3Gn6
         wyUa+Ap+e3LHRPnsSp7YUcMaCOJmLkBMgqJmGaX4tCn+kxCKZzXuIfuQI40X5Qt0Y7Ud
         H032H/GhU7K9m5veKB7FD1LFV4i/p9NAK9s1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSHwQ0uPZoaHMKtYLAn4QPLBbehuBaSVR98Wt0x/7aE=;
        b=iW1oiky7li6EELWrqpB+IZQrxyfZRRTGTlWsQDH+SmsRBOXqoM9K3NZMMGR+gNaFDn
         GGqIWLHfuYhc47hGoyOuKAx8CGTYD3pAWYPPGaMCc06dTZbAtPFMDeE76NqelCmOfXRc
         vSflB0QTG88FTE4Jv03r/ul7gghM3Z2m6cToxrWFvY8ftqEisQyK4ZZ2Xx2Qf5NgS3pG
         A+W8WXUWtcBVOZenLSyiaeFViMOgaSsVK419X7U+8UViq74Sf0aIw7JR9j4B66DO6M5M
         BmKvKLiNJbgDpgwjL0+/GX0heRjn9yOdNZ9ymXrUOeHelU8ED/fGIy7l8/sbdNz2EAZH
         52+w==
X-Gm-Message-State: AOAM532+SJwOIWsV62nXr6nJHr+AmsYn5OLwUyazqz/4KvyB1ZvrP2fN
        KOU8CQlRjNK24iLArZKrAWsCXXj5Qj0=
X-Google-Smtp-Source: ABdhPJzb6xDe5FSipui7snBf7UIGuoAQk3zc17Ydcanjq3pD8GV71TRb16Lhuv275RvCMseGbyTFkA==
X-Received: by 2002:a19:c311:: with SMTP id t17mr12287071lff.58.1591052562697;
        Mon, 01 Jun 2020 16:02:42 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h24sm229447lfj.11.2020.06.01.16.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 16:02:41 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z6so10194547ljm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:02:41 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr4913722ljn.70.1591052561069;
 Mon, 01 Jun 2020 16:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200601132443.GA796373@gmail.com> <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
 <CAHk-=wjt9O8JReJbSTLTSeZoD3X9KkQiMhQfgRyqjA1FyQXgRw@mail.gmail.com>
In-Reply-To: <CAHk-=wjt9O8JReJbSTLTSeZoD3X9KkQiMhQfgRyqjA1FyQXgRw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 16:02:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2xgJ=nnfjW-yYQ4yzMOTQ17eVsfQupjd3dXu1BuguUA@mail.gmail.com>
Message-ID: <CAHk-=wh2xgJ=nnfjW-yYQ4yzMOTQ17eVsfQupjd3dXu1BuguUA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI changes for v5.8
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 1:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I'll try to remember, but I probably won't. So it would be lovely
> to be reminded when I get the arm pull.

Well, the arm pull already came in, and mentioned it, and it all
looked entirely local and simple, so it's all good.

Or rather, it's all _potentially_ good, but completely untested by yours truly.

rmk said he'd take a look, but maybe Ard might want to peek at it too.

                Linus
