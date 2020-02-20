Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D9C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76183206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNgGUgcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgBTXFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:05:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34098 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:05:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so2690701pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c0kZSeFM/+814IXGYlA2mUh7BiAgeVF3A/1ZFnTcsZc=;
        b=oNgGUgcXPIIzpKoyYuQCg2iZgDGOqNq2Nuywq1XBACo+UkBmEshyJJcH4Rq/FYPAyV
         wmpxnA+i3Uj2NsKgZB7+n+cELRd+40ZezWMN3LL3O7GAvIzFSkQ7jxZrbtedJlR/P5zc
         qznGHo5Zt1TIpx7dru+9PdeL5yFGhMh8D4Ztc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c0kZSeFM/+814IXGYlA2mUh7BiAgeVF3A/1ZFnTcsZc=;
        b=Xe3rNAUv6yZUOZ7iQf3PcpnZZJ+CnzvfmUNjbfjv1C/JrOLMxX4RdeZb00Zva3244r
         VwXE9pb3iM12ZJ9elsRAKtw0EpRJFT0ywYAaUjwtwtnuPYlDLEbP7PoEyywKs4H4EfPv
         7k6WNZMQEpdjxan6G70nCjQQ7W9iahrZBy6Sr4kgjCbRPlbyT5oUKqh5ncjt8fRG0+3l
         zsuuJiE6t+yLzv8JxxV7JwYTylCWrcWN/oNU6xVuiu8MFh5cZxbow0ztiFZDbqKZ6n6M
         06fMJg9bbNx3lwDbDH+YI+3W2Y3TRlz8jCE2Coml6p7tfpVsuMwARrsGdqJwAfLAzM4J
         RiiA==
X-Gm-Message-State: APjAAAWr3mfp/WLevn0pOPhvQ13MZXkrqsd5U9edSw3DTyyGrpXNo0+6
        Z5tw6IRhhLpXbbrp4dwH27BOxw==
X-Google-Smtp-Source: APXvYqxk+KNXpddw0Soriz9dh3hS8Ty+wHgvXPj77cXIpL/9OafL5vZZNFJjY0dqa57hetm/W/6LdA==
X-Received: by 2002:aa7:8f33:: with SMTP id y19mr32954425pfr.47.1582239938288;
        Thu, 20 Feb 2020 15:05:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm660356pfq.33.2020.02.20.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:05:37 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:05:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Alexander Potapenko <glider@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/xen: Distribute switch variables for initialization
Message-ID: <202002201505.C3863B2D0@keescook>
References: <20200220062318.69299-1-keescook@chromium.org>
 <16a166da-c6e7-aa36-53a0-1b56197c8fc0@suse.com>
 <8a7f5bd7-2bb6-d187-cc6e-87ff01c440ce@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7f5bd7-2bb6-d187-cc6e-87ff01c440ce@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:33:41AM -0500, Boris Ostrovsky wrote:
> 
> 
> On 2/20/20 1:37 AM, Jürgen Groß wrote:
> > On 20.02.20 07:23, Kees Cook wrote:
> >> Variables declared in a switch statement before any case statements
> >> cannot be automatically initialized with compiler instrumentation (as
> >> they are not part of any execution flow). With GCC's proposed automatic
> >> stack variable initialization feature, this triggers a warning (and they
> >> don't get initialized). Clang's automatic stack variable initialization
> >> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> >> doesn't initialize such variables[1]. Note that these warnings (or
> >> silent
> >> skipping) happen before the dead-store elimination optimization phase,
> >> so even when the automatic initializations are later elided in favor of
> >> direct initializations, the warnings remain.
> >>
> >> To avoid these problems, move such variables into the "case" where
> >> they're used or lift them up into the main function body.
> >>
> >> arch/x86/xen/enlighten_pv.c: In function ‘xen_write_msr_safe’:
> >> arch/x86/xen/enlighten_pv.c:904:12: warning: statement will never be
> >> executed [-Wswitch-unreachable]
> >>    904 |   unsigned which;
> >>        |            ^~~~~
> >>
> >> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> >
> 
> Applied to for-linus-5.6.
> 
> (I replaced 'unsigned' with 'unsigned int' to quiet down checkpatch )

Oh, good call. Sorry I missed that!

Thanks!

-- 
Kees Cook
