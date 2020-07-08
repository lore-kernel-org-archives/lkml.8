Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0439C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB4720720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcLaSajD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHXqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGHXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:46:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BBC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:46:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so276450ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNVOm+zljioPYiyCEKhVRUSifVw9+Rq4lrANP+/QLBY=;
        b=lcLaSajDl3PXHLI0IsixId3ctDcJw/wcCMiK5LmAriZFBPjCqkHzrpB5Wr8RE5ku3r
         jUWEGuzjjFwKK+MoTRT33yCbdQgTQwKFWb/UnbSfHe2j9OUtBiKy4DK8qeLKCpRc+9Wj
         Bzun1SbvUp06+5xggjiRZELJWnHnhk59in1ncmMWss/+VxfsOQxB1i07p/3CscAo4Vbr
         QjdH83dDvnirLejbklIErYxD/G1RzjIG34SvWUSpq6cQtuEaY7S7Q8EIA2lIqnunGSmj
         pdQe99/xvr+rhtnFuHZvy68oV0FkHeMRCItVNOqykDmMRzv+6icK/e4Zz3KUbgNWAVXS
         LFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNVOm+zljioPYiyCEKhVRUSifVw9+Rq4lrANP+/QLBY=;
        b=QmNcps7xJZopempDrkilgrcCx4cXWMeZNPZH0lsgmY80wMwxFWG7PZx38/C6LlC2QB
         kIZ0zdKSrIzJ42gaBcBHC+3Ye0F/HQdJRAxgBFqX1byYVicwKaNN0xCYu2JVgCjSOyY2
         Smed1J3M3It+a1CT5+AlHwjJ+Y8H2RKWWEy4fkf3d36scNl2C3G/FEgKh+yWBr/BBxhg
         VQRWNfRvrLdXJdERJMGdgofDk/eUnz2pwmGUvWwEatNRJVEH8zf8lvuMrehrZNKmf7+7
         +rMnJnMnxGqGh6ntmFKmL6g0+bao8hdGZrfPxme3lWf/5rHtyNg7Nrow8vVy/M6QMwCq
         bblA==
X-Gm-Message-State: AOAM531UQf8OSuaQGKmQ3cmouiG0r0kduFkppSOOLjV4AUAqxtQjYt6b
        OE059VBmY99JoJAVwa6RiSGTBv0tsHtO55VAUlA5sQ==
X-Google-Smtp-Source: ABdhPJxQopmgjC6jnaMAt/WQPRrVXt1aN4OhHEolRLPsjEpEaz9Q/mPmsN9bvmri8KaSrr7ODM5XB1eWwNM+XDZ6cAM=
X-Received: by 2002:a05:651c:1106:: with SMTP id d6mr6280417ljo.214.1594252006292;
 Wed, 08 Jul 2020 16:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708162017.GB549022@linux.intel.com> <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
In-Reply-To: <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 9 Jul 2020 08:46:35 +0900
Message-ID: <CADQ0-X8xF0NpMakEB_Kqd2hVSrMsMB5FqFd7V9F1eLryJbEeFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

> Hi Jakko,
I apologize for mis-spelling of your name.
Same mistake also appears in my another reply to "[PATCH v3 1/2] tpm:
tis: add support for MMIO TPM on SynQuacer"

On Thu, 9 Jul 2020 at 08:34, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Hi Jakko,
>
> > Overally the code looks great. You've run it through checkpatch.pl?
>
> Yes, I have run checkpatch.pl and removed errors.
>
> Regards,
> Masahisa
>
> On Thu, 9 Jul 2020 at 01:20, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Jul 08, 2020 at 10:14:22PM +0900, Masahisa Kojima wrote:
> > > This adds support for driving the TPM on Socionext SynQuacer platform
> > > using the driver for a memory mapped TIS frame.
> > >
> > > v3:
> > > - prepare new module to handle TPM MMIO access on SynQuacer platform
> > >
> > > v2:
> > > - don't use read/write_bytes() to implement read/write16/32 since that uses
> > >   the wrong address
> > >
> > > Cc: jarkko.sakkinen@linux.intel.com
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: ardb@kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-integrity@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: peterhuewe@gmx.de
> > > Cc: jgg@ziepe.ca
> > >
> > > Masahisa Kojima (2):
> > >   tpm: tis: add support for MMIO TPM on SynQuacer
> > >   dt-bindings: Add SynQucer TPM MMIO as a trivial device
> > >
> > >  .../devicetree/bindings/trivial-devices.yaml  |   2 +
> > >  drivers/char/tpm/Kconfig                      |  12 ++
> > >  drivers/char/tpm/Makefile                     |   1 +
> > >  drivers/char/tpm/tpm_tis_synquacer.c          | 196 ++++++++++++++++++
> > >  4 files changed, 211 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Overally the code looks great. You've run it through checkpatch.pl?
> >
> > /Jarkko
