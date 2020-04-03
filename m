Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415E1206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585935964;
	bh=ZRI7NC/u/UbhnTqyAWMZAmd2wwvo9p8ToYmi3Jc1+8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZgnTRMGYv9TdOiwS1CDEQ1Aqsm089Ta+caCpKavao2anzeIA+O+AIOFzeQKW8yQF5
	 GMGtKqRUrUo6zHMBY6ASRyoRaNNDcmP84cEZSuAZDqX5imfziQLhDSBJGV5OJnUe+j
	 mHgjAeeD0WacCM2PPIrDR3ig6RNRfGxze1yCxR9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404462AbgDCRqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:46:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37091 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404405AbgDCRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:46:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so7829588ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtZk7RTzsQbxV6Wu8be+P9MfgmzeSaSXGSifFFHT7Ng=;
        b=QXLKYEtYIcLWDBH3cTJPT0v99KbYuJ9xLQHPResFlaWKrcu75rRr4FvRPNL4p8q/fP
         dLF6Iwwxq21VvnO/TpA/m/+JYbQc8NNTe4HDyLViiRTog6pfV11mOAWEjYZSRGFeXl+C
         ZJAGE7ACiDjGjSrR0B7X3aDBCrwDDtwh3idLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtZk7RTzsQbxV6Wu8be+P9MfgmzeSaSXGSifFFHT7Ng=;
        b=oifJinScj9asl48tOEduSQ2KCuBceU/SdrSsPOtEyN+GcZ561zEXzDTVAspKBjQ2Qj
         TOdpRdBXmTWuj9Q/gnGgTajXeNJgINjGfiwnzIbUfeKZRup9l8x9FGtJ9zZzJptHlVXd
         qzEXZnAXVdYaTur0p1bMeDwKQcepp0On77scnGs/Y2RpvXAWYDkQaTwLpIkEXrxelHpk
         Fp4uiAh5o34Syb36lCySqXIhBZVOdeLYLm0+ETkfKQ/KZxg0cyH6/6OXqvhpx+ZcZ9YJ
         f+UKD45d2BxuebjxnCVu+X38LXYW2gGp4h8Zgell4yJakT9GcwAip4MG60kP4fJ/xUll
         AXtQ==
X-Gm-Message-State: AGi0PuYeimD8UkydlvpL7QR9zcE5wv9vP/Rco092rugngvFno3uGpqiQ
        E47RZIsq3njIDeDV3MuqGvZpuZoYBtA=
X-Google-Smtp-Source: APiQypJriD+NZTC+kVzcpw6gZxQ6FDeUJ9QNOLR2dnQHNZbdVByRDXaRZuOh7ARMwQ8Ai7thyVWJqQ==
X-Received: by 2002:a2e:2415:: with SMTP id k21mr5380876ljk.93.1585935960358;
        Fri, 03 Apr 2020 10:46:00 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x11sm5189172ljm.7.2020.04.03.10.45.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:45:59 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t11so6510931lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:45:59 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr2584555lfd.10.1585935958834;
 Fri, 03 Apr 2020 10:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200403141950.9359-1-peter.ujfalusi@ti.com>
In-Reply-To: <20200403141950.9359-1-peter.ujfalusi@ti.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 10:45:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-1gB1e1togBo0TJ3QghHvxZhJ9fX069X2+D+N9xhNyQ@mail.gmail.com>
Message-ID: <CAHk-=wi-1gB1e1togBo0TJ3QghHvxZhJ9fX069X2+D+N9xhNyQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Drop COMPILE_TEST for the drivers
 for now
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 7:19 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Remove the COMPILE_TEST until it is actually possible to compile test the
> drivers.

Ack, of course. Thanks,

              Linus
