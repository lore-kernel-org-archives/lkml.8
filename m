Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0BD22D00
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJSZquCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHFFxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:53:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726051AbgHFFxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596693194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0AG8W/Xs0dRN98tWfYfSB2XGEBT9FxGN8gSm2qY254=;
        b=fJSZquCOxOFKzkNh2x7kOF0rJB5tTrsnLAsR0MS33EU49omBMjxD0wq0lQ1wFGk+CRAre+
        wqZIpKTleMxHPQnkOe0n1xMklAEfFvCJHhsIjVq3rB6tuSQhtzd/Uq7hYpVk1w4YXSTzAj
        oM37i24buqvz+o5xUol1988Q+lU5H8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-PJDzE5tHOQavGq8vHvonSg-1; Thu, 06 Aug 2020 01:53:13 -0400
X-MC-Unique: PJDzE5tHOQavGq8vHvonSg-1
Received: by mail-wr1-f69.google.com with SMTP id s23so14142349wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g0AG8W/Xs0dRN98tWfYfSB2XGEBT9FxGN8gSm2qY254=;
        b=MhzLFKh3Np/L2P5mw8M5TX2niEJUCiJGYDGu+nix6CxeudQGR13E/KHp7EDOPg50aQ
         /zZMu5cMG8z+iVkfAo+ux1+hUGnRUkjjwfXjlWDjU2q0w4Y6PsiAEFz3nehlIJbLlSI0
         swRcvytwR9Q70dulhm33s0e/mUMvXdWMkWVoFVIbhRyb+l8XSyRG7yAULJO4r/WuDvoH
         LE2Z+o0BZxCacYGxTdwLMCxMwnk1jF63Wz0VHdWV1c46FXvDCZCycuT3mheW3T9tvGlk
         +JGDoan+R4w5B0bAgD8gqoR81aLvc5cOE7AkDAtnvuPAVP5E2IJkubTwsBnfMyPa/tTA
         UlKQ==
X-Gm-Message-State: AOAM532lG2oPzIP0t0gj6gzc8BmP++YJ6rD352227XLjfYDjJgdeiVkH
        vuK454ny5O3qPmNabj2vRozK8/j09AMNAhtZa9VqTC8nj8G14D9l0ZSpaxehqqouTCKrMxVDd8K
        4XG9vriHTQCqsuwo0f5ki7V3c
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr6718362wmk.17.1596693191726;
        Wed, 05 Aug 2020 22:53:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8a6tMavB7+5XSSwiab+2Y4P011aP3x8ME+5gxJCOmpF1HTdWOiE5IV+wyb5jc2wMEZEBy6w==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr6718355wmk.17.1596693191496;
        Wed, 05 Aug 2020 22:53:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id f15sm4931149wmj.39.2020.08.05.22.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:53:10 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:53:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200806015112-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:23:05AM +0800, Jason Wang wrote:
> 
> On 2020/8/5 下午7:40, Michael S. Tsirkin wrote:
> > On Wed, Aug 05, 2020 at 02:14:07PM +0800, Jason Wang wrote:
> > > On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
> > > > Some legacy guests just assume features are 0 after reset.
> > > > We detect that config space is accessed before features are
> > > > set and set features to 0 automatically.
> > > > Note: some legacy guests might not even access config space, if this is
> > > > reported in the field we might need to catch a kick to handle these.
> > > I wonder whether it's easier to just support modern device?
> > > 
> > > Thanks
> > Well hardware vendors are I think interested in supporting legacy
> > guests. Limiting vdpa to modern only would make it uncompetitive.
> 
> 
> My understanding is that, IOMMU_PLATFORM is mandatory for hardware vDPA to
> work.

Hmm I don't really see why. Assume host maps guest memory properly,
VM does not have an IOMMU, legacy guest can just work.

Care explaining what's wrong with this picture?


> So it can only work for modern device ...
> 
> Thanks
> 
> 
> > 
> > 
> > 

