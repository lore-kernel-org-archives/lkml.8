Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728BCC35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEF422527
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVTjx6gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgBYDd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:33:56 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41070 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:33:55 -0500
Received: by mail-ot1-f44.google.com with SMTP id r27so10798506otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AtHRSTtrgdpxX7I9KkYj8t+4xP5KBWvQCkTpEy+3KU=;
        b=pVTjx6gLDVSqirZcMfRkxTMBQy+HPbUBDYKIPzvhxPVQDlljeZa8FR8gILTA0HOUKE
         68LfM0OV9T3nGwGa0R38F4M1VPAMD8SE9yLQ3dBnS3cTvly+m9o51ujOWtHXI5bFgKqC
         F4JcSM81rtvzr0X+QPgs82S+fY8SHpjGeSkiXWrmy3FGJNLukuqD01iZHN2t4RfLTJ9B
         zdOXzMxdwfusXVmubgd2Ssl4JW7DTUslWvfuiT3rB5Y8eUvOag6R3YC/n7hQISRQW4mH
         20XW+/Ib+yFmr++JsxHxsSacy4U4Ie7N42UILVRHZMknVTlfDtUu55b/TRi8eKDf08QJ
         /ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AtHRSTtrgdpxX7I9KkYj8t+4xP5KBWvQCkTpEy+3KU=;
        b=r42cb1mVCFZORaS69m1w8xmD1ZCLRKQR5FPqPbNfB5ElHbGxGUcVOKuxlmKyY7hLKF
         5e+1PC1/AGykbhfU5N4NJtOvDjYx3b2ZSkQltEkOatTo1qzGW6K5KpX3SoF8Hwslj3iO
         a1Gh6Zklg9Jp9juwijJknDhEpzHxO89pujxy4V65wjDGY+wIx1BHlW8xBmxgR4YtH2nt
         QnF4wBtZVI/mo2YBTHHKti5rfECSpxnseL5cBDn2RHqelVPa+lyQ8tv6BbQ0d23vSj8+
         bCGTRXMzE/M91N7Xe6ij6oZzFrfXdc017lB3+1rPPHbdpguwh9TjJTJxzao8NTTh8CCF
         b04A==
X-Gm-Message-State: APjAAAXHsugsrfksS2Iq/ZDkbfcEvCard0nnd4tD961FYE9O4oombkr+
        1MtUyOQckw4L68kfxjGF5ZAT1Dsiuwwec5b6anU=
X-Google-Smtp-Source: APXvYqwHUUEHXCJbBdkJoX9BDITo2hdWfvSbhL0O1Efu2QWpvI2GZeU35fVK5ueGzDNohKTUnHOLtZ+vBHupavqkCJA=
X-Received: by 2002:a9d:4f04:: with SMTP id d4mr42798017otl.78.1582601634987;
 Mon, 24 Feb 2020 19:33:54 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
 <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com> <158257881650.26598.5580907010251811605@skylake-alporthouse-com>
In-Reply-To: <158257881650.26598.5580907010251811605@skylake-alporthouse-com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 25 Feb 2020 13:33:43 +1000
Message-ID: <CAPM=9twmxKz97jMNjMq7U47tZ_3QiZp73EZrcwrYuwLhApcx4Q@mail.gmail.com>
Subject: Re: i915 GPU-hang regression in v5.6-rcx
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 07:13, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Linus Torvalds (2020-02-24 20:18:03)
> > Let's add in some of the i915 people and list.
>
> Haswell eating kittens. The offending patch will be rolled back shortly.
> -Chris

https://patchwork.freedesktop.org/patch/354775/

is the patch that is working it's way through the system.

Dave.
