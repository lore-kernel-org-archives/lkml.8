Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31301C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102D720706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2PXDCmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgFWIDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:03:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731534AbgFWIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592899397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6YBkvu4NKIVRvb0+R6NtCtLkpIDbKvQHwDRTDMavYs=;
        b=X2PXDCmMiJaHYm5nL8CmOMMh6V/iGcnVNZGYpfnYuQs+zXcPTXVHT0ED10GXfNwgKs0yl4
        wdsvQHKS9Y4KeZ2ceSwTs4StxVin6wAptQFXOXAi/6JhLNza541jh8/PFzl9SzvH0z6uC8
        8vaQj8lRA/b3Y0QNUhWvcgd7wUg4+Fs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-BWOTNlfBO2auqO6176yD1g-1; Tue, 23 Jun 2020 04:03:15 -0400
X-MC-Unique: BWOTNlfBO2auqO6176yD1g-1
Received: by mail-ej1-f69.google.com with SMTP id b24so7847055ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6YBkvu4NKIVRvb0+R6NtCtLkpIDbKvQHwDRTDMavYs=;
        b=ORMOJX2pxxb1go38z/4VnKEJms7EmzzOa4gE1UVqccPdw5p8UQn7wsK6plAvLJslkp
         VIJYiPDkiPrxSKCfhzjaapehRTSMI+a2i3jpNPFWs7NKrhcU8BAZ1I8QBk+f5NSJ0IhR
         7Lg6XdNGwvEbeT1uwma1JD/4SSjlGeogzkQ/RU5OLo8jR3GMVSD/wy4N8Q++GZyurxIL
         JTGxAk1zsVbJx3RkcjsaQwOgp0dstRCYNMabuhS6Y4qgSdVLMavIvC+ZR/vfuDWKUUbk
         Ol/iclEShVB2wa5Rh2U/7hLIn6lbcj7nyWB7AeD4kEH60gdpWfWi3sxl/odYGlPK/PDe
         UBLQ==
X-Gm-Message-State: AOAM5301zmX13bxdVDbBs12QjAeAZw1FFbkUeSEmCOBO1oxb15DJKTew
        JIvdwyxtB4sbUtNLixm9km2nQBzxzNW+cbLOouZ0TAP+h8PemEzV3tJiuQD7TkAOmhJ4kGiPOHb
        glDuod/7iahxtytU2RGwswxle
X-Received: by 2002:a50:d6dd:: with SMTP id l29mr4423991edj.345.1592899393650;
        Tue, 23 Jun 2020 01:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUO01hrtBJeja7UCvnapxRDA0N13a8vbDxVvxvfNDa9KjTKO3iua7zztinJD+WlgufIZAdhA==
X-Received: by 2002:a50:d6dd:: with SMTP id l29mr4423970edj.345.1592899393410;
        Tue, 23 Jun 2020 01:03:13 -0700 (PDT)
Received: from localhost ([2001:470:5b39:29:79fc:ff4e:48ab:b845])
        by smtp.gmail.com with ESMTPSA id x11sm13035250ejv.81.2020.06.23.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:03:12 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:03:11 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "R.F. Burns" <burnsrf@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: PC speaker
Message-ID: <20200623080311.7ljhyo3zymfbtnbl@butterfly.localdomain>
References: <CABG1boOyDJheyNFuxhB0amA3_NH_DtvtZb2BBUtUOCQ01jeCEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABG1boOyDJheyNFuxhB0amA3_NH_DtvtZb2BBUtUOCQ01jeCEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Thu, Jun 18, 2020 at 01:49:37PM -0400, R.F. Burns wrote:
> Is it possible to write a kernel module which, when loaded, will blow
> the PC speaker?

1) where have you been starting from 2011 till 2015?
2) why does the posting date of this letter varies a little bit?
3) why June (but July in 2008)?
4) are you a robot?
5) if you are a robot, what's your setup?
6) if you are not a robot, blink.

I'm eagerly waiting for this email each year, but it's a shame you
neither reveal any details nor respond to questions. We are intrigued!

Please uncover this great LKML mystery. We'd like to know you closer.

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

