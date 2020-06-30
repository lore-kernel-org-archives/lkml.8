Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB79BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47E92073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbgF3PAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:00:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgF3PAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:00:33 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M42b8-1jqHkO0eQK-0007pw for <linux-kernel@vger.kernel.org>; Tue, 30 Jun
 2020 17:00:32 +0200
Received: by mail-qk1-f182.google.com with SMTP id j80so18865329qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:00:31 -0700 (PDT)
X-Gm-Message-State: AOAM530WlOS6EM6piA3vZPjjw35Mp/C0edZC6SufNqSpLrBLXqulw2kx
        lGC5vdriMwSiQludntRFm+iUVclMTGNNyK18/ho=
X-Google-Smtp-Source: ABdhPJxc+rJC1FVSVT20ACTLzJUDfVOt+ZKzz/cHEuAhJFG7HGFLCm4c5Y2ASqeRRJISfwukuMx0yd+d949gp2cgAVE=
X-Received: by 2002:a37:a496:: with SMTP id n144mr20363421qke.286.1593529230706;
 Tue, 30 Jun 2020 08:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <20200630085641.GD637809@kroah.com> <CAFmMkTGrnZt7ZaGyYCe-LCHET4yHz9DfanaZwsOS6HCxK40apQ@mail.gmail.com>
In-Reply-To: <CAFmMkTGrnZt7ZaGyYCe-LCHET4yHz9DfanaZwsOS6HCxK40apQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 17:00:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0WKODYvHzsf05QZ1dFh5uMQu2z7dzO1DMp1E9TWCrsPQ@mail.gmail.com>
Message-ID: <CAK8P3a0WKODYvHzsf05QZ1dFh5uMQu2z7dzO1DMp1E9TWCrsPQ@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:669HeGT6U6E3Rq2JQkIMVKl6CONWwyMwcTepCuBIMw+537tUoxw
 9xJSGOy6lHZO1B5TILaKxo6qfVcChN7+xieEXSme9uTBONF83h5uJGzj/6YfcE9uqP7nkN9
 DAn6b7/eAyqBBQyazOdxKeA0YcJc56faWAnOCEp8cLTzrTda7TIVB/jy1zwHvNkyA5Lku6x
 25z8Pmu4jKiDxOjSO6NDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:98U+WpWIQC0=:N7MDersVAjJozj+a33ZsLe
 KwfeFjq9G7yJB28qquAaOuksdZ/IKBtxUvmopnWt7rXYB2+Fi985LvtGs+1MT8Z7sjfLsmv7p
 XmIyeeK2n/Tqbt1DF44Jf/mfza9M+aZV+W6I5WPS0PQXtNV9bSUeLOi8QQmJBFNlJLr848Obb
 6hnHE3QBj6Tfwv/yut83aFEDl3nKS07MuNbCNuDxl8S6p9n5wRXBy7v41JgPPtuEMqbq+KqzP
 L7yth0aLMD8h/0jVT556d/RQjOOx2zwlrvldUwUq7iKbgDoUCQG313eoCstaA1DsAXpR0bvn3
 g7nFUUDVLegpiEnVly06kIcTgV3UCBFOI8bMSKeOpIpk8/s0fOSOwJL76/KDMsSQWBA3R+Qce
 mCw4UGTINMuivUGqVASFIF0EPg+DvgY2A2G0UjyzMbzy6qEqoiEHwqZ/Yz6s7YY0zzkB2VhfY
 EZmh9sQFErtuwBrtK2cV7H9CN/3aALWX8Bjp2rou7+wWM3NnlM92fbcSuCnbHJw3FEVwl2i0+
 cudddCsU33pEd+Qa0UuKlLd5kbpCBDGZjljSTiHw7AUM6gueCAFw9SCx1TIr+0amG9RyEYwrU
 BPqNE38joPx5Q0gkcXLb44tqBwLlZM8Gj5Jet7+nmRubVgV0mNuuo3Sg8mLkmdNggGLnqVXrK
 00HaEG02gB2zR2ktmB1Pi8+rs1Vt+Y5iIyqX8naxULy67v+TEdxiu4L+fiDPCGu6g50i7P0s8
 /dpHgjPjmh8HF1tuGjHJgRq54s4G81QnVtR57oIjShnBEtc3PFKZeOAaufmXiyMw0jRNzinLS
 R/JL+4F3+K24gGIcn8gI2A3db/ZSLT/IsHBwB9T4hlGTw5rXGw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 4:43 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Jun 30, 2020 at 5:56 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
>> Why is this going in securityfs at all?  Why not just sysfs as it is a
>> CPU attribute, right?
>
> Richard already discussed that, but "it" is not only (one) CPU attribute, are SPI chip
> settings and attributes coming from the firmware.
> Please note that I wanted to submit the minimum patch, but I need to add more attributes.

Why can't the SPI chip settings be attributes of the SPI chip device in sysfs?

Which firmware are you actually talking about here? Do you mean firmware running
on a device behind the SPI controller?

      Arnd
