Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9AC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDCA21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekbaXVjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgAMGae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:30:34 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42499 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbgAMGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:30:29 -0500
Received: by mail-ed1-f50.google.com with SMTP id e10so7454211edv.9;
        Sun, 12 Jan 2020 22:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CJ4ZswgCxRhQ6h5Ad3QQvTSlKhWbXFgXln0BG8u9GAg=;
        b=ekbaXVjI21kUlN/zb/O6dio5edYHM/QuT1OTt45TXWtmactU1Cn0mWHSf1ZDdCrCp8
         QKq5sKH0n3L3JuxXw3lzzfJrJGip4xm5VjTPqFLU4oidgbUgzisUUvl10Qeeoh1Ujz3u
         f64H8a6BFhrFs3w5OQmt7byyo42NlVQkSWSMqcEC9QXtZBj/OtEsR5QGLM+3akpNCtlo
         2bCZtJt1BHSa6FevfR1QXpbgWqyBvPU44o3rpC1/rpOyiI3v8pmDoESiPFBP7Tenv4ei
         KlOGg+90xu00RB7AznQ+31dMHYb8Vdryzs2O38GwYldKkVnjULTAcXSe8WQ/Y0RFeYIK
         YkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CJ4ZswgCxRhQ6h5Ad3QQvTSlKhWbXFgXln0BG8u9GAg=;
        b=gIpWiHVN8oX7462b2b++XZqDmQK81mDjBa3aFufvXgNjyTdvThhj1q3xIUGa/EAJjR
         ayAwXTjpebwEcm1pf+mXIko0/ylVS80zsFPr8YRPZV7qZsxBqTr2qCIMJA2xwYKGq48b
         19wU8CeFVM17fdm1waxL2antLKFI2fd8NVRDyxYtekblVdokQ3hpxID1QrB5ZORlptCT
         PlQ0VviSeku3etszTUY3uUQ1aKLtYN1LQQE9Lya9s11Ob7NoIAijR7r3bJMegsHXHn6l
         C2Vp1TTX7llscS6k1E4NcDYh4TbR3YRilFfCOGjADDPPxu8/ygLt4kNL8vHFdabY75uR
         RpBQ==
X-Gm-Message-State: APjAAAXWCCsj6Eoagvk26wMawM3AXBWa68zy0jHfl4eDERzlCkdWgwhn
        cDDuljbMEmqYveXRlt3jqT28RayriW6xPPFxMSg=
X-Google-Smtp-Source: APXvYqzZdU/zBcFlC1Qppl5O+e5V/0DsFkCsg7jwBIYaTqVJTQE7M/VV+aFBv4Z1ZRjJzZ4jtzqM/jb+plq8wH5u/94=
X-Received: by 2002:a17:906:5586:: with SMTP id y6mr11953821ejp.336.1578897027885;
 Sun, 12 Jan 2020 22:30:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:1c11:0:0:0:0 with HTTP; Sun, 12 Jan 2020 22:30:27
 -0800 (PST)
In-Reply-To: <20200112140218.GA902610@kroah.com>
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <CACMCwJ+FE8yD10VF07ci6tTqiBA8aBejKQT0EwyayQQOrLGUKQ@mail.gmail.com> <20200112140218.GA902610@kroah.com>
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Mon, 13 Jan 2020 08:30:27 +0200
Message-ID: <CACMCwJL7uqMtp7Jg8GdrRpJkk7jeMrxksr4EXQq86Agw9Zme+A@mail.gmail.com>
Subject: Re: Fix built-in early-load Intel microcode alignment
To:     Greg KH <greg@kroah.com>
Cc:     Borislav Petkov <bp@alien8.de>, Fenghua Yu <fenghua.yu@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/20, Greg KH <greg@kroah.com> wrote:
> On Sun, Jan 12, 2020 at 03:03:44PM +0200, Jari Ruusu wrote:
>> Backport of "Fix built-in early-load Intel microcode alignment"
>> for linux-4.19 and older stable kernels.
>
> Any hint as to what that git commit id is?

It is not in mainline yet.
You have far better chances of pushing it to mainline than I do.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
