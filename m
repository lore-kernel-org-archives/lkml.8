Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F4C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A022073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOYnwekw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD2Ox2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgD2Ox1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:53:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D05C03C1AD;
        Wed, 29 Apr 2020 07:53:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so1162776pfw.13;
        Wed, 29 Apr 2020 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0ZRCFqU303/twN8hVJ5hqfcmrbnv34m+1dUf1S5stNk=;
        b=aOYnwekw+Ep61qJAMEnkw1HpeaNpSpUiVZAODecFZzn3FmNASj/FNznKgfNWegoS60
         Yx5v1NGzv3S/cPXEc3ALlBzUihHvwDLvBYDf17ffCaRVDrXS7RuTipnW8sDa30ggxmse
         RxoTryFRRFriEs7NCReUY3zAzzqEf45PXnZxoAn9U33LHz7Y/EXsLGugPMvi1SoSxEqq
         WjhhGe5oRPVT2bScL/FE/cnQ1Q3Ib8s4lq/Dm0vMqw9KXRs1rHPyQ7f9yl8eiLOl1YIb
         k+wLFh11qK0RwlCEPBLxcBsPeEylR5cfU3rJWCmg4L/vfq9U6d9G6fHsv3rHNlf8jPL7
         ofNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0ZRCFqU303/twN8hVJ5hqfcmrbnv34m+1dUf1S5stNk=;
        b=a0i++ZttpGzhTov6BWEBpoZ8GNv933+x4sUKPNbacyDy/S2AEN4BksqR0xDkYtu8WV
         Dn9wyIZUBTtvQkfOe+qdsdrNmPBYnJ0QJo0hCgPLofepm/CeLIxoyff47JxqZlfDBjGP
         2Lf51Q0Cra81G9TaC2nSxax/aW+Q2TvRYAkSgHjmaZIJy7xNAT4uiImkPrD6aJ/7jrlT
         Otc9BTZxB8Dd6DEHzYrfFY8VZWtZoLdxFsyBYNjqkONfPsOJA8+nfQ593hIYMQ87uRVM
         jPFLvCnpxCOKFGNve47vMMtP5jDdlagDiqgLuPzgNhPIb3N2xLuktonwYvkAnApyGGgF
         Lvew==
X-Gm-Message-State: AGi0PuYLitqG4rOy0CCuuNRbkOFogbIeq1xKaicigL7EOlkBusQaw1mN
        2FvpMyE4yagGPhCnOeYTU0Y=
X-Google-Smtp-Source: APiQypII7p7aNkIJuh7yMUE3jid684h7H+f5nYDkdRXBk7Yp8huPtWwgw135zQbdhJ8i10Nsn1nMGA==
X-Received: by 2002:aa7:951b:: with SMTP id b27mr35415299pfp.2.1588172007216;
        Wed, 29 Apr 2020 07:53:27 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id y24sm1243603pfn.211.2020.04.29.07.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 07:53:26 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03SGIdPj000709;
        Wed, 29 Apr 2020 00:18:39 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03SGIVsG000694;
        Wed, 29 Apr 2020 00:18:31 +0800
Date:   Wed, 29 Apr 2020 00:18:31 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
Message-ID: <20200428161831.GB30042@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200428020223.GA28074@udknight>
 <38e1a926-53a6-bda6-cb07-2614f4c682ba@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38e1a926-53a6-bda6-cb07-2614f4c682ba@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:52:59PM +0200, Markus Elfring wrote:
> > And there is no 'Fixes:' tag format checker in checkpatch
> 
> I have taken another look at corresponding implementation details.
> Will programming challenges get any more attention?
> 
> 
> > to check the commit id length too,
> 
> The mentioned script contains the following information.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/scripts/checkpatch.pl?id=b240f960afb900e59112ebcfa5a759bb0a85a14e#n2818
> 
> # Check for git id commit length and improperly formed commit descriptions
> 
> 
> > so let's add dedicated checker to check these conditions for 'Fixes:' tag.
> 
> How do you think about to reconsider the usage of the word “checker”
> at specific places?

Yes, I will use the word "check" only in later version.

> 
> 
> > +		    my $id = '0123456789ab';
> > +		    my $orig_desc = "commit description";
> 
> * Do you try to extend the existing software analysis approach “GIT_COMMIT_ID”?
> 
> * Would you like to avoid the development of duplicate Perl code?

Fixes: lines don't need to have a "commit" prefix before the commit id, the description
in normal commit id could across multiple lines, and we don't need to consider the
$commit_log_possible_stack_dump for 'Fixes:' tag line. I mean it will make the GIT_COMMIT_ID
code become harder to read and maintain.

> 
> Regards,
> Markus
