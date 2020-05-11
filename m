Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC780C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD2D20746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxEioQ6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgEKNmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:42:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729540AbgEKNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589204555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+4ueUpxmGyJDhdbyflC74SPtwDyNM5MVN9jc/tyoSI=;
        b=AxEioQ6gtfDKApfSJ0M5QyFLyW5aMGaBQnZK+XgD6zRzuNiAr/9q1S9wlKN6GKg9scukNE
        mRBpTSasC+DBhOTbuICh/t+BK5uynAKBpsho8neKjDvQ48PQOWDBeBj2T7RvwU42NvJ86e
        zPljbWTNqVGUJhESS1vLlMxhi3T9PR0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-gZ3L24Z9OhOP5BMS4fPieQ-1; Mon, 11 May 2020 09:42:33 -0400
X-MC-Unique: gZ3L24Z9OhOP5BMS4fPieQ-1
Received: by mail-qk1-f197.google.com with SMTP id f200so3461652qke.14
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+4ueUpxmGyJDhdbyflC74SPtwDyNM5MVN9jc/tyoSI=;
        b=O/d1ROn/Zc6n7SatmYRvERIDqCgsQUBhsVavNdX5+dBkAjnM1YypV4Jzicj2E9yiHN
         C5YW3jEii9zHBNzU5LnyXnI+XM+o7HynC/nSSp6SYb/Whn8xgv/rLsZUBNnO65+OS4no
         nYy1UUURsq0dv01teqadS3PQtCfxYgnEniQX9a8jVGMofRBm28Qwyemy5VBlgEVoCbMN
         m9P7U0Cb+4cQ5jjM/y6uN43o+Wh6VSO+vJj4rItXZFaKdmU3EGSWa09U+6QAVafIbeWV
         WF2d3H2fI2KgqOj2eGzeOPK/BIcNwRpSUFqF9XNhnbxpJ4klqLy4+4h6vGiKUZzcne5K
         vNxw==
X-Gm-Message-State: AGi0PuYIkqnYx2vKReLmiE8V08sbiki4AfKwdz54jC4zQ7WZJV++ElZM
        XV+3D2eY4AsJ8R3QsKWJr3MbEhvHWx4Q1OQO+RJmVffrNsh6Q7qULxXr0AmXZI26b5j3xesulBm
        2/eAhLlm/u407FQriljG5W4zf
X-Received: by 2002:ac8:73c1:: with SMTP id v1mr2550411qtp.320.1589204552985;
        Mon, 11 May 2020 06:42:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4405i17T0JRi13ewE3f6GCn+QSzyzZe5yeFSXc+m6vqXV/0lUH1IRX3bFPNx4UEMXZUpqcQ==
X-Received: by 2002:ac8:73c1:: with SMTP id v1mr2550390qtp.320.1589204552670;
        Mon, 11 May 2020 06:42:32 -0700 (PDT)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id c63sm7973124qkf.131.2020.05.11.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:42:31 -0700 (PDT)
Date:   Mon, 11 May 2020 09:42:30 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH] lockdown: Allow unprivileged users to see lockdown status
Message-ID: <20200511134230.GA2311339@dev.jcline.org>
References: <20200220151738.1492852-1-jcline@redhat.com>
 <alpine.LRH.2.21.2002220351010.18183@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2002220351010.18183@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 03:51:24AM +1100, James Morris wrote:
> On Thu, 20 Feb 2020, Jeremy Cline wrote:
> 
> > A number of userspace tools, such as systemtap, need a way to see the
> > current lockdown state so they can gracefully deal with the kernel being
> > locked down. The state is already exposed in
> > /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> > permissions so unprivileged users can read the state.
> > 
> > Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> > Cc: Frank Ch. Eigler <fche@redhat.com>
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Looks fine to me, any objection from Matthew or others?
> 

Can we take resounding silence as no objections?

- Jeremy

> > ---
> >  security/lockdown/lockdown.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> > index 5a952617a0eb..87cbdc64d272 100644
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
> >  {
> >  	struct dentry *dentry;
> >  
> > -	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> > +	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
> >  					&lockdown_ops);
> >  	return PTR_ERR_OR_ZERO(dentry);
> >  }
> > 
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 

