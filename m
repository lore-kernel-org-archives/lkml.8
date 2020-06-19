Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88778C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B19206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAA1aFkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgFSMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgFSMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:11:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4368C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:11:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so9477531wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uw1fRJk8W9uzHYW58SXoTwxg2AWOnCyPtVa0nujwxNo=;
        b=aAA1aFkxA985YEVfjLAPiKf66EhzPWckcNx4xKon5snQWNwK/YtUsVhxAr8entll5J
         FqpecJvgTmxRT5+MvuHxJe9wSNpmI0nvvrBzF3a6gi+LUIybTOg+JYdbJqT0dZYlFxMk
         KKN+iSVJrEIms+E2BI5fXbNWVdsb2j9/Lm4zmMbjwR4aASLWSTAHS8bjK4ndoX9Radrz
         tAJ9VVNEEMY8zPNBspED7etWgK9KAxQVfeSI4+eLeelOpXXdGi5OUzXSQ1/NP3AapKjN
         3YhofK/HVDX+bv/bUFdvGIO34LjDkJ5lop0TmHsA2yBXmfMLzQrW56prXHQF0G2R0N+F
         /h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uw1fRJk8W9uzHYW58SXoTwxg2AWOnCyPtVa0nujwxNo=;
        b=Vy2JUtjE+BJ87X/RSL9F1CHYUfU7AjCKRPQ5F0m+EcTWg1bX+EF06qbqXIqQl/XMW3
         Z3iSjl2NCsoy64ZSFwjRbMtp+pbIhD70mnojZj+0ojwxzXJ0tKUJQ9jPaDMpeaVWK4Ky
         RcqOkwYfZkOOcptZGHVSGDPSOW7UY0cYBE/vNxYjUiJI2HdC4Tc/IM80tkcpvUzmwDsw
         25twX/I6VvqRI53pY7T4OWGeodFkXTVe65xh9fKpxjUGr1bRhCOTrSEwQMiPuL5R6bSx
         BuKqLGn8pS5UsNisRDxcOMsfbnuSS/l0Iv/lPH21K+1AJpty3QzzTHQuJGjBkEuv7F5A
         QBLA==
X-Gm-Message-State: AOAM5312tf9l3ZuuNLKZK6juQ3kVXqbW1+zIwIVv2sdf8Kp0t55bxmlj
        O6+p9EuIHzDQeOxsBq73ZXFoLg==
X-Google-Smtp-Source: ABdhPJzXf4aN7gKCGZYXPOoqVI1aLeO650Z1tn89qTbHzCNLC55N0Ab6rAbplKt8XgQAxTgA+V7Dkw==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr3727602wrq.196.1592568669243;
        Fri, 19 Jun 2020 05:11:09 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:d994:d48b:4a9:7c2b])
        by smtp.gmail.com with ESMTPSA id l8sm6886721wrq.15.2020.06.19.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 05:11:08 -0700 (PDT)
Date:   Fri, 19 Jun 2020 13:11:06 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 03/15] arm64: kvm: Add build rules for separate nVHE
 object files
Message-ID: <20200619121106.sz5qxxkb53ida5qa@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-4-dbrazdil@google.com>
 <09976ea31931481f4e00d627dc5e06fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09976ea31931481f4e00d627dc5e06fe@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

> I guess that one of the first use of this __KVM_NVHE_HYPERVISOR__
> flag could be the has_vhe() predicate: if you're running the nVHE
> code, you are *guaranteed* not to use VHE at all.

Sure, I'll add that to the next respin. If I'm reading __is_defined correctly,
it means I have to define the flag as =1. Easy.

Thanks,
-David
