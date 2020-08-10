Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8DD206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp2Cfw0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgHJMv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:51:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55085 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHJMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597063881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbCRipNDdE2rdGG8Ew5oYAs5hi/QBu0fk1zdZZ69+Ag=;
        b=Jp2Cfw0zfjpG0fmiiScJfPPFtBAM9L1uaBn8bO+zSVZUKFFJN2oZKOpcNOrXYp0r6s+o2H
        eIRw1Uob8hSaUVsykwULMK37xKOIJDhm3a95KKOh2ZZtFlEHxGCRsgLNl0ph0j9Q3awmn/
        mMz3cpRvUxp4vIA4lX9azXA1lxxpApo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-QJdtFYdrPnyiGL8lmk8mAg-1; Mon, 10 Aug 2020 08:51:19 -0400
X-MC-Unique: QJdtFYdrPnyiGL8lmk8mAg-1
Received: by mail-wm1-f69.google.com with SMTP id s4so2752530wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbCRipNDdE2rdGG8Ew5oYAs5hi/QBu0fk1zdZZ69+Ag=;
        b=k1Z0OmXmjGoY2kU0R88yKXs40EP909OYKykuAKPI0q30evcLAZ7fapgT42yvXsS01v
         HqeYuOkDdvbRT6rsXQz10XcBYGo11NHdOWe1Y1eqiMw7KLZen0Z5LDXiPOV9T0jzt2h0
         nV9Des9A7w1KuyP2GXYnZTABd9pt7YfvqkUXI5UUQ6DUdmRwv7w2TIudsISqi+Kp46kO
         Y63Nb82InkXYqZjADBzNxBTnYY+QEO3ZPSS7rSDXsDdhzLR+mvL04nBxns5FYC8eP3Rd
         bBOfBjuG2TC9nZuZd07dHNyeYDvYbYsn2FJUlwgaOTP9crkvLaXc3jf9VfDwf/En9GMy
         xOoA==
X-Gm-Message-State: AOAM532ayJatH8beilCnT7ElY65Pnac366NWdtGQczWVK7fNSrCp1VTc
        EiIf7w5jcKi0UU3jF+MpYvtntp5moxHhIDwuxTsA8s8KCk/Fo9SJcCDyQHDrG+di4Vp7GwHllsK
        aRQGi/QAMUbsTcByC8E9bmSph
X-Received: by 2002:a1c:660a:: with SMTP id a10mr23997547wmc.115.1597063878271;
        Mon, 10 Aug 2020 05:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzy3Dz3dF5JO2RN9WQmfJMP4NbRyiuZeMh6LVQ+I1mdOBPFJ/QmTu8RxjAG9ENsA2zx2Z1Uw==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr23997530wmc.115.1597063878140;
        Mon, 10 Aug 2020 05:51:18 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id g145sm29537435wmg.23.2020.08.10.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:51:17 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:51:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     Colin King <colin.king@canonical.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vdpa/mlx5: fix memory allocation failure checks
Message-ID: <20200810085100-mutt-send-email-mst@kernel.org>
References: <20200806160828.90463-1-colin.king@canonical.com>
 <20200809060347.GA48369@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809060347.GA48369@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 09:03:47AM +0300, Eli Cohen wrote:
> On Thu, Aug 06, 2020 at 05:08:28PM +0100, Colin King wrote:
> Acked by: Eli Cohen <eli@mellanox.com>

That should be Acked-by: (with a dash).

