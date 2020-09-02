Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBB7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E7206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599014642;
	bh=GwS5hgbpilzz93f4cVCaZ/bbS6pjbRN50Cm/qLyYzIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Slw6GaqCWWGIqPJoIcbjRVvIZpQ2aq/V12v9IwVPfdF4Ok5i9cqv5fVabeFYZrtaB
	 E69jFpzN+YiidPnQWziQ4dQRPHB5SnnjStTpd8CBGI5/q1AhVOgP4k8n7/pfNPLaT9
	 3cPNXOU3Yk80yZbW17+wmKxusCE1+EGyNMO6qy0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBCoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIBCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:43:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0DC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:43:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so4024015ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJ4PjoZDwwfzg0Z/mADsWEXL5wj1Bc8Q7ntv5NFy29c=;
        b=G0Mo+VnwcXQu6DapPma+6KQV000biK2/pSEruCHZIfIsOaAgQvAECKM/J/+kV79Fi0
         tJ8wEnuV4Mk3d8+jGGy441CKQsxVwsZE462jR3HGZf5gunOI6s04Bt7SsitS7Zf3FXpn
         qdTqWBtthFAPcviuc0XwhkcjIslrp8yFn7hq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJ4PjoZDwwfzg0Z/mADsWEXL5wj1Bc8Q7ntv5NFy29c=;
        b=CHNBYm6T5niEL2skHRWMwG29g9y9K1fkan0S9s3ZTNPwPLaMoO/Sgd5ddoLaDotu8S
         vbqzdj9MzHetPxhsNyMSAfEdv0K9lG29Rp1az2WIRiUO4A4sBUyGOYU5bxHVDiyuDWUs
         UVjOat2yOBHhhh15T1LWAmdbzfsMIQsIR+ESMMImFmI5l25FJhDT+9YA4ytTKcUSeELe
         O0ore0Yn5zo8hys6oSSqc52AmNfCTWnO3yawgNTcALTFcEI82r3FnC91pS4A9LelW4fC
         F7SJwVTHjh6dXBGL8qTRZdzawUcLSAFb5EBbBkSiKkrVwNGECWACz+Ww5GwZAUXtyBOQ
         p36Q==
X-Gm-Message-State: AOAM530MOhD5yURfRHTH2YQN2Y0lCLBAUVbmKN36fJ6Ds3SeoW2IrAHm
        DtP0hZNA9N++MYI/r3neQr0BgFI4NS62ew==
X-Google-Smtp-Source: ABdhPJy/+1jDvZHHVFsJwJDXX6UosNgq/r5dOhWuXgEBDjHfuLBKyOqXTiYN1dh1Ur2VDZIZD9tcIg==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr2176654ljh.88.1599014631819;
        Tue, 01 Sep 2020 19:43:51 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b13sm713085lff.91.2020.09.01.19.43.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 19:43:50 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e11so4008747ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:43:50 -0700 (PDT)
X-Received: by 2002:a05:651c:219:: with SMTP id y25mr2006023ljn.314.1599014629844;
 Tue, 01 Sep 2020 19:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200901224154.3436175-1-acme@kernel.org>
In-Reply-To: <20200901224154.3436175-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Sep 2020 19:43:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
Message-ID: <CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.9
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Al Grant <al.grant@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Like Xu <like.xu@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 3:42 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> - The SNOOPX and REMOTE offsets in the data_src bitmask in perf records were
>   were both 37, SNOOPX is 38, fix it.

The kernel uapi side thinks it's 37. What's up?

  $ git grep PERF_MEM_SNOOPX_SHIFT

results in

  include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT   37
  tools/include/uapi/linux/perf_event.h:#define PERF_MEM_SNOOPX_SHIFT     38

Hmm?

                   Linus
