Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B74C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE62072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqjN7sn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCEEDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:03:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:03:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id z9so3400896lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VklxRdhjEuCIVv9HPoUaXq6mGuwwwTdi/ln0LYnVDsY=;
        b=iqjN7sn1fgP8MPUCuQpmzoScaDl1FaFzxx3l1cao6LafOPa8aFbH28X7nrCPhLRAbR
         qtXG+jrOx+0IPwQTh8T0OpSSV6eVDvOi2nVHr+AMlvWLKSoWxo9JoXpKQMXHEZjbZdIP
         Eg0P7foQARhwfsw4LDg3rxTBm0PfMExB/HPfcvvQU6OCxEiMKA+A7donE9uK7TQxxHGd
         Tlb/uDyhYeWMxsBDSAv3jUoA+bsPBAJ+mBd165pbvxkgbsChGGXYU/liBCc22CPvI+Bi
         u5S/sz/Q0IsWdmEYawIM+0cbJg3IigCvSnjnEwRb3eJSdmZoLWTq9uMqepeF8ts+1lF1
         PH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VklxRdhjEuCIVv9HPoUaXq6mGuwwwTdi/ln0LYnVDsY=;
        b=g0pu3AQSStkWWwdVIMp0fxu/H9QhXV3r6F3C5ldt9+ZrTqiV+/jqCy5UT5Rb3ZkAd4
         wLt+bMM85zrHikN2BgsYmXM7tvBqGUCZ0XRnWpyYCyae4TrPOnKiTXbHJVIrobGvNo1h
         EY8IH/C5xnIBULvReJoFRsHUw3O3B7Cu6QfiTzI2ztT0SEjiK9hj9zmyNkQIeGIm6lXc
         usOqxpfdabYPPjzFUuplUpCM7bnU6y/Rbr158U+uBQPr/QzJW0h+iVNI8Gp+moqsJiUM
         51Afog2PjyDqV1ouooYBEZ/8XASYFJlZ/efkALLrdeqikSUxvnTm36Arsl6fZHFAPBvK
         LhPw==
X-Gm-Message-State: ANhLgQ0XUHV3R/8B0eiTaftT15RasfTnG5zPBkoukAOC1fBvs5dBwT75
        ncmlGEO9FQf2GlHCn9T7nVO3numGB5Dv5DuYaHc=
X-Google-Smtp-Source: ADFU+vuQdhdkwqvCT4rZebQz2XQDE0WI+aS9PhR/Z3fu1h9LmSnA/wASEBpkts2Cc3AneUr71GfjwjxOKvU2A0KiPf4=
X-Received: by 2002:ac2:5f62:: with SMTP id c2mr4094191lfc.207.1583381017663;
 Wed, 04 Mar 2020 20:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
 <20200303065210.1279-3-zhenzhong.duan@gmail.com> <ba5067ad-4fba-52c9-6872-c18bfeb947db@intel.com>
In-Reply-To: <ba5067ad-4fba-52c9-6872-c18bfeb947db@intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Thu, 5 Mar 2020 12:03:26 +0800
Message-ID: <CAFH1YnN01PtCBm_92m3CPRhsiS2Bzis8q-vOJ5q+_LUq8ZoZqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/boot/KASLR: Fix unused variable warning
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 6:56 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/2/20 10:52 PM, Zhenzhong Duan wrote:
> > Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> > CONFIG_ACPI are defined, but definition of variable 'i' is out of guard=
.
> > If any of the two macros is undefined, below warning triggers during
> > build, fix it by moving 'i' in the guard.
> >
> > arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable =E2=80=
=98i=E2=80=99 [-Wunused-variable]
> ...
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compresse=
d/kaslr.c
> > index d7408af55738..62bc46684581 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *r=
egion,
> >                              unsigned long long minimum,
> >                              unsigned long long image_size)
> >  {
> > -     int i;
> >       /*
> >        * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> >        * use @region directly.
> > @@ -711,6 +710,7 @@ static bool process_mem_region(struct mem_vector *r=
egion,
> >       }
> >
> >  #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
> > +     int i;
>
> Won't this just result in a different warning since it now it will
> declare 'i' in the middle of the function once CONFIG_MEMORY_HOTREMOVE
> and ACPI are enabled?

I didn't see a different warning with both configs enabled, because
-std=3Dgnu89 isn't
enforced in arch/x86/boot/compressed but it does in other part of kernel.
C99 and above allows declaration in middule of the function.

Zhenzhong
