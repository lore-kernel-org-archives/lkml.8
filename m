Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A675DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5467221D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyAWg8On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgIKMOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:14:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgIKMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599826352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WpSJZoDhXU8Bl8cIqyk1fDl2xLvOrmyAbOIbzanIsbk=;
        b=CyAWg8On73k4z81bGzC2y7+ER6dbGGnw2bl6NElXV5vTgC3hQ/tG8djyw+x1t1zMlMXLcm
        h6/DbHeWM0yJ6dYKF14jHgqau1os4ZmxotZ8jXaEghEvSfyO8tN7Yar+92gU2C8w3Ok4oQ
        1xyCiwskBRIx2IzByqYqvLyzWfy24Gs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-R2--wQuQOGS8szD0G-wq1w-1; Fri, 11 Sep 2020 08:12:30 -0400
X-MC-Unique: R2--wQuQOGS8szD0G-wq1w-1
Received: by mail-wr1-f69.google.com with SMTP id b7so3443809wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpSJZoDhXU8Bl8cIqyk1fDl2xLvOrmyAbOIbzanIsbk=;
        b=EklPykPtud+qTxhf/Dxu24FPaSUjRDy8fVE7q3Pz8rySQB9X1mc8u5I4uJxDskX52B
         1F/wVyMQFpGjH5dmUEPQaGYv+niyVhXOe/oGzGpcDiY4GG3pVxvH3aN69JRtxTWhNEge
         C+XfGnmumEkzvElpsGTCgIcYIjOq8pdyD9pOWP7uvRMVM0SlPSM0TgFHijqtkeNQSCLd
         qgRp4fmb0WaNiZcLWLBNBFLiEe9yX0w4n/m9CLvI+yyE+nSq/55Z9R1qnBeLAK+Y+ore
         paU2LoQll7MpHN2V+/Mch9Wd5eGaOXDQg5YwS8mlWlkrtFM/x4uwgDk/2Ou58R9hiZnP
         m4Ig==
X-Gm-Message-State: AOAM530+72MiLdhw7/c1UD97k+WXkJxqBBOSF7jarHNdl0keEWAjFeKU
        bceYuC9ldKZiTq8inLMxNxHQ1iloudJpTCanerUp/1Wat6P5yAiARHpMFiQVqS5HPI+tPBOrFsB
        7NpWkA+mMtuwHCgoxrOXkp+WzoH0+DXsCdDKmVK5o
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr1782468wru.329.1599826349297;
        Fri, 11 Sep 2020 05:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2UcPBLQ0l7SPS9t0/toMzg9RpVOraIQlfIv6RFuu9TW58mkfeZOObj5sfwveO+dt5rkefD7fFw5kHsJV91Z4=
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr1782450wru.329.1599826349139;
 Fri, 11 Sep 2020 05:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200623195316.864547658@linuxfoundation.org> <20200623195323.968867013@linuxfoundation.org>
 <20200910194319.GA131386@eldamar.local> <20200911115816.GB3717176@kroah.com> <20200911120854.GA221663@eldamar.local>
In-Reply-To: <20200911120854.GA221663@eldamar.local>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 11 Sep 2020 14:12:17 +0200
Message-ID: <CAHc6FU5iH5LdCQA5qGKbu0gqO1p+-A2Dn8XYahXCLJNB4JSqWA@mail.gmail.com>
Subject: Re: [PATCH 4.19 142/206] gfs2: fix use-after-free on transaction ail lists
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Daniel.Craig@csiro.au,
        Nicolas Courtel <courtel@cena.fr>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 2:09 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> On Fri, Sep 11, 2020 at 01:58:16PM +0200, Greg Kroah-Hartman wrote:
> > Can you report this to the gfs2 developers?
>
> Sure! Bob Peterson and Andreas Gruenbacher were already on the
> recipient list but I forgot cluster-devel@redhat.com .
>
> I can send there a separate report as followup if still needed.

No need right now, we're looking, thanks.

Andreas

