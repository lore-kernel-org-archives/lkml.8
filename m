Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B452073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgF3MFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbgF3MFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:51 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MODeL-1jRqXU1xxh-00OTRt for <linux-kernel@vger.kernel.org>; Tue, 30 Jun
 2020 14:05:49 +0200
Received: by mail-qk1-f178.google.com with SMTP id c30so14372567qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:05:49 -0700 (PDT)
X-Gm-Message-State: AOAM533tjbkNRPWcUMnyhvhe3D4U6okbtrRXanq9g2Jvdp0/PJL7vEgr
        TMVXDUzkMlAi1HWimoQKHEZf+CQtBJ/Jfv9IoPg=
X-Google-Smtp-Source: ABdhPJyD2sTPFIhaB4+ilsJ2YeOSs7jo61s2FyUbZk9qT7eA2TcijeomDU1N0tw3ypRzRHDUYI5VXZv7yOapAOlhIZ8=
X-Received: by 2002:a37:a282:: with SMTP id l124mr18603651qke.3.1593518748284;
 Tue, 30 Jun 2020 05:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <202006301056.8ppxjF2q%lkp@intel.com>
In-Reply-To: <202006301056.8ppxjF2q%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 14:05:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xoJkd4sOny94Fs3YFeXvymkJWWcPnLLGZTLvLK4sDAQ@mail.gmail.com>
Message-ID: <CAK8P3a3xoJkd4sOny94Fs3YFeXvymkJWWcPnLLGZTLvLK4sDAQ@mail.gmail.com>
Subject: Re: drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous
 prototype for 'udc_send_in_zlp'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fzoGJGtVyxjdmfcv4rapUaJsFZIRWRCcmjJegj9Q1oOEmlWRubO
 yG08dD5qujVuGkmFwP4kSpaVHApMxq8LFBZAkXf/2CB3AmDMvgTaAQ6f5OjG4QrdYZJ5fLb
 wwBY1jlnrmUGGB6bNY4t2fqC1WK5nR4t3BsjBCM4X849urSGFRNyi7nSB83JA24qc+xLuAJ
 N6cMAEMCfskyhCJmZgLSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X5S2M58vEGM=:argfAXArNAL/nrXr7rBeT5
 oN6FIuit6z9IL/vXI+9ewBWYgceRl7+npAuY2DiEnKs21NzDjdZoM9uunGjuE3ZIS4wIYhEeg
 fP1EQmtR8qauoXNcWsZ7neh6oPxWhIjLBlcgNxM6Vo5SoJd41xmbDp5B4ZcDOJmJibORh/ptr
 O5QBA3ZIfit2IihwK5cKmJWsiHLM93kfvaSBEcOHsz5LT8NPSx1bI4pkVGwP9KhMDLHWW0BWk
 PuIyAB9mHJyrhGFVURwdWZS44U/nWpSj2Kndj1MsBzchRh9oblB1LxR91yqj4cpBroXH0xE4h
 ecwm0rpt3naedadZ64hHBwEuGcYuj7K8R1jngm0XEot6eBsumEcd7wc+Bai3MgZHB+BuwgsAa
 ZB2zzf+g14lOB05Cl/Xe9LJHbPkPy9MsoKaZFqkccqTwSnf5hxfey134XTFE/qkhZika9eDgL
 JvdNZCpPzSg0APFJ6+dUfWwxE7SFNCLzCBJAr1DdEOJhxWWd274mTz9rZJQA7A/7WFwgrHvai
 ST4+0Cnty2bVJ45XiLq9miLSXTOe8nusoqdZR5jfl1ZDLiI51bOq0gaS6VSfYjQ0pIEiler9K
 LFhLNggrV/Bo0qhkVrGmhQOiJvKWXaZ+9B0U+Iy3kUlAq2oDhS0i4HEd2hH9zoJShyUqDjKhF
 xNAsBdhxeMdIrkygNg/qhVboqnaS0GaXM7gUioaxxayXnHD/FUDUZJwJ2QR4SK9ZL+VMc/YKl
 Gqt73PqFCICgbDPZUV8Sm1dPtQVPBPCTrbJ/9oso0clAIFwZQBEyF/+k6tSWE46lOo7fnhX0c
 faRGChSrCG0NTwS8zEpOTSbSpRNvJqjxSUD1sb/uHKWkSawSyQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 4:20 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> First bad commit (maybe != root cause):

Correct, my patch only made the driver build on all architectures for the first
time, and now it produces a harmless warning. I sent a fix for it anyway.

         Arnd
