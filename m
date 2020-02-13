Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D0C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8620848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvOWm20J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgBMLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:12:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39155 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:12:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so6211130wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjbPZrEbtFmqBlxSEQ8uJW/5jdaC0VtLl/huovljPNk=;
        b=XvOWm20J8V2hJtzrfZP9BsSVOpuodtNgDW83ikwOXQBl1TJEaHj94NjxXPbANZznnn
         OGeoiFim/TK2WS9FCW6wBzogEtRGt/GftYzZYxRSO2j/4Z8PlHtExSFMfKeNvzb68q4s
         VHUvSQnHlzcXp9lIlZR0ciHcdLkOKKAb3r95vbLVJPBEKQdKAXNswuQ5kQ3eEYINkKYN
         RdA+VK/zmq0+7J2Gjh88EuIZhmEuQYsplNQEeumrTzXXenYqvwuSSYCHNM+6nTw9mAv6
         SIk8xIsuQtJMYYEPDWMZR7Cz4nLV0JJVzvcaRxen8iRwyIMMpITMHTk/EPimIERJXwGL
         RC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjbPZrEbtFmqBlxSEQ8uJW/5jdaC0VtLl/huovljPNk=;
        b=QpHmrV8A5X6Wx882qXjmjwSYKotngNgMBm22bjAENpt9lGnniR94Q1Io6rXJqoleya
         O/giUdt3/uI+DMRkI1t4sWi6QLek1gD5+hhpNFpAizgxQWu+HSRvT89U167+KJuFha5Q
         sk1p7OOh2/ymjwFKV6UkocObHdySXqFga89OC6U/4PIuOk8egsUKiE3n9x+e5/ROC6hU
         kR9PeVTxtUHIXtf+24Ag04euJ0F6GNj0eh8ukrqzTFmAHozTowKGaMk7Nh94PRMgJq9L
         RcVNhyZPL7lZP6i+bPLcdg+w7K5/0EWyikzpdr57Pedd0CtdYlTQAc5wB2nnLVfXjRp2
         OrMQ==
X-Gm-Message-State: APjAAAV6MCfZ48jVI2Vn4UK9VU86cLgnHgRMG+mRgqtrRX9t2mGfsA2h
        +8nxFTboV1gq+1kxUlD+YPE0Z2VfjD8JqUh5ohgBwA==
X-Google-Smtp-Source: APXvYqxrfIYPP1alv0HAEx19Rj2wPXEesEtdsffep7m+n7renjP/jG11icrYenbgM8sL3AwqLhoQFTxp1g29tBjw2Zk=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr5174972wma.62.1581592332274;
 Thu, 13 Feb 2020 03:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20200211174126.GA29960@embeddedor> <CAMuHMdVZq3Lho0HxEvhv8di=OCBhvNEo=O198b1iayX_Wz_QcA@mail.gmail.com>
In-Reply-To: <CAMuHMdVZq3Lho0HxEvhv8di=OCBhvNEo=O198b1iayX_Wz_QcA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Feb 2020 11:11:59 +0000
Message-ID: <CAKv+Gu-eRn+H2xj=iYW8gqKRCWWzeOTbC=9W5nKae0ytq5NYGA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Replace zero-length arrays with flexible-array member
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 12:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Gustavo,
>
> On Tue, Feb 11, 2020 at 10:49 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> >
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > unadvertenly introduced[3] to the codebase from now on.
> >
> > All these instances of code were found with the help of the following
> > Coccinelle script:
> >
> > @@
> > identifier S, member, array;
> > type T1, T2;
> > @@
> >
> > struct S {
> >   ...
> >   T1 member;
> >   T2 array[
> > - 0
> >   ];
> > };
>
> I've stumbled across one more in include/uapi/linux/usb/ch9.h:
>
>     struct usb_key_descriptor {
>             __u8  bLength;
>             __u8  bDescriptorType;
>
>             __u8  tTKID[3];
>             __u8  bReserved;
>             __u8  bKeyData[0];
>     } __attribute__((packed));
>
> And it seems people are (ab)using one-sized arrays for flexible arrays, too:
>
>     struct usb_string_descriptor {
>             __u8  bLength;
>             __u8  bDescriptorType;
>
>             __le16 wData[1];                /* UTF-16LE encoded */
>     } __attribute__ ((packed));
>
> As this is UAPI, we have to be careful for regressions, though.
>

These were probably taken straight from the specification. The [1]
trick is used a lot in the UEFI specification as well, for instance.
