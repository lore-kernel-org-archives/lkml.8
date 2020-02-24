Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C002C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21DC20661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZNyxgGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBXIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:50:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33378 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:50:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so10991059edq.0;
        Mon, 24 Feb 2020 00:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7kZjv63LFHKza8UDwSw6jtYnFU6nvK79NAbl1X68Oc=;
        b=IZNyxgGvpWJs+VtgUl9O1ecpNNasDL2hsHYFFQWA8ApZtS+bnJ/SHGlYeiUDcjkF6a
         BHj/ZCoS9r+/HTSXd3bNVoSnR8INBsnRa1FeaTxUR+OFFP2tdV52jzRihxqD9r6BTEcl
         T/LzbWEYpWfAJO9g02inQwfZuXZ78bSk/yr9fXDXhXSDH50zPt07gy4kK7cuOzFQFAkD
         OoBrVTX3Ey+hjGQe0xEeqXMAomlLyBdyOUGxr69YKZ6BC81usZ1XbW//3LinXfi/H4Wa
         HtDkwUrBxRIp7+ADPBgIWsJtXr/b1AYgRUHVPSe1pClkiSYz9QM2doFsG2zKnAD4owZv
         9q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7kZjv63LFHKza8UDwSw6jtYnFU6nvK79NAbl1X68Oc=;
        b=ofN1vC7bzLYzkw4dLjOd3MfLwGLwE/vgpQ9uSy8e18FHGRVcdLnPyJbT1Y//V2NOPH
         rw18i7SX/j44+A4LFDVxtLArU5tKUbJb95+Z74sitvG3S722hES5ARFb652fjMOEOmgR
         B97MQA0PdHgh+0zF00+z770FJxndBfV5fZa8l2i9H9qFbBWubpOX1g7Aqkz6Va6KuWKG
         O1C6DcDVIJZ7CllNt2zy2JF+3cEA2EmJIki39sfCdw9iWt2K8SBgtYXd99tKUY4lzOjb
         2K70804SwvadAIaHJhH2aGQ1hmm6y19W1x9lKxoy2hY5akWuIQfkh6jMDe+WeCC+l+x4
         fHxg==
X-Gm-Message-State: APjAAAWpUUqQfyLOMcnxywp9382d+oajYsLgpWLgIuuRSuL22BFFcGoZ
        hGhxzP/IJ24XB8pOT9xHOWhXPOAblbP+URc+FAU=
X-Google-Smtp-Source: APXvYqxpzJaz5Y96nNBzpQGXViVlrfFVtfjU89hQINu41+byhDSBl0KN7uOt7kSVe0TQ1uDays50x3ztLIDSNbxGwS0=
X-Received: by 2002:aa7:c44e:: with SMTP id n14mr46615689edr.179.1582534245113;
 Mon, 24 Feb 2020 00:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20200219151259.14273-1-olteanv@gmail.com> <20200224063154.GK27688@dragon>
 <CA+h21hok4V_-uarhnyBkdXqnwRdXpgRJWLSvuuVn8K3VRMtrcA@mail.gmail.com> <20200224084826.GE27688@dragon>
In-Reply-To: <20200224084826.GE27688@dragon>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 24 Feb 2020 10:50:34 +0200
Message-ID: <CA+h21hop_veYT7Ru6os2iqPV_tO+6vkZPo6sqgVf9GcNAsjWuw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next/devicetree 0/5] DT bindings for Felix DSA
 switch on LS1028A
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 at 10:48, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Feb 24, 2020 at 09:59:53AM +0200, Vladimir Oltean wrote:
> > Hi Shawn,
> >
> > On Mon, 24 Feb 2020 at 08:32, Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Wed, Feb 19, 2020 at 05:12:54PM +0200, Vladimir Oltean wrote:
> > > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > >
> > > > As per feedback received in v1, I've changed the DT bindings for the
> > > > internal ports from "gmii" to "internal". So I would like the entire
> > > > series to be merged through a single tree, be it net-next or devicetree.
> > >
> > > Will applying the patches via different trees as normal cause any
> > > issue like build breakage or regression on either tree?  Otherwise, I do
> > > not see the series needs to go in through a single tree.
> > >
> > > Shawn
> > >
> >
> > No, the point is that I've made some changes in the device tree
> > bindings validation in the driver, which make the driver without those
> > changes incompatible with the bindings themselves that I'm
> > introducing. So I would like the driver to be operational on the
> > actual commit that introduces the bindings, at least in your tree. I
> > don't expect merge conflicts to occur in that area of the code.
>
> The dt-bindings patch is supposed to go through subsystem tree together
> with driver changes by nature.  That said, patch #1 and #2 are for
> David, and I will pick up the rest (DTS ones).
>
> Shawn

Ok, any further comments on the series or should I respin after your
feedback regarding the commit message prefix and the status =
"disabled" ordering?

-Vladimir
