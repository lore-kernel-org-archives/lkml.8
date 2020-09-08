Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCFCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D614D2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9bU/wnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgIHSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:43:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731351AbgIHSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599590507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpjlD6Mndqdn+nz+CJTU5sL9T+UVkaZ8HXjd0BtRM3s=;
        b=S9bU/wnXmyTCNZG9PLNzEraoJqGl4uzIgFdA1SbtZWgw1z5lRzpfBXo6EM7pAn+gQleZ6t
        mOPZ/jDD4V47xUXbaqInXHFodA9ycMOf/UJd1GG059zsbXA5AzRzfWnfazpsPTyRsHvEl3
        SI3W3TPhOGgOavWsRCqrk9E9vGwsYMQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Qfdc4krrOjWmW7x3cqpx8A-1; Tue, 08 Sep 2020 14:41:44 -0400
X-MC-Unique: Qfdc4krrOjWmW7x3cqpx8A-1
Received: by mail-qv1-f72.google.com with SMTP id l29so9649744qve.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=IpjlD6Mndqdn+nz+CJTU5sL9T+UVkaZ8HXjd0BtRM3s=;
        b=eWklTbitmRo+6UfYHCMcHIJBWztCv59ruY6OGnJF5FZwXoVY8cJjcucS8o0oLsg3mg
         GyDWqhWRs+/tZKlcYTwEc43ckrG/Upk5NjRhkhLuqjjJozL1yW97I4yE95mKpIDvTq6/
         DVaMlubiwWQBB1EFmmHg6RnzCvtVKLUmRukD1boyD14DbJJ6HDXInXwILKgtVuoxoyes
         EP4mePUoX1UCnyAB8b+y4oKRwgKaypJ3HP5loQJufzDbTSyCyCI+9MTqNYyHHqbs3zZ8
         nOJ6IkWKP+0mJOEERW3OG7Kes0jY77RD/kTdbzrwbpesoTEYKWQ9EnGs3oS1nFjR94G4
         PLHA==
X-Gm-Message-State: AOAM532lJMDOlHU3Qd687RhNU2JrkNStiD/Hr+mRgWG8wnP5zZoy4z6X
        zpc/zxToqZbNlWv9DXqzj5o+BcFCqwn7XJY2uj11W26CoRu3OQwVga1Bjcxm9R8GRG+wPbRl8zA
        5Hgc5FYxeQqofekblgAmFv319
X-Received: by 2002:ac8:2942:: with SMTP id z2mr1504573qtz.376.1599590503836;
        Tue, 08 Sep 2020 11:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV5R7T9pGSZb0id3QT5Zh36EqJ9LGz3wCDMkMIc5C16Jl7FkxMtmGYs2WIHLxR8SosqFb+MQ==
X-Received: by 2002:ac8:2942:: with SMTP id z2mr1504558qtz.376.1599590503622;
        Tue, 08 Sep 2020 11:41:43 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 29sm51810qkr.114.2020.09.08.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:41:43 -0700 (PDT)
Message-ID: <5b63113be2e02d15268470d54b0cffeae06c5292.camel@redhat.com>
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
From:   Lyude Paul <lyude@redhat.com>
To:     Zwane Mwaikambo <zwanem@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, tcamuso@redhat.com,
        dkwon@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Date:   Tue, 08 Sep 2020 14:41:42 -0400
In-Reply-To: <alpine.DEB.2.21.2008181057090.8571@montezuma.home>
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
         <20200811085830.GZ2352366@phenom.ffwll.local>
         <alpine.DEB.2.21.2008111514210.35094@montezuma.home>
         <CAKMK7uHxikojLQNbsnnfDfGZ3tFP9CRUTzvr+DsZghzQupaBGg@mail.gmail.com>
         <a1141faf8c6a0a924d87132fb4a297cd6d47e09d.camel@redhat.com>
         <alpine.DEB.2.21.2008181057090.8571@montezuma.home>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 10:58 -0700, Zwane Mwaikambo wrote:
> On Wed, 12 Aug 2020, Lyude Paul wrote:
> 
> > On Wed, 2020-08-12 at 16:10 +0200, Daniel Vetter wrote:
> > > On Wed, Aug 12, 2020 at 12:16 AM Zwane Mwaikambo <zwanem@gmail.com>
> > > wrote:
> > > > On Tue, 11 Aug 2020, Daniel Vetter wrote:
> > > > 
> > > > > On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> > > > > > Hi Folks,
> > > > > >     I know this thread eventually dropped off due to not
> > > > > > identifying
> > > > > > the underlying issue. It's still occuring on 5.8 and in my case it
> > > > > > happened because the udev device nodes for the DP aux devices were
> > > > > > not
> > > > > > cleaned up whereas the kernel had no association with them. I can
> > > > > > reproduce the bug just by creating a device node for a non-
> > > > > > existent
> > > > > > minor
> > > > > > device and calling open().
> > > > > 
> > > > > Hm I don't have that thread anymore, but generally these bugs are
> > > > > solved
> > > > > by not registering the device before it's ready for use. We do have
> > > > > drm_connector->late_register for that stuff. Just a guess since I'm
> > > > > not
> > > > > seeing full details here.
> > > > 
> > > > In this particular case, the physical device disappeared before the
> > > > nodes
> > > > were cleaned up. It involves putting a computer to sleep with a
> > > > monitor
> > > > plugged in and then waking it up with the monitor unplugged.
> > > 
> > > We also have early_unregister for the reverse, but yes this sounds
> > > more tricky ... Adding Lyude who's been working on way too much
> > > lifetime fun around dp recently.
> > > -Daniel
> > > 
> > Hi-I think just checking whether the auxdev is NULL or not is a reasonable
> > fix, although I am curious as to how exactly the aux dev's parent is
> > getting
> > destroyed before it's child, which I would have thought would be the only
> > way
> > you could hit this?
> 
> Hi, If this is acceptable, would you consider an updated patch against 
> 5.8?

Sure-although the process to getting this into stable is to get the patch into
drm-next first, then it can get cherry-picked into the stable kernel branches.
See https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> 
> Thanks,
> 	Zwane
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

