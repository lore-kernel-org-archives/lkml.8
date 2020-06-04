Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97660C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691862072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c95W5F7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgFDQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:47:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729856AbgFDQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591289258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Ar15+z0tlu8GE0Wg5KZSeq2GZEzeqWT+aUmm+wx7x4=;
        b=c95W5F7VEA/C633Hto+WBSZsYwLCINSQ5IWspfELy7vqfITu0rxIzrLl6JPCUmhl4QnaiV
        ft2fLhYpYhgdPHsI+E7hBRmr6rHEyOMjeMtZZNS2HW8mYEygGWg2IWve8rY1ZtYQ/7hvk8
        Jen92RRirT9qfIRZ01uB/ort2wSLfmI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-t4N_9AzwMvSWa7F-Ayy4VA-1; Thu, 04 Jun 2020 12:47:35 -0400
X-MC-Unique: t4N_9AzwMvSWa7F-Ayy4VA-1
Received: by mail-wr1-f71.google.com with SMTP id j16so2626016wre.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ar15+z0tlu8GE0Wg5KZSeq2GZEzeqWT+aUmm+wx7x4=;
        b=iGc8S2IaFUaA58zS/ZXioghPQMY3b93cTRVayey54RzwSOMTIiPLYt6VM0vWrqpqTC
         YgmrBOyQ8nnBfobs+Gy+qe8PAUuHyssPbUUwWT/zo2vn0fIj6x1gfFMogDQ9HgEFotyq
         KYCQJBKGdEkNe2r422I4Z9/CDxOi30lffLJDHgwMEhOCpOpftC5nMVf/g1Tb1ebHIpz3
         1L6Q600RZAVw8RuRDNzmiW6cDopSfTB0WfrbvCpqhafJpImYNRpmq14r7IhEYyc9E9C2
         kQP7ZaiJlRhJx8ozBh3rLSB84dfsHRHYA8Nzedrnb92Atcpzr8V4a7eDuTisnwd1+WFt
         SK7Q==
X-Gm-Message-State: AOAM532a/8XcQ0KIrq+eFxfukGtIrYGKPXjXhuYWXcUU1CV/DjGbebD9
        S23D/sgVwIYxIe2q9i5eWw3L98JhDn4bX2qABVU77ierYRMdseJavS/HPHrxfCvRr+nm5IRNByU
        H6CbPQZJjyz9UBaWsoLk55GrY
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr5209775wrq.218.1591289254184;
        Thu, 04 Jun 2020 09:47:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/oB1XkJnvn++j/58MNAY5P5qdvPGtsdrzBj0W/ri36XSP6zrbEREeugPFE4b1qeLilItQwQ==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr5209770wrq.218.1591289254041;
        Thu, 04 Jun 2020 09:47:34 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id v6sm118202wrf.61.2020.06.04.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:47:33 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:47:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200604124703-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
 <20200603011810-mutt-send-email-mst@kernel.org>
 <20200603165205.GU23230@ZenIV.linux.org.uk>
 <20200604054516-mutt-send-email-mst@kernel.org>
 <20200604150335.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604150335.GG23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:03:35PM +0100, Al Viro wrote:
> On Thu, Jun 04, 2020 at 06:10:23AM -0400, Michael S. Tsirkin wrote:
> 
> > 	stac()
> > 	for (i = 0; i < 64; ++i) {
> > 	 get_user(flags, desc[i].flags)
> unsafe_get_user(), please.
> > 	 smp_rmb()
> > 	 if (!(flags & VALID))
> > 		break;
> > 	 copy_from_user(&adesc[i], desc + i, sizeof adesc[i]);
> ... and that would raw_copy_from_user() (or unsafe_copy_from_user(),
> for wrapper that would take a label to bugger off to)
> > 	}
> > 	clac()

Absolutely, that's all just pseudo-code.

-- 
MST

