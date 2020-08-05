Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2285C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCA022D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596649026;
	bh=0b0E6WKbiQlBVu/fGFXi0So5DhXTlE8qcVrcu7H76Qg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FHe6yDwkWhhDhMYoUlMEy9kAw8ZTDLuhZr4Z2fiRBMX8jnqKgDhq7SEXd8YpHHOP1
	 wlwzEVbQatAAcxvOFkV5wJT9hoK2uT5ox943ovrRozTQhsoUDuXyTzKsqTEb4zJ2Ob
	 hwLY7f997ENw43MptqqcqDaHkvsjQO/XPJjnNqa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHERhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgHERdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:02 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E5C061757
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:32:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b30so24690322lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0O/A2cezVuB/QMtGDV0w8M/cQpgej4IbeFVmCUBKN34=;
        b=g2z0q3DehVGOj6+EVJm4x/hwlkqyBJ+6sjjEolBgDgmrVojA82SWGyPYplXGk6nZz4
         tBDDsgA5D3E9t07YwgHjqIhce2JrBaqR24SLIZ9H7iaBBCDQfXGPdagobUmPf8h2MrgL
         A7vpzsGgHrnqUu6WLBssX3eI8MTOw2kBAKj0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O/A2cezVuB/QMtGDV0w8M/cQpgej4IbeFVmCUBKN34=;
        b=s2DACMfZuU9qs+VSTcwfx5xIt9tcSjfqaKWWrg6wgSKh4aib/EcxzYJZeNeibcFN6w
         eV74mSKVs+Zjs8E97DnE+lA74AIdUNLOT/nqzamBWRBUMJqbI+dNAfHeMpM/BMJD9P54
         l1/Hrm1gEKlzP3jn/lfALeKNaBvNlpXNKtbiM1wzLUV+J21dCAA7ATkUhd5RdTHWd/U5
         zA0acvlHU3wxz+erlEXfsSfWo3PbqPwZxroljQSlUdoPkZ4LR+6LSUbywIRHOLOvBWYd
         fgIp9CfTzNb/S+QGcqYGHlpj1TNHac7UTZmuUhF8kGstC9IwpNP8IMW9A068TuVN5lYs
         ug8w==
X-Gm-Message-State: AOAM532wIkBk8BXFjzQkFyATBVP92tmLGEsABDl0X41R/IYEeGGl7ZBr
        zNYKUng8a11ReaE95vYoNab/9yg8Qqg=
X-Google-Smtp-Source: ABdhPJyNmFdmwnm3KHe9UwHdiHFOc3/NnoFvD3/05v89UKKsTk/d/hGID1NAQPskyBE3e2pEhgFcTA==
X-Received: by 2002:a19:6d1e:: with SMTP id i30mr2072975lfc.104.1596648764163;
        Wed, 05 Aug 2020 10:32:44 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k12sm1378843lfe.68.2020.08.05.10.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v9so14151255ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr2031802ljf.285.1596648762224;
 Wed, 05 Aug 2020 10:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com> <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
In-Reply-To: <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 10:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Message-ID: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:13 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the following Kselftest update for Linux 5.9-rc1.

Ok, it worked fine this time, although now you lost the note about the
conflict ;)

I took the version from the seccomp tree that seemed to be the
slightly cleaned-up one.

            Linus
