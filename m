Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0783B20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZYffuEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCILiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:38:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46721 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:38:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id h18so9510377ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skc/cnkGW5EmDb6A/txSukNhIWJatTlr853ta4KTET8=;
        b=XZYffuEwIbrL6SXYlyjqcmVdEzAlcc/HMMFFYrFtrLaRVruStGfigXf0jkNK/rTce4
         FmfZzYiorUVrNbLI6THywEyFKhDdz69MRoig0S1RPtQyWAArDLUewkIKpjICoMjGY7/W
         ctNRnkOb6u9PIx6vWcCObShwqB1t4hqBHUotYwJXYkyEVt2gVtfw6XvW+/6tvY0Qwd+i
         Iq8YrpTzxTw98hni/v1hBFMKJESNmcd7W1z92Hdjy/TGVymzfbksdGTlKuVcKI/OZjUJ
         PBDPTaaeurPiK3v9yYhIaipGlPr58/Nlofk5VqZpsgb0iQuAIdtLuZbMAH6Y4/8UEkVH
         JRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skc/cnkGW5EmDb6A/txSukNhIWJatTlr853ta4KTET8=;
        b=t33Omwxxga7h0RLGElf5ESJeUiarr97WTNbFDg9YqzGUc/Y9Z6QM7Fq5/AO86/O/fi
         2QhpMQenhZRuHynwfqnrngug9DyHZkOLKBCRy284/o7pmCZozXN2/d0x4ezEGe7yuWJG
         armpOyMJBN/4dyx5tYdY5KsjK5YTxk+pM3TUzZzsAvDTqG2Rnf5IEyLeI8FIRcrJBgJc
         Lvk0iTfvYY3yGep6HY8qZcUDcMdAsKHWQK4hdjzC+yEWJjuzS++YvK/YrLZVJRajZflx
         FxczrDte6GGZhhTQZcbwTNW/MVDWvtH7yaG82fdoKIKfk789WJ/Yr3zxR+Dh9d7PwD6I
         sqvg==
X-Gm-Message-State: ANhLgQ0b3B31L38om9R+I38Mh7bkc5TbTNwO+CamYA8v2XuGMlH6Tqtn
        7G22MRbmuZ+xJuPmqurQBHk4Zqgy8TIPC6ZKpQE=
X-Google-Smtp-Source: ADFU+vu7eDXvIs+yiff4Dtnc7iz0KBuYRKLbFdD0kJAVzJVFwj9dTrV7ihGu+vJz3Z7ScUNRN4qjpOzoSXe8jSS/YVU=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr9446467ljg.194.1583753880400;
 Mon, 09 Mar 2020 04:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com> <20200309021747.626-2-zhenzhong.duan@gmail.com>
In-Reply-To: <20200309021747.626-2-zhenzhong.duan@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Mar 2020 12:37:49 +0100
Message-ID: <CANiq72kFFhM5zBscELtS8OVpH8wG3837SfOS-maHTodpCoBKhA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file
 into miscdevice.h
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, mpm@selenic.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>, b.zolnierkie@samsung.com,
        rjw@rjwysocki.net, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:18 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>
>  drivers/auxdisplay/charlcd.c     |  2 --
>  drivers/auxdisplay/panel.c       |  2 --

Compile-tested these two for arm and arm64.

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
