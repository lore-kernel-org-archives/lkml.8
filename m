Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDBC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F9C20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZD/KgRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgCWUop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:44:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37314 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:44:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so11367035lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e061pcmiSocm5TCH2kexNo/1LtEisTcSsHnrvUPbEiA=;
        b=QZD/KgRPHgcOxtb0qWhUKPvSZHXx/HGVixEwM+IWFrVubL8hnRtHer1OuNpH4SX2hM
         et/A57hTvPYZavJafDtMEIwBI2RqvlxrTruXy8fqS79oLTB9xNaxZ5+SV7JpbRzuvdCg
         1yByR6BBDe43ZDKfbVgD0TZhf3QtjUcKNI1S3uVmbSg5b69Gb1gr0+LDcDcY9e6E6bq9
         E3rB6iYP6yTcHa7eDfeld72008bfP8yEOtCRhjLSve4gf/TFGx+Ayi34Vhvj8SUNr3at
         7whfcwefkLPfp6Jiyll9s2NGZWA6w5U6NHk3FffeQRbES+Ahf8qiCsMKgE9opWmINOow
         jGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e061pcmiSocm5TCH2kexNo/1LtEisTcSsHnrvUPbEiA=;
        b=NKsq+4wZ73HrBCshQnayZKUdpqM806aIsFJ0IJysDPiiOTIQnIxTUnKbP299KITdo8
         CQG0mbAE08wuhFfhUH4pqu6cH5ihGmGGkeDdUzHxX8MXPgIDAwu9XEeoxLQRcvU/2weK
         OKKYgk0bmvDPUKMAKkvTsowU0d4wkuqufa1j3gAEbpatP9izB07IE2kT0jiGU/0a4cmU
         4Jj6tFTAqOjBdNc67s+mAEOO5VMz/4VWu+8z0VttEcu1yZLojHdmKHjrZ3hjYAZx+PSe
         oWZ9INvi9+qPkunzRDwpmdVytqXUMcOdE8TOnLMDyDpBk5UVNSIGIy8q5rzE2Hv4rKHw
         AfaQ==
X-Gm-Message-State: ANhLgQ29Tz6NXeZhp4CsMM0JEtHfMYBRHdlJEaQ9PclINQSJtg+0sO9L
        dExR3chSN1FoO26SoGnP/BoWxKeysPKzdVl/QAephbxo
X-Google-Smtp-Source: ADFU+vsTXJ33avbaKKNKuuv9JSmVCumR5ejYDfgc7vUWBMzBSRxV9N+5vck7HENKih2MNH2L3VHcCttJW2RMzVBhWfs=
X-Received: by 2002:ac2:548f:: with SMTP id t15mr14146896lfk.115.1584996282705;
 Mon, 23 Mar 2020 13:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamv3wT4aqF0y1_PHG_=cbzH-ATsP6TiV5Zt5Qc+ACVnOPw@mail.gmail.com>
 <20200323064616.GB129571@kroah.com>
In-Reply-To: <20200323064616.GB129571@kroah.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 23 Mar 2020 16:44:31 -0400
Message-ID: <CAEAjamvv7LzaTBu-Xh5rg4r1-_NaDDGVoe9LZ7NmZv3gpLXkuw@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, slyfox@gentoo.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, rei4dan@gmail.com,
        Dave Tian <dave.jing.tian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 07:46:16AM +0100, Greg KH wrote:
> On Sun, Mar 22, 2020 at 11:34:01PM -0400, Kyungtae Kim wrote:
> > We report a bug (in linux-5.5.11) found by FuzzUSB (modified version
> > of syzkaller)
> >
> > Seems the variable "npadch" has a very large value (i.e., 333333333)
> > as a result of multiple executions of the function "k_ascii" (keyboard.c:888)
> > while the variable "base" has 10.
> > So their multiplication at line 888 in "k_ascii" will become
> > larger than the max of type int, causing such an integer overflow.
> >
> > I believe this can be solved by checking for overflow ahead of operations
> > e.g., using check_mul_overflow().
> >
> > kernel config: https://kt0755.github.io/etc/config_v5.5.11
>
> Great, can you send a patch for this?
>
> thanks,
>
> greg k-h

I'm not sure the following works best.

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..c1ae9d2e6970 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -869,6 +869,7 @@ static void k_meta(struct vc_data *vc, unsigned
char value, char up_flag)
 static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 {
        int base;
+       int bytes, res;

        if (up_flag)
                return;
@@ -884,6 +885,8 @@ static void k_ascii(struct vc_data *vc, unsigned
char value, char up_flag)

        if (npadch == -1)
                npadch = value;
+       else if (check_mul_overflow(npadch, base, &bytes) ||
check_add_overflow(bytes, value, &res))
+               return;
        else
                npadch = npadch * base + value;
 }

Thanks,
Kyungtae Kim
