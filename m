Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9D2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fznGwjSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGINIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGINID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:08:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0DC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:08:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so1092824pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Arpvxm12PLtqyJPJz+S0I97EB/5x2ZsWFDQoUmCkco=;
        b=fznGwjSiO3RaAqXL/JXdh3ChOLhq2OdVXhPfn64QRiA60KjRuareCLb2cQoytqMcEa
         K9FobADVyXSHHVtQrGjKnEyF54vGaVnQclxT+GC94JjuxOkOv8clflw7elk67iWCkl3I
         xNzRnbd9gVj0hlkJjZ8OPFFKz3QKZ+jw9bNLARoOmRwmqDLud4O2Szpwve+F+IH49+jj
         B+bhJdHgplYVe4cKIz8jreKyT/R/otMuJZYANPs2w2YOy+OfUA/SmvpNaG0HbkLrDy93
         DH8BrW1H7OD1Eg+rdJkh3HxPYDlYrC/UsA2hf8NJrUeroUnstJBiOdgL9U9jn1W6REX0
         12vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Arpvxm12PLtqyJPJz+S0I97EB/5x2ZsWFDQoUmCkco=;
        b=f0ISTgo6ZzQD+B5n1kUPRLhgXDS+HTvR9UGD4vfjUWMH9IeGVTsfovTUJGgKMnXMKO
         tO+Zkp8A6mixIdHiG+IluJ86sMB0H+UoeKHY1xHg+G/bZgk0ZHdpCx1nYH7NccQO1JGm
         icnspnVpLxpfAU2kE6fcoolRDoID/5jDrh68ZyRm8IQa8vkDiSwVh6xZUq41pHl6TvXk
         Rq9/TL4RNNlQgReHygfGVrdolMKlVZjfZjgHfMmfaz6+0w4gNyu5BH6CxOGntz7q0Ake
         ofNVpywaZsnXr+ibFU9mJbJdKgifZ/rFAsxNlDeiqYhuLR4+TFKMZOrsj8NZWH5NJadw
         eZqg==
X-Gm-Message-State: AOAM533oQFJpkMVp9sY0jCK7jkNrL3m+0moX46WVRADk71ACPY3C/bWJ
        M1GZQo9jGbStNKC/cGL0GE0=
X-Google-Smtp-Source: ABdhPJxg8dSvn+lh7WeNszbLKluvKCSn2H8HnmFZerTp+0tmvgQOf/pEWtRsUkDaMkbJcoIjLvChHA==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr15056098pja.180.1594300082504;
        Thu, 09 Jul 2020 06:08:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 191sm2813150pfw.150.2020.07.09.06.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:08:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 9 Jul 2020 22:07:58 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709130758.GB4380@jagdpanzerIV.localdomain>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
 <20200709105906.GC11164@alley>
 <20200709111310.GD11164@alley>
 <87zh89kkek.fsf@jogness.linutronix.de>
 <20200709122448.GJ4751@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709122448.GJ4751@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/09 14:25), Petr Mladek wrote:
> On Thu 2020-07-09 13:23:07, John Ogness wrote:
> > On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> > > I though more about it. IMHO, it will be better to modify
> > > prb_first_seq() to do the same cycle as prb_next_seq()
> > > and return seq number of the first valid entry.
> > 
> > Exactly!
> > 
> > Here is a patch that does just that. I added a prb_first_valid_seq()
> > function and made prb_first_seq() static. (The ringbuffer still needs
> > prb_first_seq() for itself.)
> 
> The fix looks fine to me:

Yeah, looks right to me as well.

> It means that we have two fixes on top of the original patchset. Could
> you please send v5 with the two fixes integrated? I would just squash
> them into the 4th patch.

I'd prefer v5, if possible.

	-ss
