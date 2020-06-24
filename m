Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B54C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4A520663
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593003160;
	bh=bGKLOzXs0g6SkMcsLecR7cl0qPhgg12HGv1cwNX6TYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NigBjq4ggS/fxrfSRD7oLBeTj1hiXTDEtNXkDu+QgLS4tzuxLRoYmsRcPgfEdZ68B
	 gWkijWTIxFxZmTSalqH1h9NqGYPbs+2y0LsPL2S8JT49Zxop4miD0rESCycyrWN9RN
	 u4c4n2fW5GG1RQoXRNNYyEwZDRrIwe2t0n/q6ncI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgFXMwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:52:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgFXMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:52:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id j1so1135725pfe.4;
        Wed, 24 Jun 2020 05:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ImZMVmJ6KLEqHAgKJ4c32f0nuRv6OUnQsFfctRSAXJo=;
        b=aq9B/Xquq7abP5W46czT/Y6R0AfQt6SMY2t56fsDVPTTUuHqh3n8759IC7LiWzKPjk
         9pDrbuCKE43BMY5yyu/DY1+aaThShdSqVPXLqw9Ej/9nAZXswXwjlsCFApCp9A5wk4Ia
         56S2A65e3tXtjajxVqXh62RTMBac/9gncxFJ+VeC1QzS3MKKKEeSJ7To01F2bX0iUe/Z
         ZjYqnXEb2hJico4bcPuA2YtGDQHBafYVX8ZC91dStxzivDf+BFItv5QlwXG2hS+3aJig
         A9F2IjgU/b0SspwnpAkV9fHvG8IFGKRTBhwmO+t3FT6J7dl+E+QTt7XxhpLXperTQb3I
         zmyA==
X-Gm-Message-State: AOAM533kBqFXjfTD7+5zoUuwN2YIhwPhXX7YRzOpUOgpr6Bow1FnP1sW
        IzZhNl7SxijYa+6z7KnLn2A=
X-Google-Smtp-Source: ABdhPJzddnf/uaOk9Rgp8vbxcf8lUTdU8rjuvn4Wiik8YZvkhsAy30AnlKe/2Lxzs/SCBU/Spfu6GQ==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr21027891pgq.279.1593003158753;
        Wed, 24 Jun 2020 05:52:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z11sm20679101pfk.141.2020.06.24.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:52:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BAA8F40430; Wed, 24 Jun 2020 12:52:36 +0000 (UTC)
Date:   Wed, 24 Jun 2020 12:52:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
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
Subject: Re: [PATCH v2 2/5] ARM: vdso: Don't use gcc plugins for building
 vgettimeofday.c
Message-ID: <20200624125236.GF4332@42.do-not-panic.com>
References: <20200624123330.83226-1-alex.popov@linux.com>
 <20200624123330.83226-3-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624123330.83226-3-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:33:27PM +0300, Alexander Popov wrote:
> Don't use gcc plugins for building arch/arm/vdso/vgettimeofday.c to
> avoid unneeded instrumentation.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

But why is skipping it safe?

  Luis
