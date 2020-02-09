Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B29C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2B2207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx/aW7/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBILtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 06:49:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40200 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBILtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 06:49:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so2941816pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 03:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ypd9so2dFrgbHr/PjvCwvLxYURIQERM57HWlYJTykw=;
        b=Hx/aW7/UaDciRDeQXQgeyexyBq+kbVxTFEEMLzSYbrxx9mqLQFMP+ujzJYSKYJmq6Y
         8RCAo00vyf3w19LuSsYlLPJ94qLIq0u5udGsUCnGtG2oCUHHWCd8LJhIHCboXo5u2+SV
         zVQcL729sj7OqSXVtBe99zslwOYg1mc+fnKIsyCTjqRBgkbvYUY8OH3aNfXdMJHAt9mK
         mQk6Hw9U5JE3cxiuPWLERaHeq4Bidrl/0QZZJylVlix2NF79lxg7hkcfqWQI9YKUtb4z
         CNW2AcUSvZH9EhcP90cc7+HGt0B4aM16G6cnxbUPrcYlGIZL8lFhC88b/S1hgZPqOhhX
         sWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ypd9so2dFrgbHr/PjvCwvLxYURIQERM57HWlYJTykw=;
        b=PAEeaxry0S0EGlZq31LHE/2VM12mg16Agb/5LSq5Itmf04CjiIo2w2irlR3DeEr2je
         aGej2aA54U+kGVxqt2efM2h/QxPFrvz6nTWzGPSulTwBpjw3XdT6RBA7fKuurdoSCwJd
         cVXeFl+WbCjvdtzgtfNKw7mENCS4dT6Tu36hBpppRtEEldAyybxDuv77k488KnaA23Xd
         yE+PmJOUk0t3onTaDA3aQrYGhViaXG1vIJ2IG4Bi9lgaYprGBN2cUEU4CeLLZaYf8xys
         DyByrtphXEw3qraNIQlawgQvu1D9U1qyvyoybkUzJOMY/8yaV5uQh/AtTEkPzCU5Nc7G
         WHzA==
X-Gm-Message-State: APjAAAUfAwNIYETIL3cMh8/xMR7C3hIP/qX1vmAN47xMMuZpt/BJYHN9
        59V/E/gnXbwnk+1+PcMPnyU4acpI83IS8qt/Czo=
X-Google-Smtp-Source: APXvYqxFp5S2F0x62EOFHIbW8vkuOlALERwrDU7ah+y03gXqzM3+U4mGX8BDOdlCP04w+6BqC8ziM6bRvBpAfLuJv/c=
X-Received: by 2002:a17:902:758e:: with SMTP id j14mr8084476pll.18.1581248941909;
 Sun, 09 Feb 2020 03:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20200208184407.1294-1-tomas.winkler@intel.com>
In-Reply-To: <20200208184407.1294-1-tomas.winkler@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Feb 2020 13:48:50 +0200
Message-ID: <CAHp75Ve0PGO_s-nRk6zwk6QTcFi4Jm3yA-QZ7j7dxqVkYB=svA@mail.gmail.com>
Subject: Re: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 8:44 PM Tomas Winkler <tomas.winkler@intel.com> wrote:
>
> Constify 'struct property_entry *properties' in
> mfd_cell It is always passed
> around as a pointer const struct.

I guess this should be second patch in the split and it's actually
dependent to the first one (won't we get a compiler warning when we
drop const qualifier during assignment?).

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>
> V2: drop platform_device part

Btw, when you prepare series, you may use -vX command line parameter,
where X is a version number. The scripts will put v2 in each Subject
line uniformly.

-- 
With Best Regards,
Andy Shevchenko
