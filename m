Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4712C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2820771
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx+risdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgF1JtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgF1JtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 05:49:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 02:49:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so13377900ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KmKamB0F0GgOEkWla27jfPS/bwTrioDp0P+TVLvUBrM=;
        b=Nx+risdCkjMrgQLB9R8v01kO+dtXnPeJURtoCoGSr0HBDvgO1CjvLjWAOqFXKcLTy0
         oxjKY1vWaLWrePi5AFkPR5AM5ZASOHEbb40/5y3HxHRonljyvhNgl8es9gp6WZx2/OE7
         sPm7yOJ3cnp1WXQO5/UC4uLSI3y1fhuygQMPv9Qv/w6QniZ8DxOXBhYbMByOo0M8KUFs
         cew6jyjol1maoqqqJ2vrvrmaPELhfv65F4x9ouXB2WLZ9Co1+Vj+LpFKuFhZII65hyJh
         51j8zW6Qj0Ux98Wn6dhpGjP92QgaRLYJspoBJ8P3vMF4Z40JF8ClfXxaYS3wwo0QkLik
         FnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KmKamB0F0GgOEkWla27jfPS/bwTrioDp0P+TVLvUBrM=;
        b=ng0f3DoDTSkMJnsV8VpI2U6wY444TK+R9h/EYImDGws088q79WSQxG9Vcri55eNkS9
         rM/0n9SiVqj7y8WI6JPfiE05bM9SvnC8IAMo2NEM/aZIJBPCIu6BuCW9fu8OIiQAkD0+
         P4y9k6AE9QC3GBAJRwdoMXN4W6RInbt8z+/clTwDmDn4fVSvqGpN7bQF6hqhWJlkMZrN
         DcFQd/sqGhySfnTsFl7UxcHXgv/YOLAsnbAjORTb4ZczNhkuihLnfqQaJm6ABHpEm9Dk
         vyZVfCbALloGmL2+TY19capcLuDvU+T9F76Ez0xCmqwtEQHcC0rwyTyZDOxzf4nTSp06
         A2eA==
X-Gm-Message-State: AOAM5320p/MalAlxLbC08ZbQg6Mg758nk/jT00MIFPqXvOS4LBnwPD2W
        f60pN85sbeFCUOS3K7u5axajtGKX
X-Google-Smtp-Source: ABdhPJw2x5qLWVpH292RdAsV9jwrHtfJEci3LndXhGW22ErTEYndBHbUU56XGlVuABz1fnV6HjiHgA==
X-Received: by 2002:a17:907:7290:: with SMTP id dt16mr9350075ejc.63.1593337745527;
        Sun, 28 Jun 2020 02:49:05 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:f51f:7c31:2fc7:f95b])
        by smtp.gmail.com with ESMTPSA id sd15sm14829893ejb.66.2020.06.28.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:49:04 -0700 (PDT)
Date:   Sun, 28 Jun 2020 11:49:03 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: update URL for sparse's tarballs
Message-ID: <20200628094903.jpj6lq4qguglcady@ltop.local>
References: <20200621153330.54480-1-luc.vanoostenryck@gmail.com>
 <20200626112349.1292a654@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626112349.1292a654@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:23:49AM -0600, Jonathan Corbet wrote:
> 
> I've applied this, but it also seems like we're losing some information by
> going from a wiki straight to a directory listing.  It seems maybe we need
> a link to the new documentation site in here as well?

Yes. I hesitated to do this because:
- the wiki contained very very few useful informations
- the new documentation doesn't contain for a user / kernel
  dev perspective.

I'm sending a new patch that can be applied separately
or be squashed with this one if you prefer so.
 
Thanks,
-- Luc
