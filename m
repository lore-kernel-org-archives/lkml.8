Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8080C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DBA22BEB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="PPKe2c9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHZPZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgHZPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:25:03 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94DBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:25:02 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y11so876800qvl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jCdtk/ZURSNuEFDfKhXe1ymBpf3lit0hQaqnak8Pck=;
        b=PPKe2c9w7o8mKfxppP3ImoOQWtbEiAyVzoSGux9dLmTh0TtWAU7mAYN/eqGA8il0eR
         IRb7JnwpNPiDNFsDrr+7EEKK3VJVCRM3gNXGLp+/ZfSy9bFA0SjOWwy3ITc5/ZpotjXS
         +ONIyx9EQf80B7pWXlNfQE+YSPNGFiRd3DmKfdbebnTq9InXXX63O60Yjb8ilkgnbS5m
         SpaKx4vj3dweaM8D3DT3M9BFS4gZHeCWDCEeZYg7PFSlIzjkUFqXzr9L1pnGArRoWcEc
         wIPbtRVYvENkLXpQp33xNU8fvZ0AY2P7CaA4UUgmnJbgfF++p1TVHSRBX9a/sCwIN2jj
         OIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jCdtk/ZURSNuEFDfKhXe1ymBpf3lit0hQaqnak8Pck=;
        b=Cx3Q6J0jyQ6Ozk/STldl/5hwKkhq4zV3iASD5LWb8tS+4RpzpkUDO7ubRf2PrkspHA
         oI+zBjyQxyUZXvyOsJa2kOTrCjTedX/AHuvOnUVJJHjBevFW3R/tRJzIDby2rj1GyU01
         eAZGdB1ewAN1dGbs4IQ42d9ZnS4gyHsNUZ2vJCDDbUuVVz/i2Z1JVj9Wbq46SdgUHm1y
         0qmOCTGCvWMnK8uGuP1+qjN778OfgX6KCdd69qqJFUd/av8mYyC2czBYRc7Qx3azFgUl
         sZU66QcaMjKIIHgchqJm0+qJGJGNSoh3ZKjM5rStpzrP0+5dGSvyRgZB7RU/4HnMfH2r
         cztA==
X-Gm-Message-State: AOAM5329rXs8dN0+yVhyT3QX9RoIMOsgseukxtvJCBrZW1EUSJMVMfNf
        XB9pEV/0IkasKx6B+lVPYWmsxw==
X-Google-Smtp-Source: ABdhPJybSAIDosW5z0AAAsSDqg7kgtB/dyNQZnTsV+MunsOMYGeYiMt4qloptISx1U+AUpUU4zFMfw==
X-Received: by 2002:ad4:4aa5:: with SMTP id i5mr14499134qvx.179.1598455501966;
        Wed, 26 Aug 2020 08:25:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id f193sm1842958qke.101.2020.08.26.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:25:00 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:23:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-08-24-16-06 uploaded
Message-ID: <20200826152346.GF988805@cmpxchg.org>
References: <20200824230725.8gXQoJFD-%akpm@linux-foundation.org>
 <20200825084543.GA16605@linux>
 <20200825173021.fcf20a4f3043ed5d5b4ac3b5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825173021.fcf20a4f3043ed5d5b4ac3b5@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 05:30:21PM -0700, Andrew Morton wrote:
> On Tue, 25 Aug 2020 10:45:48 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> 
> > On Mon, Aug 24, 2020 at 04:07:25PM -0700, akpm@linux-foundation.org wrote:
> > > A full copy of the full kernel tree with the linux-next and mmotm patches
> > > already applied is available through git within an hour of the mmotm
> > > release.  Individual mmotm releases are tagged.  The master branch always
> > > points to the latest release, so it's constantly rebasing.
> > > 
> > > 	https://github.com/hnaz/linux-mm
> > 
> > Is it me or this is out of sync?
> > 
> 
> Seems that way.  Maybe Johannes's script needs a new battery?

It looks like github had the hiccups yesterday:

Connection to github.com closed by remote host.
fatal: the remote end hung up unexpectedly
fatal: the remote end hung up unexpectedly

But it's uptodate now.
