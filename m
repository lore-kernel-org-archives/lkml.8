Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FB1208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzB4d4PH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgEGOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgEGOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:36:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E26CC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:36:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so7082430wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=97qbtlSksxUqP4IepQZvJvrELnOIuCcLtceZei2X0fU=;
        b=ZzB4d4PH21eRkcpcL8/dT+++RvB0ZZmSphkIMJLtD5oMY2Jnwy7S98JFpZfw1OYm52
         3TWG2h2gorD9PKb0JKdyLP7kgH0CYBI6AQD+bD51IoyPOPJmai2OhLaOaM2Tn8KR/r+T
         0HjMn9km6DG+HcLGaNGTTtsaAmKgEi66yeYEVYKrej1QmHPcsTZfgNVFFeqPB5IR4/oJ
         G297cddKz4Z7Lxx7yvZy8V268l+77Bsr7s7lMPa0lTjhhO62NCnger0sZ9xW99EGDqJN
         GyLqbTJdof20XyI1vBiW1i2flDKKGUJpK3R7pfKCu/PK8sMvX8aEdJ/CQGv2O2uojqIf
         fROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=97qbtlSksxUqP4IepQZvJvrELnOIuCcLtceZei2X0fU=;
        b=qdYbRwqapsTMBLMkd7eB5YqMNBMXT38IjC2eUaEmVm8UMzP+e7JD8g34KepwZ3BNq8
         OiWKliqJ0A2hxELTqlcrrqKK2hj45hjb1PLeCNrdS1GuMuNMZsXg/zc9Tgq18yb/OfDf
         2I0MSNhab8SYV7di7HhNTuvMyEh1Q2xjoBKYP51hvw/l0UxKFHpjU7Ie5aMeAe2s3zBM
         5V7rEkH63tAJwcLxDG2Ap8dWUxXGFwtlKJCt8Wzj7ajP8NUQNsBHsU8daJNyoQVCzAe4
         FYHr1ToAna++/ri82EESq7rZ7vbQp0NP/tPZFWIWtp0uSFtEB4lJYdKQ15IdG5bm/ZcW
         KQnA==
X-Gm-Message-State: AGi0Pua5ima61+tG6J4JVA57DPgE9IrSC+ISM53BZ+K5SmRXZn57KS8m
        ztbA05DUGORDVHbgiZ4q0WiOTA==
X-Google-Smtp-Source: APiQypKByb7yOAaqMEZY3XrineEZDS7bGjGUh3lbDYheXhS+bRdzViSRoAmOnUwDPOJrmi6GqqsTGw==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr10888700wmc.11.1588862179402;
        Thu, 07 May 2020 07:36:19 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:1887:a290:f251:d169])
        by smtp.gmail.com with ESMTPSA id c190sm8793473wme.4.2020.05.07.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:36:18 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Thu, 7 May 2020 15:36:17 +0100
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] arm64: kvm: Fix symbol dependency in
 __hyp_call_panic_nvhe
Message-ID: <20200507143617.2j5x3mfxi3ber7ig@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-4-dbrazdil@google.com>
 <87blmzj2w5.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blmzj2w5.wl-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> 
> What breaks without this constraint? Is it a fix that should go in
> early? Otherwise looks good.

This only becomes an issue when __hyp_call_panic_nvhe() and
__hyp_call_panic_vhe() are moved to separate files, so I don't think it's
necessary to go in early.

Currently the string variable (declared static) is seen by the C compiler as
used by __hyp_call_panic_vhe(). But when split, the variable in the nVHE source
file becomes unused, is dropped by the compiler and the inline assembly's
reference is unresolved. We could then alias __hyp_text___hyp_panic_string back
to the VHE copy, but this is the right way of addressing it.

Thanks for the review,
David

