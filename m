Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44875C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159F2207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590110922;
	bh=fcixLSIhkETTM8M2vWm2aY09uJRQubWo7CccLnwDEHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DrUR1PJZUx7KagnFlqweUl4YxFKQBEEjFL78L9k4WrfOA83YpL+lLJ8jxb+8GgSKY
	 wU2+Cd+CY5txs/JJXwCY8TGrx1XYlF1K0NIscLoTTGfDclizwnmEcArX73ptxtm0bM
	 fEKsBWhjcTIZVKhDhoSG6t+rofbZ/5UOdXO5cgeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgEVB2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:28:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:46791 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgEVB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:28:40 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04M1SJai011585;
        Fri, 22 May 2020 10:28:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04M1SJai011585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590110899;
        bh=WO97w+HaBwdmE62qzYedm3R7prD0osfSacFfO3kd6QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YABKSuDHCESfDul3RO1gyhAv7Em2FcDwW74TJygydahezkeMZWlaS/RN0hqfdZ8XR
         0GkZa5AYIGIpcvwN+SNI20GTyGsNCtvfiwns1d4oesaD0RpoIuy/5Arcb8v6y78zTR
         xGHly314NJSX5ep7HVbZTWS8zSV6C/nxm0klTbzHCyRKlw5UfLUUvn+T6/luP67xTS
         Rn/M0A87YD8o623lVZuXO5RlFjIwKvYU0fTW8zjXG9TlYv7//QmAfuNCl+k8BtlguV
         fDRPiuF+c2/0TDJjuOT7yLSQFQq7wg7mDcBekE0NxRU8avXu4+p0HbVpDoXVeI4rCM
         Pgk/2ZZLxZvRQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id e7so5213995vsm.6;
        Thu, 21 May 2020 18:28:19 -0700 (PDT)
X-Gm-Message-State: AOAM533+ZHQXa20WZvqtdOInmGP4tbrnO6yTm0k15PLZe+PknITu97Cf
        PCTQlJVZcvJXF5g/cVXrVVJaf5dvRsw8dAyAt3c=
X-Google-Smtp-Source: ABdhPJwyhZAU6Ap3q5CzUiDCarir2jXr7qhUNz/IzRXLgmA+eeuyS/cezLBc3TiYG6z5VvUd15L9gYfucAwn6uUAu/Y=
X-Received: by 2002:a67:d016:: with SMTP id r22mr8961471vsi.215.1590110898528;
 Thu, 21 May 2020 18:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200522082433.4f536de1@canb.auug.org.au>
In-Reply-To: <20200522082433.4f536de1@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 May 2020 10:27:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATU18vKsSV_pugSRw4e3bQBUAQ670ac34GbO2YNHXgLPw@mail.gmail.com>
Message-ID: <CAK7LNATU18vKsSV_pugSRw4e3bQBUAQ670ac34GbO2YNHXgLPw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 7:24 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   82ab9b6705bd ("dt-bindings: arm: Add Akebi96 board support")
>
> is missing a Signed-off-by from its committer.


Sorry, I missed to add it.

Olof, Arnd,
If you want me to resend the pull-request,
please let me know.
(but, probably it is too late, I guess...)


-- 
Best Regards
Masahiro Yamada
