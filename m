Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E09C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE53720801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582241538;
	bh=PnWdemNzl8t3D+ICdzFH3Z7glID+wZxgfxtM41+7VPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0dse177FeIe0SiDMUCC6XOSSASP248R2c34jJb14iaqQZL1JfAOrYHOYW5mOxnA7q
	 N8esbrFQlKT7vn5csvwhtpvfZB1MFMMHfvEoJfJoQvgwIhDF+aAZ1OmxymUXuFXP+V
	 MPWBYuKGu4l6TsSYOkfB9dSeaN6faCYDPh2xfUqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgBTXcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:32:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41111 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgBTXcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:32:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so247902ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWeBp/urnK4tuGJfqV9ZFGP9TrjtClq354zSDpIQQfY=;
        b=GZX6OFO7fkNUS1d3TzfeLavrKb+nZ6HWPMW1jViAB8AtYBh8cGv3whtpphDdik8l2K
         YtIl2m5ZcTHKKQ1z0FAj0P/4veATqWxebKwQxOZ0rcOFdozjfQo2RaKvMYrD/UncZu93
         6QiaHgv/uUMuDaodJwlKgm24Ve6MdwTVPf/lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWeBp/urnK4tuGJfqV9ZFGP9TrjtClq354zSDpIQQfY=;
        b=TvOL+hxN/0BOimDRkmKpCQBoxRdcKcUIS3pqSPS1Mi70VUUyfiihMAKCQZ+QZilheQ
         epQp42/9difRI0PhPJHpqRWW9Qr0coBE0EY/60KK4j4VvUQEO/MLGFBpXcIyWyrgSuI1
         dRQo2D60n4XZG/FejDW0zMkeqfMGtkfQR5lIF95wU5ZRl/We/b24r9CMEmjsXdAVnqDK
         gIloLbA2GExfcjEdy4OQbOZyMvvdfOUzuHnZ7XkhL1nggrqnsOpOw48aeOLzwZNVnkV+
         KK/v4Yd7xkG52A5+YcgZtT1nWrzCwkVNrpcuoWC1PauO+zJ4yFxJOI8l94UW6v/d438i
         /Gkw==
X-Gm-Message-State: APjAAAVOQgbC/AjA9f/rYgEstvmbep0GCdPukaqKGGcYWGx0og/1I6Ff
        yP84aHRk3lrkZCAWKK01SBKxUDRQdp0=
X-Google-Smtp-Source: APXvYqxUggGoqZqr30JeKpWLhMkp05dHBQSnog68WOI+3IWabKIh4QFJYWwCWB58cjQohYpsX1lnpQ==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr20152260ljh.183.1582241533537;
        Thu, 20 Feb 2020 15:32:13 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m15sm485459ljg.4.2020.02.20.15.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:32:12 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l16so105581lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:32:12 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr18104253lfb.31.1582241531956;
 Thu, 20 Feb 2020 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk> <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
 <20200220232929.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220232929.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
Message-ID: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
Subject: Re: [RFC] regset ->get() API
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 3:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We do know that caller does not want more than the value it has passed in
> 'size' argument, though.

Ok, fair enough. That's probably a good way to handle the "allocate in
the caller".

So then I have no issues with that approach.

          Linus
