Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6345C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850A12065C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcMkHHU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLCan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgHLCan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:30:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38BC06174A;
        Tue, 11 Aug 2020 19:30:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o13so273257pgf.0;
        Tue, 11 Aug 2020 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXlQ7DK9v+cF0bKIBVhay4AV+w1yPCPQuugUAYTYUVE=;
        b=pcMkHHU1yB5tTz/vaGoHkNGJvh82GGUPwdcOWq/I14U80syCTq630UuvEy29Cro0It
         aIiIr/BDVowsVwtZyt9ne67HK+SkGDm81MAiTMWHsCkbsf//liVzzNtPWLgnqXWNROeK
         F0vBrCqsVjCjDe8jXJHhO/QrJ/LGY/XNJy20sXn7ojo3KLxYnw1mx2nsW/oYENzQn1bE
         55lZHKzbfq28F6o1RmeG/x2wRkGUuV58cv+NyCzrk3dJuHKxanDwFVISr7fhEMY2JKjk
         RkGpc+IQFwiyB+88RfcOtfww7q5cxCiZqSHp5eKFFNgw+UGDXcZ1zNpBmSVNsJgKe+0I
         IE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXlQ7DK9v+cF0bKIBVhay4AV+w1yPCPQuugUAYTYUVE=;
        b=CTrrsF+B6lfCzQV2b0N/kOU/e8Gfu+ToFtC01r9vLt/sVIYiLIsWvWy/ixFgM3zstq
         9HJqeTcBEcgm91B2ifCejbN56Bdh3TFNnNFHdfeaJ2B2zH4I56shVD6Lyzsyrv+PDZ4g
         m//WhgLsf6PWPmXt1eWR2rdf+6sgPLc9+yIFVspu1Pd04tx5RH7VpiJ8YzoX7Kf4c2dU
         UgVmEPTJCOwsPuXVHYmpHPAjN9pk01oy7YxnC5Q5XVqaSfW9hlfwf/BKt7HkTnvGTP9j
         UAIHHcpb4d7IwODgAvJw3AeW291rMMJhJ1RY6rIGDx6KMiQS9IlXR73GC3fWzFvMH8uS
         f2kA==
X-Gm-Message-State: AOAM532iR4sfMzt62F/DULagNq1TNT8vGaSTSFaAtKlys/m5+qqThewB
        PvB4g0s6wMUXNEaD6932fCW/PSKTmGAb27eH3yA=
X-Google-Smtp-Source: ABdhPJxD6p41SG3pYPzcLo1hPzmwufqobCemJbHQfaIr7spsYscRYXsQInBFtVadQvtXzY9D0izksvxjQ823VWBpd58=
X-Received: by 2002:a65:5a45:: with SMTP id z5mr3152133pgs.233.1597199442615;
 Tue, 11 Aug 2020 19:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200809023548.684217-1-xie.he.0141@gmail.com> <20200811.103225.204767763010456044.davem@davemloft.net>
In-Reply-To: <20200811.103225.204767763010456044.davem@davemloft.net>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Tue, 11 Aug 2020 19:30:31 -0700
Message-ID: <CAJht_EM9KAO24mPWHZJwcVEugzCrKq6ndiaxhai=-mTudYi3+A@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
To:     David Miller <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:32 AM David Miller <davem@davemloft.net> wrote:
>
> Applied, thank you.

Thank you!
