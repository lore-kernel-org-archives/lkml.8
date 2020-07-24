Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7880206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJVXb5n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGXR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:57:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADCC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:57:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so5737220pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMaFwW8t3IfIMVggiKK5OHJuDKp9jaqqEbc7QFoh/rs=;
        b=CJVXb5n6JR5dWMx2tAJLg0bcwhbi4VQqyjo9ptukfmM2mUWjqZH+jR4n9It2TyDcL6
         DImQfQV/+SB3ARDdJ+h56qcR6WkyApTGi8w3+KG7PXrxzaipl3pJotCGKEKeeIXseiao
         kT7/1zeJ2y2o+p3sPye32JbtH4ABoCfClNQCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMaFwW8t3IfIMVggiKK5OHJuDKp9jaqqEbc7QFoh/rs=;
        b=IegCKAQImafrfDSMwaG6NY7LR9DwTWraXETE9DDbZ1SKCMWzYacLVI+nhgJdA58N4i
         rfAjrS28ACbgJ1C9nEYFcst2rqkWFPGNuY2PpQ2Thrtjw+0ZuZpn6lM+OrZpBYYQDWXX
         CY1FdX4KuiSXR+C+SDuvHHV2tQq7X5pnjnYNNcT3VBQerOHKJl2ys5calPPl0I9B2dpv
         hJI31nSn/9WYNTg2S0JTXA2NwDFsSm+/XaLP02isN5Ns88rnFG5Lg6sYNdqP1LdozstD
         kNYL7C6xmkgUn65zCG/7t3JRo1Sdq69+jB5AKUJ4MokSdQxhrJvf8e0mMwTJ1n90s1zN
         LCLw==
X-Gm-Message-State: AOAM531pkVJd2L+KiUy0k0iAcgsfGBm+d52tRuHLkqSnviM/hq3/lIzC
        oer+sekI+PDvRvWmn1hOF2BGhQ==
X-Google-Smtp-Source: ABdhPJwT1ivDifcMkDJuyupKZW8COKgntYhL394BofNxgSA9BgFQyVU125t2d5Ivjc4ONMX5CLywvA==
X-Received: by 2002:a17:90a:ed87:: with SMTP id k7mr6699745pjy.31.1595613458750;
        Fri, 24 Jul 2020 10:57:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6sm6950620pfr.129.2020.07.24.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:57:37 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:57:36 -0700
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
Subject: Re: [PATCH v5 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Message-ID: <202007241057.2D78C2A41B@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-71-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-71-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:03:31PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The APs are not ready to handle exceptions when verify_cpu() is called
> in secondary_startup_64.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Thanks for updating this! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
