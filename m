Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD373C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A793F20674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGa5ZBgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGOB0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOB0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:26:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:26:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so672622pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=//8Ju0FArBc4zb01MxBoUcI/VYVDSlzg+BW3vSvSIkE=;
        b=aGa5ZBgHdWlGrdfvyqG//oW9uMRL8c4lif5pE5f9n31J0nGMfTfTLdQH8s0aTTbj5E
         XseYVdFj/m/ggc4SYgZzFFvS4yWNkLyoDsxCgYX3tfj9qjanEQCxrddTm1aZfG0VbwNO
         xgWTY5KoMFbPTRNg4DxovW5nmKheMJSQTsCOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//8Ju0FArBc4zb01MxBoUcI/VYVDSlzg+BW3vSvSIkE=;
        b=nzAP7CFZe4se+g2hBiPra58z3H/8WLh/GHAlZnTXRYhHmib7MxJXMM6mi8S1mDdnCs
         DlNKzlLnda4Ynp+7zdLpXUezRNXaUR3afOF3HKz4zkA8MNV72uGd9tZ0ck3AgrZjYKfn
         RLqbYdNRIGcPql9dWvdHcFo353HuvfhU+qbknQMadEslh7CyclTB+PRO7AJQFxQj6Bmw
         AV9XOKb8i9bca/6nL7atbRpj1p/pAKrpoIHMxSVnwHEv2NGrb3AK5H6jV4kiCw4SVwWz
         UWMWFndTZ639kTvNyoPcb/+e78gxyU290NAdppjo+07Tfey9yYzutfGcXeLYtwJiBHx+
         GNtw==
X-Gm-Message-State: AOAM530rpC5+vzBHFA/k5NA4PNt6wXP1RrK4U1bf7hesG4r9QBYom00L
        zFi1MMbAk3XYbdGEpsA2dS69dg==
X-Google-Smtp-Source: ABdhPJzLdhmv/sgESdhBL5NEfWWnipaR1+RTxq1oQwAzUR+7rkRLawIsRncUD/eUpdU7XimBXhr5BQ==
X-Received: by 2002:a63:5004:: with SMTP id e4mr5816911pgb.208.1594776360077;
        Tue, 14 Jul 2020 18:26:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l23sm246555pjy.45.2020.07.14.18.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:25:59 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:25:58 -0700
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
Subject: Re: [PATCH v4 27/75] x86/idt: Move IDT to data segment
Message-ID: <202007141825.7A90799@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-28-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-28-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:29PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> With SEV-ES, exception handling is needed very early, even before the
> kernel has cleared the bss segment. In order to prevent clearing the
> currently used IDT, move the IDT to the data segment.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
