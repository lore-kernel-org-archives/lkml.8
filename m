Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F211C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4F5206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PY4jtJv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHEX4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHEX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:56:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9AEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:56:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so35349368ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L1l6436aYpzWmrXvSmicrdb7epr4eUoEZtwL5qTMbc=;
        b=PY4jtJv48cbn7DsYkDpowqMyWGwFZNmYSI37uoIov7GmENsPowfK1HejrlCLoeE+p9
         Yup8G6bug4+oQECbftI/oC6vPTGOB1FSK11/OAZ7jOxp5UEvgfx0VlABNsakgf3OATXq
         DW8F2BUWqGeLc3KMCJge/SRcP+SPMpqoZj6RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L1l6436aYpzWmrXvSmicrdb7epr4eUoEZtwL5qTMbc=;
        b=sRs8P1hr2MXZ/4oxb7Ity3jfCeAoTPrFlczAmPjYzbqPzAuZ3Xxg9Y7l6+BAst/oVa
         99UHqG2X9fp2+oBq7itAnbXYZP+dI3SXVv0rwbqe9ClZ+RSJlCC9gJp63ySykXTc+Gst
         nzqrjF1gAbSHym6c4QLmFbJE90Yz7pKI4FpJWp5NDJmZBSTQyeqG+SoOT+QdTIG7fDTg
         3M6rq+58dQR1k8tmdJVxe3OFBWiej1JC+GlkZ1qSV4g+SNkf7geFg4oJfytw+dpTu2Qr
         O0pWcK4To9A5pE3Rwx5A76/c9z/Qn0WP2xq7R/H7dHvIBDxBJfKMrQD1HL/JKntQLKyz
         Oh2w==
X-Gm-Message-State: AOAM533ztgrAjUnEfTyZ1QRUv51Eq5RBQGnz4nUOYNTy7D0IQIrmcS5/
        a/8luoFLN+xJuyF3AFQmQJmO6qSlhUB7F5W6fI8=
X-Google-Smtp-Source: ABdhPJzxco3JCkUtOA/WJJ2a9bVvFYNfLw4v3RvRGR4WbPJD10tx7Y+ObqkZ3Yr7blJdKaXNMbRb5GVRNslEQ9IINlc=
X-Received: by 2002:a17:906:198e:: with SMTP id g14mr1727817ejd.266.1596671788734;
 Wed, 05 Aug 2020 16:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 5 Aug 2020 23:56:15 +0000
Message-ID: <CACPK8XdiSa6ry6WmxoELT-t8kHD2BgZQhiDcS4_dmGHQBLiBMA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fsi: Constify fsi_device_ids
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 at 23:27, Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> fsi_device_id is never modified (and it's a const pointer in the
> fsi_driver struct), so make the static variables const to allow the
> compiler to put them in read-only memory.

Thanks, I have applied these to the fsi next tree.

Cheers,

Joel

>
> Rikard Falkeborn (3):
>   fsi: master: Constify hub_master_ids
>   fsi: sbefifo: Constify sbefifo_ids
>   fsi: scom: Constify scom_ids
>
>  drivers/fsi/fsi-master-hub.c | 2 +-
>  drivers/fsi/fsi-sbefifo.c    | 2 +-
>  drivers/fsi/fsi-scom.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.28.0
>
