Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D975C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4886221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587075011;
	bh=D02fVRl/SCKSQnjUIkyjJym4/jDmogkH3Yw4vc7qhfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eZLxwpt0eCqT5Q7ZC7102hcOdJNhLqAKiJ7IuOxCWI0vGxAAaP4FphSr8SijhWs2g
	 BHV58ox5pmEKE5kkExv0uXu4wRc3V6GrVzGc+/nnhGrQmS5MeduEBmoL22cpADCwnq
	 ROH3FUWtQVWXHYvOvtqTKk044HKpdcbihyzZmUWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgDPWKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:10:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46961 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDPWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:10:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id q204so323954oia.13;
        Thu, 16 Apr 2020 15:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xuaXNuyOWtae20g9LglZEfMHpMFIV3/XEIuYH9TLOJ4=;
        b=P7qtLtXTPyfEHwwr4leEVQHYcVG5ncJvxZBYnq3gM94PC4ZCcmWA3CXafo13Hn5XkS
         vlB7KpW4zj+lPwWsRcPUvwDyg7gbuJisu+KyI5seZiamaikzA+R6sC0x2Kwd+mzIrJPH
         Re8i6b4xbG98ju5BC5eRj5h8ZJZ7t+4rDQ5ijfISX3hx6fZiUDZoKpua39E7LUa5UWX9
         izl0spOm+P1uqEpxJZUfTDuOevEjcuQKrRphqrSfw7zQD1z89uuM+z7OTAu2yocAarx7
         jxbeyanDpajm5U61gnnl+/JCXdw/7LSDir/2aiSnApqhVqmpIPcs31MQVPQcjKpAkMzg
         Mk6g==
X-Gm-Message-State: AGi0Pubw7aMADmUm6c+j80cwV180pi1zmcEqXi5+Uy01CfGDxtQWLsb8
        EBCq642nWHgWKqK1ID2eFg==
X-Google-Smtp-Source: APiQypIDYNqjOjthur0kjkpy/7f+/AIQ9zvvbEBOAqjkTUox800aHyAX7WLBHb5oPF+jPXAdOn/y9Q==
X-Received: by 2002:a05:6808:992:: with SMTP id a18mr213149oic.142.1587075008763;
        Thu, 16 Apr 2020 15:10:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm7432277otk.24.2020.04.16.15.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:10:07 -0700 (PDT)
Received: (nullmailer pid 6668 invoked by uid 1000);
        Thu, 16 Apr 2020 22:10:06 -0000
Date:   Thu, 16 Apr 2020 17:10:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 0/5] of: unittest: kmleak detected memory leaks
Message-ID: <20200416221006.GA3834@bogus>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:42:45PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Original bug report:
>   https://bugzilla.kernel.org/show_bug.cgi?id=206203
>   https://lore.kernel.org/r/877dyqlles.fsf@mpe.ellerman.id.au
> 
> kmemleak detected many memory leaks originating if devicetree
> unittests.
> 
> Five separate causes were found.  Four causes were bugs and
> one was expected.
> 
> Fix the four bugs and modify the test that led to the expected
> memory leak to no longer have a memory leak.
> 
> 
> Frank Rowand (5):
>   of: unittest: kmemleak on changeset destroy
>   of: unittest: kmemleak in of_unittest_platform_populate()
>   of: unittest: kmemleak in of_unittest_overlay_high_level()
>   of: overlay: kmemleak in dup_and_fixup_symbol_prop()
>   of: unittest: kmemleak in duplicate property update

Series applied. (To get into today's -next and I plan to send to Linus 
tomorrow.)

Rob
