Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B370C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F64F2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc16qhzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgF0TnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0TnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 15:43:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A312C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 12:43:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e15so9482265edr.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGY8B6Oe7XCHiADnLEqpel5yWhZGTgQFMZLJLu4AeLg=;
        b=Rc16qhzTaGkvar0RBwernOkMKUaB2kPbxraK853fDwlvWWhKavUOOmXLt+hsQMDnQC
         NQQjm3eyWCkcTkss7DUV5Bbs6lnHwIJxtikNZ+2hU13pN3y9YPIZT7Kjk8wOmiemCmme
         +WsbPSNfbSAEIjHWlHDmF00fPKbKEJwT6SMoXCVMOPsjpBsFXYCNZ1jnQENLd0gvAQw3
         rlwZ/lxlGi0swTvJ9mOnHX3+sABFxlv7iCHPx4fukAeVYdmqxcVSTAkoPTHfKE2eUstI
         VFy1cKoRZ0A2Df5tA0TsKm6yoSwvcEzXCXFWS+/aFGd29fYODwSMf1zuR7LrzkAdJQda
         3/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGY8B6Oe7XCHiADnLEqpel5yWhZGTgQFMZLJLu4AeLg=;
        b=Ucf+MHKe++3NVNks8v6ra0VVcy6z/SdxDLA92GH0x82Cw5e/iKwREMOGVmN13cNP6H
         x/S42aE1SoBaiP0fZzeQIsaSDqW7lpNko/0uQHHwAN3Y/ktGNcc07/e3uC4S4AIbgQJ+
         IU9gDceePVICME+HUbnCJ2wt9wTxPxJSvsePXbQrEY+CL8eClDlI7zbiVpnLgKEUFp7D
         i/EmF/IXXF6fKChwel1q1h2yCB3FpDYwZGxUCBYXDiPEukSCm8o47tWAldqj/AUoEB3e
         K1VldI+TGdTWvGWdVWFgG/9ktg7OBWjMMvFmR1kxZVIcE6IkastSfMjX6EQs0gi0qH1I
         VjPQ==
X-Gm-Message-State: AOAM533HYqNiL1ey9lUYYmI+7HxkDH6wD6B2jHB5Iw5BCFYxQYsbOi81
        7zGDrYnfjxRiSP7iwDuWAuvsy8pjzed7jX6zXVc=
X-Google-Smtp-Source: ABdhPJzQiWUDIYGSsX+B23VyHEVSNyAyfdKQrssW7lJL48zy17S+fQiaHNN7lg3dINy+2DQpLyN47qQsODs8ks9qGJM=
X-Received: by 2002:a05:6402:542:: with SMTP id i2mr8211841edx.318.1593286992686;
 Sat, 27 Jun 2020 12:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <202006210249.QHly8bQZ%lkp@intel.com> <CA+h21hpABfDvthiwq_JwWGpqZ68VJxu5TOBVbw_Gaxpq8j+XQg@mail.gmail.com>
 <CAKwvOdnAKR_CtOccZohR_r1kzKKVuvo8LbpLi0s3ek+3u+c_zw@mail.gmail.com>
In-Reply-To: <CAKwvOdnAKR_CtOccZohR_r1kzKKVuvo8LbpLi0s3ek+3u+c_zw@mail.gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sat, 27 Jun 2020 22:43:01 +0300
Message-ID: <CA+h21hokCCF52O1wxkg0gLqS9ZcGtB0xMBm07_--i56=anJ=Rg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/panel/panel-samsung-ld9040.c:240:12: warning:
 stack frame size of 8312 bytes in function 'ld9040_prepare'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>, sam@ravnborg.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, 22 Jun 2020 at 19:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
>

> > I really don't get what's the problem here. The listing of
> > ld9040_prepare at the given commit and with the given .config is:
>
> I wrote a tool to help debug these.
> https://github.com/ClangBuiltLinux/frame-larger-than
> If you fetch the randconfig and rebuild with debug info, that tool
> will help show you which variables are used in which stack frames and
> what their sizes are.  Also note that strange things get dug up from
> randconfigs.
>
>
> --
> Thanks,
> ~Nick Desaulniers

I ran your tool and it basically told me that all 11 calls to
ld9040_dcs_write from within ld9040_init are inlined by the compiler.
Each of these ld9040_dcs_write functions calls ld9040_spi_write_word
twice, so 22 inline calls to that. Now, sizeof(struct
spi_transfer)=136 and sizeof(struct spi_message)=104, so, no wonder we
run out of stack pretty quickly.

But my question is: what's wrong with the code, if anything at all?
Why does the compiler try to inline it, and then complain that it's
using too much stack when basically nobody appears to have asked it to
inline it?

Thanks,
-Vladimir
