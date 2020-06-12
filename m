Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD54207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzTXSx88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLQDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:03:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846AEC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:03:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a45so4341650pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2PKPk7BQfppfNr7O5EBp2nwpc5uqRbW/+JPiDE2SzHo=;
        b=gzTXSx88SmeQROG5/rGF7+StSAeA8oieFghvZiWRXbsX0YrIDy6ZLYFtzpEQtqm7QT
         j9lg6c7oS2UP0q7Iw3M6MOt2bmEB004fbzsC58/BqPpUmVDLElY/NOHMhrQHLjbI11Ju
         jGCwCQUrcu2XqrbsIx3BMvnm4sJBsZI6iRFVvEiFdcgkcHFleXct5bJ3C7hTuw6/07ZV
         vcluFltq1gR7/RtS5iW5InpEDUPnHaGihu6oe3MzewquFXcGwB/RBBWmtXXwmjz8iKud
         8b7zcMHKQUxRudHvmMtf6PKgmIz4Kv0MVxY9dhZSvQm7AWFAJu20+uDM3OtaRdHSECQQ
         Lc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2PKPk7BQfppfNr7O5EBp2nwpc5uqRbW/+JPiDE2SzHo=;
        b=s6xFSL4aMDJvKW08GoWa3mgqRozJx+HFi/3LWZ5O7q0TFyw7XK3RulmbWffa+cq2BL
         E39KjNIMsQqW6LXrRVX229Cc0N+GjmKksj95ZZeNtToBaDbw/xdedZTTw3kzGokwledI
         RW7/d/+YUHm96UsSerayY7Aco9Ia1osLCHXfWHyInhQBv7WiEwn9Kxl9K2BkoRxFQWwn
         /YEqTlUQjYzhFJZ1YklWmqD/AuuzMM51u/3tiyorZUBhYJ+9J8DXEdWp04qmUAOWywSt
         K3QknSpu/zL7SFiBx7oCYxaEqdgJl4uyaeqB/3+m1Itkf9pg6giAQy+vShg4eMnzcDyI
         GcNQ==
X-Gm-Message-State: AOAM531UofuFsUFHDjAfCXSucVhaWaRYKe7kTje6UDMW5Xo5s0wPU42J
        dDvgG/XRFsZhYW5J02ibVWU=
X-Google-Smtp-Source: ABdhPJwG6QKhN5cTOdTvAF2ijD+ToA4XjdemGeBA1Y9qXvZuwAPSipLJGT8MuHp8NJ/Dd0Udn0cN+A==
X-Received: by 2002:a17:90a:e08f:: with SMTP id q15mr14574510pjy.178.1591977821425;
        Fri, 12 Jun 2020 09:03:41 -0700 (PDT)
Received: from localhost ([49.205.221.68])
        by smtp.gmail.com with ESMTPSA id h8sm10524409pjb.1.2020.06.12.09.03.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 09:03:40 -0700 (PDT)
Date:   Fri, 12 Jun 2020 21:33:38 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/3] ARM: copy_{from,to}_user() for vmsplit 4g/4g
Message-ID: <20200612160338.GA31501@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <nycvar.YSQ.7.77.849.2006121117250.3341460@knanqh.ubzr>
 <20200612160112.GA27659@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612160112.GA27659@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 09:31:12PM +0530, afzal mohammed wrote:

>                  512     1K      4K     16K     32K     64K     1M
>  
> normal           30      46      89     95      90      85      65
> 
> uaccess_w_memcpy 28.5    45      85     92      91      85      65
> 
> w/ series        22      36      72     79      78      75      61

For the sake of completeness all in MB/s, w/ various 'dd' 'bs' sizes.

Regards
afzal
