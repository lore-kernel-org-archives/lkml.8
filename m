Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4EBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBDD20878
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAjphygu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgEYO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:28:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390879AbgEYO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590416891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZaEIUSBX9tpbhuTtXwt0hPkJYnX8LPVpuC0gCRduKRM=;
        b=TAjphygu3iA4QXwEqmcVdAvkaMtxKjBCasWNZmvtaxkCDxjcWFQ7RHfwNn+UxtTa12QlyI
        jonP9GKchSPd1AlxH4j2xMFigXvTc1f/RT1nsSNdXviNjSkBdJqr8Bq0WOu9eQct+3vpNF
        2e+NeaEBD0m4Od3Auwda8R3MPg/9cvY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-WaWKYkqiOLaACR2Gkrh6Qw-1; Mon, 25 May 2020 10:28:09 -0400
X-MC-Unique: WaWKYkqiOLaACR2Gkrh6Qw-1
Received: by mail-qk1-f197.google.com with SMTP id n22so2651735qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZaEIUSBX9tpbhuTtXwt0hPkJYnX8LPVpuC0gCRduKRM=;
        b=N7y+/dRUdLVOLH/Lr1EmsJS3132Gb6tk+NnP73FK/hROUVvdq+r1xElcjgC5rnajGe
         WJ8SPiXaTOGTNrRiAd8fdGZHhMdw5u4NF/zUi5kZj0cEpHgWwdsdZaV7XKc6NonTmVJf
         6bfoS8+6WBwy6xZaVZ5/LVti1XmQ+yYzFB2sfJ216EYN0Tgdwv8SEsbCIpLvZHTMu492
         TT+W0qM3+nh0dcNYnJowu43ZxSRNjurcctv0RKl1YcoUE6cJN+c3LFf0v9Hgtv2wwi1K
         P2xooXSHY4DVo/DXFHUuLr/Ti5m/YUosSsACdtv/pf64s/Yyfdfhlf7dqJym1CpmTtdh
         YbFQ==
X-Gm-Message-State: AOAM5311pBKPgUc1a5lcLgeO1cYY0joSmAKajVHBFSoHJ8fKP/4mRVWu
        7k42zl0VL5Q0inwCsZ69Z/wN0RZMRwbHr6RDcQlM7AgWo5QStWO3/GKhxpZTvb9M/4ZZypHwj9q
        V1hhHRnB8eYJ+Ehy+t9j0AeO9
X-Received: by 2002:ad4:4e6f:: with SMTP id ec15mr16255160qvb.88.1590416889390;
        Mon, 25 May 2020 07:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjb9M4FkYI0U4ICscrcqcpLddToI8iQZDPwlZmFCKNG2Yq4ppAaEqVT0efADo9YCNE/szg8g==
X-Received: by 2002:ad4:4e6f:: with SMTP id ec15mr16255137qvb.88.1590416889166;
        Mon, 25 May 2020 07:28:09 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h3sm13643021qkl.28.2020.05.25.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:28:08 -0700 (PDT)
Date:   Mon, 25 May 2020 10:28:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com, cai@lca.pw
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200525142806.GC1058657@xz-x1>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
 <159017506369.18853.17306023099999811263.stgit@gimli.home>
 <20200523193417.GI766834@xz-x1>
 <20200523170602.5eb09a66@x1.home>
 <20200523235257.GC939059@xz-x1>
 <20200525122607.GC744@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525122607.GC744@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 09:26:07AM -0300, Jason Gunthorpe wrote:
> On Sat, May 23, 2020 at 07:52:57PM -0400, Peter Xu wrote:
> 
> > For what I understand now, IMHO we should still need all those handlings of
> > FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
> > try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
> > not sure what would be the side effect of that if fault() blocked it.  E.g.,
> > the caller could be in an atomic context.
> 
> AFAICT FAULT_FLAG_RETRY_NOWAIT only impacts what happens when
> VM_FAULT_RETRY is returned, which this doesn't do?

Yes, that's why I think we should still properly return VM_FAULT_RETRY if
needed..  because IMHO it is still possible that the caller calls with
FAULT_FLAG_RETRY_NOWAIT.

My understanding is that FAULT_FLAG_RETRY_NOWAIT majorly means:

  - We cannot release the mmap_sem, and,
  - We cannot sleep

But we're allowed to return VM_FAULT_RETRY if any of the above is necessary.

Thanks,

-- 
Peter Xu

