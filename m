Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FCA20720
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oh/RiiCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFZUC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:02:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D5C03E97E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:02:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k1so4651735pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HuJILZmXLURp/yn0oSueJPx2COyMJVkAtdj3c8sCa2A=;
        b=Oh/RiiCDnbp34CVdzAILpR378u4/AQdViDFg7C7oW5dt1jDbyEeAjP90KAvvKhIr97
         KwI71vJclhWb7o4mSkhCh2NOFbTtfJgpS+vox3O7+FvJkCsMl4urremmWYspWh28A0+Z
         sV5HTCY7Nn86R70arsfIYUzY6CqZUi43QquRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HuJILZmXLURp/yn0oSueJPx2COyMJVkAtdj3c8sCa2A=;
        b=NZUqldZgERhQfmnZtCjWUujusRi465ZrHve5mikItlVF6q/LbGNWoRFxTQ/MAqS9YZ
         q96m39z+4OkW22CQDvMHmc2WED1IgE0YZ6qU8BzMPWIshaF9JlvkqRrkxrQRDSLGGsBQ
         pVwU08NsutX+vgUiS0wym4i/aD+H1FJMAWg7aP/ndtAxYP/+pfxgKlPmCyJWL1Sjj8e6
         2/iIOcclo/TLxI5UR/qIVABz/sE5YDkyUjgdHF58bH+bR8Y8S1/p8zs7Oj40QRc/RIiz
         svQ8H/Dji4b/8Fm+VFifbWkADAloxAxpcWTbpEJFRXB5XwqXcx8Y6WaXHWC3MZQoeD/m
         JR5Q==
X-Gm-Message-State: AOAM530L5klsXX3OH4JSLrl+ZTm+aY4toZ1mZepE+VC+Wbxvaf6D/gAB
        BfNVXQdlwZcQADladl/UL0hhzQ==
X-Google-Smtp-Source: ABdhPJw11xKQt6MwLhidUJ9gydREFfdw80oPEr/XN3WYlxPPeC/ryrLDoithYT16cWqdMGMaKZA/Bw==
X-Received: by 2002:a17:90a:8a8e:: with SMTP id x14mr4810785pjn.169.1593201776002;
        Fri, 26 Jun 2020 13:02:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm8925970pfb.186.2020.06.26.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:02:55 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:02:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-06-25-20-36 uploaded (mm/slab.c)
Message-ID: <202006261302.13BB6AB703@keescook>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
 <7ff248c7-d447-340c-a8e2-8c02972aca70@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ff248c7-d447-340c-a8e2-8c02972aca70@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:28:36AM -0700, Randy Dunlap wrote:
> On 6/25/20 8:37 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-06-25-20-36 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> 
> when CONFIG_NUMA is not set/enabled:
> 
> ../mm/slab.c: In function ‘___cache_free’:
> ../mm/slab.c:3471:2: error: implicit declaration of function ‘__free_one’; did you mean ‘__free_page’? [-Werror=implicit-function-declaration]
>   __free_one(ac, objp);
>   ^~~~~~~~~~

Eek! Thanks for catching that. I will send a fix patch.

-- 
Kees Cook
