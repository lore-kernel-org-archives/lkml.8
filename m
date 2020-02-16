Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACEBC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18A20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSbdy3sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBPHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:47:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38222 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBPHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:47:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so13193611oth.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t9s1T3eocQw5dgvxMojafgwpl5YoO6h8bjzIOUjQhy0=;
        b=nSbdy3samj8+Q2RYYBRWCqRbVnOhlmAZZ6uKOE0piU2F+J+fZInogaPDpv/bPEP+Rx
         enpcDPGp34/pDt/gCIMaw93qHfUVwMpyzZWK9IxerKmxbX3BpgJHTlZgIz8YyXgqxyEP
         MBy3BsVXjttnDwZut+ioMf5cii/6mPZmC4SXZt1me+crv+QLKExXgeBX0U/kqSeH9uwI
         Tb9HkLHr4WWlqCY3aoVDj3jN8Mt6jtr69MVVRLg4BY8L3N/Ri1CCo7uQ/Ut8k2gWsmQZ
         TROVQpamxHgNd0NrAPlnSA0p7kgk4I0i0vhQUWVws42L/JKqlUpKo11dNGcMjfrZs7R4
         v3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t9s1T3eocQw5dgvxMojafgwpl5YoO6h8bjzIOUjQhy0=;
        b=dflvjd3c9uPQaQGUsupAYAHWbWQ2yloDc1ArId60W2r1/S1ULBkK8/gIfn/mI3GQRV
         4O+t+PPJ2/1P1WVacV5FwdhbadKcj59XHZMIY3eoI2SAVvcfsLj9ptfF8hfwviOsDqHK
         q/zSdr27XoGMzl3dGthtqFYxUIXcAfX23+L5fm9/evjcm1MLBTHnFG6mDnNLqynaji0/
         /JiSrUViTb1l9ZM+Nl6W5frnefCef09Dd5vZB6wzstOXBQdw/+vGzflI8SVW+geGkAwt
         j6XnRpTr58CyHPyxp9R/rk3We5g/whxG5PwlpKsohOtqXbh99g8iCc/u7eeJmVk9talo
         j7GA==
X-Gm-Message-State: APjAAAWSQ3ssCoGgNZIibQXqMF/wIH1yk8RHW4TkFoeO9Bnw83zCjki7
        DC+FNmJ6e8Lawhoo9qTSRq8=
X-Google-Smtp-Source: APXvYqyGXk/eH31o+eRMhSWi4j55/TFMgC4INohI2TEWVKX6QqF4IaWaliKAoNttXJo4HRL6zUsCfg==
X-Received: by 2002:a9d:6d1a:: with SMTP id o26mr7860793otp.141.1581839257856;
        Sat, 15 Feb 2020 23:47:37 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id p184sm3601382oic.40.2020.02.15.23.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Feb 2020 23:47:37 -0800 (PST)
Date:   Sun, 16 Feb 2020 00:47:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Message-ID: <20200216074735.GA4717@ubuntu-m2-xlarge-x86>
References: <20200216004039.23464-1-natechancellor@gmail.com>
 <67FCAE69-05CF-4588-A7BC-664267D14BAF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67FCAE69-05CF-4588-A7BC-664267D14BAF@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 08:36:45AM +0100, David Hildenbrand wrote:
> 
> 
> > Am 16.02.2020 um 01:41 schrieb Nathan Chancellor <natechancellor@gmail.com>:
> > 
> > ﻿Clang warns when CONFIG_BALLOON_COMPACTION is unset:
> > 
> > ../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
> > 'out_del_vqs' [-Wunused-label]
> > out_del_vqs:
> > ^~~~~~~~~~~~
> > 1 warning generated.
> > 
> 
> Thanks, there is already „ [PATCH] virtio_balloon: Fix unused label warning“ from Boris on the list.
> 
> Cheers!
> 

Sorry for the noise, I thought I did a search for duplicate patches but
seems I missed it :/ I've commented on that patch.

Cheers,
Nathan
