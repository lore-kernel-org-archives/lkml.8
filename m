Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5376C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7938D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMacKXxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgG0KD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgG0KD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:03:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1931BC061794;
        Mon, 27 Jul 2020 03:03:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c3so1501656lfb.3;
        Mon, 27 Jul 2020 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6I2lLfZNvMeErNBP+6RCTBs+KS8Tnc+1L09dfq9pLM=;
        b=eMacKXxB0UWbCbTyTrY1Y2dKEZbpP4OCoTxx8nqEiWAJznuSw23HeKgtCZeLmTZcor
         Q/xQgMIiwmvlBzU1Tadh4s8dPw0ZbNMII5XJASaoJpBrSPK2oeVpmDHRnhgnBb4gAUpb
         mGKQtYTB3u7OxTSOv3Ik9dI0QyEuc7t9IYZYtsSRWr0ACBuhlIc1c5aTQurKD3WoCExC
         7hFuxlbr9/NZN4hyKWTaeyTG2R1Eof253JVjShzM7a31FPkMebnykTXKd+lF4y2C6lKR
         Nubp9PMFE4kZFZBJ+0Og5tieHtw6MEWikGRr6Vswc5/VHyjoqYLA6cjdHvZ71wOMgaKX
         jf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6I2lLfZNvMeErNBP+6RCTBs+KS8Tnc+1L09dfq9pLM=;
        b=T0n35u+eBgs+tS6xwiO6ZDin+xQLcrD5SSwOuKkcxj7v+EE0uEdbBE5LexRIzZJZYi
         74Epvo2zQT4zPfudIpGfG8H0twU4af4/NzN8ySHgF+0OmGpWxMgMterUgDB2nud+lLEC
         asHWzgCHaZvD/XUoudeiWopNyLa1QzhY5YILoVsv8CWautvo6M9VqrQbUo/CxY2P7ckB
         llb38ql1YiRPBa84u2tKH+/c+NKBPBfeZjmgPjzoRBPhR1a1bgu4IpdXP+yCm8VM3aP2
         2yuEFDLsBnJfrwQ1iPVih97nRDWOtbIYaF2N4JsEaDRupaD1W6VwcVPIyK05FYBTM5VX
         kmbQ==
X-Gm-Message-State: AOAM532nUPhpcfSVC2bOf6iGAETmF47xHHedMI/XHBWEX6fX0Cbv9Xlw
        Ifn+duG/XpmF0XTMyqPQkI+8gX8U3SL81rvVD/wpaEt4N2I=
X-Google-Smtp-Source: ABdhPJzNIJlwlw2uz6FtpnKqLkz53xW+A4YgKjOefKWGV+Ww1GXoJ3ZG1EtqY1tyDSqZgkozgDcDen2BIje09EZ39ZE=
X-Received: by 2002:a19:7f94:: with SMTP id a142mr3612342lfd.43.1595844235631;
 Mon, 27 Jul 2020 03:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200727090629.169701-1-cyrozap@gmail.com> <20200727090629.169701-2-cyrozap@gmail.com>
 <20200727092654.GD1764157@kroah.com>
In-Reply-To: <20200727092654.GD1764157@kroah.com>
From:   Forest Crossman <cyrozap@gmail.com>
Date:   Mon, 27 Jul 2020 05:03:43 -0500
Message-ID: <CAO3ALPwJq4=GairV8ksHenRtXwg2mYNDKtnYcf99eN6Eo6es5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: xhci: define IDs for various ASMedia host controllers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 4:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 27, 2020 at 04:06:28AM -0500, Forest Crossman wrote:
> > Signed-off-by: Forest Crossman <cyrozap@gmail.com>
>
> I can not take patches without any changelog text, sorry.

Ah, whoops, I'm very sorry about that! Should I send a v2 of just this
patch? Or would it be better to send the whole series again?


Thanks,

Forest
