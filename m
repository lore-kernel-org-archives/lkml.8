Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3FE20786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596733531;
	bh=2OmgWgStj3tXx7fhEIWzRGEAomp6KIiE1SwRNcmeMFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B87c3jo2xmhJDVfZTE94n6oejJvljhSXpKW4knK22cooinCheaG05ehbZNTAncvK4
	 9hbp110mZHppfkn0BHHk83wmpNpGX1fASebdxTa2x2rfaTRnd/pj8RloXfHTTpr1jr
	 ZRBPp/TkuLfka8yPyZ4NuCDYNeCBtaiuX1UFOqUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgHFRF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbgHFREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6ACC034627;
        Thu,  6 Aug 2020 06:36:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so24554335ejc.2;
        Thu, 06 Aug 2020 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gIDHrckbjX7A25XdrR7+VuHvfE++wIYqYDxklPozcMs=;
        b=ogSom+x8Vy+lrAdhx1aGY5/eZbaKav0gVy1rtsnre4Wxvro3UESENnKfnCp/QxCtmG
         fW5QRMvekFqUn3rRvHSO0BVG77bAIelCG1bTOXD3LZh+CjPOWHHlBw6YNgv4yxyWxZ1A
         C2MtbtQJlwXe0jG5hKajDsyJBM1ZI881zSKQnR1JyP/vsNpY/I4tAkQEfGlTqBz4ikWO
         8uiMs17fIiTulh4cHi8R/rcX/ZP3A6ZBHdcA2FT6m7uZyIoFs7mEANUdpHknqNVgI7xv
         geOQu7Af/PNjiCUOmAWBleQ8MnuxaZLIhkPbbGEI7EYs0CjOlF5400DjzClFHZI+z9ii
         Qt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gIDHrckbjX7A25XdrR7+VuHvfE++wIYqYDxklPozcMs=;
        b=kM3nsUP0pF6E9AdOjLoAVx4mRxszl9T5Zs+EBFwp8TvVKTStDaF0JnR22MNVr3ksf5
         GiRrISKGykfgJe6abQgDTgH1OA2AGAJkNa5KaY1mvO/Ws3gEltnho6jIRV6ZD7OQjpWI
         G6wV9M5W8aJDVdDAv/sveyeWHVtqgiqCKT3oIvHJp+lNbR55C+DjTDLg6ZCjQLhqNenS
         nDcS0UwKYwUnpNn0jM97QUt1eoE6htdzz6QZJpxdEsT4xOUzz67zMsR8gpc4EW1qHTLv
         b4dKoSzqLL838BqTyueXRPE7prsCQw86mFccSlynZWZA3IdymYFeYtN3skD+4JhWGXrv
         7jPg==
X-Gm-Message-State: AOAM530laNci504X9mHnc0aZJAD46qv/Iabfx+rwI+xDDXTLwc61Td6C
        Z0+ZrNUH5O+84swvyd34WMs=
X-Google-Smtp-Source: ABdhPJxwl1YXqFobKjLCcATa/wMS8MPiG3+A3CHWjljmnJY2ertpfCVqc4nVSOG5Fs9xOTTwnb/N0A==
X-Received: by 2002:a17:906:b59:: with SMTP id v25mr4357184ejg.436.1596720991043;
        Thu, 06 Aug 2020 06:36:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id pv28sm3788137ejb.71.2020.08.06.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:36:29 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:36:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com,
        bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 2/5] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20200806133627.GB2077191@gmail.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-3-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-3-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen Zhou <chenzhou10@huawei.com> wrote:

> In preparation for supporting reserve_crashkernel_low in arm64 as
> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> 
> BTW, move x86_64 CRASH_ALIGN to 2M suggested by Dave. CONFIG_PHYSICAL_ALIGN
> can be selected from 2M to 16M, move to the same as arm64.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/x86/include/asm/kexec.h | 24 ++++++++++
>  arch/x86/kernel/setup.c      | 86 +++---------------------------------
>  include/linux/crash_core.h   |  3 ++
>  include/linux/kexec.h        |  2 -
>  kernel/crash_core.c          | 74 +++++++++++++++++++++++++++++++
>  kernel/kexec_core.c          | 17 -------
>  6 files changed, 107 insertions(+), 99 deletions(-)

Since the changes are centered around arm64, I suppose the arm64 tree 
will carry this patchset?

Assuming that this is a 100% invariant moving of code that doesn't 
regress on x86:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
