Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4446DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8BB21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582051521;
	bh=S+xum8+iKb3FJNdJ58dmNfZUoog88cro/e92JuL/MGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EY8SlBgnssKZ2wSzTjq97Z80suYMTScEnXdNlApIvy9mNHwniaoAw3lUIlcFbauxi
	 g8pt3fJdx9DaKLmOQAw0ELG+OfDkNYqu897fPw15p3CGJmTkvNfNHzmxGsVzQxLCCP
	 VkGl7JVLPNcxrN7G0i/OviEFJVJuUKO0ICTirVPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:45:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39528 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:45:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so24196737ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNeLzd5uvZYWN6498VUwShbkMxciH+WA0SwB5l9Lvfw=;
        b=YCj5W+2X8mUEpKVDH5pH5LMktwPyLdGWrVwBm8WFadeyTkLuczKB4yCg+LqDZA37Cr
         74UopflDMKlst6kRvIXKyA4TFuIgdyQY/ewMgLHiTbh4uJikgynBr/2DaANBx58tYNOq
         YeoieWehb48VDbCpL0df8EsBmrd9MwvSuurWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNeLzd5uvZYWN6498VUwShbkMxciH+WA0SwB5l9Lvfw=;
        b=Ss/mi7qAAx6Bm1SkrVvk7XkrrEGYA7NMEdxhqAmzVjGAj4mCZiy7Y5tUk0Q32s9ARn
         uySBFfx79t4Vdl6nhxHUVE9FDQvvk3+04HXdM1s9CsMPF3XacNMcDBLA8e5jus0hw5CJ
         WCsC9mVUMFEKmUlVmA8dMTaieVGG/pL8exWR5sioNYYNLAuZ6/WYizBSuKagpFUIzh4X
         X0+rV4icTC+IYQ9cPIVxllJc2cCY9k5Pac4LWrwwg/FH1Elsq0j8PIDaHJiPZq2Ec/RF
         O+keKMWBTMUoOJuR+5y0/hcTnfitvZTKhlu5n3nNKkcNF3Kl7QIuGWevrrNoRcOnQ/hZ
         e5fA==
X-Gm-Message-State: APjAAAVjKfy6QRYbEU+Gf4gI4DPP8SG1TiXs33ONrHcYthvamIBOryAP
        HWScyFau0dI2zIMfycbcN1bzzoI+FZU=
X-Google-Smtp-Source: APXvYqz9qT3+emHAAxMpxmU8kc0AOPELKGEf7KE/IbJ9+frL40VbUvnAlXzfBK9XLVDhYAcMZ3yWtA==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr12915206ljg.154.1582051517128;
        Tue, 18 Feb 2020 10:45:17 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t29sm2673359lfg.84.2020.02.18.10.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:45:16 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id f24so15281513lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:45:15 -0800 (PST)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr10888980lft.192.1582051515316;
 Tue, 18 Feb 2020 10:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com>
In-Reply-To: <20200217222803.6723-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 10:44:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmLVGmu26K0W+BH0BPfwWewHmM53Cy-ep=YVT68ToPmQ@mail.gmail.com>
Message-ID: <CAHk-=whmLVGmu26K0W+BH0BPfwWewHmM53Cy-ep=YVT68ToPmQ@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:27 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> I don't see what security concern is addressed by obfuscating NULL
> and IS_ERR() error pointers, printed with %p/%pK.

Ack, looks good to me.

              Linus
