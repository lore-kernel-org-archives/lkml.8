Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3738E21527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBD5qvWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395151AbgFSQd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395148AbgFSQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:33:52 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC575C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:33:51 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id i8so3377947uak.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuZRFjj4GVKk/Ijdunq9xPTSKIAnwdTCqv+U3vVkS6Q=;
        b=tBD5qvWnzqVjOjDwB0x1Hz5x6DtcXvTseEAauDmLtLWzHFM6OwFIX1CPHunYcQNoog
         vfgdI0PpQ3rI+vB1gTms79sAPMWIIJAvvoi6qSUT7Jo4/Bil9+Ci6sQv705fytJVmd29
         G1jXJEb8Z+dMtUWPTKmi2DisPXJnf7OJUDDKEbd6CbgqVSRsi/gG2LWQUByJmyR2P1AU
         Ucqtvf8IfqsuFuFyx7pvahPGesRdRFk0RwuC6iuqy6vgkq6pAPt2bGU1sclAYqv0V/Cy
         d8XYX47vZr3e8tL+KOSHXZgruOkdABtUo9HpogdkQ8hJAI1k8jxFo9QbmimyH48UWWsL
         rLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuZRFjj4GVKk/Ijdunq9xPTSKIAnwdTCqv+U3vVkS6Q=;
        b=jxT44sFix+qVkkiLo5eSDCb5ARlxEkJvTXVx99/KpZyJhRM4JDd18z03nnasQ8PO6m
         sXhWGFoVBcYjD4QZeaT2L4MnZE33tyIBeSYZeioyn67jSWx9iHgeqpBGkn/S9KzroIxx
         UOZKB424dSoTW/oaWVsb4cqiH1O/3twYjGwqf1OnNKWaGcEjYICaPup5sAOGx0akdq5Y
         im3IW1x0t1ProLkCg0j2vxEfWAVJUzk70qDqusfOBk6T7njOBCK9YW2AJ8SamMbY3Hwv
         ZcUI+pM+BcS4T8NZgKE5eIgOar0IWlOX7sc7hvRxK4qi7hq5D5QWNdpBQLqlbFeNvEeU
         86eg==
X-Gm-Message-State: AOAM530YSgSCFgvfVJQ4q9MK5S9MxJ9mcB4etgwbskgEfhbPdaNXGzXY
        h9lTfgG/D3gc6Tjh2OEtGBK27UcNw4RhuV/1uL8=
X-Google-Smtp-Source: ABdhPJw2L77SOUy58I3ivbTsxlOgwP7tCAnMpgs00+TIfjEaLjRTI6/4+SlFZLmSif47JDNv1zZg6jmAIwWguNZMLpc=
X-Received: by 2002:a9f:28c6:: with SMTP id d64mr3304951uad.61.1592584430851;
 Fri, 19 Jun 2020 09:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic>
In-Reply-To: <20200619161026.GF32683@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 17:33:39 +0100
Message-ID: <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 17:10, Borislav Petkov <bp@alien8.de> wrote:
> - do you just want to display feature support?

Yes. I want to show the user *why* TME is not available.

Richard.
