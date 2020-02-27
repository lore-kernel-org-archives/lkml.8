Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DDC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947DC24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNTDcgai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgB0NjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:39:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46140 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgB0NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:39:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id i14so2219665qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vb7D/cjd/9YIQ7Jlnb2gMsNd7Bubxkbt9Epw1wFmkzI=;
        b=mNTDcgaiXzvGRQfXcoCJ+JPLWUcOO6QnrlpHhAbwxFedhE8ZmydHeIRzGz0TwG52Pv
         NTnIBKlCAghnYk9umji2p1kZwz9f2HAq3Joz9IDcCbvdxgtL+uSUTH/4umZp/PnTyVrN
         Q9pkN0Y8SvutlNC0sUlcEg6fKtCAuo7sfMC5rmtONqIW3wPbwlCfZ47917q2Cgy1xe9M
         3vpbryDOvLfUNxfKIwCvxI7yPVx49QK/vcUUVbodLaKpWlDUK/TljhS+O/vpGnwhR2eH
         /YDNUHD5jf8mtGOfjOXiLLelqEHlI5DEsFJEmmK41urdfDgRnS+BN/ax0CPMNit80vC/
         x1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vb7D/cjd/9YIQ7Jlnb2gMsNd7Bubxkbt9Epw1wFmkzI=;
        b=IBreMpS6RgjeLHlzY6eKYv8wWO3pB8NzNlSSBztgjT5c2CuHKjZljtTB2IWYqpcqW+
         tHqwKjgV4y2ahCbYxpwX9ogcTyOrARgze+kyYPwt+Ur883zK71Qd4BbLC+urQawbE8W9
         3NHl+xiuHeCxY9co/bgDZG9yILiZkFSSGtH4OtS322YOnGAnewShV2q9d5gj4fNN9omy
         Lx0pXyucIB30DyosA37t9b1gu/5IOs9yLKyyywJ0YNv7qEtXlQkKNGz4ldKjoCea2jBz
         t4uuHG5syBk8HWIqknaENGwPGzs9NRvwcawHjyo7Bfzh/6jHP/Zlwpp8TIRf3I6lMr04
         qktQ==
X-Gm-Message-State: APjAAAWukhETlHruIq9jEP/8rJu9DRzPkk2wRA8EcTD1EauO0WMSuSa8
        Sdf71PP4ixermNX8wuIh9Fg=
X-Google-Smtp-Source: APXvYqxu/QHy/RdH++OgLABJnLzSUcE2QyXaBEZmwiKaO06LCDjLXdP7+/MGw2qQ1LA4O1qDUcZYvA==
X-Received: by 2002:ac8:4244:: with SMTP id r4mr4856648qtm.169.1582810749185;
        Thu, 27 Feb 2020 05:39:09 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p18sm3081259qkp.47.2020.02.27.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:39:08 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8C68A403AD; Thu, 27 Feb 2020 10:39:06 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:39:06 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, xieyisheng1@huawei.com,
        alexey.budankov@linux.intel.com, treeze.taeung@gmail.com,
        adrian.hunter@intel.com, tmricht@linux.ibm.com,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] perf annotate/config: More fixes
Message-ID: <20200227133906.GE9899@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 13, 2020 at 12:12:58PM +0530, Ravi Bangoria escreveu:
> These are the additional set of fixes on top of previous series:
> http://lore.kernel.org/r/20200204045233.474937-1-ravi.bangoria@linux.ibm.com

All applied to perf/urgent, thanks a lot!

- Arnaldo
 
> Note for the last patch:
> I couldn't understand what intel-pt.cache-divisor is really used for.
> Adrian, can you please help.
> 
> Ravi Bangoria (8):
>   perf annotate/tui: Re-render title bar after switching back from
>     script browser
>   perf annotate: Fix --show-total-period for tui/stdio2
>   perf annotate: Fix --show-nr-samples for tui/stdio2
>   perf config: Introduce perf_config_u8()
>   perf annotate: Make perf config effective
>   perf annotate: Prefer cmdline option over default config
>   perf annotate: Fix perf config option description
>   perf config: Document missing config options
> 
>  tools/perf/Documentation/perf-config.txt | 74 +++++++++++++++++++-
>  tools/perf/builtin-annotate.c            |  4 +-
>  tools/perf/builtin-report.c              |  2 +-
>  tools/perf/builtin-top.c                 |  2 +-
>  tools/perf/ui/browsers/annotate.c        | 19 +++--
>  tools/perf/util/annotate.c               | 89 +++++++++---------------
>  tools/perf/util/annotate.h               |  6 +-
>  tools/perf/util/config.c                 | 12 ++++
>  tools/perf/util/config.h                 |  1 +
>  9 files changed, 134 insertions(+), 75 deletions(-)
> 
> -- 
> 2.24.1
> 

-- 

- Arnaldo
