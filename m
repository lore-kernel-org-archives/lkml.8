Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E0D20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apzowtx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgHSH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:58:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0859C061389;
        Wed, 19 Aug 2020 00:58:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so10436237plr.5;
        Wed, 19 Aug 2020 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKF15E21rJWLju6nAeOokc2X10iJm45TmDDuTb7BDyo=;
        b=apzowtx/JJMYaJFqB9aNKjQu09kNkBa68AGGbFzCPAXBOIxcNvo9zGM4wdTIhYFCQH
         2PejIHHl6Pynxe9KrWu2drm/COx+KbANK43OHOxu7x3O/orJOXx0tG9GgWC43iTxMUaO
         s5Ar5Uj0gkR895502pghrXlVmDa8++kb4k2CKrOnSJmcg/51W6EXKBAOubqp9xoJ6vRU
         h8apUodiIHXB+7fNsGd7Om7RmEVj68rCWkaM4X9+GrtKe16lV84ulJJHurHjH8QymnGy
         89z7XSFFuubH9a1kKLdJYqM/Gkg0Al67RH1LE+8ANVWa1he2wkrSjz8F6LDKK6Mg9YfH
         CmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKF15E21rJWLju6nAeOokc2X10iJm45TmDDuTb7BDyo=;
        b=PmdKJzz6/1/KLW5qsiNfcCn1kpZ0j/lYsj3gXSjxhYxvsuFL75+HF80ghLHBppOPhf
         gqGxZFi3K5Wzof26EgB/lMOBqlRJY9La5R0BPWlNZVDT1bdBRfH0sqZTtel9V5kuHfHz
         by2U3epi/BohJRmc5BqxFhwDpJUBIdxEh55bKP3AbZ70F8diAXEOYLzRpvtM43KtbEf5
         0QnsNhNKgici4nxUWB4xBltAMoIwYqkMlUEwBIpq8HEV9ve/59hiykLix5RhcPT+SizQ
         DNUjeeBJ6dWbScMDw8bqRFoiPaWMAdvKpA2//QAcwUzlhKrJKjwlw9trFJ9jHgjnUFPW
         v2yQ==
X-Gm-Message-State: AOAM531VbZSdmlIjLnFrP5GZuC385HUadGqPnZS7uLpgIAXJVl3Xd4vd
        GZPg3UKELGeizItUxygZ81zJkd7Zxk1rJZmM2kw=
X-Google-Smtp-Source: ABdhPJy2mpdctsp/Elqdf1ybhxRpmrmOnWPechCwAQFwProksNJSI1q8DyW0WdAG7ge6vQ2XPJBBgdi2oti2c3W8xbA=
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr17416466plt.262.1597823921415;
 Wed, 19 Aug 2020 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200819071733.60028-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200819071733.60028-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 10:58:25 +0300
Message-ID: <CAHp75VckB49ZoJetK6WxK08SszzxutQyNOm-TLEsMDwhow=3Fw@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: move to tools buildsystem
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:17 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Converting the Makefile to use the new tools buildsystem.

In particular it allows you to build with `make O=...` which is very helpful!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  tools/usb/Build    |  2 ++
>  tools/usb/Makefile | 53 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 47 insertions(+), 8 deletions(-)
>  create mode 100644 tools/usb/Build
>
> diff --git a/tools/usb/Build b/tools/usb/Build
> new file mode 100644
> index 0000000000000..2ad6f97458168
> --- /dev/null
> +++ b/tools/usb/Build
> @@ -0,0 +1,2 @@
> +testusb-y += testusb.o
> +ffs-test-y += ffs-test.o
> diff --git a/tools/usb/Makefile b/tools/usb/Makefile
> index 01d758d73b6db..1b128e551b2e4 100644
> --- a/tools/usb/Makefile
> +++ b/tools/usb/Makefile
> @@ -1,14 +1,51 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for USB tools
> +include ../scripts/Makefile.include
>
> -PTHREAD_LIBS = -lpthread
> -WARNINGS = -Wall -Wextra
> -CFLAGS = $(WARNINGS) -g -I../include
> -LDFLAGS = $(PTHREAD_LIBS)
> +bindir ?= /usr/bin
>
> -all: testusb ffs-test
> -%: %.c
> -       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
> +# Do not use make's built-in rules
> +# (this improves performance and avoids hard-to-debug behaviour);
> +MAKEFLAGS += -r
> +
> +override CFLAGS += -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
> +override LDFLAGS += -lpthread
> +
> +ALL_TARGETS := testusb ffs-test
> +ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> +
> +all: $(ALL_PROGRAMS)
> +
> +export srctree OUTPUT CC LD CFLAGS
> +include $(srctree)/tools/build/Makefile.include
> +
> +TESTUSB_IN := $(OUTPUT)testusb-in.o
> +$(TESTUSB_IN): FORCE
> +       $(Q)$(MAKE) $(build)=testusb
> +$(OUTPUT)testusb: $(TESTUSB_IN)
> +       $(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> +
> +FFS_TEST_IN := $(OUTPUT)ffs-test-in.o
> +$(FFS_TEST_IN): FORCE
> +       $(Q)$(MAKE) $(build)=ffs-test
> +$(OUTPUT)ffs-test: $(FFS_TEST_IN)
> +       $(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
>
>  clean:
> -       $(RM) testusb ffs-test
> +       rm -f $(ALL_PROGRAMS)
> +       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.o.cmd' -delete
> +
> +install: $(ALL_PROGRAMS)
> +       install -d -m 755 $(DESTDIR)$(bindir);          \
> +       for program in $(ALL_PROGRAMS); do              \
> +               install $$program $(DESTDIR)$(bindir);  \
> +       done
> +
> +FORCE:
> +
> +.PHONY: all install clean FORCE prepare
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
