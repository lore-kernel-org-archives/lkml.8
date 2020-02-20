Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8871C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcmu9VVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTRmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:42:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41643 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgBTRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:42:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so28343525oie.8;
        Thu, 20 Feb 2020 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9Dt1rTQG+8mW00nE6RUDWzEXyX1oi0U9gjEJm6wv4s=;
        b=tcmu9VVzizK8IROczB8VVVl9RZBBLv1YGv/Px0Q7BNuoVIstuIDvu34mAsDLvruOVN
         HI+JwJEiHh0JS2J+sBEEwx4a01xgn9h1zaxMR3yxdyQSr6PdLdESqHupqqQzzs4LeYI5
         BzJzdcp4nIblN1k6fT+Pv0C8dS0fbB8m6SfUl7owcMD3FREgSMi9CMYqG9Zy1qIpH+mZ
         cLJrIb8FRmYMJCZMCK0UR/3ZO+3tzar9z1t0fPk02ClPhc2b+62Y/zVtGFAZFwokWged
         RC4Rk15VdbhmrG1d1Rx1XMcrIAi/5eA3uw+oTXDwX6bRSh4VitOqAg+cNuXf2sOniWhq
         kSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9Dt1rTQG+8mW00nE6RUDWzEXyX1oi0U9gjEJm6wv4s=;
        b=SbOYFc+pOSn9g0lDsHCJStb3L0pW+J5C42Gf+Dfl9sAExFZizMABDJveNLyvCB6n+I
         NocK75zASW/F0U5pnH9reVLBhqYhmETx3O2pDZWsZU4WlXojE0tisvUm5l/dceDBQWX5
         FSHaoZtT+vj++5pHB9bODOR9uXGl/YxWnf4jkzAsXH/FIAEq4FYf38uTMXQR4pXImrQp
         8RMwFkY1h7dzRf1DBPMrc8MjdIdhZZlIrlcsTCY2cKQhuIYb+ZSWnz15RMA2k27D3Q20
         mHBh3Lzemm9NpCty4PzD4UVtTV8fxYhns2jOEfYCHQ32dBArbcCg6kyTzoxzD6zeDZO3
         5bWQ==
X-Gm-Message-State: APjAAAW3oLgR4+NUaJMVW6k8/kBNJERih0yhT/EykTO2Ev36Zc+qgtXS
        lyF+CuCKOrscStMDyRDxFyQ=
X-Google-Smtp-Source: APXvYqxbLUqsEbxRGFXijT2Nf67SribXo4ggAKLcOk45tQeVOHhOH1C5QNpP5jFmuPDtRxWiRwqPhw==
X-Received: by 2002:aca:ec15:: with SMTP id k21mr2936699oih.35.1582220565218;
        Thu, 20 Feb 2020 09:42:45 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r10sm38162otn.37.2020.02.20.09.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:42:44 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:42:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Message-ID: <20200220174243.GB40621@ubuntu-m2-xlarge-x86>
References: <20200220110807.32534-1-masahiroy@kernel.org>
 <20200220110807.32534-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220110807.32534-2-masahiroy@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:08:07PM +0900, Masahiro Yamada wrote:
> Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") made this always-on option. We released v5.4 and v5.5
> including that commit.
> 
> Remove the CONFIG option and clean up the code now.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
