Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F062C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E8C20726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOfnW2Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBHJjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:39:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54993 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgBHJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 04:39:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1982160pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 01:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LV9WF+yd91+ZDhE/yQPz+qm50+VF/ECH8f8P/Lu3r8Q=;
        b=VOfnW2QcAmEk+1oDxWm/HU+divjNnXx/NfoCXo2e7hKNqa/iL+7X4j+Vohki2En8SS
         6p/xsURPJY1Oe6aZ5+/55BtiX6H6htIbIPm6UZZKTABG5zIhKoOLw90SZ60hRD7tTRnS
         SvVJpr9eLkfu5OxGSLR3sm4YlVRZ42X7LuK35HvMGcYVOXlbFup2umreYRiUUKhXGQVV
         NXHYXyhZzdvCehofpM9cKb0/hJO71TAtgHelFriXPyxRofj9p4g/HvLjHx3P7igDefQT
         EwAyNYHVDlMJnK9YcHXKNh4HJDhFC2DtLXr5TTW98n3ZGQY8YmSt8SEkdbq4PD/m1Qak
         BlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LV9WF+yd91+ZDhE/yQPz+qm50+VF/ECH8f8P/Lu3r8Q=;
        b=mlJr/Sy8LVa2JInnmE5xtTtM+WBpYVoOoIfzdOo8SOq1et6ohe3xP0nrGaCmvpPPj+
         bmOI/aZM6A9tiErFS2SX7iDFEQyN0Ua8u0jGvIorzQN/ICfk+O+txMdBG3+72I5FyhBr
         2VG3KAIPl8rMcth5eOpfsv6dS/v0OTUANJH6prK4y6vWIOcdkNXgrl37AgTIj1NndB0a
         aaBER0bhla4CEgMI8g/cDe83S5QH1HZJ1WDJJLrpphS0sY4CLYetqY6ULHZCco+3u1yE
         cGS+n90cQ1Z5lvTKtZ8hPazY1zKFcrK+mXOV4TV3lUurC6ATroG3eYLl+xnouH07Wf2W
         xc3Q==
X-Gm-Message-State: APjAAAXw5XXdFszl8EWY1DdE7f7GvXqPgo+Ne0yWySV3XWmGkQ+r4Flz
        YwR4L85OWJPB9rwrFVp7v48UGfnJPtXy7LlACM0=
X-Google-Smtp-Source: APXvYqzwnYImvvlQlSlyM9lxoByXLoroT47vx7bY48Tfpge+DfN6Pe4B3ZR0jq0ua+GsczF/vAST6aM9HndOwtP9Afc=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr3023478plf.255.1581154775225;
 Sat, 08 Feb 2020 01:39:35 -0800 (PST)
MIME-Version: 1.0
References: <202002080809.X3Aan7LJ%lkp@intel.com>
In-Reply-To: <202002080809.X3Aan7LJ%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Feb 2020 11:39:24 +0200
Message-ID: <CAHp75VcXFcMy4NHxjupch50OkbR6yJ4KKm8YkOQQxH3yY1YZ=g@mail.gmail.com>
Subject: Re: WARNING: vmlinux.o(.text.unlikely+0x3e94): Section mismatch in
 reference from the function bitmap_copy_clear_tail() to the variable .init.rodata:__setup_str_initcall_blacklist
To:     kbuild test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 2:03 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   90568ecf561540fa330511e21fcd823b0c3829c6
> commit: 30544ed5de431fe25d3793e4dd5a058d877c4d77 lib/bitmap: introduce bitmap_replace() helper
> date:   9 weeks ago
> config: xtensa-randconfig-a001-20200208 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 30544ed5de431fe25d3793e4dd5a058d877c4d77
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=xtensa
>

The discussion is happening here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> WARNING: vmlinux.o(.text.unlikely+0x3e94): Section mismatch in reference from the function bitmap_copy_clear_tail() to the variable .init.rodata:__setup_str_initcall_blacklist
>    The function bitmap_copy_clear_tail() references
>    the variable __initconst __setup_str_initcall_blacklist.
>    This is often because bitmap_copy_clear_tail lacks a __initconst
>    annotation or the annotation of __setup_str_initcall_blacklist is wrong.
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko
