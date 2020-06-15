Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9520739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ACjIi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgFOPLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFOPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:11:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:11:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so18243132iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PieIGvQlj3E4NH14G199DoG6j5Cbq8FJrA0WPNTIlWg=;
        b=C5ACjIi/TkkOTzIVo/MR1GdGIhWnkkF+rEO579iDy7hjEpvc3EJ7rhU0mjVUXUHyeh
         HesF59K2qmTzk3x7jr3DDKlMfRs4I932YCIGBecS8OEtFy5sGxpUmcEqVUN4f+eL2LtZ
         852bNCHCsW6/JOQM+9wjVUCPUHJHffLQ5tC8bmZGBUaGn1Qi6TvRZmf1yKEZOQM1wfWj
         y3bKqqkBKkAYUxJpaLpzr39pTVGM+qyGJzlVMLv9hvAG3Pz4JuTpu3ayYVezhTi5g6Wo
         4CjDeC2/827S3CYrax7W+dVLXvIw4T3Wt9T8K+un5poarzjISI+NfA/0wGodAXnV79+r
         5TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PieIGvQlj3E4NH14G199DoG6j5Cbq8FJrA0WPNTIlWg=;
        b=ct/MpFswYZLiZGzah3Goi8mj+5yHG1Uvu/qntduwas33nH86F1ghklKh5c2HglQ1/j
         kif4EkRvV9ucyBUvcQgjzlp+A4KK168ZOb2ev82mwwHhhcWPmLWHAcW0zxv3WINLBv8f
         8rEbSlAErtT5caojKXqhGDfDD1PcCWMJtY6gzKHnhyESSDROFF4iKThkGJU9T01ILTdR
         79ejFNbVKBK0qct+Gyp9bAJJIlvrVCfdX6xRWpwpUo+M4rHOxbCn5J/V6l+V616wU5hC
         sgKM7lrPVWBXrCxVKyYBgJfRosN/CpbUxqs/upDokwHPhGb3OA+C+5kg4OcgRIVYEgZd
         SByA==
X-Gm-Message-State: AOAM531ta2jhwSAONNTaEHFTVUTAfkUg6MVSaZU00+iKR96inxKXtJUz
        u6MOAyLMcienUfLiAKZYmvUdQBZiLH4ymvN9JpUybqHD
X-Google-Smtp-Source: ABdhPJyGZp1m2WH/mUKvQLav5aU64ZZQSf6FLyDvOTrzG/Kwrk07DtR62ay+1BrYrXVAVd0GUPueWWq1zwjLP2PL750=
X-Received: by 2002:a02:6a1a:: with SMTP id l26mr21977264jac.66.1592233871265;
 Mon, 15 Jun 2020 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200611054454.2547-1-kdasu.kdev@gmail.com> <20200611054454.2547-2-kdasu.kdev@gmail.com>
 <20200611092707.75da8c6a@xps13> <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
 <20200612090728.043b6baf@xps13> <CAC=U0a1oLPs_=SgUTxYPxiW8JpQXOpz-RbL2KrgzDjutt1v0mQ@mail.gmail.com>
 <20200615091923.0c3c7aa7@xps13>
In-Reply-To: <20200615091923.0c3c7aa7@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 15 Jun 2020 11:11:00 -0400
Message-ID: <CAC=U0a14R-ZFtwcjESLn67tOfM=DPtdm_Ljuu6Y6Xyx6mRS-Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU transfers
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:19 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 12 Jun 2020 12:34:22
> -0400:
>
> > On Fri, Jun 12, 2020 at 3:07 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Kamal,
> > >
> > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 12:04:29
> > > -0400:
> > >
> > > > On Thu, Jun 11, 2020 at 3:27 AM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > >
> > > > > Hi Kamal,
> > > > >
> > > > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44=
:54
> > > > > -0400:
> > > > >
> > > > > > Implemented ECC correctable and uncorrectable error handling fo=
r EDU
> > > > >
> > > > > Implement?
> > > > >
> > > > > > reads. If ECC correctable bitflips are encountered  on EDU tran=
sfer,
> > > > >
> > > > > extra space                                         ^
> > > > >
> > > > > > read page again using pio, This is needed due to a controller l=
mitation
> > > > >
> > > > > s/pio/PIO/
> > > > >
> > > > > > where read and corrected data is not transferred to the DMA buf=
fer on ECC
> > > > > > errors. This holds true for ECC correctable errors beyond set t=
hreshold.
> > > > >
> > > > > error.
> > > > >
> > > > > Not sure what the last sentence means?
> > > > >
> > > >
> > > > NAND controller allows for setting a correctable  ECC threshold num=
ber
> > > > of bits beyond which it will actually report the error to the drive=
r.
> > > > e.g. for BCH-4 the threshold is 3, so 3-bit and 4-bit errors will
> > > > generate correctable ECC interrupt however 1-bit and 2-bit errors w=
ill
> > > > be corrected silently.
> > > > From the above example EDU hardware will not transfer corrected dat=
a
> > > > to the DMA buffer for 3-bit and 4-bit errors that get reported. So
> > > > once we detect
> > > > the error duing EDU we read the page again using pio.
> > >
> > > Ok I see what you mean, can't you fake the threshold instead? The NAN=
D
> > > controller in Linux is not supposed to handle this threshold, the NAN=
D
> > > core is in charge. So what the controller driver should do is just:
> > > increase the number of bitflips + return the maximum number or bitfli=
p
> > > or increase the failure counter. Is this already the case?
> > >
> > /* threshold =3D ceil(BCH-level * 0.75) */
> > brcmnand_wr_corr_thresh(host, DIV_ROUND_UP(chip->ecc.strength * 3, 4));
> > This how the threshold is set, all it means is that for high BCH
> > levels don't interrupt on low number (less than threshold) of
> > bit_flips. Yes the controller driver only increments correctable ECC
> > count. But due the EDU design an EDU operation is disrupted when the
> > controller interrupts on correctable ECC errors during subpage ECC
> > calculations. Hence the driver needs to read the page again with PIO
> > to transfer corrected data.
>
> IIUC, you are doing the job twice: you should just return a number of
> bitflips or an error to the NAND core. So that's why I'm telling that
> you should get rid of this threshold. It would avoid the need for the
> PIO transfer too.

I think you are reading some statements in isolation that probably are
causing some confusion.
EDU design has a flaw in case of reported  ECC error interrupt in that
corrected data is not transferred to the DMA buffer. The PIO is needed
to read corrected data into the NAND data buffer and only for the
reported errors. So there is no need to change the threshold
calculation logic, if we get rid of the threshold then we will have to
do the PIO read on any correctable bit error if it occurs during EDU
reads.

>
> You also say that the controller "only increments correctable ECC
> count", what do you mean exactly?

Maybe that statement was a bit misleading. To be clear when an ECC
error is reported the controller gives the bit_flips count  as well as
updates the ECC error address Register and ecc error status registers.
This logic works as expected in the hardware.

>The controller does not report errors
> when the number of bitflips happens to be above the BCH threshold? This
> would be the only case where what is currently done would be actually
> needed though.

 It's the other way. The controller only reports bit errors beyond
>=3Dthreshold value, will not report otherwise and silently correct the
data. There is no problem in  cases where erros are corrected
silently. Now ECC (un)correctable on EDU reads are detected by simply
reading back the ECC Error address register. And in case of reported
uncorrectable ECC errors are treated as usual.  And for reported
correctable ECC errors we need to read the page again using PIO so
that the corrected data is properly transferred. All this applies to
EDU transfer only.

>
> Thanks,
> Miqu=C3=A8l

Kamal
