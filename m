Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADFC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A32D2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYYArvhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCWTsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:48:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWTsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:48:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so18686499wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DpJzr60RYH1YHVeyAiSvNUlbvp8CoyZnIEyzGyGJIf0=;
        b=YYYArvhMrddRhLjVhyEYKPKfh4GTqwNmNMEUs45MCXfUsTsARG0MPtNgY4fo2iT6Y1
         ouXyxE842tFyWhJ5Levjm/QqUPGpTUIj6KunvmQKz4JnVZvP8mVCWgzhHyBUBgdRiXze
         qAkqWKvEKYkfvAr+IP9NRLtF7ING9QoSE/QCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DpJzr60RYH1YHVeyAiSvNUlbvp8CoyZnIEyzGyGJIf0=;
        b=mgT4wBzXpuDRAr9aXE8OIFmbXwjbvo13gtA/4tmX57eoLFYViSzLX1cyUqm9sc5tot
         +YqW4lVyFJuspD12I+KWYtvKLuYkqDWCQCP0bSOEon4wncKc+roGyxldCvSOkqdi1dqD
         xkVErO6wX6K6N4p4vmUvq/F37mYokmzEP2Ue08BKxUz7Q4MS1x0yXw5EQ2CklC4/Sbxw
         7r80lKjWdBTm8XeM5hvEE4uaZ54E24vyGRg5P37WiMV4IpsBbvx8mUFqcawnZFKqdnrM
         D3Q09vVKYSbMobnpJqeGK4YlaAlml6Gj3/YxrioSHdrLESVLWeiUun7gJTBy6zUF1tZT
         w7eg==
X-Gm-Message-State: ANhLgQ1e6ylixrL5TnVO6JTbYVQlBhhP117Qjf8BGStRgea9DRMt0p08
        KwHmMOSbFyh+LwW9bn0KDBrrkg==
X-Google-Smtp-Source: ADFU+vv1U6VIAdemYMnEy9FSr5lCJAP64BaIJKTie9ZvD3AjbyfxtN8VblU78oyqhuq7U1TPCzFMPA==
X-Received: by 2002:adf:b31d:: with SMTP id j29mr17628886wrd.218.1584992882202;
        Mon, 23 Mar 2020 12:48:02 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id s7sm24212509wri.61.2020.03.23.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:48:01 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 23 Mar 2020 20:47:59 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200323194759.GB18787@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003231237.F654B379@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Mär 12:44, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 05:44:13PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > The bpf_lsm_ nops are initialized into the LSM framework like any other
> > LSM.  Some LSM hooks do not have 0 as their default return value. The
> > __weak symbol for these hooks is overridden by a corresponding
> > definition in security/bpf/hooks.c
> > 
> > The LSM can be enabled / disabled with CONFIG_LSM.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> 
> Nice! This is super clean on the LSM side of things. :)
> 
> One note below...
> 
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>

[...]

> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/bpf_lsm.h>
> > +
> > +/* Some LSM hooks do not have 0 as their default return values. Override the
> > + * __weak definitons generated by default for these hooks
> 
> If you wanted to avoid this, couldn't you make the default return value
> part of lsm_hooks.h?
> 
> e.g.:
> 
> LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
> 	 const char *name, void **buffer, bool alloc)
> 
> ...
> 
> #define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
> 	LSM_HOOK_##RET(NAME, DEFAULT, __VA_ARGS__)
> ...
> #define LSM_HOOK_int(NAME, DEFAULT, ...)	\
> noinline int bpf_lsm_##NAME(__VA_ARGS__)	\
> {						\
> 	return (DEFAULT);			\
> }
> 
> Then all the __weak stuff is gone, and the following 4 functions don't
> need to be written out, and the information is available to the macros
> if anyone else might ever want it.

Thanks, I like it!

If no-one objects, I will update it in the next revision.

- KP

> 
> -Kees
> 
> > + */
> > +noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const char *name,
> > +				       void **buffer, bool alloc)
> > +};

[...]

> > -- 
> > 2.20.1
> > 
> 
> -- 
> Kees Cook
