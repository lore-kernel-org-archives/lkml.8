Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB03C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6C3206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HuNn966m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGFUSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGFUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:18:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D786C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:18:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so2107510plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kH+JcTGSZq1IaKf+7a5y8xpXE6P2p/YmqDxscyJtTF0=;
        b=HuNn966m+ekn7j32VIF+2PaEsLSVoU8AbREQ3KujZX2sg0iaaxuUqC/sJ0pC/m1ndS
         SYZfhGq4S4TRC4+LFuJ+gRy0OcHxcGDlT5xX9vnzCGlFBHucY2wx8FFpDtB85Ba8pL+b
         qqv9HkwiqXGfGVM63KlB0kHmdoL3tKJgy7xiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kH+JcTGSZq1IaKf+7a5y8xpXE6P2p/YmqDxscyJtTF0=;
        b=OH284KmgWY5LwwtYDcrwMdbcI5EVhBzk3bTbvOhAZgcfZTJ1akeVsPL3s1p4BC/+Pn
         Sp3mMTLmt1HcUY8ZHTBZaEKfVp9UFbFRWLehAFtTDPH0JqmFSD4Xnv0L8GD+M4T2JPCD
         h7CMdTq3SN7IknW2O2ckcvaQK4y1EZgf8nD7rAUKAKycKW0aKGTDCNCNz5Sm13sTWm9q
         H8+AHxppcR53XsDLSGslou8oDfIxqKEl5jF9JtmtIkQ8sm9PmNK4SXxcrmxbrz8KVl/v
         ifK0LgKhsx8j7M7PrsJQuRuD/0S35V5MRI7CUqi1b0q9grRjRJ5Vc7hWuKcaK0vVGvM3
         mCQw==
X-Gm-Message-State: AOAM531kNVoC2gGNJbBWYKlRljqFawF03KuXPVaOBTHNrEslbRAmbz37
        D2cHa+mZoj4ls3geAgYe+cMPTQ==
X-Google-Smtp-Source: ABdhPJzt4rTgm2BYV08YGvM9tpMf4XxwVel/3LKMdtZcXsPgjzGrEQudgSQHsicb9CJx2isUr3Fa4g==
X-Received: by 2002:a17:90a:e987:: with SMTP id v7mr845528pjy.56.1594066712687;
        Mon, 06 Jul 2020 13:18:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm275141pjy.54.2020.07.06.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:18:31 -0700 (PDT)
Date:   Mon, 6 Jul 2020 13:18:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] selftests/harness: Switch to TAP output
Message-ID: <202007061318.9868E4321D@keescook>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <202007042245.BCC693126@keescook>
 <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:57:19PM -0600, Shuah Khan wrote:
> I will pull them in today. OSS+ELC set me back with getting ready for

Thanks!

> the talks and presenting. July 4th holiday didn't help.

Heh, yeah, I'm in the same boat. :)

-- 
Kees Cook
