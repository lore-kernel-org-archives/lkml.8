Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2468206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjX+5xEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgCaNNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:13:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730646AbgCaNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585660387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhuhyUwYopA1n84wfzfATkQxt+0y/RkX+3b+ZUlYd24=;
        b=UjX+5xEJwuHtbQTZY/f0d5vv+G0tP370C0lBp0Snciuiwg1wDXLZNIfSOpUZgdFf+XNzKJ
        IE8gCPiUtNmHifMhMKTqHKATrPGXriCH0sHzo3wxXtb8v584VxLRewsrWk6xKpnE1EqDRu
        vjErxa45ctGwseiM9Wo6AUjjqDhkUlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Zv9otfIoN_qzfnd0JzU2Tw-1; Tue, 31 Mar 2020 09:13:05 -0400
X-MC-Unique: Zv9otfIoN_qzfnd0JzU2Tw-1
Received: by mail-wm1-f72.google.com with SMTP id y1so1052079wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vhuhyUwYopA1n84wfzfATkQxt+0y/RkX+3b+ZUlYd24=;
        b=J7GamM8I1pQe0MKHXloR0b1bt3alLbUzM/uK2jIuwl8zEbTA2E9nbIYVJqcvQ+OKmF
         1RBc7GDYFjZ6zx2pxMuHGD2Jae9ehA5y1dMvjRQInYpKYW42G2oMEF4gDEGVa6B2uXl8
         2Vy8mP/vj947HhIKOEmHvkw4dSXkcXjArAJlwGBhhxGH7tqxojfUnncqw9FDNMvo1wlZ
         Gov6do+Yjv+pEDgrvpAMJgXidjpkQFqi+dv/8+JuXNalw6GUnXyt/ttKsevyhruDZ0L4
         AFbO07Y4N90P+nHGc1crgMeClVUS5t8OR2onAC8xtbpS7nz7oiV+GOH2aPk82GSYVC8K
         91rQ==
X-Gm-Message-State: ANhLgQ0vghlNQGWZNJiUz425FAp8liG+BNPZ5aSy4Z/gIrmDZMkTTN6W
        uLDBO67C/VIprRZs3LbjAjIwWMrmDIn6YSNW70bM8clAifNxJ2zJKou2bHeCwh2VTvdKeU6L8+h
        3aShFc5z06e2KjjtpRckMeDjy
X-Received: by 2002:adf:f610:: with SMTP id t16mr20105986wrp.30.1585660384343;
        Tue, 31 Mar 2020 06:13:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuM4mf6PErLBYuIr557Jbfwdq0tffIdJD4BRvVV+5LWR2L1gVxuCah7k8R5X7pszotZ2Uw5HA==
X-Received: by 2002:adf:f610:: with SMTP id t16mr20105970wrp.30.1585660384168;
        Tue, 31 Mar 2020 06:13:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id j188sm3928906wmj.36.2020.03.31.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:13:03 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:13:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM <kvm@vger.kernel.org>
Subject: Re: linux-next: Tree for Mar 30 (vhost)
Message-ID: <20200331091138-mutt-send-email-mst@kernel.org>
References: <20200330204307.669bbb4d@canb.auug.org.au>
 <347c851a-b9f6-0046-f6c8-1db0b42be213@infradead.org>
 <649927d4-9851-c369-2ad2-bf25527b057a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649927d4-9851-c369-2ad2-bf25527b057a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:27:48AM +0800, Jason Wang wrote:
> 
> On 2020/3/31 上午1:22, Randy Dunlap wrote:
> > On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The merge window has opened, so please do not add any material for the
> > > next release into your linux-next included trees/branches until after
> > > the merge window closes.
> > > 
> > > Changes since 20200327:
> > > 
> > > The vhost tree gained a conflict against the kvm-arm tree.
> > > 
> > (note: today's linux-next is on 5.6-rc7.)
> > 
> > on x86_64:
> > 
> > # CONFIG_EVENTFD is not set
> > 
> > ../drivers/vhost/vhost.c: In function 'vhost_vring_ioctl':
> > ../drivers/vhost/vhost.c:1577:33: error: implicit declaration of function 'eventfd_fget'; did you mean 'eventfd_signal'? [-Werror=implicit-function-declaration]
> >     eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
> >                                   ^~~~~~~~~~~~
> >                                   eventfd_signal
> > ../drivers/vhost/vhost.c:1577:31: warning: pointer/integer type mismatch in conditional expression
> >     eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
> 
> 
> Will fix.
> 
> VHOST should depend on EVENTFD now.
> 
> Thanks


I did that and pushed. Pls take a look.

> 
> >                                 ^
> > 

