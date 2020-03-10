Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA3C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D438F2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lNAHNZVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJL6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:58:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50805 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:58:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so1082393wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OQiy11R8ysMEMVGnnlAJfpm5twl5UBWdAasXal19OYo=;
        b=lNAHNZVGXmPO35wIINL++rLZX/jYpmztZgeD1jSNPV6Jlc2eykKFHZ5oQKQ2hWxyBP
         huSBKGQ13oew6/XIInKAYKNJ1GYvSO87HEvPRPMeAuur5AQeghPUVL5yajtSKn6bLcfv
         2N/iRxSo7EAdMkGB1bdsDVouVmllVu8irasDTyNsDzOgCec7ky5SstDeFoHo3ri6IZ2p
         G0jMtN+NODGTkB9YD0H447dKAI2mjDq9Ef9oOmtEuMp8SIDo+FSf+FS7vfMnErMZc56i
         kCwNaWR0psN2jdB9u6n6ksOItDwDiVIJ5e96T1YlKCyFsdTKFEnHpN8bfjZwOBMU5kth
         e/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OQiy11R8ysMEMVGnnlAJfpm5twl5UBWdAasXal19OYo=;
        b=nKPzfluw7ZyFRYgdkfD+r2kICk8egAstMgIOpilpdXuY4in9i2NhjL/2Wed5ADcZk+
         yaaJcRi0G60zIuA/sCdvGU1yctNoRgyIToT4V2C+VNLLKm2XnOWg+Gh/bmXEXE01bYo2
         dR3wWxn+wftW6FCUNkCbFcRCt4iY/ki1HC4y3irsdWWab/s9HcISgdZP1y4GMC8G3v5J
         ug9pK1WUy0khNVXkEpmVLw0YwDVN1uWhr+xh6K23dgVfytC+qcmjcyjPqrh3OFVEWlSl
         JdwmJWFWMoUNvxkSqMTipNseHvIQrVQqZcX9bdRmQtY6zYHRP5KojuERgF5wCQFxb6AR
         NxFA==
X-Gm-Message-State: ANhLgQ27bfLc5aTvfAUbQudS/gX2fhZ8beyUE236idGsYWZ6/xF8hTx8
        xqt3w4DRCztXqah1v2vFa1PNgOTV6EGK749cfpLcSw==
X-Google-Smtp-Source: ADFU+vskX+jRObHtqozavxpi6rHnvu1BAyDctR2GYm1m3OykqFIMf7pilcQrBc32lRRcbc5mkSLG7EBZYzYDLFFPdRk=
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr1927337wmk.78.1583841484223;
 Tue, 10 Mar 2020 04:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191125132147.97111-1-anup.patel@wdc.com> <20191125132147.97111-2-anup.patel@wdc.com>
 <mvmh7yx4z2u.fsf@suse.de> <MN2PR04MB60611C6CE40C024E336C8ADC8DFE0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <mvmmu8objdr.fsf@suse.de>
In-Reply-To: <mvmmu8objdr.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 10 Mar 2020 17:27:51 +0530
Message-ID: <CAAhSdy0Ctq=qF-tYwwBMoW6LbddDt7+oDDT6SgdAR2HCKqbAgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 3:51 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 09 2020, Anup Patel wrote:
>
> > Perhaps selecting DRM and NET_9P from SOC_VIRT will help. Can you
> > try and send patch ?
>
> No, the config option should be removed.  It is useless.

It's not useless. Going forward, we are adding SOC kconfig option for
each supported platform.

In case of SOC_VIRT, we over-selected all required VIRTIO drivers.
Instead, we should only select essential drivers from SOC_VIRT and
enable the rest of drivers via defconfigs.

Regards,
Anup
