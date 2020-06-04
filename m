Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE911C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E620206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzW8aWNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgFDJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:01:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbgFDJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591261282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xh5Mj8Dm7pwISvlFLqL8NiYNfeUBsG7hGmY7DgnArSI=;
        b=MzW8aWNvtRMx1zRjcU68n88TwmgOSfyxL88xjIZTDWhIe+RUkfHrbc5jk2Dcq9tnhN17aI
        LGGkwGUGJn+MZ8UGwrDRoPJbA7SogvAlLUaB48U0OTUa85XiySe9SFbNVjRapX2kns28v5
        eWcen3QUOAA4yf1h4Jo4rJXVibiuCbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-_mBvH6GbMOWFVvC-s_Gr1Q-1; Thu, 04 Jun 2020 05:01:20 -0400
X-MC-Unique: _mBvH6GbMOWFVvC-s_Gr1Q-1
Received: by mail-wm1-f70.google.com with SMTP id u11so1746553wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 02:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xh5Mj8Dm7pwISvlFLqL8NiYNfeUBsG7hGmY7DgnArSI=;
        b=ZeWX0TCWD0x7PnUhXDCHBfFbUyOxcfPlHJ0h1ZnaALKZCZ28Tg5cUT/kA96Dy96824
         /Ew3F29B7wZYXwF6pQG94XSvXeKt94Aujw68ESimhDLCbvElqjGQEBWYG/kH0zAbE/Ba
         NSOodTXxMmWA2j4+YRe/5F1uAberAFeu0JSbeDQAh/KstFvhhbeQU2NNW5toH9ZTbSdD
         T5ILQdAjoM9rbOeWyHE0T3vnMbAA0Yl90Z919p6r8Bxl257n8iB31GUlh396fKR0HOva
         1k5GwQ9XfGla7oWnIXt1O9crMb73e2zoLTw/ClYToCe8gzojcnJe2yOvI/2ZrHjBnDH5
         Vh/g==
X-Gm-Message-State: AOAM5327bAbTeoadfElwdQy72aT7tJRyOQWwVnOj8qZpQaPhR5FFH4UQ
        tYETliCEuECpkCh7p+0yLLL1xGoQU6wNqSq+WP5ki4hnOojxJNYxepTXMBq1zG3wKIoG+7c6okc
        eLGSG6U/Gf2Xqtl2vZyUN9rSp
X-Received: by 2002:adf:ea03:: with SMTP id q3mr3291695wrm.286.1591261279728;
        Thu, 04 Jun 2020 02:01:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/zGaMBjx21Z9cwBMj+pCZMs7uKzsNY9xUq1Big6tLAZfVUSVRfMUci1KnmD6zuRYgAJmYOQ==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr3291669wrm.286.1591261279537;
        Thu, 04 Jun 2020 02:01:19 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
        by smtp.gmail.com with ESMTPSA id d18sm6904921wrn.34.2020.06.04.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 02:01:18 -0700 (PDT)
Date:   Thu, 4 Jun 2020 05:01:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC 04/13] vhost: cleanup fetch_buf return code handling
Message-ID: <20200604050011-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-5-mst@redhat.com>
 <7221afa5-bafd-f19b-9cfd-cc51a8d3b321@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7221afa5-bafd-f19b-9cfd-cc51a8d3b321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:29:02PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > Return code of fetch_buf is confusing, so callers resort to
> > tricks to get to sane values. Let's switch to something standard:
> > 0 empty, >0 non-empty, <0 error.
> > 
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > ---
> >   drivers/vhost/vhost.c | 24 ++++++++++++++++--------
> >   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> 
> Why not squashing this into patch 2 or 3?
> 
> Thanks

It makes the tricky patches smaller. I'll consider it,
for now this split is also because patches 1-3 have
already been tested.

-- 
MST

