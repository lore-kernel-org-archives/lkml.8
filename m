Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFADC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A3D2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591864405;
	bh=qaQTKLGgj0nbxwMXhWVfC0P0JHctZsdHTtuhkbdPcdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZDLWnvVKrP3rN4xRcxqmqcdnLy6of21mWYOheCDKN2almMMhc+s7i1uEBXNp+OfHF
	 ar2k0JR/thpizctVw1bxBXPc4uABPrfp/61EkVkcUFeGlm8TOLATbRAelwtz3kN8Qd
	 aKXhDK1VThObbwL/xegGZ3zNr0Il3Gi9CG/g9URc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFKIdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:33:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45410 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgFKIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:33:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7so3018868lfi.12;
        Thu, 11 Jun 2020 01:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ME6wf3f+dByhrerJVAFcdzd6092HGdjTYYYCeIaY1OA=;
        b=ELAPS1y43tffxLqCi7ZpkG0Xf3vbz6p+2ovb43yALdYxMWZg/7G9cqaebLPAErnOb9
         ZGV4djUGNWDy1Us6ix9yhStEnSoBq9y8ypk4iro0o5lYJxlKoXaKhhP3J909iq9IiymE
         y4tRFeCOtB7S9nyteRAgDSDOf0H032qyAhon8/Oxqkvagv4Hu7kzDON4bdIMcmmh14/u
         gsmVI4WjZiKuhlWQBOjl8V5THHtf5oXFRQxBjTcrwBt/jdAGsRfCBOnNwddz59M2dKo8
         SAOSiSTJhezT8REf/FG0opJ95cPIJbAaUjb9Xj7JQNNOfB0f5SYezz5rnnCZz+hO36NN
         q85w==
X-Gm-Message-State: AOAM53028IS1X91Y2ClmCJ3f84spnlV0CGvNv7xnNgNWJJToiLizG2xL
        U7ErB79CFIKoQzp+r9/kNb8=
X-Google-Smtp-Source: ABdhPJwsyAeF6aTiG8WNBUrnN6XJ0DOMvgytISW549HxLenBQD/DUr0GzypXTL4Du6eZebuY7OAvrw==
X-Received: by 2002:a19:c6c2:: with SMTP id w185mr3713357lff.69.1591864401158;
        Thu, 11 Jun 2020 01:33:21 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r15sm548680ljm.31.2020.06.11.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:33:20 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jjIeD-0000LV-4U; Thu, 11 Jun 2020 10:33:17 +0200
Date:   Thu, 11 Jun 2020 10:33:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] serial: core: drop unnecessary gpio include
Message-ID: <20200611083317.GO19480@localhost>
References: <20200610155121.14014-1-johan@kernel.org>
 <20200611082530.rnx7rkbi6novjdar@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611082530.rnx7rkbi6novjdar@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:25:30AM +0200, Lukas Wunner wrote:
> [cc += Heiko]
> 
> On Wed, Jun 10, 2020 at 05:51:21PM +0200, Johan Hovold wrote:
> > Drop the recently added gpio include from the serial-core header in
> > favour of a forward declaration and instead include the gpio header only
> > where needed.
> 
> Hm, but why?  Are there adverse effects if this is included by
> <linux/serial_core.h>?

Compilation time and general code hygiene. Headers shouldn't include
more than needed. And in this case only a single driver (besides core)
is actually using the gpio interface.

Johan
