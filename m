Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD61EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94452207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvMMb7oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGBMPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgGBMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:15:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:15:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so26516221wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EzM/pb7gYv8JvwioLPo9DRc3FyjfyEr1KmO2usfe+U0=;
        b=FvMMb7oj/EGRfkF7U6wpJUgN4/CkcNrdQp+se1jqhbGt2jttt1w494rHwRm4E+iRMb
         OrpeWfeon3h08SheN7IfgfJu+GcFgeXRJhh3GjL4JF1cIQgb/TH8tc0HEAeq4CmBom3Z
         JSVL9QrK+jtiza1dOMb9c+jt2jMPNgpUa0/Mm0FDvp28V9mqnvOT2XvY4eIQvmkWpoHi
         F+SVxxyId9CGIZLnPGS8MiVLoNXs//sV3N2GOQgGoxLpVndbo+SqJOGlREwM2ZVTA5uE
         3Gu37Lh4ZlQUENahYn4sDTzijx7vV/z/igLmfTusiLgS0wPPspFlS87ZlSrIVjFDzAJ6
         ZsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzM/pb7gYv8JvwioLPo9DRc3FyjfyEr1KmO2usfe+U0=;
        b=dzID5G0eGoB8Bg5iHhBUSmMgZcYYvJyMVTk7MPiN4GQqfovN0/0EUU7IdSeJEE469Y
         R4EZILM3Uv+2VewSyG+LfhrLjGL8+iTgqSza4ZZPxwwBh0SHPoUt7jgCeTRWMB3llh2J
         qk8D0g1GiIvI7CzKU3iurYNTB8mvQCeZyP1j3fH2EhHEODkeG096i1XuaOU95YXit9C8
         0fueW0KfR9O6m0U66Em6OcxhtTaUWV6QnVOGvKVYATAI7ZhMgmZCcQMMWNp9Gbru18Fz
         RVuz1uw2fP2+q8FLPub9lsrymMF3oh5ChnTihi1kfwJa43vXcQVvNuFoCZq29fZVBgab
         ikjA==
X-Gm-Message-State: AOAM531/t6Eb25gDTuMWAsemqwYyt/TgC+bjvkKqrbcfe/lz9joi3eYV
        UyD87EMfh5qqm1KCV1RLLjyInA==
X-Google-Smtp-Source: ABdhPJxCEaPCchosYIYyndtMcmOOVKlrSf6z8wKYgWcXUp/SxUdqtyocGgoJFkD+/KuXWCr18r71CQ==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr30186720wmg.44.1593692141215;
        Thu, 02 Jul 2020 05:15:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id s203sm1352965wms.32.2020.07.02.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:15:40 -0700 (PDT)
Date:   Thu, 2 Jul 2020 13:15:36 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain
 flag metadata
Message-ID: <20200702121536.GA765585@google.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701190656.10126-3-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Valentin,

On Wednesday 01 Jul 2020 at 20:06:50 (+0100), Valentin Schneider wrote:
> +/*
> + * Domain members have different CPU capacities
> + *
> + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> + * asymmetry is detected.
> + */
> +SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT)

Probably not a huge deal, but I don't think this is _exactly_ how
SD_ASYM_CPUCAPACITY was defined originally, nor how the topology
detection code deals with it (IIRC).

That is, IIRC Morten defined SD_ASYM_CPUCAPACITY as the _lowest_ domain
at which all CPU capacities are visible. On all real systems I can think
of, this domain also happens to be the topmost domain, so that might not
be a huge deal and we can probably change that definition to the one you
suggest. But we should perhaps make the matching changes to
asym_cpu_capacity_level()/build_sched_domains() if we're going down that
path?

Thanks,
Quentin
