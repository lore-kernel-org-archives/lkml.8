Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E8C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F254A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581374464;
	bh=JhddfdXjg0U4PSVRtNONlS6BkZ9TilpufKsbswmZZ9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SQVCiMWas0aulK4kbCWZld5igA+EnLA7R543ng9UZ2nmjfH/l/69hdQSTAHeyrrA0
	 FkiksbF4Hah+s1SWxNqDmnCMthR5BfU+4RFtoR3XjzaOTMuYdMH0eMZUK6kvx/9z5o
	 NmiYnhVwPP1bG6Idj8a5nXflEHQvLlUWLljeeQ8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBJWlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJWlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:41:02 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90372072C;
        Mon, 10 Feb 2020 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581374462;
        bh=JhddfdXjg0U4PSVRtNONlS6BkZ9TilpufKsbswmZZ9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q3dhWq9Ytf6KzOEfCuFQLNb0leG35v2nrkfV8vE8Dx++4CtlRI873FYlzjohjDq6U
         kWv4a98eiI+8/Q1NK9iOP7srm1POK2XrZn1UwNhkHQIt8Bg1b2kTtoOYzEiLGic+5O
         30vwN6+zdBRYWYOMrfaFVw11Gko3pgMEAAmojNAU=
Date:   Mon, 10 Feb 2020 14:41:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] lib/test_lockup: test module to generate lockups
Message-Id: <20200210144101.e144335455399d6d84d92370@linux-foundation.org>
In-Reply-To: <158132859146.2797.525923171323227836.stgit@buzz>
References: <158132859146.2797.525923171323227836.stgit@buzz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 12:56:31 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> CONFIG_TEST_LOCKUP=m adds module "test_lockup" that helps to make sure
> that watchdogs and lockup detectors are working properly.

Now we'll get test robot reports "hey this makes my kernel lock up" ;)

Is there any way in which we can close the loop here?  Add a
tools/testing/selftests script which loads the module, attempts to
trigger a lockup and then checks whether it happened as expected? 
Sounds tricky.
