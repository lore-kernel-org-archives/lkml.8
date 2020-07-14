Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB24C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF662064C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XR5InLU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgGNViZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgGNViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B294C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so8342557pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=XR5InLU/ZuYgwGb0JtnB3ih96loG0AE59nbhZISKaA1qecqUWLJaYCd13NQJ3Or6sC
         +3LfdAmhLom67MejtQ6qgLpS0M6Dmkf1Wsb8or6ZSMX/ni3TgDMdp8V4HIp9Y6BLUVn0
         iB1MILb/MoIgDVtacC26ydy565jdZ3reUFdJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=gsOS6tlwDwymIV2TZVbSGiOXbv219Md7DjmmLQ90ZOIbI2aiC3Nsx/iYgpHtg1vqlR
         Pbp44EW4pXT6YeVWQb+Af3ncyuPh691T1myT/EauvJN+kSVPiReq+lkyP0iJuMBJ/fOo
         +2DFvuQFkGlt12+JF3OuFk1HLVCSkS0ygaX3zXmSxgTVgl/3nAEYbpniK0lntBKre3Pp
         oFjTEnJSthynv+d+OpY15imF4luM8ZSIuikzWSAcWnDsh028q6hd8XtyEcmZmYh87VF/
         BNLoDXT11OAp8QroHrsxFKKN6huJ1VE+ozurS9BhReoEwYiTkYfD25pw/HCa7nRszCJ6
         03Gg==
X-Gm-Message-State: AOAM5308nbJaaZ79zGcnf46clKHFSwl4wW7NllfQ3Vhdqg2AH+SXtRiy
        9LoFYH73Um0fEx5LQEcVpffr8w==
X-Google-Smtp-Source: ABdhPJz6b6t7d1xxynzW3FbpvoGzvZ0dDIPSG7G6/UnTLzQBeOIoJTyLQKUygq9QebBJSIO7rhfuVQ==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr4803979pgp.452.1594762703715;
        Tue, 14 Jul 2020 14:38:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm109930pfb.190.2020.07.14.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/7] exec: Factor out alloc_bprm
Message-ID: <202007141438.C4E2A2A9@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87pn8y6x9a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:29:05AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Move the allocation
> of the bprm into it's own function (alloc_bprm) and move the call of
> alloc_bprm before unshare_files so that bprm can ultimately be
> allocated, the arguments can be placed on the new stack, and then the
> bprm can be passed into the core of exec.
> 
> Neither the allocation of struct binprm nor the unsharing depend upon each
> other so swapping the order in which they are called is trivially safe.
> 
> To keep things consistent the order of cleanup at the end of
> do_execve_common swapped to match the order of initialization.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
