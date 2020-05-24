Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E73C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F3E206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3UMUo+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgEXRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgEXRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:21:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD6C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:21:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so5672157qka.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yaQbyc25RqKKkOAhEkaw1xc+vmh3Cee1FjzEZxcqNM=;
        b=p3UMUo+Y7cqhA8YXDA1S3xm1BT3lRjqwfEnypkY0sIgdny7gwd91b4PcFlvJTb6XY2
         Gf0Yv9889A41M+udDV5U12ZCN+962b2Gh1shG9QnvX3rSYF+m5wKV8SN4oz0Rg8T1eDC
         SQDoLEMI0Fqv9thyomqohtZoQIlZfuVuP/j/9rhluR9KK2HoVQ2f27KXzYEfpP835n8V
         gVsTq8uvrFQZ/gcyKjz710Q8oaD/hLc5e2rmzw/zl/dl4GOhA3lkTwHjwYmWdGu38bGk
         d1csJgNME0Z1qE8XC5ED3KyMCnDYHmkLsREajfFGWr962I0X6vDsHsJtRjHwIK0OqhJ3
         N/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yaQbyc25RqKKkOAhEkaw1xc+vmh3Cee1FjzEZxcqNM=;
        b=R73esnH8rIadtRvWP79txiI+2bc6ukOPhHlMMJJ+rWCRZfOB1Fxp+xLLS5nvyWcseu
         GpAhej98+uB4XRoIuAjTNs/+PuwjMLQ4VuIo+6QfEk7cdOjJ1sgTSanrdYB8LRSTv/JJ
         Pd+Oa9nXX3JXdRYTxo3dXA7zSd4pj8DKOOZKa12+zSvOEqunqmzuhl3/G8T9RrCpiC1T
         odh6zdqdkPgAE2wvAOdzG1pBJ+BNvBEKJxUuJsApyxLaYs4B/w5rOrieHL8awgfLQsGr
         gDps+afF5Mgq+EHEOqAwaM578M+oxCD41LMCArpyjHqbDz8/T2avvM6YhPaOU0TNJ2d+
         mAQA==
X-Gm-Message-State: AOAM5339s7HmdMweHKSYnnSy+GqFqjg6S54pC9LLrWzQ652RPklvHniw
        bKAfE0Bnim3Xuu1xGqqmk3tJxmzqtNl8iLqngPM=
X-Google-Smtp-Source: ABdhPJzK5UDUD9Z/IcNNHqoev1Fg7LXphylP+EuvxrgJxhiHNqSOfzgI8aG9c3+szRmXbqjbxowCFuQALUCvxmtT9Yg=
X-Received: by 2002:ae9:e901:: with SMTP id x1mr22465025qkf.131.1590340884838;
 Sun, 24 May 2020 10:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200523174957.6294-1-anarsoul@gmail.com> <s5hftbpx1h1.wl-tiwai@suse.de>
In-Reply-To: <s5hftbpx1h1.wl-tiwai@suse.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 24 May 2020 10:20:58 -0700
Message-ID: <CA+E=qVf4kRGV+iwkuVkceumxsPynoEDHCBWsoy3bHWpghte5Hw@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: line6: add hw monitor volume control for POD HD500
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Pavel Machek <pavel@denx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 11:59 PM Takashi Iwai <tiwai@suse.de> wrote:

> Thanks for the patch.
> The basic implementation looks good, but I see a few issues.

> > +EXPORT_SYMBOL(line6_send_raw_message);
>
> Let's use EXPORT_SYMBOL_GPL() instead.

Sure, will do.

> > +static const unsigned int float_zero_to_one_lookup[] = {
> > +0x00000000, 0x3C23D70A, 0x3CA3D70A, 0x3CF5C28F, 0x3D23D70A, 0x3D4CCCCD,
> > +0x3D75C28F, 0x3D8F5C29, 0x3DA3D70A, 0x3DB851EC, 0x3DCCCCCD, 0x3DE147AE,
> > +0x3DF5C28F, 0x3E051EB8, 0x3E0F5C29, 0x3E19999A, 0x3E23D70A, 0x3E2E147B,
> > +0x3E3851EC, 0x3E428F5C, 0x3E4CCCCD, 0x3E570A3D, 0x3E6147AE, 0x3E6B851F,
> > +0x3E75C28F, 0x3E800000, 0x3E851EB8, 0x3E8A3D71, 0x3E8F5C29, 0x3E947AE1,
> > +0x3E99999A, 0x3E9EB852, 0x3EA3D70A, 0x3EA8F5C3, 0x3EAE147B, 0x3EB33333,
> > +0x3EB851EC, 0x3EBD70A4, 0x3EC28F5C, 0x3EC7AE14, 0x3ECCCCCD, 0x3ED1EB85,
> > +0x3ED70A3D, 0x3EDC28F6, 0x3EE147AE, 0x3EE66666, 0x3EEB851F, 0x3EF0A3D7,
> > +0x3EF5C28F, 0x3EFAE148, 0x3F000000, 0x3F028F5C, 0x3F051EB8, 0x3F07AE14,
> > +0x3F0A3D71, 0x3F0CCCCD, 0x3F0F5C29, 0x3F11EB85, 0x3F147AE1, 0x3F170A3D,
> > +0x3F19999A, 0x3F1C28F6, 0x3F1EB852, 0x3F2147AE, 0x3F23D70A, 0x3F266666,
> > +0x3F28F5C3, 0x3F2B851F, 0x3F2E147B, 0x3F30A3D7, 0x3F333333, 0x3F35C28F,
> > +0x3F3851EC, 0x3F3AE148, 0x3F3D70A4, 0x3F400000, 0x3F428F5C, 0x3F451EB8,
> > +0x3F47AE14, 0x3F4A3D71, 0x3F4CCCCD, 0x3F4F5C29, 0x3F51EB85, 0x3F547AE1,
> > +0x3F570A3D, 0x3F59999A, 0x3F5C28F6, 0x3F5EB852, 0x3F6147AE, 0x3F63D70A,
> > +0x3F666666, 0x3F68F5C3, 0x3F6B851F, 0x3F6E147B, 0x3F70A3D7, 0x3F733333,
> > +0x3F75C28F, 0x3F7851EC, 0x3F7AE148, 0x3F7D70A4, 0x3F800000
>
> Just nitpick: better to align with lower hex letters (a-f).

Sorry, I don't really understand what you meant here. Could you elaborate?

> > +     buf = kmalloc(sizeof(msg), GFP_ATOMIC);
>
> Is this function called from the irq context like the urb callback?
> I saw that it's called from the mixer put callback, and it's in the
> normal sleepable context, hence GFP_KERNEL can be used safely.

It's also called from podhd_init() to set initial value but I assume
it can sleep there. I'll change it to GFP_KERNEL.

Thanks for review!

Regards,
Vasily
