Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A76AC2D0ED
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E2620714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KguwooGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgCZTnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:43:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:43:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so3423943pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UGAInaue7GSFpt799maDJX4PnvgR4YSaBrw6mv4yOuk=;
        b=KguwooGsTz40f9cvcDxM2GNej0d6GxRAuvL6H5rS2U2v7SuftTKbyWwCoyrbVU3Ran
         VyD2YsLLg4xfZTRozdTd/JY90atjqoOpyPsEJjDzEgufF+wEMTpcE9MagelT/9cM8rva
         QrE54uxvU0eXm4LkVkrQl5WgpIwRwN69ZnuS/VeB9cIZ12+TL/6uHMUaz5OfwZH7g6gX
         YxxUMnphBeI2VAuIg77Dt7Xx2x+goewYVKpeBqxiX70yfRkUTuFEx1Bkcvfl4H8KhpYo
         8xpDJePD6vF39IcomlmlCm4/vnfi0aW9XyeDzV0/RiS+yCNpFXy9NGbVAaLleQ8A+QFj
         zhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGAInaue7GSFpt799maDJX4PnvgR4YSaBrw6mv4yOuk=;
        b=gX6KoLsfgyWivu4SdaYfXCDxj76g7YJ+UBYIyXNJLb35s36yy1Z+1tobGB4YVKFdCz
         k7yLDCm9U6ssox8piaYGIq+x2sQxLm0+16HP8b+Gemmg6oM47X3hOW6EHszZIlMl5fFc
         KvArEd5qFzRe8eQTy425jk/srxinm60fnwB//5EeLQg3PBbh4Ms5iZaHs7rD/mcWD6YW
         9Zecfi8r9V7Loild+vyHpA2deAqK4ru9ypEAgptaHuWhlki/m9pPIIPBPIJk2iQKN5L0
         k5iI2uNCK5dRk95f+zZjjyBuhxEzn0b9vHm9kS/tycK4eARl3zBctrnLz9H5YMxgk39P
         1dAw==
X-Gm-Message-State: ANhLgQ1bJkwSn7d3eZTcwJtOfqIuwPlyNUCIxiFDKalsCWne2vR0ZcXr
        gL2hhraDN626HPeG4LsEHV0cgQ==
X-Google-Smtp-Source: ADFU+vv9sWxbnpeMRWqiM+cTYJKGzMXvNJsp7SDb2PVAVwCDDAyVZTC6Mxm+NU97kEdmTimNfqkYPw==
X-Received: by 2002:a63:2e03:: with SMTP id u3mr9972910pgu.205.1585251787183;
        Thu, 26 Mar 2020 12:43:07 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 132sm2321984pfc.183.2020.03.26.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:43:06 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:43:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] remoteproc: use a local copy for the name field
Message-ID: <20200326194304.GB59436@builder>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-3-s-anna@ti.com>
 <20200326054234.GA59436@builder>
 <2089a4a8-d5e4-e4f5-e7bc-7d053f654204@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2089a4a8-d5e4-e4f5-e7bc-7d053f654204@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Mar 07:01 PDT 2020, Suman Anna wrote:

> Hi Bjorn,
> 
> On 3/26/20 12:42 AM, Bjorn Andersson wrote:
> > On Tue 24 Mar 13:18 PDT 2020, Suman Anna wrote:
> > 
> >> The current name field used in the remoteproc structure is simply
> >> a pointer to a name field supplied during the rproc_alloc() call.
> >> The pointer passed in by remoteproc drivers during registration is
> >> typically a dev_name pointer, but it is possible that the pointer
> >> will no longer remain valid if the devices themselves were created
> >> at runtime like in the case of of_platform_populate(), and were
> >> deleted upon any failures within the respective remoteproc driver
> >> probe function.
> >>
> >> So, allocate and maintain a local copy for this name field to
> >> keep it agnostic of the logic used in the remoteproc drivers.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >>  drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
> >>  include/linux/remoteproc.h           | 2 +-
> >>  2 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >> index aca6d022901a..6e0b91fa6f11 100644
> >> --- a/drivers/remoteproc/remoteproc_core.c
> >> +++ b/drivers/remoteproc/remoteproc_core.c
> >> @@ -1989,6 +1989,7 @@ static void rproc_type_release(struct device *dev)
> >>  
> >>  	kfree(rproc->firmware);
> >>  	kfree(rproc->ops);
> >> +	kfree(rproc->name);
> >>  	kfree(rproc);
> >>  }
> >>  
> >> @@ -2061,7 +2062,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >>  	}
> >>  
> >>  	rproc->firmware = p;
> >> -	rproc->name = name;
> >> +	rproc->name = kstrdup(name, GFP_KERNEL);
> > 
> > Let's use kstrdup_const() instead here (and kfree_const() instead of
> > kfree()), so that the cases where we are passed a constant we won't
> > create a duplicate on the heap.
> > 
> > And the "name" in struct rproc can remain const.
> 
> Agreed, that's better functions to use for this.
> 
> > 
> >> +	if (!rproc->name) {
> >> +		kfree(p);
> >> +		kfree(rproc->ops);
> >> +		kfree(rproc);
> >> +		return NULL;
> > 
> > Perhaps we can rearrange the hunks here slightly and get to a point
> > where we can rely on the release function earlier?
> 
> Not sure I understand. I don't see any release function, all failure
> paths in rproc_alloc() directly unwind the previous operations. You mean
> move this to before the alloc for rproc structure, something similar to
> what we are doing with firmware?
> 

Look at the failure for ida_simple_get(), there we're past the setup of
rproc->dev.type, so the rproc_type->release function will be invoked as
we call put_device().

So if you move the initialization of rproc->dev up right after the
allocation of rproc we should be able to rely on that to clean up all
these for us.

Regards,
Bjorn

> regards
> Suman
> 
> 
> > 
> > Regards,
> > Bjorn
> > 
> >> +	}
> >>  	rproc->priv = &rproc[1];
> >>  	rproc->auto_boot = true;
> >>  	rproc->elf_class = ELFCLASS32;
> >> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >> index ddce7a7775d1..77788a4bb94e 100644
> >> --- a/include/linux/remoteproc.h
> >> +++ b/include/linux/remoteproc.h
> >> @@ -490,7 +490,7 @@ struct rproc_dump_segment {
> >>  struct rproc {
> >>  	struct list_head node;
> >>  	struct iommu_domain *domain;
> >> -	const char *name;
> >> +	char *name;
> >>  	char *firmware;
> >>  	void *priv;
> >>  	struct rproc_ops *ops;
> >> -- 
> >> 2.23.0
> >>
> 
