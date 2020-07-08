Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F92075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8PX2ntc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgGHGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgGHGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:51:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B0C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:51:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so47663496wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yp+USi3k/rtN/+EN4PgKchnRscSh5eat2EuNnlU17YI=;
        b=I8PX2ntcXg5w3iLhaOGVYbe7zvOq4DrSKcBE9Eyj95lWFY+8ExEU25/zGAVJ0HtzG4
         X5ftMbPKPG5ElIjqVG1TV6k/b0r4h2z3GPH6pg/bFqZMnhOtKvV4UP9ILIsRrX5i2dX2
         7rtXuYXMoIg3hjHzqw+MeAr78QolOGqwV31A+jAkJWFQBfNGJckpek8pBoiipFky0tqi
         Jmp5If45bgPk9i63xnFRd1JP5L0ZFFwW42J7pdgohCdRwIXNBh9eehcJA5O7WkA1KMcl
         6ZvHiDIuOYsSRi5ocAlunhj569jypoyTEOWKvtNA0PuvVysB2wfP17WiXIM/zjjhXBOb
         mnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yp+USi3k/rtN/+EN4PgKchnRscSh5eat2EuNnlU17YI=;
        b=d0JYld37inbm40BJTn5TQBM2VEmJPy7nMxJiTmYCht5yPpL0nkf86Qe8JtqJeFzdKP
         elGTMIpyVcY/QtCMjF22iLQ4iNx3LI9n3hfRQQXdmScmyPMV6pTLGC2cVdQ3d4iIsid0
         iM8a9el7vMuXZnqLcSDdVsjoKTei3SCAViRvPIX/1nZnKgPrrNgqhrkitYFeFv1wizdO
         /VuLvLmR755N6Wy7Pie76kozGbL+j5Ncv9gSNN6m1s0rz3gm+au7awHSkz813laSrLt3
         WF39uolAWBSuRRBoxg3U3CVPJLpeaoBxR2EmrRPxcIOLqeNoq+i6IsJzadbcNb2pzdoL
         HnmA==
X-Gm-Message-State: AOAM533/dAxuuRjGr5JmZuZzIUNmYPTj0z8+OEsjY/65o9jh35NEAXl3
        otjAYkmlZ8EgNAVkZiHcGFfK9g==
X-Google-Smtp-Source: ABdhPJxgJvPAqdGIy+dhGAhBxnVtSIS37GRDCrymppZVGAK2+sMwzrM7xca0qDj9PKFa1VqDnu2R3A==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr57343863wrv.155.1594191098795;
        Tue, 07 Jul 2020 23:51:38 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id n16sm3766422wra.19.2020.07.07.23.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:51:38 -0700 (PDT)
Date:   Wed, 8 Jul 2020 07:51:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
Message-ID: <20200708065136.GL3500@dell>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
 <CY4PR04MB3751BE9A73158B811D163EADE7670@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751BE9A73158B811D163EADE7670@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Damien Le Moal wrote:

> On 2020/07/07 23:01, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > There are a whole lot more of these.  More fixes to follow.
> 
> Hi Lee,
> 
> I posted a series doing that cleanup for megaraid, mpt3sas sd and sd_zbc yesterday.
> 
> https://www.spinics.net/lists/linux-scsi/msg144023.html
> 
> Probably could merge the series since yours touches other drivers too.

Do you have plans to fix anything else, or should I continue?

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
> >  drivers/scsi/aha152x.c                      |   3 +-
> >  drivers/scsi/fdomain.h                      |   2 +-
> >  drivers/scsi/libfc/fc_disc.c                |   6 +-
> >  drivers/scsi/megaraid/megaraid_mbox.c       |   4 +-
> >  drivers/scsi/megaraid/megaraid_mm.c         |   1 -
> >  drivers/scsi/megaraid/megaraid_sas.h        |  25 ++++-
> >  drivers/scsi/megaraid/megaraid_sas_base.c   |   4 -
> >  drivers/scsi/megaraid/megaraid_sas_fusion.c | 102 ++++++++------------
> >  drivers/scsi/megaraid/megaraid_sas_fusion.h |   6 ++
> >  drivers/scsi/pcmcia/nsp_cs.c                |   5 +-
> >  10 files changed, 81 insertions(+), 77 deletions(-)
> > 
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
