Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7260CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253D52087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhgVv6yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgIHXXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIHXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:22:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69515C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 16:22:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so606409pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vw8y/keL8WobWtmOV5HZRJN8/Uakg/hovhFlM5RtH0=;
        b=dhgVv6ytoDhKtI7epFtTsWzhO99dRLXs9qP6tHOGr0W9iPEBMxhPEYFzCPy4e45x1p
         iv7oDHrhvzoFHFQbgnieeDK9qlcnx9jCxpTM73Wv9OxRI1dQYBAzJ5GwMJlhCteDErSG
         EnPe8FFbiKqJ1TpYawiqNukVf+bzmUYQIoggE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vw8y/keL8WobWtmOV5HZRJN8/Uakg/hovhFlM5RtH0=;
        b=ZqDy6Mczsnz1vzhtJpHOKkbB+OZkQxhH/aFLlOaiLa1e3xf6Z1052j9F+gzwGFxJck
         /8A/+0fDc0NTEtk3avY2Of3KgGWn2wy9ja2dFLYaB3etz1yAjGAr1Te67C+Q5Ij5Q3t7
         KP1iSxTf+YzcIfdw1eBI7GStkwd8f14zANBgA3EnjbYJ0wqsF+A5+BBft5GrfpAKqXOj
         Ceh5Bk4XurvOPZyDwoKgpnpBTXKyd/uZ/6th02XXnVkGYJWxIHdK3E9CCAPrIoqMSWXI
         15oucU5hqJViWc5v9C+y5JusZun27Aqr0PSEOXV/5vbIMoD2MOTvwxVYwD93xymfzCbV
         Lmlw==
X-Gm-Message-State: AOAM532N6GurRlzq78KZp4yFffjfsjIap8gbmAeRXE/tmfX2vv/nhEOK
        QGYM2eophf40xTC9tkm/r+FuFQ==
X-Google-Smtp-Source: ABdhPJyWsjXkHCgvBe7fbOxyDUTgQ0nowPHAXIjoEPMa62KZxAej8RSYGYurVX5t0SOTnFuQ0UNLDw==
X-Received: by 2002:aa7:942a:: with SMTP id y10mr1046719pfo.68.1599607374934;
        Tue, 08 Sep 2020 16:22:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 194sm474000pfy.44.2020.09.08.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:22:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     kafai@fb.com, songliubraving@fb.com,
        linux-kselftest@vger.kernel.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        kpsingh@chromium.org, shuah@kernel.org, netdev@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>, yhs@fb.com, andriin@fb.com,
        bpf@vger.kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH -next] selftests/seccomp: Use bitwise instead of arithmetic operator for flags
Date:   Tue,  8 Sep 2020 16:22:12 -0700
Message-Id: <159960731879.1678444.6814133998182138035.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1586924101-65940-1-git-send-email-zou_wei@huawei.com>
References: <1586924101-65940-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 12:15:01 +0800, Zou Wei wrote:
> This silences the following coccinelle warning:
> 
> "WARNING: sum of probable bitmasks, consider |"
> 
> tools/testing/selftests/seccomp/seccomp_bpf.c:3131:17-18: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3133:18-19: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3134:18-19: WARNING: sum of probable bitmasks, consider |
> tools/testing/selftests/seccomp/seccomp_bpf.c:3135:18-19: WARNING: sum of probable bitmasks, consider |

Applied, thanks!

[1/1] selftests/seccomp: Use bitwise instead of arithmetic operator for flags
      https://git.kernel.org/kees/c/76993fe3c1e4

Sorry for the massive delay on this one! I lost this email in my inbox. :)

-- 
Kees Cook

