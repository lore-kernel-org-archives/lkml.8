Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E79F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgERMPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:15:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58858 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:15:29 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jaeg3-0002Sl-OE
        for linux-kernel@vger.kernel.org; Mon, 18 May 2020 12:15:27 +0000
Received: by mail-ej1-f71.google.com with SMTP id 7so5131930ejy.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSKPyI+z3/ghuKiiEStd7yz61AaHIt29YcTLEMnoHhI=;
        b=iimwJRkchuktEIHGHmNlFw+OBVKtGVkDGwJBpDN84TeyoU7yNIbHfdNtvrS9GfLaWH
         RHH/5LgUyvecq2D9S8w9erIsDU3cJ8ajvXeloq6FMGBd8jFXRzXFzJlDlo6D+7VBWaEI
         0UOZMYvpN5b/Dnvz/cUGOoB4jmafm2TwE9J1/nJubqMKSup/J/U2fXe/ehB2boBpaNM6
         Ylh/ROQSOFk0wT0sH44mept1RoB79YT3dgH1YMdGT37H50N2j7H0nZdHnX1YhY1H+7SV
         ffqzGWsx1t7jc8Ulw+BN9pfUo2hQMNbQ21U2gI6f+J/aNylQWRDA11J9aVfDkOgCO36r
         sjJA==
X-Gm-Message-State: AOAM531ZdPvXCwoRQnUrmbxjMplBrdVnSv7BgFL1tzxBMDDQRkmz3puY
        XNn9FOB3fsda0e2fdD5cgpJpqGYJS7BOjN1k6BBQK1muNbB8IbztpdalapB3sTHU8elkZXNeGDF
        wXgdMQswCtaMRCCHIv5hhdYbh1OpJ+ePdZfbJCXLhRq58PaFF10y7NwNd7A==
X-Received: by 2002:a17:906:6a43:: with SMTP id n3mr1847781ejs.33.1589804127431;
        Mon, 18 May 2020 05:15:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx92b8+cJv+vIkG6WlGqCQiI3XfGvfpzW4RZyHWBrMioHzcq9k6+bFhU+3dVoZWZJfIhb/0GfPnVM2t/ZkDik=
X-Received: by 2002:a17:906:6a43:: with SMTP id n3mr1847757ejs.33.1589804127148;
 Mon, 18 May 2020 05:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
 <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
 <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com> <6bf5e178-f2c8-f453-9035-93e31995bb53@sony.com>
In-Reply-To: <6bf5e178-f2c8-f453-9035-93e31995bb53@sony.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 18 May 2020 09:14:51 -0300
Message-ID: <CAHD1Q_yk4GhUgTMc5KcvpaW-oMNEfvSj7vxOCOQGALs4qe8VUQ@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, thanks for the feedback. What do you mean by "trace
notification" ? We seem to have a trace event in that function you
mentioned. Also, accounting for that function is enough to
differentiate when the compaction is triggered by the kernel itself or
by the user (which is our use case here) ?

Cheers,


Guilherme
