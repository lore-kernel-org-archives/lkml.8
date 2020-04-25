Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5D52072B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HSXwK1S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgDYTrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:47:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2157C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:47:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so5419904pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=su/TZCdqsGvDX9O/dILShocQiIYHImvs41WopVEj3dw=;
        b=HSXwK1S0RYPgtPSMNgcEjmafSf61If+0xsLS+GSFa2PueznsCEQ0seads/QyC49eam
         ChF2VREKs79Xr2/x1ZXz/hxctXZzXzSm+dKeuSZ95p5d0d9wlWufoRlNviyr31NcTuPi
         ds/VTJnblzlXan6xNWu5FVl05hOJTzbCmH7FnIrRgzN9MwKqO7iu7VFWv8xkBoY6GpDl
         Jznip7aJE891SixfzCyH9GiFuwWvLoOukW3NU363SZ3X+hewceNu0/cauA9MStDr+tgz
         ndotP6Bq4jE6rI35SQCmWMndOsi1yWHYH0/LiDg6y8dKccC3HNc4Yb/re7xLVArFp9Cf
         9afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=su/TZCdqsGvDX9O/dILShocQiIYHImvs41WopVEj3dw=;
        b=trXUV0wSqfgRA8OoZ0biLV2BhdJN4MvBWHPPPBglB3dQwvHTeIEoz45BZhQVeTrjAF
         4Th7akSNlwsMDEY1P3PPjhpvnH8x+IHSFXbB318rx9vfYnXsyrzaEkAIdCC0irPYUGqE
         coW2e7cLVbXU3RmLwQwMqKajOsLBl4COdmomJkm4gNJAJVvO2NLl9qwZSrT7XPTlpGU2
         cuEQeJBAe4z1FsDvSzQx4hpdyyc1exASKFhdzuFO3UwLDmUt3wLEyMCVY9JJHBcG8+sO
         753nujhDOBOX64fwAqC2aZ4G6tpd9OqCfRDKHQPsgJL7/j7fJbH3cL/ENXFkPG5UtbKV
         b/RA==
X-Gm-Message-State: AGi0Pua3EG0IG3/YkAgyu6AtN3wK7Kio83/ZXmgKZH6tXmsL0yy7sf2r
        xPSwpnz08vwoFklr4Rts8S0d0Q==
X-Google-Smtp-Source: APiQypKEMhdWCQosOVFNGGvelzt3tcfdxzwTQ4wUUFKoxDVH8RdkAuEGYoNGN00zKueIqusTJ5+Cmg==
X-Received: by 2002:a17:90a:d984:: with SMTP id d4mr14044440pjv.59.1587844054298;
        Sat, 25 Apr 2020 12:47:34 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d16f:990f:8780:729d? ([2601:646:c200:1ef2:d16f:990f:8780:729d])
        by smtp.gmail.com with ESMTPSA id b2sm7567961pgg.77.2020.04.25.12.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:47:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date:   Sat, 25 Apr 2020 12:47:31 -0700
Message-Id: <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
References: <20200425191032.GK21900@8bytes.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Mike Stunes <mstunes@vmware.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>,
        Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
In-Reply-To: <20200425191032.GK21900@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 25, 2020, at 12:10 PM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFOn Sat, Apr 25, 2020 at 11:15:35AM -0700, Andy Lutomirski wrote:
>> shift_ist is gross.  What's it for?  If it's not needed, I'd rather
>> not use it, and I eventually want to get rid of it for #DB as well.
>=20
> The #VC handler needs to be able to nest, there is no way around that
> for various reasons, the two most important ones are:
>=20
>    1. The #VC -> NMI -> #VC case. #VCs can happen in the NMI
>       handler, for example (but not exclusivly) for RDPMC.
>=20
>    2. In case of an error the #VC handler needs to print out error
>       information by calling one of the printk wrappers. Those will
>       end up doing IO to some console/serial port/whatever which
>       will also cause #VC exceptions to emulate the access to the
>       output devices.
>=20
> Using shift_ist is perfect for that, the only problem is the race
> condition with the NMI handler, as shift_ist does not work well with
> exceptions that can also trigger within the NMI handler. But I have
> taken care of that for #VC.
>=20

I assume the race you mean is:

#VC
Immediate NMI before IST gets shifted
#VC

Kaboom.

How are you dealing with this?  Ultimately, I think that NMI will need to tu=
rn off IST before engaging in any funny business. Let me ponder this a bit.

>=20
> Regards,
>=20
>    Joerg
>=20
