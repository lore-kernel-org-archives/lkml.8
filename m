Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC6C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731942074B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRxDHte9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGNVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgGNVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:37:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C0C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:37:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so8338407pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3wJCA26EnDH+H7697aEgwc1sqImArY0F/o+Wd8m8BHk=;
        b=aRxDHte9IfRADQK7+FQrSyXLyc+PeMeFt77R7Wbn8+P2a2zh6nokjwFYGqTEwbXRXz
         fm5tmBHJ08riJufPAMlvXx2HV1a49fx7f2kGG6SJshBwguHUNLZ07GMcapjS5LY5xHv8
         8b1r3YNKte34UREHrvrLR1xWE2wNoy97pkUjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wJCA26EnDH+H7697aEgwc1sqImArY0F/o+Wd8m8BHk=;
        b=CzwaLJDdrG5LG7LITaeI0Q3J8WMDGhbElY4mPSTcdGuGb0MkP6gdq1BJ4Jdovj89mN
         Az1icfZiINKyeC6ShPiko7abQ+YbvwPzftOK3IKLfQEQzLt617LsaZrNxye857sNGyIe
         hhpwFEHNuY7LiG+kkxlIX/0xPVdJIry0qeI9w7XL8p+MPv6dFLIRNwpV8YGgzmoendwn
         Ui6tLpCT0KPbuo6XXRvTwXNZePKl28hVkrpZ+BSCZcRUb85pbcWvOPZWhSAVAZDQLVi2
         SQewGNj4K5CQxXPH6476ZLzcZ2rgKpE9FBIGWtcVPYe3G6Z4pEaaLHgaGD2WoVwNH+rF
         dZ1w==
X-Gm-Message-State: AOAM5318xBY6+fE8eH9cSPV4Zd+36L0XsAXnl+lB3crGfEPEcb0CYAVa
        E2C8z8mN7YXWh5ZIVqVxoTVUkA==
X-Google-Smtp-Source: ABdhPJwedjvcJkbbWHA56bL2e2voI8icupI3iRU3xdjuXkmvA/IIiBaCmNDEWGErll1rlA5J8eKHgA==
X-Received: by 2002:a63:1f09:: with SMTP id f9mr4900532pgf.324.1594762650142;
        Tue, 14 Jul 2020 14:37:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k26sm87486pgi.16.2020.07.14.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:37:29 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:37:28 -0700
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
Subject: Re: [PATCH 4/7] exec: Move bprm_mm_init into alloc_bprm
Message-ID: <202007141436.960E2E647@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87eepe6x7p.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eepe6x7p.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:30:02AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code that
> launches init to use set_fs so that pages coming from the kernel look like
> they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument copying
> from userspace needs to happen earlier.  Move the allocation and
> initialization of bprm->mm into alloc_bprm so that the bprm->mm is
> available early to store the new user stack into.  This is a prerequisite
> for copying argv and envp into the new user stack early before ther rest of
> exec.
> 
> To keep the things consistent the cleanup of bprm->mm is moved into
> free_bprm.  So that bprm->mm will be cleaned up whenever bprm->mm is
> allocated and free_bprm are called.
> 
> Moving bprm_mm_init earlier is safe as it does not depend on any files,
> current->in_execve, current->fs->in_exec, bprm->unsafe, or the if the file
> table is shared. (AKA bprm_mm_init does not depend on any of the code that
> happens between alloc_bprm and where it was previously called.)
> 
> This moves bprm->mm cleanup after current->fs->in_exec is set to 0.  This
> is safe because current->fs->in_exec is only used to preventy taking an
> additional reference on the fs_struct.
> 
> This moves bprm->mm cleanup after current->in_execve is set to 0.  This is
> safe because current->in_execve is only used by the lsms (apparmor and
> tomoyou) and always for LSM specific functions, never for anything to do
> with the mm.
> 
> This adds bprm->mm cleanup into the successful return path.  This is safe
> because being on the successful return path implies that begin_new_exec
> succeeded and set brpm->mm to NULL.  As bprm->mm is NULL bprm cleanup I am
> moving into free_bprm will do nothing.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

This looks correct, and is required before moving the arg pages stuff,
so good. :)

-- 
Kees Cook
