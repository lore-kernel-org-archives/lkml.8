Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01250C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB802078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPFSCgiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFJXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJXrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:47:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D2C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:47:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w15so2458329lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXDVJ01oPr7+DVOG48ZzBnv0DUZ50rfZMiH97fPmSsY=;
        b=SPFSCgiL1AquGxkTFcoWT8rBLkkuxrQI3VD0O4eTSCQPxHTaNuEIjvgc1S/5qAWrWQ
         HvXYwBFxiSLpvBDxLTDhtnFIoFhaQ9ab1FT8IH9P4C5gQWZQ1mD8xj8grVg61arzhiUH
         Ayw/ZfLpN3h2bCT287+R1+hQnMN2hKZljE7U7c7ZTW9FK+MD1cCK/R8w+GKXs+dKxCHX
         n22xK4HTDzFEk5DIRzcOEafYadSjZWt44sB9Wc0GKEtfZ9BURf2Gc0gGKI7QKCkf2sqN
         ianhbGVgtJ9qzuw7lWIxfK9r5l9+g4bXLBnqacYitBm+ACJQaRcULBtnA9eX2v3M7j2Q
         43gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXDVJ01oPr7+DVOG48ZzBnv0DUZ50rfZMiH97fPmSsY=;
        b=SRJkhVPo+m4awvhzuZWtu8KNTTLaSn2RoVfdslsvSUeZmP1pTe6cQqj4Xp3ljsr4id
         /M2N0v30u+c2F0FAslnNUFavKngAVe6kc12MG/eWNwAmU0xuWwaTULUgbJOwc9R0elRS
         PC1z3g7+YsN7Plux8eS7iyEJZPWalxsj1wJ+fdhdrra2OuyOYaDU+o3cS6slYrcyUmtR
         4aAT0aayZDlMubq/bvLw1YI6Hr55ylT5oy29BXGWOsBzth8ojn5Gi8tIsGWcU/Yt36YE
         v1fUvXZUGnvF5XixoCihuDdphPbYEeBjo1F07tWT8dr+WoAVL/pAWne8TI8ORKdwjrHP
         o6zg==
X-Gm-Message-State: AOAM533G4FldMuLeyktOaFEpqGyu11hGwKOLr/m0r+AhXdm/HUrx0URY
        VppI1clsKfQNfEgF94UlvAoffZ1oYUvAxGYlc69CtQ==
X-Google-Smtp-Source: ABdhPJz++I8H5Iwp+DbYjJ8eR5SVWoSY/jHYsbqRWRtXpWSRT9ZTED7WdpFa9h+U0oo/gsd5dGRT1YgzEQEAF9kQ97w=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr2898514lfn.21.1591832833994;
 Wed, 10 Jun 2020 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
 <20200610230119.GA1528268@bjorn-Precision-5520>
In-Reply-To: <20200610230119.GA1528268@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 10 Jun 2020 16:46:37 -0700
Message-ID: <CACK8Z6G1dKzSCABvu_Sh1NV81GM0fBZ7HXNBY0jGvgj0FkiQRw@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 4:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 09, 2020 at 05:30:13PM -0700, Rajat Jain wrote:
> > On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > > > Thanks for sending out the summary, I was about to send it out but got lazy.
> > > > ...
>
> > > > The one thing that still needs more thought is how about the
> > > > "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> > > > needs to be whitelisted for further enumeration downstream. What do
> > > > you think?
> > >
> > > The pcieport driver is required for AER, PCIe native hotplug, PME,
> > > etc., and it cannot be a module, so the whitelist wouldn't apply to
> > > it.
> >
> > Not that I see the need, but slight clarification needed just to make
> > sure I understand it clearly:
> >
> > Since pcieport driver is statically compiled in, AER, pciehp, PME, DPC
> > etc will always be enabled for devices plugged in during boot. But I
> > can still choose to choose to allow or deny for devices added *after
> > boot* using the whitelist, right?
>
> Yes, I think so.  However, if pcieport doesn't claim hot-added devices
> like a dock, I don't think hotplug of PCI things downstream from the
> dock will work, e.g., if there are Thunderbolt switches in a monitor
> or something.

Yes, understood, thanks.

>
> > Also, denying pcieport driver for hot-added PCIe bridges only disables
> > these pcieport services on those bridges, but device enumeration
> > further downstream those bridges is not an issue?
>
> Right.  Devices without pcieport would not be able to report hotplug
> events, so we wouldn't notice hot-adds or -removes involving those
> devices.

Understood.

Thanks,

Rajat
