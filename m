Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0D5206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbNuGRub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgGXRyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgGXRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:54:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBDC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:54:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f185so690207pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zh6CKPu9OXN15zjWZk7WlElaxcoMcysSL6HQfo9H3E=;
        b=BbNuGRub6gajP1oXDi9LwdUymaGqj51igXR8/6ZLQKhDEfSjyi+vtEXaLGXxlqngob
         kJegiFXVFS80BXaVFZw1O/OKTg/9rxDkgjecPYAyHkfgMBDh/BX8tEvs/bqrbasncZoZ
         RQVIid6OkNAf+JNeU/aRV3dfwXuwxI59wPrxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zh6CKPu9OXN15zjWZk7WlElaxcoMcysSL6HQfo9H3E=;
        b=uclB7Kw7QvxwoLw5vxelnaAS7iDWzt1mvzcB9znk0Pg/fShCdar9Z2ZDLxJisPs6Cp
         0QhyGapssVtk6JmtBPdY4cg3bHMjHiC7NjhvpmaaGuuaAanZuGzFCmvp5qvNUmN5/kAd
         QsRs4jF0ahYOqNGnpH4IJaMzHtzpq448E4EHEkWyhKmSOVTDZ9OQIs6mIUc/i7fnFLNl
         z/BKL4UvppE6r01YuBwl0UJ/k/RY0l8jllgJbL4Xi76SD+rTwa/xZfs0pzvBIN4Vr4aL
         zXpEWyRQA0bjsamr+fMuInVeRnVPtBZ4V8TaWOe1sBCzA099elg+ubclGYEoVs8C0Djc
         cKfA==
X-Gm-Message-State: AOAM531+e+BiNN5hKC7/VviDJwL8DHiMCFJBW9dIf+V28ZHK8NLqSKAq
        Nq+CWAA677genUDuUFSeovoAFA==
X-Google-Smtp-Source: ABdhPJzI1NNk18MRpvgt6+LY08/9F3MGjY/+aI5dG+MQzucT+SD3uVmkPKkrl3cYefTv0keng+DOCg==
X-Received: by 2002:a63:3d01:: with SMTP id k1mr9236832pga.71.1595613279983;
        Fri, 24 Jul 2020 10:54:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d29sm5683851pgb.54.2020.07.24.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:54:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:54:38 -0700
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
Subject: Re: [PATCH v5 38/75] x86/sev-es: Add SEV-ES Feature Detection
Message-ID: <202007241054.25B564BA61@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-39-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-39-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:02:59PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add the sev_es_active function for checking whether SEV-ES is enabled.
> Also cache the value of MSR_AMD64_SEV at boot to speed up the feature
> checking in the running code.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
