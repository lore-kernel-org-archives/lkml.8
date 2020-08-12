Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD5A20768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJMmkgr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHLHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36581 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbgHLHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597216707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5vnrGUSviiSyDo4A1Jti2cqm6vCb7k5wROaco57qD0=;
        b=EJMmkgr/6Mu0bFQUhDE7Jiur2WgYyZyIPz9YWIZNqAXcyfJDeQzRydvyqrwfNCK71DUr1U
        Ko/vTtYm/qCLgshpQEQW4xFaeOgI+Kop8TQ3r3H5W4xSNTi9kwpIN+JokeD9W4K6wiTi9l
        IFqofjHPKYcaGv6FSMQVZX20SWQOdo8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-3iO5BckCPYWyaiYagMySBg-1; Wed, 12 Aug 2020 03:18:25 -0400
X-MC-Unique: 3iO5BckCPYWyaiYagMySBg-1
Received: by mail-wm1-f71.google.com with SMTP id z1so541316wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5vnrGUSviiSyDo4A1Jti2cqm6vCb7k5wROaco57qD0=;
        b=QECnN/TrGK8laOX/dMYUXgeT13gnvi53X/2abjzeoDn5nyNuM1fW37BWtoibE5F++z
         2V6LIcZk9WNj7WVRUBcktyuJG/0m/JfJIoVHBDNBMU/I2SX4Cbs/NDSRO/4N24n4Nkse
         J1qHLH6TyjyRkTscq39K7TZl+9AuSKMeWAOft6UUX1dPewPtgrF03aSYwmnuy9qvadWI
         yOLLg+4Skbw5SPIMy2iGCqxJBh1rZQmgYP2nB5gNIAFm2p+UfnUQy3ajpONyM71jqngT
         zSqTiUXQc4LVAI5MBrmBS7MVNLDHqfIWk2OH55XOUqD1mNtL/GVt3pGL6HIiMRwGA14+
         SYxg==
X-Gm-Message-State: AOAM5307fO4bv/p6ymseLBvaGSPzNeF8N1ZitHtYpHTSGPKoM/NiNKqw
        TN0f4xKxsBkJBA61KqDP3zBEShg0oPtyecPaW77I87oXugejVlngAdYqNtpLIIMJdrhHpP0BixL
        YpnAESlymiEq9uKG+4MyRdmIP
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr7833386wmg.91.1597216704439;
        Wed, 12 Aug 2020 00:18:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdYhlEIglOLVe6YV8jXLsNNRYYEwJBGXoch1voDOXD/WBMnFly08DgF2XM7EKR+k6oZDm1/g==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr7833366wmg.91.1597216704160;
        Wed, 12 Aug 2020 00:18:24 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id w1sm2236205wmc.18.2020.08.12.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:18:23 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:17:42 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jhansen@vmware.com, netdev@vger.kernel.org, kuba@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        stefanha@redhat.com
Subject: Re: [PATCH net 0/2] vsock: fix null pointer dereference and cleanup
 in vsock_poll()
Message-ID: <20200812071742.4zoxlvu44ivunsjd@steredhat>
References: <20200811095504.25051-1-sgarzare@redhat.com>
 <20200811.102418.1200203139092745562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811.102418.1200203139092745562.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:24:18AM -0700, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Tue, 11 Aug 2020 11:55:02 +0200
> 
> > The first patch fixes a potential null pointer dereference in vsock_poll()
> > reported by syzbot.
> > The second patch is a simple cleanup in the same block code. I put this later,
> > to make it easier to backport the first patch in the stable branches.
> 
> Please do not mix cleanups and bug fixes into the same patch series.

I did it because I was going through the same part of the code,
but I won't do it again!

> 
> net-next is closed, so you should not be submitting non-bugfixes at
> this time.
> 

I'll resend only the first patch, sorry for the noise.

Thanks,
Stefano

