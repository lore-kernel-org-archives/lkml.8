Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA4EC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA76F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QktBavBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgD3NsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgD3NsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:48:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69AC035494;
        Thu, 30 Apr 2020 06:48:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so1522513ion.0;
        Thu, 30 Apr 2020 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=10MZchLKLWnUIx2ECF9AmTSv1/bLhdLwtRVHSCWf8+g=;
        b=QktBavBK6XvPz921HcbrP7hPlPYQsHcjwKAwVazUGuPktYwg0hWVhrpQDMwKYPEpmX
         YQwTWO5Of3YIILrrAN3BaPXufDisF6Wq4gKImopG9EMRx2I4GFwCPFvXcCU1Q/r3SyCK
         uJi79JjeszqUlBm56CTuQbiXv3K9LQxr0nTcaDFYqcuuI+CKspZZULdGBa2qseDI+KTX
         4j9gOTBXn/+ZSYB/6Ng1f0LLtsz/A4F1PlG/FVq4r1PT57FAx+kkMMz+EWVtoiIbdJxY
         UoSV76tlgI32brHrtsqmghmLgL/rphijhheE0iv3sM9DYC9UfpM6aFilTg1n2yGD+etb
         mAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=10MZchLKLWnUIx2ECF9AmTSv1/bLhdLwtRVHSCWf8+g=;
        b=bgF0VUy2O+Xl4oILzjFWoTkdzm7WijXWHu/n5Hr6C+acKyaG8BMLwZvGLE4OI4I13f
         ghKpLt3vsr6/Q1oTWqzQCd8rZIZIpEFgkDDsmLZC+eKPiTdm+zW1wmfNFTGAuaYKRXFs
         DD7fEtBAaWBv/Gh/SxPjWKs9AFHa89gdBtxAfEoF+KCODFwG/kaIg25DMdNBfdSzvOWl
         d4c5NRCBaUURZ6bHmbwFqvAIRhXCVy5JlY3No/RPa6eIZU1+SPZFxkwH3VGNA2Pbf908
         4kE4HjV7Klcv77Lc0xKQdVRJ7xDPMxEf2+CSesz3xHVPTfzuoAhhMGqXyL55RmWyK1wP
         jhMA==
X-Gm-Message-State: AGi0PuY1/0o+51XkTxspXMkdYjdTPN6YjIZr6waVdWFGslGyx66gKhSU
        gyVMA3+zQ7FxCQl9OqO6WQc2tnTuuHNpJ/fkswo=
X-Google-Smtp-Source: APiQypKUewJB7mq7q4jnAnRBE/CzoMbD/Z0qGWJZJ2DU8qcUWhS+0JFArF36tAUwzspubM+J9kD6UrRljIliN6yqnRg=
X-Received: by 2002:a02:3f44:: with SMTP id c4mr1837141jaf.144.1588254495397;
 Thu, 30 Apr 2020 06:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200428142629.8950-1-peron.clem@gmail.com> <98246e5d-ebef-bcb5-f0b8-d74b3834b835@arm.com>
 <CAJiuCcco0d_UoWeHqh6oc0rFNAMFynXjLRQ6APsT0WBh7m+GQg@mail.gmail.com> <20200428164522.p7ypca7zwocc7alq@gilmour.lan>
In-Reply-To: <20200428164522.p7ypca7zwocc7alq@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 30 Apr 2020 15:48:04 +0200
Message-ID: <CAJiuCce9UDp--XQ=rXPZ5cZyNDMFC3zyq7pnw3ETXkR3=zMWaQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: dts: allwinner: h6: Use dummy
 regulator for Tanix TX6
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 28 Apr 2020 at 18:45, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Apr 28, 2020 at 06:23:35PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Robin,
> >
> > On Tue, 28 Apr 2020 at 17:21, Robin Murphy <robin.murphy@arm.com> wrote=
:
> > >
> > > On 2020-04-28 3:26 pm, Cl=C3=A9ment P=C3=A9ron wrote:
> > > > Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> > > > voltage to meet OPP table, the DVFS is not working as expected.
> > >
> > > Hmm, isn't that really a bug in the DVFS code? I guess it's just blin=
dly
> > > propagating -EINVAL from the fixed regulators not implementing
> > > set_voltage, but AFAICS it has no real excuse not to be cleverer and
> > > still allow switching frequency as long as the voltage *is* high enou=
gh
> > > for the given OPP. I wonder how well it works if the regulator is
> > > programmable but shared with other consumers... that case probably ca=
n't
> > > be hacked around in DT.
> >
> > Like you, I thought that the DVFS was clever enough to understand this
> > but guess not..
> >
> > Maybe they are some cases where you don't want to leave the voltage hig=
h and
> > reduce the frequency. But I don't know such case.
>
> I assume the intent was to prevent a regulator driver to overshoot and en=
d up
> over-volting the CPU which would be pretty bad.
>
> I guess we could check that the voltage is in the range opp < actual volt=
age <
> max opp voltage ?

As this could take more time than expected,

Could you drop the commit :
add1e27fb703f65f33191ccc70dd9d811254387c
arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6

Thanks,
Clement

>
> Maxime
