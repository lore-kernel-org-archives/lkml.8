Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324EC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C2B2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV/7Z6Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgAJGNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:13:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbgAJGNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578636784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUb7J5k9pHQGDMgWElpRTaa3UN/XQp4RFy7vMyL+c3E=;
        b=NV/7Z6SciDP2eNTJnrhrOhLhjklYARNnUBet0WMjkQJSqbQFl7fgqxC1nKhfGc2VaLGfR0
        K5VkWZhYK+6UPEKqfzkfuNQVfaqLxHfss/1adziwIZrLa7tB+mwdVOsmXn72ly9jF2Fmj2
        X3X8ZI6LKYWe0d9t4HB+/rGTTsJ2uV4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-HbCBka4HOW2Hn3xXtZi34Q-1; Fri, 10 Jan 2020 01:13:03 -0500
X-MC-Unique: HbCBka4HOW2Hn3xXtZi34Q-1
Received: by mail-qk1-f198.google.com with SMTP id u30so577252qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 22:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JUb7J5k9pHQGDMgWElpRTaa3UN/XQp4RFy7vMyL+c3E=;
        b=T9b+/mX5eQub5nSyhjoL+fNvDuifFslOV/wDOAhpmVoNXscacT4uENEJtI0NFLvVk9
         JtNXXm/pSPDG4TL4mlgIHkjk5gZJbSoMtme4Vtag0CdXGnL1JxjkJO591hK3c72tyzYH
         dmO7a4lFvOynu7IR7XzE/Rc1LmuaUQIpP1/iWo7Djeb5pqLmnuBMKl5Kj1R/vjHVF+5t
         iSOI6MOT7JZq3ja2Tdir6eRAZq3im1immPnlhqj2UgFTnjLqaUQaTdmuZ1uiPo4uYX5V
         0rP85M5/3oHjEGzlHsaMdti18F8ANPiZWFUls841yx9hs+qWI6xHP8E2A3H87iIQ4G+C
         3PmQ==
X-Gm-Message-State: APjAAAXo0/sD4ejNMO7ew53/9Mb3XeWkRhxn7HZFGEjykGce41ql2nDa
        D1IoTdc+n+lf65MOKmm2+ZSxma025we+HxJXourEJX4gQnyWtLV3RKAwSAIyV/A5LM+tSmWg/JL
        SrshgiOUDOQhXHbAgUi4Ufrie
X-Received: by 2002:ac8:6697:: with SMTP id d23mr1080348qtp.350.1578636783316;
        Thu, 09 Jan 2020 22:13:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEBnt7IxTIASPQRiXS/2qwYjQd4GY3gTOeHUpypwIPSrQCqrkSOQtY6sfsyfysgAniCEZu/A==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr1080336qtp.350.1578636783113;
        Thu, 09 Jan 2020 22:13:03 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id z3sm546702qtm.5.2020.01.09.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:13:01 -0800 (PST)
Date:   Fri, 10 Jan 2020 01:12:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, adelva@google.com,
        willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Message-ID: <20200110011236-mutt-send-email-mst@kernel.org>
References: <20200105132120.92370-1-mst@redhat.com>
 <20200109.183339.173768060466817001.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109.183339.173768060466817001.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 06:33:39PM -0800, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Sun, 5 Jan 2020 08:22:07 -0500
> 
> > The only way for guest to control offloads (as enabled by
> > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
> > through CTRL_VQ. So it does not make sense to
> > acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
> > VIRTIO_NET_F_CTRL_VQ.
> > 
> > The spec does not outlaw devices with such a configuration, so we have
> > to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > Note that Linux is still crashing if it tries to
> > change the offloads when there's no control vq.
> > That needs to be fixed by another patch.
> > 
> > Reported-by: Alistair Delva <adelva@google.com>
> > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Same patch as v1 but update documentation so it's clear it's not
> > enough to fix the crash.
> 
> Where are we with this patch?  There seems to still be some unresolved
> discussion about how we should actually handle this case.
> 
> Thanks.

Once discussion is resolved I'll post v3 with updated commit log.

