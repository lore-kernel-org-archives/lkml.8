Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB5C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5FB21655
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pd09aNRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgCaNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:11:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730884AbgCaNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585660281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usxsvV26fFHRpbo4EPS+A1tC2Knjsvias64PeyQykb4=;
        b=Pd09aNRTx7XGxXwLZinva4uei/9KO9yr+ZPN6NPcR3yLO9VcctJOMkfSUNUnO90XnsXe9T
        KPZ1BizpFU+fGphUof5mKic84Vuuwa6Yl/KxHvCUf1x6DqCMf6u4pJoAd1Te6HMTAWcXs8
        9sN524PCtu1Ht1ENULAuSUfLvWja69A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-CRxOXfktMXK9yJXqxTeF2A-1; Tue, 31 Mar 2020 09:11:19 -0400
X-MC-Unique: CRxOXfktMXK9yJXqxTeF2A-1
Received: by mail-wr1-f70.google.com with SMTP id r15so5137649wrm.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usxsvV26fFHRpbo4EPS+A1tC2Knjsvias64PeyQykb4=;
        b=owf5ITV+f2eCURIriSivlpe4ZWBCQG0GeLIA160Idvub3BDXzkI9eeaoaJFFsh9Hhr
         axmyCegYhahXkbMSRf86VufkGl3299YgaIE69tFRQLekQOKN7pP8nb71nzRf0pZk8thl
         DD4Plaga8uJIjneePjHHejR+3ZPvxWyauWOX4gHzmyq2XE2HbiaoxWmshT28ZigFxm6k
         iHKHSefIdXZN/3YSWIAFxeLtKBUb4Ijr+8d1u/nY48/S/N0JpPQW6+0370Ex/Bo0N2qB
         MnNBf0+KiChGQAYM2h7AnFHKmg6yOGJhOi76yOnMeNMMc5OyJbnGk7GM/8ZKryb9xiDp
         C/+A==
X-Gm-Message-State: ANhLgQ22y++ohR/faT0OxBo3pEQDtXV+Eov/aq89TR3j6XtZthjkRscg
        p6vtNq/wC6eKO+iazJgAoa0YSGU/beaXymZ+RqrR9WcXQderVY2rok12bDj8/wASXz87tfNaWBT
        F2au7DhZJJbFizKQojaHdHG+j
X-Received: by 2002:a5d:490f:: with SMTP id x15mr19523930wrq.47.1585660278621;
        Tue, 31 Mar 2020 06:11:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttjf+fvsMP8RlVLnva+uKSJYXT4yC5ZNHvDRMtCn+D/13PEya9eLPWLqUf0IcUzgcQvmLXLA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr19523917wrq.47.1585660278456;
        Tue, 31 Mar 2020 06:11:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n2sm28031408wro.25.2020.03.31.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:11:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:11:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM <kvm@vger.kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: linux-next: Tree for Mar 30 (vhost)
Message-ID: <20200331085955-mutt-send-email-mst@kernel.org>
References: <20200330204307.669bbb4d@canb.auug.org.au>
 <347c851a-b9f6-0046-f6c8-1db0b42be213@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347c851a-b9f6-0046-f6c8-1db0b42be213@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:22:22AM -0700, Randy Dunlap wrote:
> On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The merge window has opened, so please do not add any material for the
> > next release into your linux-next included trees/branches until after
> > the merge window closes.
> > 
> > Changes since 20200327:
> > 
> > The vhost tree gained a conflict against the kvm-arm tree.
> > 
> 
> (note: today's linux-next is on 5.6-rc7.)
> 
> on x86_64:
> 
> # CONFIG_EVENTFD is not set

Oh, this is Jason's Kconfig refactoring. Vhost must depend on eventfd
of course. I fixed the relevant commit up and pushed the new tree again.
Would appreciate a report on whether any problems are left.


> ../drivers/vhost/vhost.c: In function 'vhost_vring_ioctl':
> ../drivers/vhost/vhost.c:1577:33: error: implicit declaration of function 'eventfd_fget'; did you mean 'eventfd_signal'? [-Werror=implicit-function-declaration]
>    eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
>                                  ^~~~~~~~~~~~
>                                  eventfd_signal
> ../drivers/vhost/vhost.c:1577:31: warning: pointer/integer type mismatch in conditional expression
>    eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
>                                ^
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

