Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F804206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="jZOibYqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXOsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:48:51 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:48:51 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so6330574qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6Vs4y1MPS26d6uchTo03hUjOtrM0pQETRvKS6X2Mbc=;
        b=jZOibYqrwCrjt/tnH7vTLPtTtEcYhUEZPHjOxW4ESDjGeVcX/RZEW0pYjVGBlz6DXa
         +CiNSB+lEVhiVg3bJe3Mz0Nsh7KlvQ0e+iP2fdKty26JG+vXxIEJX3PC/OIyGKyn3b60
         TswDKaicVTg7nqZudTdKglkePgtNiUgEIt66CHy6RX0RwSwUVW3AWsAtyVp7t+6A7+4c
         LFoq8mwlogctzvuMt5UDAbc+KzEI4W1T73lf5YxzRzHf2BpY96mfqosmoMfMLXPB6Q3V
         7sieojevD9DUfTogfKnCLRNHBRIaa/h3h6LmeR98TamwAY27VLulubtMWMYXUYjSH/Mo
         WJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6Vs4y1MPS26d6uchTo03hUjOtrM0pQETRvKS6X2Mbc=;
        b=sd3A5u0BgKHtxuDN81yU9xC8UINl9h3Ba8eeoD7jN0SQDAPTiCJJjXwdus4AfdmyVf
         qNQmNLiHrE8UBiTs87fYw+FjM9rqCVSBFURTwfoLSgi+vVrlsu6FuPEsoDWQ7KDnTXOL
         qaqg8hFj03JLcRRqKXqJANfTwKkN8/qID29eOenPw4fHghe4SfcwKoaq8uybnBkMrkA1
         jTgShh88V2vHmH7bTem1misQQm+cJujPx0D38sBT2QETNf5HXoEPloKJ4iy4Q1JRzLcw
         rS4SMBoGHVUj4Ocmtq53IINWzk/itf7CkL9KVr9zONAT5EYk/zIfzJru9UGaRYeGoRll
         eU2Q==
X-Gm-Message-State: AOAM532irgEFckzAPAom8z+Yi4VRaFcjl7Mzh+RuM7x5UTYbTQm1IXpL
        gLLf7AUCs/lS4hmph2KkYnFwIA==
X-Google-Smtp-Source: ABdhPJwwYJQKK36IfV3XCtVezRBiOEfyECRdMKOWFcS0ZAp8VfhDb0oPnsglyoAihw0qQWX0rzCFrg==
X-Received: by 2002:aed:364a:: with SMTP id e68mr4989396qtb.260.1598280530761;
        Mon, 24 Aug 2020 07:48:50 -0700 (PDT)
Received: from kudzu.us ([136.56.1.171])
        by smtp.gmail.com with ESMTPSA id y3sm11583032qtj.55.2020.08.24.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:48:49 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:48:45 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: intel: Fix memleak in intel_ntb_pci_probe
Message-ID: <20200824144844.GA27238@kudzu.us>
References: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
 <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 07:37:56AM -0700, Dave Jiang wrote:
> 
> 
> On 8/22/2020 11:55 PM, Dinghao Liu wrote:
> > The default error branch of a series of pdev_is_gen calls
> > should free ndev just like what we've done in these calls.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> Thanks Dinghao
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Added to my ntb branch.
I added 
    Fixes: 26bfe3d0b227 ("ntb: intel: Add Icelake (gen4) support for Intel NTB")

Thanks,
Jon


> 
> > ---
> >   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > index 3185efeab487..093dd20057b9 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > @@ -1893,7 +1893,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
> >   			goto err_init_dev;
> >   	} else {
> >   		rc = -EINVAL;
> > -		goto err_ndev;
> > +		goto err_init_pci;
> >   	}
> >   	ndev_reset_unsafe_flags(ndev);
> > 
