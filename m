Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A8C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3688A20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvV1LaHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgBQQE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:04:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgBQQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581955495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAsJ8NbGL2b46wcgIaUPisLZoLcRYPJb7lJ/X2bzICo=;
        b=GvV1LaHtF5HhYl5PL6QkOpk1iFOHCBXL5qPIBCFzTvYxDVaRoxQqscSldqTmo0X13V84wg
        ISwp/1RjpghrTEB5MiaLYHwci57MJz0ggupjk/T14CMWBiSyZQ334bhty/dQDL1g9NU484
        vq3R3o3oKPQSlwuLJB760QLuSFex6Ag=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-_qXqvEkoPxynwadeA9dmTQ-1; Mon, 17 Feb 2020 11:04:52 -0500
X-MC-Unique: _qXqvEkoPxynwadeA9dmTQ-1
Received: by mail-qt1-f199.google.com with SMTP id z25so10884827qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAsJ8NbGL2b46wcgIaUPisLZoLcRYPJb7lJ/X2bzICo=;
        b=dHW4NWbm0JFywGuCpuzkoWQCPr3MGlOgkpQZRIRHPm+aTxMFgFGLnhFAIW77Vesk7g
         ZF8SdcUVvGNQ8/TRTlCWQjTs79uSjSmxy7Iecb4dNkqE2EROIIYEBpqBKxjISoV/9Ext
         q7/WDBP/aMYOyL7+yWR6Tx1ISetRyiGfvRLGkjxOn5DE/iu4TwrMNAKGrVn0Di/xzPI5
         UzemB0cV2XlK4tgE6j9ZG6z+KuUl3Vkn8onhiiFRimAusNfWPInA6ELX8blMuWtku4qo
         WS1pRuEsliBC5c4CE/7Q6YZPM0DrGZ5C9sPY4/g8KE+Pk9KRUSaj+hFevszZtmF41SB3
         is5w==
X-Gm-Message-State: APjAAAUjgZOD/lQEejF1TJT70BQ3LFEA5DvbKbAViedlCLz2ZQMD+lkZ
        +3iCNV0wGGciQOpcSVJm8EEnHGPWy1A1C/yYUoaDNQLYM2i0dv3vKu+I+13noZFSRTVqZfJeCel
        mNBm1MbaMdenpP0wmVG2iA55M
X-Received: by 2002:a37:40c:: with SMTP id 12mr15009206qke.212.1581955492226;
        Mon, 17 Feb 2020 08:04:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvsAEaJRLANfo3ZUdT+LbldOTKe/PahIREpXyxHHS2i9rY7g2U7F193H8KoyGmAenNGyQhpg==
X-Received: by 2002:a37:40c:: with SMTP id 12mr15009189qke.212.1581955492019;
        Mon, 17 Feb 2020 08:04:52 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id z21sm408837qka.122.2020.02.17.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:04:51 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:04:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] smp: Allow smp_call_function_single_async() to
 insert locked csd
Message-ID: <20200217160449.GA1309280@xz-x1>
References: <20191216213125.9536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213125.9536-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 04:31:22PM -0500, Peter Xu wrote:
> This v2 introduced two more patches to let mips/kernel/smp.c and
> kernel/sched/core.c to start using the new feature, then we can drop
> the customized implementations.
> 
> One thing to mention is that cpuidle_coupled_poke_pending is another
> candidate that we can consider, however that cpumask is special in
> that it's not only used for singleton test of the per-vcpu csd when
> injecting new calls, but also in cpuidle_coupled_any_pokes_pending()
> or so to check whether there's any pending pokes.  In that sense it
> should be good to still keep the mask because it could be faster than
> looping over each per-cpu csd.
> 
> Patch 1 is the same as v1, no change.  Patch 2-3 are new ones.
> 
> Smoke tested on x86_64 only.
> 
> Please review, thanks.

Ping?

-- 
Peter Xu

