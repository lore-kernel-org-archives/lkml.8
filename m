Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F562187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVb2hUrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgBNT1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:27:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42005 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:27:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so12192965wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VP86rC4jlMZ20pNXPxdyUDyRCGD4cSNaWzeZ85oQNd4=;
        b=jVb2hUrxG6s7keVKOwnMXKnD0bCzFC2TtYTtetPeA8ZxSEeIbuoKViY/hJ16CCUZQs
         NwJoPP4vfDY3u3kj/C5XfejVRufoRFOZBRRQzHelxLnA+HYVPSsh/ISIufAqEuHTYdkO
         doa/VLfslTGhp+hA8dZ50myQl2HCmoCx6HLcHn7+Xp2WNIvj9X6PYYIZe+xVHye0ndOm
         KXg0lirQcsM8v5BJcYnz6SozbrvlOcBE5MRAbKcPRhTS4/dUXnWwYsb8EeH2sDDyQixk
         1Ee/DFSJJ9FBZrR82QiK1Y2wWo8fZTKFRRKyPD8B5JGGuLHFElnmf207ecS0pw4mTqCC
         hiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VP86rC4jlMZ20pNXPxdyUDyRCGD4cSNaWzeZ85oQNd4=;
        b=h+jEUBW4FDfrBa8fmb7XUII1UBzLzMIwVXsyeCcAoduS9L1pFzRV6egrVCTenp8bI0
         L+yzMybrZ8Z4HgOGRB22U+IiujneJOmySeoiZRfWG1SEmaWhD74TAHMJBAnF36zTjnqT
         GIMflZWyiIKSSzW99pptqUCde8/zvuJMH/faqdAH+cwFej0jF7oW/DzXWtAD7OTYXnUh
         ssGjikSKaCrAb3ufBUbCDfDtTpTSDfrw6AIaNTAG0RYoTI+uxQ7wmA4bsgiW2PJiYY/N
         ZYYUk+kke96ONBB9pEwYcscY/ysmNV/05jWPYaPzkqEvRE3mzINCU1chi9Rma/X9dAYV
         HgJg==
X-Gm-Message-State: APjAAAXnhHXT1O1/d9Cwf3A7vbK76uhzURIdzFas6UbdMccki7iXHiTT
        1NiWY65mDzYzx6eBFl8v/fDOUQF9QXWYktgSsmQg1awc
X-Google-Smtp-Source: APXvYqyH1ibbYri7IM8Yc0NVQLKuPddpS8ErXdBnKexdIuAXypjGwt+QBW7N42xfRdNyXZkyvA9oMlJaqj6/HXavRFM=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr5324897wrm.290.1581708428742;
 Fri, 14 Feb 2020 11:27:08 -0800 (PST)
MIME-Version: 1.0
From:   Chris Gorman <chrisjohgorman@gmail.com>
Date:   Fri, 14 Feb 2020 14:26:57 -0500
Message-ID: <CAHVeOW-TgaUctUE71jDSofBCM_O3dxrSvbCYLPRKm_eRpmY_MQ@mail.gmail.com>
Subject: digital microphone on google chromebook code name banon
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a problem with my laptop recording via the digital microphone.
I did try to explain the problem on
https://bugzilla.kernel.org/show_bug.cgi?id=95681, but I have heard no
response on the issue, so I am bugging the mailing list in hopes that
someone will have a magic fix for me. ;)

My laptop is a google chromebook, braswell, banon.  It is of the intel
strago family.  When I try to record all I get is white noise.  I can
reduce the level of noise via alsamixer, but I have to reduce all the
capture levels to 5 or lower.

I reached out to Sam McNally (thank you sam) from chromium regarding
his patch to cht_bsw_rt5645.c
adebb11139029ddf1fba6f796c4a476f17eacddc.  He was quite nice and
helpful.  According to Sam, the banon chromebooks dmic works with
their chromeos 4.9 and chromeos 5.4 kernels.  Unfortunately the dmic
still failed on my system when I tried the chromeos 5.4 kernel.
Perhaps the problem is my new coreboot 4.11 bios, whereas chrome uses
an older bios? I don't know.

Sam also pointed me to checking /sys/kernel/debug/clk/clk_summary.
While recording I get..

pmc_plt_clk_0                     0        0        0    19200000
       0     0  50000

and while playing everything's fine and I get...

pmc_plt_clk_0                     1        1        0    19200000
       0     0  50000

This is clearly the problem.  I don't know how to get the clock
working with the capture function though.

My kernel configs are ...

SOUND = y
SND = y
SND_SOC = y
SND_SOC_INTEL_MACH = y
SND_SST_ATOM_HIFI2_PLATFORM = y
SND_SST_ATOM_HIFI2_PLATFORM_ACPI = y
I2C = y
ACPI = y
X86_INTEL_LPSS = y
SND_SOC_ACPI = y
SND_SOC_INTEL_CHT_BSW_RT5645_MACH = y
SND_SOC_RT5645 = y
SND_SOC_DMIC = y

and I am running linux 5.5.0.  I welcome patches and suggestions, but
have not subscribed to the mailing list because of the volume of
emails, so please cc me with any response.

Thanks in advance.

Chris Gorman
