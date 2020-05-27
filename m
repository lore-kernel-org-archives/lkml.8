Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BDCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAD7207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="AO00RpDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbgE0P0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgE0P0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:26:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E547C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:26:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z15so1183292pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=diDLEh/NKfAiTgrkORi9j9+/MffGZqePbVT8pyJZQa4=;
        b=AO00RpDHcGljo0ZBenMboFTqJT0jVi+hidKNOvUCDhkZoqPI82Rc848SvBoMdLuAoN
         Rt/xgQ2fO0AOMX+inhPoOHufY16af7/d9J8vbvNnc0aGWLH8hy9UwiFz/Ez4ZdL5hdqi
         xz2RgzdNzbpWWrHc1JGeffLzIPh75x4dA0d52VwVVaLDfHnxjn7Cz3VltVQmBLMmN0vC
         jAMazivfxIff67VJ+2GEt2vPsNq4ITcO3PMsBR3rpSP0jevZAqYKinip7/noxku6fZeJ
         yxBFJOmq6khMsb1nNX2XRbuSIG5XocjRWKIKBS33C4WQrb+JAHRRiCKXkSre1GVqOrPq
         v+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=diDLEh/NKfAiTgrkORi9j9+/MffGZqePbVT8pyJZQa4=;
        b=B66M0tf/DeFgKgFYpXUa6osI7dNDqY/q+N4puWYfGj1P89C5WLt2JFHUJKTDRDJ/RF
         JKmfvze1smoEa5Pajyxg7i8HLYmx3SK6Y2jJWoL/xYeYVDcvCQQh14wOtyUzDp1xHE7S
         MMEx/2+D/b0UIIez4ueUaEVDtnkQfcSJcdon+3USZuBk7Oe7ys625gYr6+fY3CXfrWzp
         EUlOVEKA2+uGT3jApzLqmXZDvA6KdGHW/qVecfh88pTf3d2O1qMevDuJhJkd0pobiXLD
         ZK8bmV0BvyuwxN1S1gy7PH9YULgIy5KMmD7zqMyKnhdB3yx2ihyaNyfYQwMa8LbBMrnP
         FhBQ==
X-Gm-Message-State: AOAM530L7wVSAPxFdb7b7moEl3h3rQJScBtubfGuiQXBytiiTSsZuc5S
        mSEBhY8TKpqYaWKLwchuHsgY3A==
X-Google-Smtp-Source: ABdhPJzYFeFijTzQO/msoNv8LjXRAE3f1mGK3osdG9uczKx7T4VD+6ZL9onhjL1ETOyj5/gpOaTcDw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr6332966plb.93.1590593165709;
        Wed, 27 May 2020 08:26:05 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1007::592])
        by smtp.gmail.com with ESMTPSA id n8sm2873328pjq.49.2020.05.27.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:26:04 -0700 (PDT)
Date:   Wed, 27 May 2020 09:25:59 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527152559.GB4153131@cisco>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527111902.163213-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:19:01PM +0200, Christian Brauner wrote:
> +void seccomp_filter_notify(const struct task_struct *tsk)
> +{
> +	struct seccomp_filter *orig = tsk->seccomp.filter;
> +
> +	while (orig && refcount_dec_and_test(&orig->live)) {
> +		if (waitqueue_active(&orig->wqh))
> +			wake_up_poll(&orig->wqh, EPOLLHUP);
> +		orig = orig->prev;
> +	}
> +}

Is there a reason this can't live in put_seccomp_filter()?

Tycho
