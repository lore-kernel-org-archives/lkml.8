Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66864C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BB02078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592902509;
	bh=aX9iuf1eAPHbnJVHVvIBTPmYhk5DcuRypTzSO36WQxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWadPK+shVSSvd6tceAbCiqXVyWykanVUnBcWVFHDu6iXK5yqJNcADUyLN9Nf1vGT
	 OBNIGzSLf/7JZfn+/CadUmuDuJuyBk4B6/lEbw/l8ZifEhCwz+C81g1oGXocxc0mfz
	 tH/pvRGCWzjj6DhbM9PkJbv68MOg1rBZkyhEA7cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgFWIzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:55:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40715 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbgFWIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:55:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id n23so22477137ljh.7;
        Tue, 23 Jun 2020 01:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aX9iuf1eAPHbnJVHVvIBTPmYhk5DcuRypTzSO36WQxU=;
        b=Q66+CE+pOUngHdUu4Tb4drH3h+aM5bWV07JtULtGclXUH6PB5ZwkRMoG3oyzPeUGuQ
         98MsZz8ag6K9mgzQMUgOzuVojUrsn/GRk9NKsYt7vamFHCWj4YaXpMq7NaGFSnOlIcU9
         2Hpi6ii+etLAKWotBMNYOtcx6TbfUpnCkT7q+QAMAUUDHHH84rZhzPJAH2LphwvLgv+x
         ZLOM0YbsL6f/NCrX/7PjR5RstKK17JN8xtQv0yzX4qK9x4SkerQv2pnQWaHf+jidGA4J
         oHD4ntB8j0jrDAvCytBL6ieGkAusWiYP3NNN3oM16ZMrtm7lHn0QOEFuCL0HntI0ItIi
         WbQg==
X-Gm-Message-State: AOAM531azOh/gf0H3TsMih6ykZn8WYfIiWVf2945rK2Gce2Ax9f4Kji9
        arp5QfbHUAj5NsQI5FmzS3g7NdvNefU=
X-Google-Smtp-Source: ABdhPJx0zCO4imRfmuJ6NtUZg1JAuPEqEPOrd7ia12xz7mwrd0kqCZN593A7RqM1idGuR+nnxEXFrA==
X-Received: by 2002:a2e:8950:: with SMTP id b16mr9977467ljk.349.1592902504426;
        Tue, 23 Jun 2020 01:55:04 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z17sm247655ljc.83.2020.06.23.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:55:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jnehq-0001yu-5r; Tue, 23 Jun 2020 10:55:02 +0200
Date:   Tue, 23 Jun 2020 10:55:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB
 PIM
Message-ID: <20200623085502.GG3334@localhost>
References: <20200616220403.1807003-1-james.hilliard1@gmail.com>
 <20200622085321.GA3334@localhost>
 <CADvTj4rOYs6F3J2A72GiWGbYW_Fu7VNCd0GpWaJ9it6tEt+4Hw@mail.gmail.com>
 <20200623075348.GD3334@localhost>
 <CADvTj4qn0nwyBY09pi5SZVuWHAZ65fVSUMA8QTAs1t0mYw6rmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qn0nwyBY09pi5SZVuWHAZ65fVSUMA8QTAs1t0mYw6rmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:08:57AM -0600, James Hilliard wrote:
> On Tue, Jun 23, 2020 at 1:53 AM Johan Hovold <johan@kernel.org> wrote:

> > Don't you need to add this device to the HID driver's ignore list
> > to prevent it from claiming the device (see hid_ignore_list) just like
> > for the Cypress VID?
>
> Ah, yeah, that does look to be needed, do you want to edit my patch or
> should I send a follow up patch with that added?

A follow-up patch is probably best.

Send it to the HID maintainer and include a CC-stable tag so that it
gets backported along with the new cypress_m8 entry.

Johan
