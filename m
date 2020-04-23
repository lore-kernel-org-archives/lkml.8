Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB4BC55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7788A2074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq4jE7sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDWKO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:14:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgDWKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587636867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dGdN6Yb2PwPHUYiEBVCnUSoErNUv7Phunj1WBrbxxM=;
        b=Fq4jE7sk07N9fqNrzVbZ0JmwLz+Nli7RHR/AvC7ibr2QT3H1PRKe4++TAYm0WqO21T7ENY
        mM/Jx3FZk9BRjsfvmz8q0ddSh2zOPhHOT+zXtTalzyWE8JF/WufYisAFD3JbhvqFF3JJ3U
        P0JwkfKhXlIvwrZzS57dmDr6BTV0OuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-EdVpfdOpPo-EaMJ3-CdzTQ-1; Thu, 23 Apr 2020 06:14:23 -0400
X-MC-Unique: EdVpfdOpPo-EaMJ3-CdzTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E7480B709;
        Thu, 23 Apr 2020 10:14:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com [10.36.113.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 541F46109F;
        Thu, 23 Apr 2020 10:14:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 105171753B; Thu, 23 Apr 2020 12:14:20 +0200 (CEST)
Date:   Thu, 23 Apr 2020 12:14:20 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Message-ID: <20200423101420.ityynrorrehjvxrs@sirius.home.kraxel.org>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
 <20200422135215.GA25950@nuc8i5>
 <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
 <20200422152142.GA26943@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422152142.GA26943@nuc8i5>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I am a newbie, andy gave me some directions to submit the patch, eg: check
> ioremap leak. At this time, I found that the bochs driver may have similar
> problems, so I submitted this patch, then, Andy said the best is to switch
> this driver to use pcim _ * () functions and drop tons of legacy code.
> I think we might be able to fix this issue first, after that, drop tons
> of legacy code by pcim_*() functions. Can you give me some suggestions?
> thank you very much!

drm has drmm_* functions for that.  Daniel Vetter <daniel@ffwll.ch> has
a patch series pending switching lots of drivers over and IIRC it fixes
this bug too.

cheers,
  Gerd

