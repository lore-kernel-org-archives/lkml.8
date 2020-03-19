Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ74WSzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCSP1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:27:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36639 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:27:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id z72so1463815pgz.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rmuAByMN5h8vYPNws3LwAYmJtd2p8b+p+Th3wk2m6Q=;
        b=uJ74WSzBJksh08h4KfEG5X5eYHL+HsFuHWN6KptZvnxvONOE4wmRYmx9oowuX5fdby
         JCKjLknwjWLTUEbJcm/3h7+YE2MhVUpYDMZ9tyrcrEkcN+lXzSCxeTMwCIt9iEBQQzPE
         HkKv4N3fYjPMJjohXdefJGPjeYPKFdk13/xzcxdFF7EtQxzYlRa6JkwLK0j7dits8fR1
         QqdDRJ6BcEPwwECDjS7pUFuWOEFLtpINCCcPelCB0PrfIdQSGQqea77Fj9rlejFbzphs
         caW98Eohv3uzXfiI6kHy7XXC8VA24PA2wjheswNKetEqK0FQjuJR/Ke8UjoVrnQzUsZH
         40xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rmuAByMN5h8vYPNws3LwAYmJtd2p8b+p+Th3wk2m6Q=;
        b=MTSr3cqdBshAD/fLU8EWwsFXh2N/Amgp0oBYOh0kL6CEvMSw0m7EsuCOpnXxBPq8aL
         1d493g1fFHfW7+DnI1PEqCkxzIq4hoepCMeFHhmoORGZJCz6umXZZdlCBraMEek2kcNO
         GYUelorIP4Fd995ULdFD31Qs+J1NXRm+zO3XHih8npQxk1TQGCwMcBEwpRn9bDBeX5u+
         Wx3aHcx+fif9rj5bcJ8oLjPK1mRasg2pH/c9IRoYxKvRoNql23PuKBhGZopFQXrxlYhc
         GWBCCdpIAa8ZYZ3ZQtBoxLP0vfO5T5DvNDBQw/IuWC0jkxAgnonDPtKyVeXaqbzd4C6s
         WeYw==
X-Gm-Message-State: ANhLgQ3ln0svVPoqM1OxiaafvSD131qc/yZVdODWCK955dTd6ubOLO8H
        r0Y2Ge8qCCT5t0kS84Bxnag5v0HMmrDvwd8QZ1kiag==
X-Google-Smtp-Source: ADFU+vtE6J09MbzvyhKDhUz43i8HP57434l8ZA0u/X1fpc3rYYKDDmJNtSA9zvAwdiL+l8Awhh3x9hrGuSCi42aqaY0=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr3980997pgb.263.1584631642900;
 Thu, 19 Mar 2020 08:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200220051011.26113-1-natechancellor@gmail.com>
 <20200319020004.GB8292@ubuntu-m2-xlarge-x86> <20200319103312.070b4246@gandalf.local.home>
In-Reply-To: <20200319103312.070b4246@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Mar 2020 08:27:11 -0700
Message-ID: <CAKwvOdm9notnmKYQqAsTsZN7qqEpNtpQ091wv=rWZ0kzS3OzAA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 7:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 18 Mar 2020 19:00:04 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> > Gentle ping for review/acceptance.
>
> Hmm, my local patchwork had this patch rejected. I'll go and apply it, run

Local patchwork? As in patchwork.kernel.org?  (Is there a client, or
can you host your own instance?)

> some tests and see if it works. Perhaps I meant to reject v1 and
> accidentally rejected v2 :-/
>
> Thanks for the ping!
>
> -- Steve



-- 
Thanks,
~Nick Desaulniers
