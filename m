Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22ED206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQTVJWcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFBUmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:42:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727860AbgFBUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591130529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZbzXBMyP2ZV0xb1q05Ewy42EfhDuwN256DhtDnRLuUs=;
        b=cQTVJWcz8WIU0qGE/xECbOFm9EeuHMW7I9ak80srMfQZWpJNhhN11ZvAsCpfXpF0cp8hQc
        rPgLDFhGiDoXUgp656gX4kK52nEbrJz100UQCtUlxfmuMzVBQx61p54meZmQ0PZF1JsMnc
        YqZk1L8uGPBpgtkOhb4CtJRhfTd/XTk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-xbdcsWqPNbWUXqfJ5KMf9A-1; Tue, 02 Jun 2020 16:42:07 -0400
X-MC-Unique: xbdcsWqPNbWUXqfJ5KMf9A-1
Received: by mail-wr1-f69.google.com with SMTP id m14so29426wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZbzXBMyP2ZV0xb1q05Ewy42EfhDuwN256DhtDnRLuUs=;
        b=FGY8aJEXWjpsz3tb241G18Kfvo/82k/hg5g4LmjtpN+SzZmCDCsDEd1bqezFYVpySY
         XpwxYtwtQGzkIDdsZ2XnlFmodI5vgZ6QGX2PTYKRoGyK0gDNVb42HxIugvDlEuw78mbX
         yYglZ9L4KN3KJ2HY3episSe1De+1+obEomCPqBsCzHklzJ07tBCwHeHMeWgz3GxRrV2f
         +s+E2mui5NLQq+WftXTHEwN3URvcVeUZTrTbDDHxFnyBTu3s0gJ1ysZgcwLjIIa6vkEe
         MTTE/YzG0Su+vSaT/xt9S1RMyHWt1vc4JQCtepQhQ6bOD32bwCPeoYlgQE6pBgE9T0wV
         jOxA==
X-Gm-Message-State: AOAM532cavo5FCiuQ1kyftYlC04NugTBF+I7fFl6TgqFSZXtXc2NfWLa
        DlilqlguT7VrRNYkaQzPRtGTdanYrGtQZgZXErh8aEMPkuRiePCMufFAz6sGyqh4vkTY/3sEjpR
        7GdepaBOvOz5wLpQNW1NG1h0i
X-Received: by 2002:a1c:9896:: with SMTP id a144mr4259287wme.75.1591130525946;
        Tue, 02 Jun 2020 13:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMeM2kEvp4pkvEwdpNO5MlqKjkVW+xipN3ThJjTmbbysJGdPdXbitZwUdNzRZLA11N4P7CNg==
X-Received: by 2002:a1c:9896:: with SMTP id a144mr4259277wme.75.1591130525725;
        Tue, 02 Jun 2020 13:42:05 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id p10sm189217wra.78.2020.06.02.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 13:42:05 -0700 (PDT)
Date:   Tue, 2 Jun 2020 16:42:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200602163937-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200602163048.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602163048.GL23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 05:30:48PM +0100, Al Viro wrote:
> On Tue, Jun 02, 2020 at 04:45:05AM -0400, Michael S. Tsirkin wrote:
> > So vhost needs to poke at userspace *a lot* in a quick succession.  It
> > is thus benefitial to enable userspace access, do our thing, then
> > disable. Except access_ok has already been pre-validated with all the
> > relevant nospec checks, so we don't need that.  Add an API to allow
> > userspace access after access_ok and barrier_nospec are done.
> 
> This is the wrong way to do it, and this API is certain to be abused
> elsewhere.  NAK - we need to sort out vhost-related problems, but
> this is not an acceptable solution.  Sorry.

OK so summarizing what you and Linus both said, we need at
least a way to make sure access_ok (and preferably the barrier too)
is not missed.

Another comment is about actually checking that performance impact
is significant and worth the complexity and risk.

Is that a fair summary?

I'm actually thinking it's doable with a new __unsafe_user type of
pointer, sparse will then catch errors for us.


-- 
MST

