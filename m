Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD7C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6463A2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579724164;
	bh=UwSm8VaE5Zar7jbwm21fqcL8/v1SlG8YOnDXnHw17ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JmlhuTcBgX/TiorIZoNIh1qd9fCVxpteJdAHPKmFBWC7T6zK8Hj93zpIR/MJ9ItsG
	 bovIMoo5stkzH/iu9bFrlV4Od1vBZFJRUSfoxl1u8M9nbe99Rr0nSKf46FQZF/VoCw
	 NMsJVtF77zMYREJT6fhVhso4sfs2qYPeMCI0iaTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAVUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:16:03 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34445 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAVUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:16:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so606770lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLaXGgH4O8WRc84Pr2qZRgc6Y4dR2xbO1cV7z28yhvw=;
        b=c6/3aq9HZcbkVeterj3636njxvpxgw2prgy9shUHvAD8OXcz0f+wkIkYAuQbjGEWBg
         wVKr74EpV63VLAZVJqyVwqQj1WCI2m0sZGTgzXF83HkQ+44OAwRd+/sOaE20vmKvYmlT
         36kGk2sd4GMMWPOxwa4EBhU0TxNUpffdyIDvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLaXGgH4O8WRc84Pr2qZRgc6Y4dR2xbO1cV7z28yhvw=;
        b=eZeedV9/KZOKlQJ12zr9J4Z5j2TIHzbiU+NkrqAFXDee6/4R5pneIAAwmHY4RLYoZR
         xsMYSoLAd6LHrPnvoPsNM4nLz0zz8b60Ec+TwPGMKg8LYy1dA3EGe0dIsCx8pIF+Hkcy
         IS9KFzaz86xkpXlHjnS+BJM+JoPt53FGTf19C7WmUJtsryC2aOU7uETdTsudQOdlF51g
         yIJZ/wXaQ+oMEhisG/kP/UqNOnfmpOd/dSumTvNyGeaTya2Ae86Wirp1oPOZJeLfyywf
         hwJnkuqzp9SFSzqO1xRAWpRA30IGNB8V7weqxdX+TNt0P6ALoSNJiA/obisAxkYUpthk
         queA==
X-Gm-Message-State: APjAAAXVwZB+GXQBhUoannrvzzWRQ+tz7+hdlyvVYaH3lxX3WsB1+q7+
        F0/Us1afNZrtssRVDGsH/eVDl8/S8Aw=
X-Google-Smtp-Source: APXvYqx+byr03N4H26lk76L5AlAXTN5d+NoystmwdiqLSbvTH/4+hiFVa1uKpAYuXjCAMX2RAwMljg==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2655537lfl.185.1579724159657;
        Wed, 22 Jan 2020 12:15:59 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v29sm9823547ljd.69.2020.01.22.12.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:15:58 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id a13so450097ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 12:15:58 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr20649915ljo.41.1579724158165;
 Wed, 22 Jan 2020 12:15:58 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com> <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
In-Reply-To: <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 12:15:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK1Pbj4DD4OLFuFg1Tgvup85h9W5ZroCOwAE1qCDWuBg@mail.gmail.com>
Message-ID: <CAHk-=wgK1Pbj4DD4OLFuFg1Tgvup85h9W5ZroCOwAE1qCDWuBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> A bit more re-organization also allows us to do the unsafe_put_user()
> unconditionally.

I meant the "user_access_begin()", of course.

Code was right, explanation was wrong.

That said, with this model, we _could_ make the

        unsafe_put_user(offset, &prev->d_off, efault_end);

be unconditional too, since now 'prev' will actually be a valid
pointer - it will match 'dirent' if there was no prev.

But since we want to test whether we had a previous entry anyway (for
the signal handling latency issue), making the write to the previous
d_reclen unconditional (and then overwriting it the next iteration)
doesn't actually buy us anything.

It was the user_access_begin() I'd rather have unconditional, since
otherwise it gets duplicated in two (very slightly) different versions
and we have unnecessary code bloat.

           Linus
