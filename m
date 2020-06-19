Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9867920A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVyekK6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbgFSOqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388831AbgFSOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:46:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C88C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:46:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so9102705qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+s6pkBRDM30YuGdJhldYKeWDIO48yG6flkbbQQFbzXo=;
        b=cVyekK6gNaex1l33w5CHjg7QMVi68Sw9rhx+fP+2dHuJ9VuuQAjQuvPC0embsAEdll
         pL39qxS6t4Z72V7EuzIFUxGRiUy0R9xd48CMucaUVTTfLG6KJuB1lp1lfDG99zhzwayW
         RiNI4sAMzD5UAnCVeEJWJkrrLXz2X5a1+EHq7MfcAf4QEvRW11cPPhA2vSJJXwgq8+AN
         wSG6JToEpWDGOJRIkVr0GSgtT9FzIJgJ3aJeeIbBu9wiiXvhrQHVX2R98vmzUHyZ8cjv
         lNeHlLryFxqhdOjBqQ+153TWRlnSTkOAXNDtxCU6bs6aX/NcBxp1dDa0Y7/0d+TcX9er
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+s6pkBRDM30YuGdJhldYKeWDIO48yG6flkbbQQFbzXo=;
        b=neBrbNm/WRBh1E00NRTKZLyxyCiIMQwCgZbRoCTqKB1VYL0ZX1p35qkbDT4QLvnNfy
         YfYCWqoaeGZphazEDBr5xACsHAy2YcfpwOthKH99wkFZj1esgh1rcsLrmsAaWF4XC3Oa
         pwml7IBlyhBf/oVJ5pJ9jPKnH1cbq9dkncJtq2GBjERo4Mw6HabZFfFdzd2wheWDnzo0
         vETR1+T178G3bfB4Erxy1qtle/ibDaRTZd9ps8sjVIk5AWFqsuGZ8BOUXImz6QcS1Exj
         4FVEgrtx8KsIZ1p1/oZxYQpPmhKTg7APEdLJmU8inz8zo2IV+rMkL/hTZmCZcoDoPDTS
         +hBA==
X-Gm-Message-State: AOAM533Q7A8/BOSx9WXSbwCug+P2/As8fTiBkpSs5b2Ne5ciCom4OVQE
        FoxQiy69G5e31xW5F5dnJ8WKrQ==
X-Google-Smtp-Source: ABdhPJygwoh996Fm9/gdg5XwxRwtTBWoa4pQqIYXEJJKN05JlUNfo4ySIZl5kXOYWSFVrRj4BFCHdg==
X-Received: by 2002:a05:620a:205e:: with SMTP id d30mr3855514qka.450.1592577979603;
        Fri, 19 Jun 2020 07:46:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 6sm6469489qkl.26.2020.06.19.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 07:46:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmIHa-00AoSr-JK; Fri, 19 Jun 2020 11:46:18 -0300
Date:   Fri, 19 Jun 2020 11:46:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bo YU <tsu.yubo@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        ledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/rtrs: fix potential resources leaks
Message-ID: <20200619144618.GO6578@ziepe.ca>
References: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
 <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:16:57PM +0200, Jinpu Wang wrote:
> Hi, Bo,
> On Fri, Jun 19, 2020 at 3:10 PM Bo YU <tsu.yubo@gmail.com> wrote:
> >
> > Dev is returned from allocation function kzalloc but it does not
> > free it in out_err path.
> If allocation failed, kzalloc return NULL, nothing to free.

You should re-organize this to not confuse coverity.

IS_ERR_OR_NULL should rarely be used and is the problem here

Jason
