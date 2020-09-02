Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F10D206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="PNx9FMjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:49:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA427C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 03:49:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so4006976wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKy0FvZis71+4qxVI83Fx/5Pqd+StZsc7RYb47DfcTo=;
        b=PNx9FMjYsdVOB/sxz0G794p4p4EA7KzmA0oiWvfG1w/fSMqOhV2y6pE59cAztBoMrU
         KT3KvIDP3s9Lrt7v0zTvO+T3rpb024sNuX2L+gauq55I5ZKdPV/Q2JF0Ou1qw48ghnpC
         3guRKF1jNp7S/+wgHiYo+ggs98oIB/ShlniMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKy0FvZis71+4qxVI83Fx/5Pqd+StZsc7RYb47DfcTo=;
        b=lNkfx0BOhawIBm4QRcBNyKj5JMcmZeSbsC9Mh/wFkfm0S+BAeNk+r+dkkXFNkWC1DW
         lMsd3bGVs1cYOR2in7vJHlKCZ12TAW3veO8g7fGugwRUGSngvItpj3kBQA5JvIuh5LM4
         V3xETrO7sq2Rz87pkSaBCYCA0fn8WCVG+QjU4Gu/eOWMA8B+7sdXV9FprWYmTpK/oYTa
         XPDzLedZkkAqTKlw8vfxBp/+p5hcdzaC2fBfv9ybg07LigGmtSHXKn+paz4YIRm81yXG
         zAjI5A2TAxu2a8uTekdR9jtgprPscq01P7ErjYXR+zWFZzrMwurmIxGNucBgxtHQb2oX
         X8yQ==
X-Gm-Message-State: AOAM530Ye1yKW5a2XEaJqK96H8OceMDbxZU5aMJVF8f0vq6WXU3+MBC6
        x5I9aRUguXLKN5JVIkQ94vOqgA==
X-Google-Smtp-Source: ABdhPJxkezEQ5EimdP4Yp+JtPtW0eRcJQ2iEIy0KpFqSwNAMzw6MmpDD6SCT6xU8qMChbK1udpZBEQ==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr50318wmj.132.1599043741171;
        Wed, 02 Sep 2020 03:49:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id v12sm6680567wri.47.2020.09.02.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 03:48:59 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:48:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Restore functionality of nr_inodes=0
Message-ID: <20200902104859.GA79629@chrisdown.name>
References: <20200902035715.16414-1-gandalf@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200902035715.16414-1-gandalf@winds.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek writes:
>Commit e809d5f0b5c9 ("tmpfs: per-superblock i_ino support") made changes to
>shmem_reserve_inode() in mm/shmem.c, however the original test for
>(sbinfo->max_inodes) got dropped. This causes mounting tmpfs with option
>nr_inodes=0 to fail:
>
>  # mount -ttmpfs -onr_inodes=0 none /ext0
>  mount: /ext0: mount(2) system call failed: Cannot allocate memory.
>
>This patch restores the nr_inodes=0 functionality.
>
>Fixes: e809d5f0b5c9 ("tmpfs: per-superblock i_ino support")
>Cc: Chris Down <chris@chrisdown.name>
>Signed-off-by: Byron Stanoszek <gandalf@winds.org>

Acked-by: Chris Down <chris@chrisdown.name>

Thanks, good catch.
