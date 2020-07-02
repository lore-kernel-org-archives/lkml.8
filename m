Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D6920870
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jo67aa/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGBQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgGBQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:38:40 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5331EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 09:38:40 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id b13so9122617uav.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEtyZGHGPJIZFNjI/Ip4xEzWQIwRU4IYgLEED0Ona/I=;
        b=jo67aa/lHzYqjfYskLWKW5quEITA5FiC6PWEwsrYI0aMCYXg4HY7LncYRG9WkKyXDj
         7BOU8BGXvkvEN2Q3XjgBl5MKhKWUMKGtaCA7meltTOvUmo0nm1QZurL7IYfJGwqnR8dm
         c41ogPba76PP5CTQrvGAHBqF70Qu9M4yFRZSG7CUKlo+tp0GsaGMt79ZKwyBgAr6NDiK
         rGrUPl8FW4kvGT+0gKpgTOHJ1422EOyUD/ab/axNgRiQMdrLLFYdTkHa6uKWZZsl87iE
         +3pVhBssylZ8qgB4tO80LGaZAdWXdcmPQqF2rc6o4BbLErNMrD9Apy3l5feTNLqbmDOP
         QBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEtyZGHGPJIZFNjI/Ip4xEzWQIwRU4IYgLEED0Ona/I=;
        b=FTaOqPmqDlwNGsa7SagWkgv91qG0tXwBwXV8s7V5zLBmI+1Ghula9rwpfIRLy7e6JF
         sNBuwqOHInOIMr4YFE7VrPDNMylDrec9qrTOtiv/kKIS2SxFfR4l7UIOewmPVMlzcE1t
         fSZaT4PFvvdACa3Atk4WqDRgjH5F9RdilGwThuyYm1gVuP0ZICgdEAB1zYn02tbAi6pP
         r2Ov7iQz9ZlvGY7d5RbA7kdlNTAd3jbQWAXe1xCRMcqqeFKpWf+I672oLTMg8oUWmAeW
         hF/Odre5NLJc6LqDEF9JbkrIS8DH6jPIh91oNQ+2jg+zTTOKKZR4Nl8oMHZQpraJzTRU
         vLaw==
X-Gm-Message-State: AOAM533W0AuoqJjlc6UI0gGl9YIctoENOx+p8kWBUUEGONytqAifGLS5
        PowHozZFukSd+Kj3dvES3u0/yR0qNe0ToAyLCMN3Kg==
X-Google-Smtp-Source: ABdhPJzy3R8feg5WOHFZEWnBC021WeM1muKk3BvjvajYrjfmItC3J16JyyfE80+c2pVrKZr1W0y8O2p4UVxT2Y/Hars=
X-Received: by 2002:ab0:6510:: with SMTP id w16mr14005307uam.97.1593707919367;
 Thu, 02 Jul 2020 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200630174350.2842555-1-linchuyuan@google.com>
 <20200702014223.4096977-1-linchuyuan@google.com> <20200702051453.GA235128@roeck-us.net>
In-Reply-To: <20200702051453.GA235128@roeck-us.net>
From:   Chu Lin <linchuyuan@google.com>
Date:   Thu, 2 Jul 2020 09:38:28 -0700
Message-ID: <CAKCA56D-jHF80J7u=YGcwE-+d6AjNfrbkin5AbavKAJPCqkygg@mail.gmail.com>
Subject: Re: [PATCH] hwmon:max6697: Allow max6581 to create tempX_offset attributes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Ling <jasonling@google.com>,
        Kais Belgaied <belgaied@google.com>,
        Zhongqi Li <zhongqil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 10:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jul 02, 2020 at 01:42:23AM +0000, Chu Lin wrote:
> > Per max6581, reg 4d and reg 4e is used for temperature read offset.
> > This patch will let the user specify the temperature read offset for
> > max6581. This patch is tested on max6581 and only applies to max6581.
> >
> Patchwork received four versions of this patch, with two different
> subject lines.
>
> How am I supposed to know which one to look at ?

Sorry for the confusion.
I was learning how to send amendments to a patch and forget that
it may create confusion for the reviewers. The latest one with headline
hwmon:max6697: Allow max6581 to create tempX_offset attributes is the one that
should be reviewed.

Chu
