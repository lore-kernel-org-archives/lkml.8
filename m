Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A3AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBBD20643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZKbAYW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgEHHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:30:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6D9C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:30:15 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so487343pfw.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqpyyb+XnLoj16wQZlLdWBVriL281dJ6+6/0xxtkFF0=;
        b=hZKbAYW33xb+xdQ8lBH9aT3oQXgi4QwV4iyIiZZxmjGdeY2HuZSMuK1Tv0vl5FXkoD
         lpolHB5qaTBvXWNFPcAWHh/cUtiXAyBsQO3w8th6r0E8mu6tSopQy2Qfp+qqBZu01LRn
         nyb7OqEjzsaHtT5Dn1N4KbgZ/UmchV1hf/rl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqpyyb+XnLoj16wQZlLdWBVriL281dJ6+6/0xxtkFF0=;
        b=aN0MbyYlKDsxw15cqg9xEsyYq5SHkPYBZ3K68f9RWl8VMyiB0Lx5lXYo736/tGpa9w
         uiNXrCWvJOTWAP12gf9/HJ/6NAi8nRIjULuWDrIQY+XpyaoPMdNiE+vCdPwd77Ru564N
         zS6qknJiYT/fG/iwvbBjQBd1Bn1a9W1WvxL7Fkzt/YO81b259k9TEJBtsjZL0F4BnhTX
         Iueqnbay/Nk5Es6+ilKd8xmLJqjTx4Rcwvrqhy1zx7pa4yMRB+Z+uCgxLW336FG1hYa1
         tsBpDbJU8Ln6UUYbB9dqCvwaThFGMw6l7433I7zHu+7tKTxSijunnQbVZQvfyC9J1En5
         9Iog==
X-Gm-Message-State: AGi0PubsqaRMZOA81MJU/WasOXrMeqWnUXNxZI32e6lEyrB83vJ/3N2m
        tzAlIfBdn1WSLG/BluLIL2LuhA==
X-Google-Smtp-Source: APiQypLxKaNbmOsuHu9lpEurBe6lHAKMXWmXDPwAWCdC4ArcRmf7jd0ENIeqyF7Nb5foJhJTNn7u5Q==
X-Received: by 2002:a63:5413:: with SMTP id i19mr1095604pgb.213.1588923015051;
        Fri, 08 May 2020 00:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o190sm869295pfb.178.2020.05.08.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:30:14 -0700 (PDT)
Date:   Fri, 8 May 2020 00:30:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <202005080029.538E27C@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065356.2493343-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:53:55PM +1000, Michael Ellerman wrote:
> It is Very Rude to clear dmesg in test scripts. That's because the
> script may be part of a larger test run, and clearing dmesg
> potentially destroys the output of other tests.
> 
> We can avoid using dmesg -c by saving the content of dmesg before the
> test, and then using diff to compare that to the dmesg afterward,
> producing a log with just the added lines.

Sounds good to me!

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
