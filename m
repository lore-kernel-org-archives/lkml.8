Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28152086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSW/zmI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgERQoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:44:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:44:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w64so224133wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mrOVKHVJapH6kF5qReOp0wglPtw6uXIPRlbofv8HkOI=;
        b=nSW/zmI+oIKzyOLNG6etkGbyYqHBBsA2N8whXlXs5aLplRWbKVRVZJuGjkipitkMFd
         JpDvh6n1I6fl6OnyDNwsPT/olbSNWIvVDkOpC9T4/wi31U2gZWWAb9vaKvbqwiXWSzRE
         /OCEBdRmoFd+eNbb5XCzC9mXeGwdFmBqmUkmzBgIlhfo5zWNUwJ7+xhAVSwwqpiTwxhR
         YbwDxXTWPeNSRUpgsH2ZgBcUrvqn70knzY40sUTMnYGSikYPo9uylu89drqXy985LCES
         jwguU3GVWDkHvHwoJhoQ2HH/fA+IMRHX4PXEy9HH7+Dn53Y38W//jL36zKm6iMSn9XTQ
         JH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrOVKHVJapH6kF5qReOp0wglPtw6uXIPRlbofv8HkOI=;
        b=Kn1n78eQo28yZLpKgqt5ZUPvWLQQrcclsAILMYD7vW5qsPtwuEm9J1rx3+K7XSIas4
         eYaVgInIS0uTSTJDI/OYunrmxHwgrYGe8Qwj5MTg7X9fqCDAEjx/8czJMFPi7IYEACry
         NwS7D93dsF3k38PJt4p9vEMWDvb4n4ScW50nxt2Ai6fJ2fWvS/0lNHPY1V6QTNaXVVk9
         6aj2BmXSOEn0ER/Nndmv3i/ASK4II2ZAHZN6Y+Qgymi1NTtMzNECrPnCSu8xEfOqgGRh
         1l8GwmOW77s3TkE58yfTu9g+xpdrVjcJp66qu7f3nEj9OGam3frrjOSa4xWJEmQ7QfDZ
         IzpA==
X-Gm-Message-State: AOAM530E/Q0s9//m8tGR31yTZAnDhV6xaeM84FG1oDgIZ1PY373ELuH5
        sHW56mLHP092BhSSBN9CZ37wvA==
X-Google-Smtp-Source: ABdhPJxvMfrufurokRmF+O8ESaZRzfiwWThU1ZHkuIFz5YhCwG7DhnQCN+0EO7FHTPHDCdOSTcYLjg==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr230711wmu.145.1589820253760;
        Mon, 18 May 2020 09:44:13 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:4431:2de6:16f:7f90])
        by smtp.gmail.com with ESMTPSA id e21sm125834wme.34.2020.05.18.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:44:13 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Mon, 18 May 2020 17:44:12 +0100
To:     Andrew Scull <ascull@google.com>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] arm64: kvm: Split hyp/switch.c to VHE/nVHE
Message-ID: <20200518164412.coycmliijagaaw4m@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
 <20200515105841.73532-8-dbrazdil@google.com>
 <20200518152851.GA147668@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518152851.GA147668@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 04:28:51PM +0100, Andrew Scull wrote:
> On Fri, May 15, 2020 at 11:58:34AM +0100, David Brazdil wrote:
> > +__kvm_nvhe_sve_load_state = sve_load_state;
> > +__kvm_nvhe_sve_save_state = sve_save_state;
> 
> Building without CONFIG_ARM64_VHE leads to a linker error due to the SVE
> functions being referenced in this list. This is caused by
> CONFIG_ARM64_VHE disabling CONFIG_ARM64_SVE and, in turn, preventing the
> generation of those symbols. There aren't any references from code, just
> this file.
> 
> It can be resolved by having the SVE symbol aliases depend on
> CONFIG_ARM64_SVE.
Thanks, will fix the linker script in v3.
