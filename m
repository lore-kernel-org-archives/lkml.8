Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BEC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4820728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtHDDkn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgDXLIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgDXLIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:08:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67597C09B045;
        Fri, 24 Apr 2020 04:08:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so4623915pfc.12;
        Fri, 24 Apr 2020 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GXB1+oqaJEZ3sRrWa2n2m9CuNj5/9wJlyHUPzBW4Zg=;
        b=YtHDDkn88uz9vIopfu+CDX7vy37BDJ2uCN7QXKeQamXNYDl7ng8hLdufiPlS5+ecOz
         QlAs/EEWf6LcYkALE6TZEPmdKRULqckgYB9J8jG/81b9tidUDbEd6N6QfALWUgwZbStL
         PaGKlnOXjPkNF8hKBmA8DVLhipXFxqvO7gwRsgKP+S9rYqy3ru+qLx39J/5k/7WvEt2q
         2+TIKYqPrIWU1tXuX0w86hcRNMPUtWah8iWq7PwYjXcTuDdOc+gd/b13xO2D7N6nc3tz
         yuJVabgbDbgWFskfYc1U+b+oJ21sddlBRtuP7ePkL4qETxdgnZ5GCKcSlzbI1elnusi1
         tY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GXB1+oqaJEZ3sRrWa2n2m9CuNj5/9wJlyHUPzBW4Zg=;
        b=PpMboUlVPvzcv87khQYdRRxComvEmnjQ3vuCQBObnTINF83BEz4PgQtqDKYf+gufDz
         y+xiHgguan0+1x6moeqypWeuYeUGrNI8FAVTfQw0XsJg30c0JDdmAATtbBxcCZPSJz9B
         v0U+IZFT6foGXmRJ5HtcBLj/ATewEHXbJfPSTxSXhBVzoDsDGbFUitbFi155ZCLCL2n1
         sNiZ/BkxwA3XQG7F3HgfAUWmmFn4HO9HpM5h9I8GkkSZYjYN+l2Xe2gURl1BbvXMAnXo
         nB+/QofNUJsTLgAP5xDwt5YAF6s36Pkx8VRaGNl+SUKXGQhYojL79QEEPBx2WZd+tP9w
         i+Gg==
X-Gm-Message-State: AGi0Puau+iNkMTMgL4inI15/zRrpwata/GxJ07Mu4Tl/QvNNYT/xTso9
        RfnHe0LyQlIPYPp3o9qvDOvXrTtSA4QXuP4l8LJXZaYEufU=
X-Google-Smtp-Source: APiQypJ1oNin59u5IIssxyRMfGWiCbfuziAE8WvPxPUbG9ZlHjcwm3+mT9Tl288iQJjoj0ltRHgngajz0StmCEJ8yEQ=
X-Received: by 2002:a62:f908:: with SMTP id o8mr8862431pfh.170.1587726528958;
 Fri, 24 Apr 2020 04:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200423224222.29730-1-jithu.joseph@intel.com>
In-Reply-To: <20200423224222.29730-1-jithu.joseph@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Apr 2020 14:08:41 +0300
Message-ID: <CAHp75VcqV3e8ecAUX+dr9h-bE+1XJ_71hJRA1b9XdouJJLD2ZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] platform/x86: Add Slim Bootloader firmware update support
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        kuo-lang.tseng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 1:49 AM Jithu Joseph <jithu.joseph@intel.com> wrote:
>
> v1 Upstream submission is available here:
> https://lore.kernel.org/lkml/20200420194405.8281-1-jithu.joseph@intel.com
>

Pushed to my review and testing queue, thanks!

> v2 primarily addresses review comments from Andy Shevchenko to v1.
>
> Changes in v2
>  - Rebased on top of tag: v5.7-rc2
>  - Added ABI documentation file
>  - Changed the ordering of SBL entry in Makefile and Kconfig
>  - Replaced kstrtobool() with kstrtouint() for user input processing
>  - Added DocLink: tag to annottate weblink in commit message
>  - Minor edits to commit message in p1/1
>  - Style related changes
>
> From v1 submission:
>
> Slim Bootloader(SBL) [see link below] is a small open-source boot
> firmware, designed for running on certain Intel platforms. SBL can be
> thought-of as fulfilling the role of a minimal BIOS
> implementation, i.e initializing the hardware and booting
> Operating System.
>
> This driver creates sysfs interfaces which allows user space entities
> to trigger update of SBL firmware.
>
> Acknowledgment: Initial draft of the driver code was authored by
> Maurice Ma <maurice.ma@intel.com>
>
> DocLink: https://slimbootloader.github.io
>
> Jithu Joseph (1):
>   platform/x86: Add Slim Bootloader firmware update signaling driver
>
>  .../ABI/testing/sysfs-platform-sbl-fwu-wmi    |  12 ++
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/Kconfig                  |  10 ++
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/sbl_fwu_wmi.c            | 144 ++++++++++++++++++
>  5 files changed, 174 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi
>  create mode 100644 drivers/platform/x86/sbl_fwu_wmi.c
>
>
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
