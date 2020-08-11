Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C382F20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VsIA4Kay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgHKRjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHKRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:39:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16291C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:39:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so10040444qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OVg/uR4zVLWcjVjrKs8tsHBHX3XbUVD7Z/QCkQo4KAY=;
        b=VsIA4KayqpDCO4zO8hV186Ei0lW9axCsLY4540Pt2e8yWuwsn+PvE0XTzumKI04jrB
         mxOzFXs0u9pnALo/Q0Y/He2KiRBkocmq6KWVWvAVadP8rOPYXYADrncmORfIe5wfWjgf
         fO8DcKvbL/UFWPkFdKmZ8fJhDV/iLFtG2QYvscbGOxcpBMNmNZAzf9HXjlJduv3lrwuo
         RMdGr5Jidk7yC/xz8+RjlTrF+MhqgHxB7q5UuAoO1d/B867DPuNmAYGqvMJpVUgjHsUj
         vT1cor6vNEMRe64t1hvWI/ZkvukoBFDg5AX1V+166j6gMivMCnanqJo3amMzi0NQFrip
         /yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OVg/uR4zVLWcjVjrKs8tsHBHX3XbUVD7Z/QCkQo4KAY=;
        b=f1w7/HK5lqSit9Iy4xHVqj1Hd3pDOwWj/LwWvMT0+i5KBWE2JoeUlvIwkmThYAfVsq
         WQD1xl3QD6DTkLs091HQxP9eRFclG6MhupFCh6xbHIEMrnCelT2beY2LHFpV+P541BnE
         y2J0U9Rfcbz+WV6CSfQLo9eMeUPswwcOVEZDqO3XCZtgVvZatg78kEWV0KiTsJ912xWd
         TwY4aiZ7m77IlcDYwXABKtHM+MspqrclocQ670DBLEbM+bSJGVWS2dSglOtMR/upIyjx
         w6uxQT82Lyj/NTCMeg3yph9E7E3YFHro0x5byHpxIOM+zr7KauUEb9zVoTLp9PoNsYmq
         OtbA==
X-Gm-Message-State: AOAM530daRMokaNH4obkATMqtZ5a/LR73yiKX2froUHU/VgZq1/HIkTJ
        hwOe3fHt3RSbFzdRd4Fw6SjDfA==
X-Google-Smtp-Source: ABdhPJxmp4TEraUOEtTLPhbxUVypZUS+nMNnOJoCJWj78764FbQrM0WK855eaX45+PKvfLc1BCGgWw==
X-Received: by 2002:ac8:5505:: with SMTP id j5mr2271212qtq.326.1597167571270;
        Tue, 11 Aug 2020 10:39:31 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j15sm17333817qkl.63.2020.08.11.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 10:39:30 -0700 (PDT)
Date:   Tue, 11 Aug 2020 13:39:24 -0400
From:   Qian Cai <cai@lca.pw>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Message-ID: <20200811173923.GA39857@lca.pw>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200810152254.GC5307@lca.pw>
 <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 03:11:40AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> I'm still not sure why the test succeeded by reverting these because
> current mainline kernel provides similar mechanism to prevent reuse of
> soft offlined page. So this success seems to me something suspicious.
> 
> To investigate more, I want to have additional info about the page states
> of the relevant pages after soft offlining.  Could you collect it by the
> following steps?
> 
>   - modify random.c not to run hotplug_memory() in migrate_huge_hotplug_memory(),
>   - compile it and run "./random 1" once,
>   - to collect page state with hwpoisoned pages, run "./page-types -Nlr -b hwpoison",
>     where page-types is available under tools/vm in kernel source tree.
>   - choose a few pfns of soft offlined pages from kernel message
>     "Soft offlining pfn ...", and run "./page-types -Nlr -a <pfn>".

# ./page-types -Nlr -b hwpoison
offset	len	flags
99a000	1	__________B________X_______________________
99c000	1	__________B________X_______________________
99e000	1	__________B________X_______________________
9a0000	1	__________B________X_______________________
ba6000	1	__________B________X_______________________
baa000	1	__________B________X_______________________

Every single one of pfns was like this,

# ./page-types -Nlr -a 0x99a000
offset	len	flags
99a000	1	__________B________X_______________________

# ./page-types -Nlr -a 0x99e000
offset	len	flags
99e000	1	__________B________X_______________________

# ./page-types -Nlr -a 0x99c000
offset	len	flags
99c000	1	__________B________X_______________________
