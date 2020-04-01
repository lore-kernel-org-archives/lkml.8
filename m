Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23317C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34B22071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyJh3p8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbgDARfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:35:19 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:44948 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbgDARfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:35:19 -0400
Received: by mail-pj1-f73.google.com with SMTP id t7so682876pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=llCpE/mG94XbxehHcS3fpQs9KrEDWRDGRcAjU8ExJ4U=;
        b=pyJh3p8RNFxDvJu+8EyOfw0HwzsQdsKrm1/g59jSqy3qBfZYhOVFUSj2vHGn0RxbBr
         CZ921nfgLnwQcGXqh2nSa8URFicaU26aZjpXA59A79Erkmi3SxtxSFNayBBJ3axdaVF8
         +FBufOynExC0/8Dx9l+nIO4C43a7imucMwVElT50ASuSOzVpF9i2fEeHE29vzdnP3iIC
         6dhjx/a2Kw6UsLtEa7Dh1pmxz1gcQqVJMcAA2qfUxRfaGII3HpaYHx77bp91xj7Vb/G9
         efL7biRNwPDgPqWp+W65Clg9EkyL/ojnsZ8r2SJFULs8QbExqfdyvZFCByfo+JUUu7y7
         HJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=llCpE/mG94XbxehHcS3fpQs9KrEDWRDGRcAjU8ExJ4U=;
        b=tz1v2ix2eU//S8abbVr0bsh8u7OFRCKtLBJwf4yycpjZ+H7zxy/cGAqxlc3WwINSM/
         12DCtasuWZmXk5Cr848rMzNoHG3nqUtuvs26S23mtTVcgssx8WynYm/1CiY3WMwoaphH
         eSTpIHis8ajj3My7TTPPUzZosN9dgKUNhAvDpAcVDSpz7pk/dl3wyNFt4cUQw4Fc6rZV
         o6X/Dd56drVNZ8mkJCxoLbYTeNVQ5E7QghVA7Qj/s5dsj8Y7Mm9cphSEOPsw8TfuC4cd
         rb7EOMkaXIEp/HCY5zFeovqiuasRyKOUvY621+frWjEY7WVj00KigrEiT4GOvAceaJIh
         /Qog==
X-Gm-Message-State: AGi0PuYuMCvxkjZu0lEitZ4aWWb7Z6wSMMll8f+KPWD6sKhuxfsi4+YW
        0Nxn94Q9u5HDmJqUI8zKJ3gFE2Eu+b+cO5fIo9Q=
X-Google-Smtp-Source: APiQypJYzX3YC2rPgsuTQR6O2ggyRBoFiWW2pJcsW7nszWoPGrKojOUw/ges8p69MPhlPToU8Ed3Avvg9q/o/xvkHBE=
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr6413183pjs.12.1585762517679;
 Wed, 01 Apr 2020 10:35:17 -0700 (PDT)
Date:   Wed,  1 Apr 2020 10:35:15 -0700
In-Reply-To: <20200311024240.26834-1-elder@linaro.org>
Message-Id: <20200401173515.142249-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200311024240.26834-1-elder@linaro.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: Re: [PATCH v3] bitfield.h: add FIELD_MAX() and field_max()
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     elder@linaro.org
Cc:     arnd@arndb.de, bjorn.andersson@linaro.org, davem@davemloft.net,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        natechancellor@gmail.com, netdev@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Define FIELD_MAX(), which supplies the maximum value that can be
> represented by a field value.  Define field_max() as well, to go
> along with the lower-case forms of the field mask functions.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3: Rebased on latest netdev-next/master.
> 
> David, please take this into net-next as soon as possible.  When the
> IPA code was merged the other day this prerequisite patch was not
> included, and as a result the IPA driver fails to build.  Thank you.
> 
>   See: https://lkml.org/lkml/2020/3/10/1839
> 
> 					-Alex

In particular, this seems to now have regressed into mainline for the 5.7
merge window as reported by Linaro's ToolChain Working Group's CI.
Link: https://github.com/ClangBuiltLinux/linux/issues/963
