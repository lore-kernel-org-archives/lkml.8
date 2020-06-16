Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB5208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="DZHrUyxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgFPQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgFPQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:19:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F991C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:19:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s28so12643642edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hr3yVEPV6lA1nanRTqWI8IJryq24qnnSTFJ14MM/7zs=;
        b=DZHrUyxnI2wxj8f69u1+U5wzsYX16HUl/aTv7JYK9V6CybdFLK91SGat3bh7Zz5pKw
         eYWNsiiq8LeeM+qtd7hoZtFM79A0GikMLP2CTK6Vi7ZZ3Pmc8rO8F/88x/U8wjBzFXFN
         AIPABW4VADwBnv3oGKeg7KUqSBmIPbMNrxfXP5kMM8OMO1Pcj0s8YPKN2cZrU+HnFBrU
         VqlKs3aaMLtqjjlJwDCST5EVn6wc9W5nXa48X3RPiivOEQlkEzTUg/2yeuO2FyDFZIvX
         G9k72NLkB0J8o6esTtqZXiRhC3ZF3v+XgQP08ADK7sTgozAKVy3ir0QokMg/k6nW07/+
         qObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hr3yVEPV6lA1nanRTqWI8IJryq24qnnSTFJ14MM/7zs=;
        b=kaoLk2KazO7PTTX9SgkC1zHrq7tLgUBfkZvhYvyB55DckSef04UZEF1mz9eKgWMGpc
         1vzNXOmS4yAB5wtTXC03eR/kyiaNfbmO2Qi1+NXnD+6ZT4ktoDqOSzJDgxOF8R+mrZB7
         8j+ScR9ZJLMv5J0rHiMG3SL7QfGoxWLaPMDgSKbeZEbRtyGRts/ydKphSQPoQNY2+ig5
         alaOYqBlYp6tfXlH9CO1IepmNuUoTpmFVEVgarsvCvCMuFwunMR+6WFxcpmaqEXCndg2
         sK4pBwJd5YC6O9rgVhtwzMRmMozd4LKGZsj5p83VJXkvgSIuAYr+SR0PyL6AbRaAYUA7
         enFw==
X-Gm-Message-State: AOAM531oIPs9bYCWZm1WXPN4m5YfMTfqFhzSqXlv0YRG8xTjfudFrJMt
        +1bTmLqHbPkz+bTB1zjUYCJLtw==
X-Google-Smtp-Source: ABdhPJwxZcp1lp6WrQvxCOa4+J+L4Hbhu6KDNsF55SP0s+x799vNFH70u0bmPLYwCTn8NeutUxBsnQ==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr3399666edr.175.1592324382014;
        Tue, 16 Jun 2020 09:19:42 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id ce25sm10330788edb.45.2020.06.16.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:19:41 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:19:39 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH V2] ARM: dts: am335x-pocketbeagle: Fix mmc0 Write Protect
Message-ID: <20200616161939.GA4007093@x1>
References: <20200609214521.GB2995279@x1>
 <20200616161024.GC37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616161024.GC37466@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:10:24AM -0700, Tony Lindgren wrote:
> * Drew Fustini <drew@beagleboard.org> [200609 14:46]:
> > AM3358 pin mcasp0_aclkr (ZCZ ball B13) [0] is routed to P1.31 header [1]
> > Mode 4 of this pin is mmc0_sdwp (SD Write Protect).  A signal connected
> > to P1.31 may accidentally trigger mmc0 write protection.  To avoid this
> > situation, do not put mcasp0_aclkr in mode 4 (mmc0_sdwp) by default.
> > 
> > [0] http://www.ti.com/lit/ds/symlink/am3358.pdf
> > [1] https://github.com/beagleboard/pocketbeagle/wiki/System-Reference-Manual#531_Expansion_Headers
> > 
> > Fixes: 047905376a16 (ARM: dts: Add am335x-pocketbeagle)
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > ---
> > V2 change:
> > - correct P1.13 to P1.31, apologies for not catching that in V1
> 
> Thanks (manually) applying into fixes. Your outgoing mail server has replaced
> the tabs in the patch with spaces making it not apply FYI.
> 
> Regards,
> 
> Tony

Thanks, Tony.

That is werid about the spaces.  I use mutt to send mail via smtp.google.com
(beagleboard.org is gsuite).  I'll inspect more closely next time.
