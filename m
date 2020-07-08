Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58212075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouuuKxdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgGHGvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbgGHGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:51:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C239C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:51:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so36355535wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UPMya7moYhhnMKKD/72V5a8nk/96x/JX4lIchhXhdNU=;
        b=ouuuKxdH0sx9kAJcJ0Enu16VyRuKqrXi0g6HpKof7a9Mkp0+zcyU01h7Cbg1JX9Vxt
         hU03Wo7ok1GAfr4Xc6A1Ze8YB4mYRbeTdjfyT0AehhIa3HCQM8C1+BbcVObqMIn6WXG/
         O+QvgMsS9GSjm9yRCRi6uC3ALxzJW71EXx2r2JmejsDnJ5OCLnt2wocUfBNT1Jo2nfyP
         VknRgzVDu44hul58DyV4lNZdz/HG1l/q2fo4n9Fqwlrk0Ra5ey6Qxp9a0UItIU5aWuxG
         BaPrT5FH+6iVOehi3sR6o4KqlurYQpkEZ0gXL0w42ucDpR8a8yG7U6pOaiAs235ALlFy
         80mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UPMya7moYhhnMKKD/72V5a8nk/96x/JX4lIchhXhdNU=;
        b=D0TLH6tU9xU+UdaT2cIcKlsicRtsf588FuuuusGCqDg0Vd9F+t4rtz0YA54iX84VAw
         hMhGznY5xB/HmWUApyIQJe+E7yT/zLOZfBa44Gxv1p5elSrW36ox/Horkucq4RehIXpe
         1iTISfKwk/hiUILp9FhVT3PgNoL6zX1jnfOmOzIGhq7pKwcfKCJLUJLFyrPOMDN6redU
         wW3S1KLqeHcu9GnAXpqmRWGBdEmVUdNNAKiLUHpnc3XW6jkkg5PCffl52uF3V3US/DWJ
         xLV3LSc4hZZORw80pyOLdfWTB+1YeXIgRo/SFOWubpEgPhRxTCi8jUf13iRU7UQxP5mG
         p1hA==
X-Gm-Message-State: AOAM530Jz6KzJhdu4GclZCIfcVFn6KNrwUSda0HPw8qzw85TCP4lSWO8
        z+ssDP5yRSSycdvfBrnS8vbHag==
X-Google-Smtp-Source: ABdhPJzWPqvJRETNtxsc0Gl81kU0pHSXcli4uTnNtAk5HAOUrPJxj7AFF251Tq1oqLcgTnWq742fEg==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr56265406wrm.169.1594191062177;
        Tue, 07 Jul 2020 23:51:02 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id u23sm4572650wru.94.2020.07.07.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:51:01 -0700 (PDT)
Date:   Wed, 8 Jul 2020 07:51:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
Message-ID: <20200708065100.GK3500@dell>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
 <159418828150.5152.12521251265216774568.b4-ty@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159418828150.5152.12521251265216774568.b4-ty@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Martin K. Petersen wrote:

> On Tue, 7 Jul 2020 15:00:45 +0100, Lee Jones wrote:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > There are a whole lot more of these.  More fixes to follow.
> > 
> > Lee Jones (10):
> >   scsi: megaraid: megaraid_mm: Strip excess function param description
> >   scsi: megaraid: megaraid_mbox: Fix some kerneldoc bitrot
> >   scsi: fdomain: Mark 'fdomain_pm_ops' as __maybe_unused
> >   scsi: megaraid: megaraid_sas_fusion: Fix-up a whole myriad of
> >     kerneldoc misdemeanours
> >   scsi: megaraid: megaraid_sas_base: Provide prototypes for non-static
> >     functions
> >   scsi: aha152x: Remove unused variable 'ret'
> >   scsi: pcmcia: nsp_cs: Use new __printf() format notation
> >   scsi: pcmcia: nsp_cs: Remove unused variable 'dummy'
> >   scsi: libfc: fc_disc: Fix-up some incorrectly referenced function
> >     parameters
> >   scsi: megaraid: megaraid_sas: Convert forward-declarations to
> >     prototypes
> > 
> > [...]
> 
> Applied to 5.9/scsi-queue, thanks!
> 
> [03/10] scsi: fdomain: Mark 'fdomain_pm_ops' as __maybe_unused
>         https://git.kernel.org/mkp/scsi/c/4be1fa2b55a8
> [06/10] scsi: aha152x: Remove unused variable 'ret'
>         https://git.kernel.org/mkp/scsi/c/3c011793aca7
> [07/10] scsi: pcmcia: nsp_cs: Use new __printf() format notation
>         https://git.kernel.org/mkp/scsi/c/af0b55d06004
> [08/10] scsi: pcmcia: nsp_cs: Remove unused variable 'dummy'
>         https://git.kernel.org/mkp/scsi/c/97a33483425d
> [09/10] scsi: libfc: fc_disc: Fix-up some incorrectly referenced function parameters
>         https://git.kernel.org/mkp/scsi/c/b1987c884585

Thanks Martin.

Out of interest, do you know of any other efforts to fix W=1 warnings
in SCSI?  I was going to clean the whole sub-system, but I really
would like to avoid duplicating efforts if at all possible.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
