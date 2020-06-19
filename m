Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2635C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C313A20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ9xI3Wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgFSJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731907AbgFSJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:51:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD25C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:51:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so9019800wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LnPwgU2Ku49ZJqPfwVOOBQKnYQ6yhIFp57++bexGok8=;
        b=FJ9xI3Wc7r4gcCFA8b8VjMefoKs5sNRH3+a0+UgRIipP3eDy53lralSiPmJ2KKUFPg
         c8JE5injQrqn5LsaHztBYGk8O4wl0wTfZQ6+qhNUY9qhfFCkv8b1pnDv5iH18Xdm0WMi
         eKKFHQDAzU8UZiB0zYkRR1sUz5Gv/fxVnDv6KD3O75/BkpcJa/5+cnKfmquBjd4ldZ8H
         LJ8RPvIoEisWbDMTOmgvM92LnIDCMnfxSjjZWuGO3e2YkGQhBsChs0Lk1ivwcgtZLQDx
         bXA4SH/dgcKnh9hM7Rtsy7wMH4IVdnpAo8z8gw8PFBje6DFMogBezcJDiPBM088rzVZl
         vegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnPwgU2Ku49ZJqPfwVOOBQKnYQ6yhIFp57++bexGok8=;
        b=EWGbyvBfuiGeD2QFNJ0iKL3dJuXH6yrFyZltIkoVTCChEGRWdFZgTIdCzHcTjWeWMa
         v7BZHbDH6J+hoHT0A6FxvkC5JLn9TwrLJcmgQrCFEVvHzQJ5Q7E0dygY6GSQKQT5Q8hb
         ccUFgAJm/35QvWbTjZa/2xiVcHo/rzJSPf9vgW2466BwZGwe/SqqWNC7gZDpW2a3Vfx7
         OVX/pJshkuJAuWart9cXj3eRqoaeJS1eM2P7P2y93M9iBmsf4tR6hTZjreO7quEEEPSn
         p4ElfHgI6mS/EM/595j73sTgJPIWbXBBeNEY8CR0uCmXzUgQh6qtOWnyBXFbUyVJembH
         qoUA==
X-Gm-Message-State: AOAM531mJVCWTHUuwXBE9umlIFenel45Gey3t8CGUX2FhHbTxKjDDUET
        Ag1qKBPY+DASwHAkahLGMgZ/Sw==
X-Google-Smtp-Source: ABdhPJy/P5GyQ6zftQjFqjZk4Eo0bUBjfqGjrRHEc55ESeQvI7/VsuC7NR2YjKFzBIldf4CGa6pbQw==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr3139455wrw.343.1592560282184;
        Fri, 19 Jun 2020 02:51:22 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:d994:d48b:4a9:7c2b])
        by smtp.gmail.com with ESMTPSA id n7sm6628302wrx.82.2020.06.19.02.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:51:21 -0700 (PDT)
Date:   Fri, 19 Jun 2020 10:51:20 +0100
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
Subject: Re: [PATCH v3 02/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
Message-ID: <20200619095120.wenkbs5bl3wbyiyh@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-3-dbrazdil@google.com>
 <02322fdac903aa1786c334d0ddd7f38a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02322fdac903aa1786c334d0ddd7f38a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

> > -	.popsection
> 
> I'd be tempted to leave the .popsection in place, if only for symmetry  with
> the initial .pushsection.

I removed it because other .S files don't pop either. It must have been added
here purely for the smccc workaround code. Happy to add it back if you prefer,
but the pushsection is removed later in the series, so this would disappear
as well.

> > +	.pushsection	.rodata
> > +	.global		__smccc_workaround_1_smc
> > +__smccc_workaround_1_smc:
> 
> You probably want to replace this with SYM_DATA_START (and SYM_DATA_END at
> the end).

Done

Thanks for reviewing,
David
