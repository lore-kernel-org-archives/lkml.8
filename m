Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A70C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799C320728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRBr4FLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEV1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:27:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40223 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCEV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:27:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id t24so32205pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtiKzPpj8LFUymwSB7yTCNI/ZF3QVUV6m/8sRe74jM4=;
        b=oRBr4FLijrduwoNUKzThW1pzbMbuel52u18sGML2FWtMFIppQsC5WrydR18VOc2DVW
         hPGyQlUvw2GvTRfe2Zd5SmqiARI1lYo9r0C2mchmdOKvUC+IO9X2QES5eu7CcSRdnkhs
         XpSaKYEA4NgV/zoDKF0l6wUjuqj567yZbzxbidkawyB5EvM9/vjsriViU0aaz0xzbOv2
         TvyPuQsJEElz9CngC8iqddtlNanSmDUoNQC8TYVM0fodKKnirkZP3SlCxUS9XhR64ayR
         V+Q2T4DL5gx7NjaOTb0nqMm3a5XMg2TaF06BC+NLW9IPpcFXCCjN1selMaZgT5CLsBOM
         4UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtiKzPpj8LFUymwSB7yTCNI/ZF3QVUV6m/8sRe74jM4=;
        b=mvHX+HYtgG5IoJ8kfSE3Z/vwSW1n+4iNrmgE0OSb0sEANFkNQ8HuObpAGIcmkrEgoJ
         DEjgaV86D1sNvYXkUGxkBc2ybMskWNh3ejOcJe5AJFKdtI0gVF+fnFICou2YOxUc6+Ew
         UzMtu/uZmsFXyd19o0LdinZLrmlZvp7saAdUGqSZW5juAC+7pKAnQTXZFVlFzOkqQ42h
         uRXyfHpjsVTpVb1vyDWoIPqmknbDke8O7V0jZrj//ipt9K5gjH7Aa/bILM+CfiAJ6UkW
         i8n9yVxQEJLETq2XbUFgdhOAhHPvaLIAmLswIvxY0Skg+HosyphSbUJ9gYEXiPep8nrS
         eoCQ==
X-Gm-Message-State: ANhLgQ1xAvoscNG1qZ2l5OpXTsVhMm9K0nJkO0/m6c2mHYup+zhdKD5a
        3eKBQT7ih2eRVDSr5FkyjMqZMcOioaSsD4iikwNA8A==
X-Google-Smtp-Source: ADFU+vv1ccqmownE6Ld6bBaNNfKO9+DSifBwb0CTWOQ7cMNitASw2cC+2IapEYQTfniJm4gw/d6RJSKIjoNXzef1WYI=
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr102259pgc.201.1583443625213;
 Thu, 05 Mar 2020 13:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20200305200409.239406-1-heidifahim@google.com> <20200305200409.239406-2-heidifahim@google.com>
In-Reply-To: <20200305200409.239406-2-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Mar 2020 13:26:54 -0800
Message-ID: <CAFd5g46Ht=+ueEyMZPVfG6G-APSTf5j3ragRrxH6=HJFffmi9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: Run all KUnit tests through allyesconfig
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Implemented the functionality to run all KUnit tests through kunit_tool
> by specifying an --alltests flag, which builds UML with allyesconfig
> enabled, and consequently runs every KUnit test. A new function was
> added to kunit_kernel: make_allyesconfig.
> Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
> which call make_allyesconfig. This function calls the make command,
> disables the broken configs that would otherwise prevent UML from
> building, then starts the kernel with all possible configurations
> enabled. All stdout and stderr is sent to test.log and read from there
> then fed through kunit_parser to parse the tests to the user. Also added
> a signal_handler in case kunit is interrupted while running.
> Tested: Run under different conditions such as testing with
> --raw_output, testing program interrupt then immediately running kunit
> again without --alltests and making sure to clean the console.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
