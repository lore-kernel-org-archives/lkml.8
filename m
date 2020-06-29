Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02411206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHK622U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgF2UuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgF2TNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C0CC008759
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:47:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so15681957wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=buEQVHi4pYkYNi5xR5+kq0TuOVW4rWY7G/qVT+msh3E=;
        b=CHK622U1BVBtpIrk5fAZb9epzcn8u+EYAoOwW9EKuHtj3CnEYWctFHBkGa+CdPTx7U
         jEzR0bJBVp/+IRiDk1elxRlwcZgYuXAtj4v7XKjXobEORe+ppJIZ9z0M5CCibHMkXvLJ
         BspjreQUVgczs1OCbvG73J0zXVXrd4OCoZ5d5+ciCL5ys7zkADOCMezlXYMxdrh48B/4
         VnV/Xy33royF/SH39pMdpvokXsGHrjKRq0b/hQXHM6A/c1PJ2K7BEJbOWx/qmkmfN29H
         1jMDcocpaT8rLEmUVHbKvS+LX1IzFj/MuI9XaAj+TN+f2uyDdU2VUEkU/ntcZytpj4Nl
         xhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=buEQVHi4pYkYNi5xR5+kq0TuOVW4rWY7G/qVT+msh3E=;
        b=e088zRqcfOFcmMq0/d1cNgEqschNo071FBAkZL83a0cZabaVk/O20e3pA3IKqKVxGY
         njXmEWdzR+slXkT2/o7EK54LtUtQAq7VGbB1cTrT4LTpH6OkEqgUddikxIt/241XnXVN
         ozzgyaHoeDPoKx1PIrD8iUxsDbBTR9S82f2fjQqVkEqYBCbnY3yWzZXNV/rKkJ9eRYRb
         37AcyAGJVRb4DYyo9IC26NKC8R+ruj2h7UhB2nK4/6X9vbfAQB35zClGSOQgSXwXEqHK
         hWvGqulpBqJAeWB2xek9x+CJQa2lUv0HMAZdqJBTuvH5gJOZ8luu9qBOjxZEfHIMz1oq
         PT1A==
X-Gm-Message-State: AOAM533y0gWbpC3fJBELrNqVILqur7JOCpNWTpxdVYnrH8LOrY+OIzpn
        /wfYXbIx0tV1t7TRLEPdFaCRfw==
X-Google-Smtp-Source: ABdhPJzJclim0XefS2p9RYY3YoriemGjq3Rc/tzqywjW3o/beIt1fh72+EyPBH2YUhKJtI9OuNcyVA==
X-Received: by 2002:a5d:6746:: with SMTP id l6mr16093673wrw.346.1593420421939;
        Mon, 29 Jun 2020 01:47:01 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id b62sm17113004wmh.38.2020.06.29.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:47:01 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:46:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg
 descriptions
Message-ID: <20200629084659.GI177734@dell>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-7-lee.jones@linaro.org>
 <20200627203357.GA954@ninjato>
 <20200629081436.GH177734@dell>
 <20200629082037.GA1063@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629082037.GA1063@kunai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Wolfram Sang wrote:

> 
> > > > @@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_readb);
> > > >   * @eeprom: Pointer to eeprom structure
> > > >   * @byte: Index from where we should start reading
> > > >   * @data: target pointer where the information will have to be stored
> > > > - * @words: Number of bytes that should be read.
> > > > + * @bytes: Number of bytes that should be read.
> > > 
> > > Now we have 'byte' and 'bytes' here as arguments which is confusing. I
> > > think renaming 'words' into 'num_bytes' would be even better.
> > 
> > I await your patch with bated breath. :)
> 
> ? You are touching it already, why a second patch?

Because it's a different change.  One that's orthogonal to this set,
which is designed simply to ensure the documentation matches reality.

The author decided on this (less than ideal [in our humble opinion])
nomenclature from the function's inception back in 2013.  Maybe there
are good reasons for it to be this way.  Either way, it might require
a dialogue.  For this set I'd rather stick to the script.

That said, I genuinely don't mind drafting a patch to fix this.  If I
am to do so, it would also be as part as a subsequent effort.

You or me - your call.  Happy either way.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
