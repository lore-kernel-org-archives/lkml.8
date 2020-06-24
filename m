Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4588320702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UcuWUiaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbgFXOqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgFXOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:46:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1141258plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YGEb31AttHeA5YUH1Hedg3SW+2stgVlj3nYXGGbAchU=;
        b=UcuWUiaLtS6hQwB9KxUy3Z9bv7Nks62Tpl6fbvA8uqD2/B7av9kURZB/L+B445OT1t
         NvQdGODIDeocCPW6jfNCyl35CogPsG3G8IknHXCfJJW3FYZfWX6G7dhUvusVDuWMLuDl
         qZYw9sQff/knmaH1usdfgE0F1lzEuWXKIIt4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGEb31AttHeA5YUH1Hedg3SW+2stgVlj3nYXGGbAchU=;
        b=gBIWsG+uxsmeMVhTRAc0ri7OTbtQ8it81OvRX/A7d++uGBdlBWq8Cl/mLj1GHHQHVl
         oXr1EM0mQrTdlGeCsSdUsUZg1JiEpDO/Yf9e/o+Ywio2U9KIEGZHiQIievcPT0tl3lwD
         Fw69QIoY5oltmcJn+YoPtj4tfHAlzEzm3JENazHt5Rt+QpMR00gD0mC8rBycFOx36duk
         FvM0ATroRtVwe4sHTpf56KCoHM3VHvvKWfpROvW1iRJHmtpFUHzfenHqqu8Gs9mlOIPr
         Zfbs8ea9N/J05pi2VGHbGqCJAdn4cDdGoFAKXCB6nWe7s3h0lKsSg8YSAZjmiSkaRMks
         +rng==
X-Gm-Message-State: AOAM530y6Bkqm6ECeZIeykRtSOS3KTWG5GJS47MrMsqkXE5SkgdAvFZg
        52pZhQxV+/N5HBnhq4nP0/4hrA==
X-Google-Smtp-Source: ABdhPJyaJyusdqr7gDuMQQVuvplY9KQKo74Br6IzoxaZjoYjPgwJk8Z+WqrtZcFpgt19+bLbcQX0cg==
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr27995114plo.161.1593009978891;
        Wed, 24 Jun 2020 07:46:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm20548752pfp.100.2020.06.24.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:46:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Emese Revfy <re.emese@gmail.com>,
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
Subject: Re: [PATCH v2 3/5] arm64: vdso: Don't use gcc plugins for building
 vgettimeofday.c
Message-ID: <202006240745.19E4F8BDEA@keescook>
References: <20200624123330.83226-1-alex.popov@linux.com>
 <20200624123330.83226-4-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624123330.83226-4-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:33:28PM +0300, Alexander Popov wrote:
> Don't use gcc plugins for building arch/arm64/kernel/vdso/vgettimeofday.c
> to avoid unneeded instrumentation.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

It looks like Will has taken this already, but:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
