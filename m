Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7856220759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595030423;
	bh=hbjLrFoHObjys+FD1IMtvEgoFEJ3mGB1Z3hlXq6o5FM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=njxGYH1DiujrQl876NIUm88Ts9znqiBPY4tHTel7ZLCqkew86ZwHrd+IXdGlBaefS
	 RbgQR4xFSdXgJHFm3KCatx2NUfReBrgoz0Agve9vrGyRYMgK0Eopd/blOqPf7/iknU
	 9fYRLXtgzjOcfJP9l3Tf7f2XB3c+qr40Yf935Cgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGRAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGRAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:00:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D8C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:00:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so14611672lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfDE4ruJhyC46Wi3RsJ/GllVHPpuqL5yVRuFbthLOuI=;
        b=Asvu6yiFTH7mDWS3ok1hQi/vxghIf/ULfa8/lMbwgMAQlGqUqQ2Cwhu6VCvk/zsA+V
         uN8GN3YZiywISGAvc0HpupYOQ101xF+mVckD8yWK+Y5Hty/bx0tsC7rFU6n6O0Vhiqbj
         6SWfBdimEhqyIFp6vGDlFyYi6mUu6JLgQHR+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfDE4ruJhyC46Wi3RsJ/GllVHPpuqL5yVRuFbthLOuI=;
        b=LazXLYfJikNRmp89VFQGMq8woB7X6PJoxzb8V3QgCUBvkfiU+oKDvhwIKio6Arv1XB
         AzrpT+ZrEDrXoPJoOOe6sPT30kP7EfxzOFHykITMHyhFvYS2WrVFgB9rQSwNddcDfZoR
         3r5z5lA8/rkVlkPT+DN6dAnN75lvNpGcxzkPYbND1RwMUG12jOygbDoh3hygtbR6eJUF
         EWeUJxDmJ+/dMI6RexdDDr6q4VwJSrP2kXqAgGwj0LwWE1s8b/LgG1S1IQHGMBWUjGNC
         Ecv4aHBrhc5nMDtbFenJytvXltFUJay/0fA/Fwqj2YWlBdmRT0GnYyDMpuBhevGPLTMp
         acPg==
X-Gm-Message-State: AOAM532odylGUgmsMZBehU6qcyagVLxPRHmNHGVrrp7RkHnkqiWe5XOH
        KOuAj1ZJZhMg94jIoeGj3sIgu50yoZ0=
X-Google-Smtp-Source: ABdhPJy3Hg2330W0RYSf1u85vwznr5p15B9p9EYsOhYBRXGlag7MfjSjCsR+72Pi8ag5VlWCqWKzxg==
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr5139491ljb.192.1595030419018;
        Fri, 17 Jul 2020 17:00:19 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u7sm2547546lfi.45.2020.07.17.17.00.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 17:00:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id k15so7004943lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:00:17 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr5794252lfm.10.1595030417179;
 Fri, 17 Jul 2020 17:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jul 2020 17:00:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
Message-ID: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 4:48 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> Using placeholders avoids tools such as systemd-journald from
> erroneously reporting missed messages. However, it also means that
> empty placeholder records are visible in systemd-journald logs and
> displayed in tools such as dmesg.

As long as the readers still reliably do the joining, this is fine.

HOWEVER.

Make sure you test the case of "fast concurrent readers". The last
time we did things like this, it was a disaster, because a concurrent
reader would see and return the _incomplete_ line, and the next entry
was still being generated on another CPU.

The reader would then decide to return that incomplete line, because
it had something.

And while in theory this could then be handled properly in user space,
in practice it wasn't. So you'd see a lot of logging tools that would
then report all those continuations as separate log events.

Which is the whole point of LOG_CONT - for that *not* to happen.

So this is just a heads-up that I will not pull something that breaks
LOG_CONT because it thinks "user space can handle it". No. User space
does not handle it, and we need to handle it for the user.

So as long as the kernel makes sure the joining does happen it at some
point, it's all fine. It obviously doesn't have to happen at printk()
time, just as long as incomplete records aren't exposed even to
concurrent readers.

A test-case with a short delay in between writes might be a good idea,
although the last time this broke it was very clear in peoples syslogs
and dmesg because it turns out there are lots of concurrent readers at
boot time and _somebody_ will hit the race.

             Linus
