Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E27620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="doetDBC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389050AbgFISsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFISsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:48:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1514C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:48:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so1785065pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2PL+pbfi1kh+J0AmLH2dyW1hfo8dchWmGFi/N5y4y0=;
        b=doetDBC8GLhAH/GPYh2nF/OZwCESJtT3x/5JwmFQppNQJr5rFhUwRcyR9FtefDzGs1
         RdTitQklosNO5HKOvlQUQJc+B3qoYVCfPRU7nKjg3lVc0+kFRfhloN8Q1BIilhESUAsl
         UifY/flT3XKb72YemuUE0ejI83VnmR69D+rOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2PL+pbfi1kh+J0AmLH2dyW1hfo8dchWmGFi/N5y4y0=;
        b=NffjkzdCEsWnBXz4JXvslS9Hrag1jy6LuMjuSs1vRtyJ9OvJVV329dF19bo3I3CS+S
         gIQ59livHlOT01udOJIy0P+vvLlTnZr9V9lroQSxaceLhldyqmJXTnEc2EPNqrcC95/W
         37qcZjiAl6jqGw41D/rbYhph0v4xMdjQYdeo26c9raCjPURZzastDBDctfYTxj3LAPl6
         nMyfJZbQm9ZZMg45nN0Zqh67rrjIdJ2WWa6WoBUl/tN+UZl8bZYciiAgNPnRyWcbBFFs
         GnLuO7+6EVTNAUZ4hds9kKGGcq1VxYmQl4EGRhDEtwwVb/zELLfOqWph1NXwuui06/Og
         3deQ==
X-Gm-Message-State: AOAM532DVWpw3n43aYeb5y7DN5k74vWJQdDBiMVH1aTHjvlYX6rFtRYV
        LsrEhMuCIyR7N/it4nMAISMlrg==
X-Google-Smtp-Source: ABdhPJyddt1fAWGutCRi8Fa6NrDKr2oQjU7wdUGjNSxmmyNx0/oNHsTyK+GsePEnmx8lD9WMuMMOGA==
X-Received: by 2002:a17:90a:2647:: with SMTP id l65mr6474171pje.20.1591728489562;
        Tue, 09 Jun 2020 11:48:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm3223850pje.25.2020.06.09.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:48:08 -0700 (PDT)
Date:   Tue, 9 Jun 2020 11:48:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 4/5] gcc-plugins/stackleak: Don't instrument itself
Message-ID: <202006091147.1B8E3ABE@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-5-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134957.505389-5-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:49:56PM +0300, Alexander Popov wrote:
> There is no need to try instrumenting functions in kernel/stackleak.c.
> Otherwise that can cause issues if the cleanup pass of stackleak gcc plugin
> is disabled.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
