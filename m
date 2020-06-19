Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55783C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6920675
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wos3wqRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgFSDmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgFSDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:42:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADAC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:42:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v11so3898293pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ylj+KbsOX76QNrUjj2VobkcpDWhDyawSP5wEBfqItRA=;
        b=Wos3wqRNr6giopwl7Ps797+D/UE+C34msegI+7bk+NOANm7xwlQgbmdMHILTzP/+Qh
         QxvdwZuO/nNW22FpNV799fSHpqJZvRbyVtXrOw+w56g23CVlW6VslBCgebkVcP9KQXX0
         i9JOA5DvM0E8m0JiwcLCXtTMI7/JNofOh+/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ylj+KbsOX76QNrUjj2VobkcpDWhDyawSP5wEBfqItRA=;
        b=rA0B5aVhLJm41dxpwmPbT1xMOi7GckLfbIh3+/NDcFfqdmlHMMF4fnZAtku/kl/eEJ
         kMYnvCB3gbjhl65rTk4DJyjKhkcbI0MFg+Qlj/qQ8dJoeGDfZ7/uRinAdWlx80KfKarT
         wGpXT2QIhFx5zCjpzO03ZudOjYHiMOD57jtEhBx+rgQX33Cyh+C4z53LFHmPjcinyMPe
         FDIJhLGS3+9k0zYhHqYZicA6sQw5qcS3TOVQiVWiBMiy89800ZwXOuJe8bJgq+7gpgxg
         JI6OwwuQSUZXR2DEeBpqd/Onwo4N+dUta1vjzeuE2oXu5+1OMbAW52YxnbQLlZgy9oe2
         Cflw==
X-Gm-Message-State: AOAM532jf41/ti0W+gGG8S4S7KmEk+6grx+bXIDOodNWtONuFq5vMU+x
        yOhvvZyuo+2l7SujtfEr2FU0rA==
X-Google-Smtp-Source: ABdhPJzzGJYAhwVkP7J4IYD2kzImEk41O+zNGDOowEtJkbh+VyxQSFTwMHUCTD1U6pKjg40y7tCahA==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr6651490pff.1.1592538123475;
        Thu, 18 Jun 2020 20:42:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm4355572pfd.21.2020.06.18.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:42:02 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:42:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
Message-ID: <202006182016.C93BC8AB@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
 <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
 <202006141005.BA19A9D3@keescook>
 <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
 <alpine.LRH.2.21.2006160956170.16027@localhost>
 <CABVgOS=-AHNABkAVV7p=pq67hwoVcXXJSEPvxNbp90Eh_RaxBg@mail.gmail.com>
 <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:27:55PM -0700, Brendan Higgins wrote:
> I am cool with changing *-test.c to *-kunit.c. The *-test.c was a hold

I am fine with basically any decision as long as there's a single naming
convention, *except* for this part. Dashes in source files creates
confusion for module naming. Separators should be underscores. This is
a standing pet-peeve of mine, and while I certainly can't fix it
universally in the kernel, we can at least avoid creating an entire
subsystem that gets this wrong for all modules. :)

To illustrate:

$ modinfo dvb-bt8xx
filename: .../kernel/drivers/media/pci/bt8xx/dvb-bt8xx.ko
...
name:           dvb_bt8xx
                   ^         does not match the .ko file, nor source.

Primarily my issue is the disconnect between "dmesg" output and finding
the source. It's not like, a huge deal, but it bugs me. :) As in:

$ strings drivers/media/pci/bt8xx/dvb-bt8xx.o | grep 'Init Error'
4dvb_bt8xx: or51211: Init Error - Can't Reset DVR (%i)


All this said, if there really is some good reason to use dashes, I will
get over it. :P

(And now that I've had to say all this "out loud", I wonder if maybe I
could actually fix this all at the root cause: KBUILD_MOD_NAME... it is
sometimes used for identifiers, which is why it does the underscore
replacement... I wonder if it could be split into "name" and
"identifier"...)

-- 
Kees Cook
