Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6212C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB69520674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="As6jd7uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGOBYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgGOBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:24:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:24:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so676370pfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MV9eZ5OBgqTWIWwL9zpqkY6z/89bNn4vF0SnKjjFgTo=;
        b=As6jd7uWVm/c/uXeyIWNIkQkotsGzxOaaLvAOys2HbOeY1PyGOtFGLeOpMzbRY5fBW
         7CLyuBD/uXM+ETluLcq0AobqVWwAOu6WOxc9qIb+eJ501gis6a1t3VHFTz+mJN4Shyf5
         csynOX1q6Nqq6cA0TTETd6QbQtBcx5uQ7Pwsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MV9eZ5OBgqTWIWwL9zpqkY6z/89bNn4vF0SnKjjFgTo=;
        b=KtI48aersHZbdUbtPVDLqOmc9ZPZwSYDw4jjY3VRvIv30l4yiyDyaiSp92POfYeJxu
         pcV6O2eUr6sko6fyw4cyUp5cH9U6yJFHyR70w/bbwf8sFaHi1UYT42MHtIw29sRPdjtr
         XqeobrHYt4yatwW9ThyWriBjO94gquXQwroH7/ZWkqKoyIgkuEtA+f58KyzBGwg+LUYQ
         RnFZXBAKNgF9vOYKLAqxCTOkYnDtdEm97YAFPzFTzil80pgwDO0/NKWLz313faaAd3Yf
         bXgF0ydwOAi03p0RBufqedt8XADFGq2VCgvQs3sEPwsRNj8r4vbmRg+3t+TRV1cg6mJ8
         OCVQ==
X-Gm-Message-State: AOAM530rIKN26wpYCX0PuXOJB8w0UKsB0FTN2JIv7zU1QrE8HIwsKZj6
        9KWmkPl2yWOODtxnbWbEDiB6Ew==
X-Google-Smtp-Source: ABdhPJwhN14rx8PS3l05EEyiO5yiHoXuh4AV1aLnKEa+PDj1AyXl4Y90zwpN7OBuitZH9VRBWPYvoQ==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr5523396pgk.434.1594776286032;
        Tue, 14 Jul 2020 18:24:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm328776pfq.67.2020.07.14.18.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:24:45 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:24:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 17/75] x86/boot/compressed/64: Change
 add_identity_map() to take start and end
Message-ID: <202007141824.909CAE9EB@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-18-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-18-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:19PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Changing the function to take start and end as parameters instead of
> start and size simplifies the callers, which don't need to calculate
> the size if they already have start and end.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
