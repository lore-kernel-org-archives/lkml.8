Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530CA2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJuP+NUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHZPx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgHZPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:53:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A816C061574;
        Wed, 26 Aug 2020 08:53:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k1so1204764pfu.2;
        Wed, 26 Aug 2020 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78S0umpQdnvgfhSWaH9CauU9B+pmDgBIPnkk0g1yodA=;
        b=GJuP+NULyow0TPoqdaHS5mo21Nes0g0fj07Zv3ukKJbBGZccDWZLDEXP6VimmtTjND
         5lSl546o+SkWwatqhvzj0ATjIjdpyTboFFPEKkEnL5UB+W+TICbALf2tVdoQbyCIvR9U
         7kvLnH7j+qBWfeOPqbW34RYTcgK8wGL5qhlTG8bl8obkXNBZTt4tYQCIecNhadEny5y/
         nsemflhfTEOszODt5xGBFqYhxudW1yxWvAPBr7+iWgggvFHfhdo/vMcQUTMOqtWIcHyI
         gIbQZ11uVFSeORNyVuHunKng2ij2GCKYSpmx0B4Sr9ozsi9mFUOiz6ZjES4bOEBo2NZZ
         izGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78S0umpQdnvgfhSWaH9CauU9B+pmDgBIPnkk0g1yodA=;
        b=Rzt5MHf36wL/r2YVPexgpIJ3A1qnqF2eJhlyeUm8U4r8c59//zMhq535zhB+JcIYQP
         AnICFVnznCLCd7OQxTDlWfcQJ3mmnxGn7DfRpJjefAtmzs+F6ksPhW4FcJG0LJQJxyDz
         715yUga/i+SOtWhZl6XYbGN4PCSXjZ0U+EPgtkxx/mzvOwV2fFICCoMxkBciqxMjZyZs
         /yDFzR7WWIRc6cuwdcWqBsWdkLniB0zR50yMAzXbgf+0h+Fb9wNZ6fgecPX4213yKR0A
         tebhrEQF0Rwa5+VGWXCcDXoAKVGJMiekHLt0PGUcfhE3aeYP70Phqh6tQO1+h7pe4rBL
         QGyw==
X-Gm-Message-State: AOAM531aj0r4crCtUD1ueFwh9pGsXFC+x991p+kwLGmrqvusqdf4oOze
        sJP7UE5v+ugoFu6XEjTdnX6SFBkwPOjq0rrFQKg=
X-Google-Smtp-Source: ABdhPJyib4x7o6e4MBbgPy4EPS/Lr3IiFjsUMYK7ZMSyy1wnDWTtrCEJr0UHP/PmN4eb8eLpBmfGVi9OA9MHuLEWEV8=
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr12490280pfk.219.1598457199510;
 Wed, 26 Aug 2020 08:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200826134315.GA3882506@kroah.com> <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com> <20200826153347.GB4187816@kroah.com>
In-Reply-To: <20200826153347.GB4187816@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 18:53:02 +0300
Message-ID: <CAHp75VepkugjZ4pvdNgxzT4T83ewL1AFtSZZtVq6aL+7=sqskA@mail.gmail.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Brooke Basile <brookebasile@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: multipart/mixed; boundary="00000000000090e62b05adc9d19e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000090e62b05adc9d19e
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 26, 2020 at 6:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
> > On 26.08.2020 15:43, Greg KH wrote:

> > > Brooke Basile (2):
> > >        USB: gadget: u_f: add overflow checks to VLA macros
> >
> > Sorry, but the above patch breaks USB Ethernet Gadget operation. It also
> > didn't get the proper testing in linux-next (next-20200826 is the first
> > one with this patch).
> >
> > This is how it explodes on Samsung Exynos (ARM 32bit) based board with
> > g_ether module loaded:

> Odd, for a "normal" descriptor, the logic should have remained the same
> as without this patch.

> Brooke, any ideas?

I have an idea.

Does below fix this?


-- 
With Best Regards,
Andy Shevchenko

--00000000000090e62b05adc9d19e
Content-Type: text/x-patch; charset="US-ASCII"; name="1.diff"
Content-Disposition: attachment; filename="1.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kebk4tac0>
X-Attachment-Id: f_kebk4tac0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91X2YuaCBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91X2YuaAppbmRleCBkZjRlMWRjYjM1N2QuLjBiNWM1ZjBkZDA3MyAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VfZi5oCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91X2YuaApAQCAt
MjUsOCArMjUsOCBAQAogCQlzaXplX3Qgb2Zmc2V0ID0gMDsJCQkJCSAgICAgICBcCiAJCWlmIChn
cm91cG5hbWUjI19fbmV4dCAhPSBTSVpFX01BWCkgewkJCSAgICAgICBcCiAJCQlzaXplX3QgYWxp
Z25fbWFzayA9IF9fYWxpZ25vZl9fKHR5cGUpIC0gMTsJICAgICAgIFwKLQkJCXNpemVfdCBvZmZz
ZXQgPSAoZ3JvdXBuYW1lIyNfX25leHQgKyBhbGlnbl9tYXNrKSAgICAgICBcCi0JCQkJCSAmIH5h
bGlnbl9tYXNrOwkJCSAgICAgICBcCisJCQlvZmZzZXQgPSAoZ3JvdXBuYW1lIyNfX25leHQgKyBh
bGlnbl9tYXNrKSAmCSAgICAgICBcCisJCQkJICB+YWxpZ25fbWFzazsJCQkJICAgICAgIFwKIAkJ
CXNpemVfdCBzaXplID0gYXJyYXlfc2l6ZShuLCBzaXplb2YodHlwZSkpOwkgICAgICAgXAogCQkJ
aWYgKGNoZWNrX2FkZF9vdmVyZmxvdyhvZmZzZXQsIHNpemUsCQkgICAgICAgXAogCQkJCQkgICAg
ICAgJmdyb3VwbmFtZSMjX19uZXh0KSkgeyAgICAgICAgICBcCkBAIC00Myw4ICs0Myw4IEBACiAJ
CXNpemVfdCBvZmZzZXQgPSAwOwkJCQkJCVwKIAkJaWYgKGdyb3VwbmFtZSMjX19uZXh0ICE9IFNJ
WkVfTUFYKSB7CQkJCVwKIAkJCXNpemVfdCBhbGlnbl9tYXNrID0gX19hbGlnbm9mX18odHlwZSkg
LSAxOwkJXAotCQkJc2l6ZV90IG9mZnNldCA9IChncm91cG5hbWUjI19fbmV4dCArIGFsaWduX21h
c2spCVwKLQkJCQkJICYgfmFsaWduX21hc2s7CQkJCVwKKwkJCW9mZnNldCA9IChncm91cG5hbWUj
I19fbmV4dCArIGFsaWduX21hc2spICYJCVwKKwkJCQkgIH5hbGlnbl9tYXNrOwkJCQkJXAogCQkJ
aWYgKGNoZWNrX2FkZF9vdmVyZmxvdyhvZmZzZXQsIGdyb3VwbmFtZSMjXyMjbmFtZSMjX19zeixc
CiAJCQkJCQkJJmdyb3VwbmFtZSMjX19uZXh0KSkgewlcCiAJCQkJZ3JvdXBuYW1lIyNfX25leHQg
PSBTSVpFX01BWDsJCQlcCg==
--00000000000090e62b05adc9d19e--
