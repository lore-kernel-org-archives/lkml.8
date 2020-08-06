Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B414F23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596732413;
	bh=RmU84MfkGHCfDSr5Ddisfdhf4lUVK/sae05WyQevLiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CY6Uzt6bK/JlU0aaBg41xgpuqB2iQSlbMp8l+lYLSseWUS1e1bmarRZQY+kXi5Nbl
	 q4QXyhEgl2lGOawKMhK+3mYj92j0ojSDdk2DV/Tv4PJxOIY9zWPt8mSb7mBxeo6ew/
	 4Mwgn1RsHoh6VtAP9z3ZMrD20kPkDfz0DNwyNbhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgHFQqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgHFQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:46:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18436C0A3BD0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:46:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so18669904edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QsNBwltu4WCsj38Xalccv0qu1X0Ecq7EBsM66qfS2Fo=;
        b=NllFFWmZdewm22bxmil943cZsc0Ms8eIcyJaf1+t8B5AFEXD64zF6n+WK0ruPdOmeC
         qpgBhrtnEiTcfU1pf5jDVS/T6xvhP0q+kUTyO9XXdRrAf48iHgvI7zXASofKoOgYRHRr
         Pk3AysyB9FhRQzDuBSGdIa+JHJx3MQmAy7zO0S/j/fLv1oQWeOFiMVFasyHe9IPNf1dA
         98C7ojlBSNz4krok07DZGrzeU0JKZe4ZU9ezi+N+qfEHb55MQuD/pvf2xyHD8fJgPIVQ
         DNW0ItYUmKWwLtRK3ezrvt7zyK6U4Hl1lwsQsBZUC9IlNmVbu5agikFx7LxW42aOtAj1
         HMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QsNBwltu4WCsj38Xalccv0qu1X0Ecq7EBsM66qfS2Fo=;
        b=leqzZvCpt6/EB1iZqCqYXhQPWQmyjzp+5SX3Gu/wE07oAuZRn3RxOw79zAlumm23T2
         RSoC+q4AthmlIrIoy7OlZBI/br/yqKBHpw02gFgKyYSbb7nXtx5Mbm+lKC5vp4ZlbUXU
         mxAVJegSHjpsy5tORT7tHwK7wEGLLmhZvR1+egqBe31iZS7BuKDNk3UmTRKpxr/Jk4sO
         5JgT5bJkaIU4+kKkD4camy+byKVxhGkJIvZJXCJ+x8pvM2QDDDkdfMzOmnmoDTZXZAOY
         +38X1Cf7oVSK7TxejZJNEPCPYXlx2psz9naXJ4c63HHa2F80aJ7hxICepzdw+Whm9ZIG
         ekNw==
X-Gm-Message-State: AOAM531RwbeKw+Uj3F/UpST/FKV2gv4n2YxR/SPKRCkcBGJ1TWCj9Ll/
        g4uB0c1gX/JQifCZfvFufvDq0qq9
X-Google-Smtp-Source: ABdhPJwb21jeFeQeH1rr3qUMUP48BVqDxZYmx4W8+Yk2KWdSCW5iPrNhanaxKMxeQIBzRAtNQNYw7A==
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr4903530edt.270.1596732390838;
        Thu, 06 Aug 2020 09:46:30 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x96sm3781486ede.17.2020.08.06.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:46:30 -0700 (PDT)
Date:   Thu, 6 Aug 2020 18:46:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 03/10] sched/topology: Propagate SD_ASYM_CPUCAPACITY
 upwards
Message-ID: <20200806164628.GA2137558@gmail.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
 <20200731115502.12954-4-valentin.schneider@arm.com>
 <20200806142025.GD2077896@gmail.com>
 <jhj5z9viw6p.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5z9viw6p.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> This does sound sensible; I can shuffle this around for v5.

Thanks!

> FWIW the reason I had this very patch before the instrumentation is that
> IMO it really wants to be propagated and could thus directly be tagged with
> SDF_SHARED_PARENT when the instrumentation hits. It's a minor thing, but
> having it after the instrumentation means that I'll first have to tag it
> without any hierarchical metaflag, and then tag it with SDF_SHARED_PARENT
> in the propagation fix.
> 
> If that sounds fine by you, I'll do just that.

Sounds good to me!

	Ingo
