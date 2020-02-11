Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E5C352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B42C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581386879;
	bh=1MYGgmlzJpyLavV3biDwxtj79pK1sz/V5VMPWkewTR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YVJNCj9gQwQ6jXIJpcxZvcjlIKmR3OngUATb0jdVaN/Wc9X1X2IuqqoYsFJQ7GI3b
	 JgXvb/epASSRsLJlrnhElJKD6UefKazByEC8IZBYii+cwJKa1O2xUf7YzWJNyGMEzf
	 kd3PGDFxCwfch+axXfr0Ya9+eVWP7Y/9zO8ErXgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBKCH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:07:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgBKCH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:07:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so9741691ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZmktFtWuNRr4MBQJWn7k52Pxjy+kjDuDMoIZxcgghA=;
        b=JShucc8r6D0hpeQT1Nnrm1g5ANmN7Qo/kC9ja9eYheqbwRWtW6iBI7iAF7MqgaTDXe
         EhrqvIPUINQoMoQ8goy1qNA3ZRXhiyGuval5jBA1G2OdAVfZKMH31Bd7+08ReOWRrocf
         QaEnZGmB7acwDOJTWolplby3wrYLVP5sMqcdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZmktFtWuNRr4MBQJWn7k52Pxjy+kjDuDMoIZxcgghA=;
        b=LJdiOZ2zGqryK3XNUeR9ejlCy1zoXrIQZqYI1eQBUoyDrpTIxHiT3e7rfII/IrDsE7
         9OlyzNiJp0110rqdEQqMfRcT9/dzPLpQEC0g1M4yk4Bfm8kfRYYqCPRRPdtINeFsOiuD
         uJF8PzpoaPH1PU3JtuU/cTSPdCAHhlXfe/BI4VBfld39XBPAo7Cam5AknoxY6V6LNLhu
         6YxTesG2BJ9P5lZ/UWjYbXp8B/7G6TOfodWQOAjkBJ5DLUil5kpYDkVZeqLg0pcaNmdG
         tyurOv8fB02YCLEMrUwaATHXE5wpVz0AJUMFvxP/k4gKZ99cKrvZxrcJLD2sqifl2Wxe
         kg6A==
X-Gm-Message-State: APjAAAX6JbGcj9gpAtw4+KO3lU+l2e4Z2I4eGyrncMyfSr0qwpEg83zG
        CAUgJOUSb+2/1BN0KyEvSzWyt643kKE=
X-Google-Smtp-Source: APXvYqwdas/6EKuKCdTzDzwr4CR7dVDK2OpFsZcAxFyadIYrqAsd4dKMnHjuELleG919lIo3YeGlVg==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr2795390ljn.85.1581386872831;
        Mon, 10 Feb 2020 18:07:52 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y23sm1161673ljk.6.2020.02.10.18.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 18:07:51 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y6so9795643lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 18:07:51 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr2637598ljj.241.1581386871172;
 Mon, 10 Feb 2020 18:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20200210010252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200210010252-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Feb 2020 18:07:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvPamkPZCyeERbgvmyWhJZhdt37G3ycaeRZgOo1bpVVw@mail.gmail.com>
Message-ID: <CAHk-=whvPamkPZCyeERbgvmyWhJZhdt37G3ycaeRZgOo1bpVVw@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 10:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

Hmm? Pull request re-send? This already got merged on Friday as commit
e0f121c5cc2c, as far as I can tell.

It looks like the pr-tracker-bot didn't reply to that old email. Maybe
because the subject line only says "PULL", not "GIT PULL". But more
likely because it looks like lore.kernel.org doesn't have a record of
that email at all.

You might want to check your email settings. You have some odd headers
(including a completely broken name that has "Cc:" in it in the "To:"
field).

               Linus
