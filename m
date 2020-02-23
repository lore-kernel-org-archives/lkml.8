Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5BC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A802071E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424585;
	bh=MUvCj7R2wNc1EfhAUPwgobXVW1ksw6ZdZTCit+VUhWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r47n0O3A+2IkMmmYgSkehfZG3cFe7dShDA/eF8JGXIsckLSu5N07Kv2DYc+k4XW2d
	 4AGES3uSxbcHff9Go9jRNtrhi7yC/o9ZUcXOnY0muiuNVj7a2DMRt6tb+SfKQcfHh2
	 W5GQTtvLR1dmgjlLqrWpqi7HLKcpFLy9zdg+WiJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgBWCXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:23:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgBWCXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so6204759ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRiUMLVal6a47Pn0KiyPnBHZC0rhgcARtYIItZoVMts=;
        b=cONgu9fG5pE/tWCiXtgOF5ceYHdHZxNumSvYoyFsvLp9PS5M3fb0VPF5CuTOccSzER
         r2NpU2iSrvNXG0WR0NFnOm0HM9MXa0tN+yL++q7ziS1cy/uG5oeUPcx10pfWU/Hr0Ynu
         w3/+07uf8cXa3uKMy2VDDKuUVcP4LO3LE57ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRiUMLVal6a47Pn0KiyPnBHZC0rhgcARtYIItZoVMts=;
        b=T1GkbsGDeDB9lckNPv14wndX7laCG/n5/mvBOCS+FlCMb9AMW6+SdpMehxsgDt9Xdy
         xY0WTQth4aTs/Pa13wvzXEIOymVfrYOAKxu2c+E4cmKVmPzkw87Z/D9GJ6R6mxhkdG2Z
         run53r3gV8YtkwIOLBm6bJZBSuUVMxJZi11IkSsl34wfU3kNSvRkhOOpV0/bU5ncPjoL
         ZHM+gd8AaxFgeQtdefwxpb8pWsCZrQln0LI+p61K3tBy9qIve8cOMmyutzDn8a/8qeth
         0XRJ25O5uxA1AV6/2VeYhreUQlisU3NhpXr4jw78Oo8AM4ReXwIRS75gV6fJBsOsHNOg
         P//w==
X-Gm-Message-State: APjAAAXVYXHSsn7F/VeG7w+M5J8/+scktlTLCOro6Dj5mn5sVlReb3F6
        St6M7xLvhgzSgPo3G0RFas3xEun/M0c=
X-Google-Smtp-Source: APXvYqwSSUbkYiaIpWP8rqQeMBhUJ1TFu17o/wQjFQbjsfJvTz0wVnbCyuN8VuYEIyhMuhSBgNS8vg==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr26739439ljg.166.1582424579974;
        Sat, 22 Feb 2020 18:22:59 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y2sm3993816ljm.28.2020.02.22.18.22.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:22:59 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id l16so4319818lfg.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:22:59 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr23906945lfb.31.1582424578811;
 Sat, 22 Feb 2020 18:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-22-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-22-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:22:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQaqgkZiNX6+zG5kqOPWSiGKh6iis_n+Z0dfTBJeQLCg@mail.gmail.com>
Message-ID: <CAHk-=wiQaqgkZiNX6+zG5kqOPWSiGKh6iis_n+Z0dfTBJeQLCg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 22/34] merging pick_link() with get_link(), part 5
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, one step back:

On Sat, Feb 22, 2020 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +       if (err > 0)
> +               return get_link(nd);
> +       else
> +               return ERR_PTR(err);
>  }

.. and two steps forward, as you then entirely remove the code I just
complained about.

> -       err = step_into(nd, flags, dentry, inode, seq);
> -       if (!err)
> -               return NULL;
> -       else if (err > 0)
> -               return get_link(nd);
> -       else
> -               return ERR_PTR(err);
> +       return step_into(nd, flags, dentry, inode, seq);

I'm waiting with bated breath if the next patch will then remove the
new odd if-return-else thing. But I'm not going to peek, it's going to
be a surprise.

              Linus
