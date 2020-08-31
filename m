Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA6CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD1920782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBplDfQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgHaNkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHaNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:40:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C45C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:40:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so8518528ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lddw3bdok3hAy1F/tQ2gv6hGO+6x8VFGDH1TfahaMjg=;
        b=gBplDfQqLrkZ52/3bG7dQRrqKdekFZEh45gXZ5MsUHY486B3HK7oI65JYt4l0R3ldF
         GNHW/tXR1MVsKES6Wqf1COb7UnAT3ZaQw63tIRNa5/T4qs0h8OMmXCsfgazVyJK79l8t
         jn385EO8CLCYrRbQ23bb6Sth0ZtPsuO6k4k7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lddw3bdok3hAy1F/tQ2gv6hGO+6x8VFGDH1TfahaMjg=;
        b=IZ0FTHpT2mjj+jPTFRqMwlCH8XQ+ml1iaIIWZz+PWUXmKAcGHfL3+84SgaqIsjIqT0
         VjA4JtbB8oHdud3WmfM9UP2CvqC6BXm+pSOSSvsGjc9MF1PnYOatukm6y4NVr3RvrxV4
         KAQiCHBO2K1YOSDbebTJ03R7aZ/bRFQUpkMHKN2+vN3oLlk7e3G6bZ24jY1J29sqIS5z
         /EhwXApB4LfqxnVTiSJBZFOx0/Tu7Nn//G3WfGDYQN11qUA1Cecrav3eTFOhQP3P5k+P
         Av1SaAWAoAsqHNIFg3ZJSYEzEtJGSsYYL+pZK9f5UEr012x7qCc8H/dOUBTEG2mYbwJC
         rQhg==
X-Gm-Message-State: AOAM532yTiZJ/9g/PSFTkDO1ylBfSP2hswNaEtIORZ1H1vyHEXQxdlhC
        gNIYAcYZWDW5C4GEsr3ZYsURMX/8xZrpYA==
X-Google-Smtp-Source: ABdhPJyUvFBVaojqCaFsQ/GEitC1y4QjQw5MxzDLGte0xZtgCg2sTwV/iQXOxbr/0iSE7fbgxbsnVw==
X-Received: by 2002:a17:906:cf82:: with SMTP id um2mr1212257ejb.49.1598881199372;
        Mon, 31 Aug 2020 06:39:59 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id p25sm4974464edm.60.2020.08.31.06.39.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 06:39:58 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id d11so8480120ejt.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:39:56 -0700 (PDT)
X-Received: by 2002:a17:907:7292:: with SMTP id dt18mr1291762ejc.512.1598881195924;
 Mon, 31 Aug 2020 06:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200827135205.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
 <20200829074758.GA16838@amd>
In-Reply-To: <20200829074758.GA16838@amd>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 31 Aug 2020 07:39:44 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CuWSzaMNYSfh6Zr12Q1=GA_Yqpg0jaePDkFQjgsDDBPg@mail.gmail.com>
Message-ID: <CAHQZ30CuWSzaMNYSfh6Zr12Q1=GA_Yqpg0jaePDkFQjgsDDBPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: i8042 - Prevent intermixing i8042 commands
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Andy Shevchenko <andy@infradead.org>,
        Dan Murphy <dmurphy@ti.com>,
        Darren Hart <dvhart@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Rajat Jain <rajatja@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 1:48 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2020-08-27 13:52:22, Raul E Rangel wrote:
> > The i8042_mutex must be held by writers of the AUX and KBD ports, as
> > well as users of i8042_command. There were a lot of users of
> > i8042_command that were not calling i8042_lock_chip/i8042_unlock_chip.
> > This resulted in i8042_commands being issues in between PS/2
> > transactions.
> >
> > This change moves the mutex lock into i8042_command and removes the
> > burden of locking the mutex from the callers.
> >
> > It is expected that the i8042_mutex is locked before calling
> > i8042_aux_write or i8042_kbd_write. This is currently done by the PS/2
> > layer via ps2_begin_command and ps2_end_command. Other modules
> > (serio_raw) do not currently lock the mutex, so there is still a
> > possibility for intermixed commands.
>
>
> > @@ -343,10 +330,14 @@ int i8042_command(unsigned char *param, int command)
> >       unsigned long flags;
> >       int retval;
> >
> > +     mutex_lock(&i8042_mutex);
> > +
> >       spin_lock_irqsave(&i8042_lock, flags);
> >       retval = __i8042_command(param, command);
> >       spin_unlock_irqrestore(&i8042_lock, flags);
> >
> > +      mutex_unlock(&i8042_mutex);
> > +
> >       return retval;
>
> There's something wrong with whitespace here. Checkpatch?
>                                                                         Pavel
It's fixed in the v2 patch: https://patchwork.kernel.org/patch/11741855/

Thanks
