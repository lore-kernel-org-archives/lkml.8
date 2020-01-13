Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049EBC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5598222D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esi7Itj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgAMCn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:43:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46683 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732487AbgAMCn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:43:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so8263111ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 18:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=24/I1qlMqBFXawGKcZCUrgzix2NHvFXwEaDn4ik+j2U=;
        b=esi7Itj4DmpSDioUwVhXYRkKxTZ0cZfRIRPkUwYLO6thkX04T7cQnJprHW+yehrMPI
         wEdujDl/DavLJPfpBbCV4OmeO1qNENQVjk3gnTub6I+dlUOdQJ5R+oZAzgXpb8IkQKhV
         oPliJ8aBmRFWcPN9bIoV/OG4OUihmzuSBUX7WI9bq0KkuNyXR3QUrlB80N+hHrNpIBfb
         9JrawK4EVmXXtRqOLaVQG5gB4m0byjm575jEt58Yt70femg2S37y3tCUqTSlbnQjAsL5
         rKqNDq/7croKGCQgyVEaQozc5gaGSO+y7NUNq4JsimHFNk0vQ7WcPLYsqKPFrjgykumn
         ipdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=24/I1qlMqBFXawGKcZCUrgzix2NHvFXwEaDn4ik+j2U=;
        b=rW/R/qEogdbBPbyRfrFFxEpUozEH7YCJRY9JgCK0G6N4D9Kegje5Kdes6WawPusY1k
         OPnPjoW3XIeVa+TaPuzDpLO/J1hsfERJBwa0DnqHNgxnlDugUZbGoAYIJNXGyt2JskDD
         8aSdRd5Ok9JKse/ziTCZ/L+PDdj8GpiNUYM55rL7VHxa31Q7qiyZUViPe5CBt16v93Jn
         SGPNLrln2RHTuBPq6o+dsVL2svdf0XQnpP8/Mz2OWv3xnRIeBs2rs8AYZyzL68AdA3Io
         Wwpx/6BmAK1ILqBUhgzqZaYwmgd3roOlfRuWSMrL5XAbnr6PFDFzg3Rr8Xx+Du8CVQKD
         rIFw==
X-Gm-Message-State: APjAAAVvOufzkFIHleCl52T3y/evBRpnWSTaRlS54Y5YhnmtU/tWiQho
        ZTgKLjfp7PdZPeu/CsjSUi3eg0Zu4MRodj2oAnI=
X-Google-Smtp-Source: APXvYqwXwacTiGL5FRpSFPYXYEHd2JzH7vmXzdU55onIT3/3yV9zHmg0Isx13uMvMznby+Jefub+1OThEiblDPLXpVs=
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr9309832lji.247.1578883406468;
 Sun, 12 Jan 2020 18:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic> <20200109204638.GA523773@rani.riverdale.lan>
 <CAFH1YnNA9qfM4tPzKKDaQD6DPxnE=tJsB7AUZQBohDTW3zm=Xg@mail.gmail.com> <20200110090032.GB19453@zn.tnic>
In-Reply-To: <20200110090032.GB19453@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 13 Jan 2020 10:43:14 +0800
Message-ID: <CAFH1YnN8v+8UH3RvaeT7TJEdtEyxhoBA-ZEMk-mRFWNad8e9Jw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 5:00 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 10, 2020 at 10:27:02AM +0800, Zhenzhong Duan wrote:
> > Yes. Will you send this formally?
>
> And then a flood of fix-this-trivial-warning patches ensues?
>
> You should know that they have the lowest prio when it comes to looking
> at them.
I see.
Just tried Arvind's patch, result is not that bad. Below are all
warnings during build:
In fact, only gop.c and kaslr.c have compile warning.

/root/kernel/drivers/firmware/efi/libstub/gop.c: In function =E2=80=98efi_s=
etup_gop=E2=80=99:
/root/kernel/drivers/firmware/efi/libstub/gop.c:174:18: warning:
=E2=80=98pixel_format=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
                  ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:97:6: note:
=E2=80=98pixel_format=E2=80=99 was declared here
  int pixel_format;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:166:45: warning:
=E2=80=98fb_base=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  ext_lfb_base =3D (u64)(unsigned long)fb_base >> 32;
                                             ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:95:6: note: =E2=80=98fb_bas=
e=E2=80=99
was declared here
  u64 fb_base;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:174:18: warning:
=E2=80=98pixels_per_scan_line=E2=80=99 may be used uninitialized in this fu=
nction
[-Wmaybe-uninitialized]
  setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
                  ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:93:6: note:
=E2=80=98pixels_per_scan_line=E2=80=99 was declared here
  u32 pixels_per_scan_line;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:163:17: warning:
=E2=80=98height=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  si->lfb_height =3D height;
                 ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:92:13: note: =E2=80=98heigh=
t=E2=80=99
was declared here
  u16 width, height;
             ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:162:16: warning:
=E2=80=98width=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  si->lfb_width =3D width;
                ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:92:6: note: =E2=80=98width=
=E2=80=99
was declared here
  u16 width, height;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:271:18: warning:
=E2=80=98pixel_format=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
                  ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:194:6: note:
=E2=80=98pixel_format=E2=80=99 was declared here
  int pixel_format;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:263:45: warning:
=E2=80=98fb_base=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  ext_lfb_base =3D (u64)(unsigned long)fb_base >> 32;
                                             ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:192:6: note: =E2=80=98fb_ba=
se=E2=80=99
was declared here
  u64 fb_base;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:271:18: warning:
=E2=80=98pixels_per_scan_line=E2=80=99 may be used uninitialized in this fu=
nction
[-Wmaybe-uninitialized]
  setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
                  ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:190:6: note:
=E2=80=98pixels_per_scan_line=E2=80=99 was declared here
  u32 pixels_per_scan_line;
      ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:260:17: warning:
=E2=80=98height=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  si->lfb_height =3D height;
                 ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:189:13: note: =E2=80=98heig=
ht=E2=80=99
was declared here
  u16 width, height;
             ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:259:16: warning:
=E2=80=98width=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
  si->lfb_width =3D width;
                ^
/root/kernel/drivers/firmware/efi/libstub/gop.c:189:6: note: =E2=80=98width=
=E2=80=99
was declared here
  u16 width, height;

/root/kernel/arch/x86/boot/compressed/kaslr.c: In function =E2=80=98process=
_mem_region=E2=80=99:
/root/kernel/arch/x86/boot/compressed/kaslr.c:698:6: warning: unused
variable =E2=80=98i=E2=80=99 [-Wunused-variable]
  int i;

Regards
Zhenzhong
