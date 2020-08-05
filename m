Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA942C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944AE22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GyDUOv4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHEXE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHEXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:04:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:04:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so5448662pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0keigPLovrjjXP6rE79hwi6ucgKqLoetC6uBOfGO/qU=;
        b=GyDUOv4VH9q2qbfSz78jjmLG870CKZ3aNCMxPgYeb8WQTUovaRrTVqBhk328z9W5Dy
         fc61B7RsLVmQNAOP6hntpWE9b0nJtZ7OUOddUZ+AoJkbDhDzC56zaYqej7uDSj3571PG
         hAfR525PJmw0THaugMkMgHjej/WHuHvQwFs24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0keigPLovrjjXP6rE79hwi6ucgKqLoetC6uBOfGO/qU=;
        b=OiVzy6p6FO4lw4+x7kuG4t3ZktcYomdPsd+N2mBTmo2XNTKvikXjgz8plnNyQui5BX
         bZb07VS3RR1KD/fksFruv0DwrxWF7LOlsys+HFfPpmL5KvuupmKXtClMBSfcJLGFdvdH
         pOdRc4Jlt3zh+q82trhjHiEdqfz7P2O9UZRlUcsDnwpEBKS47SvOz943tpzHGGHYSNvd
         pV+rVtR6F4XhfV8ub06QwgmNDFO8w5jwfEI3kB1YxkKAI9Bca2tUWqNH+4ox2rElO9aY
         72MvKcsj8rMNxfjk8eK+xWeHDSp6nRUlWURVfg0sjx/QOFg6xAwEwIIwcNvth6cZ06HB
         h8/w==
X-Gm-Message-State: AOAM531KNlQr7A6ybWYkrX8Qc+BGdJtllY5bSvEBPqmXCb2wBWvdWjkD
        W0dPhmiELnLsDDn8o4uQat4LVQ==
X-Google-Smtp-Source: ABdhPJyschqjLEDSti7kIO/sIsNM7ojJPY5vcJo5ssVictNPiRZG3zshwiBuIlDkQASRcG5JArl0SQ==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr5389127plb.57.1596668692888;
        Wed, 05 Aug 2020 16:04:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id f3sm5411762pfj.206.2020.08.05.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:04:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200805225015.2847624-1-ndesaulniers@google.com>
References: <20200805225015.2847624-1-ndesaulniers@google.com>
Subject: Re: [PATCH] scripts/gdb: fix python 3.8 SyntaxWarning
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Aymeric Agon-Rambosson <aymeric.agon@yandex.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 05 Aug 2020 16:04:51 -0700
Message-ID: <159666869118.1360974.14801812436095725860@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Desaulniers (2020-08-05 15:50:14)
> Fixes the observed warnings:
> scripts/gdb/linux/rbtree.py:20: SyntaxWarning: "is" with a literal. Did
> you mean "=3D=3D"?
>   if node is 0:
> scripts/gdb/linux/rbtree.py:36: SyntaxWarning: "is" with a literal. Did
> you mean "=3D=3D"?
>   if node is 0:
>=20
> It looks like this is a new warning added in Python 3.8. I've only seen
> this once after adding the add-auto-load-safe-path rule to my ~/.gdbinit
> for a new tree.
>=20
> Cc: Stephen Boyd <swboyd@chromium.org>
> Fixes: commit 449ca0c95ea2 ("scripts/gdb: add rb tree iterating utilities=
")
> Link: https://adamj.eu/tech/2020/01/21/why-does-python-3-8-syntaxwarning-=
for-is-literal/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
