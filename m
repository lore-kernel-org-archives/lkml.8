Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E999C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B48620678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KM2DmTOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbgDBUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:34:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbgDBUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:34:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id c23so2392512pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yY13RK0cKLrRjyvVBZully+r67kfxos978vIN0ruhpk=;
        b=KM2DmTOwPos0F7tLttvMAVY1LIa4ppIAmoFp2MqTGkdJDILQMA+dZFGoZUczJkP06n
         tIY11T4DiaYxZ3XpYIcaUADijDTLfmnhM6w5KLWiXD/U/5E644jQ7tBWEtkWTvI15PEr
         VVKHw3OqKjW7vcSabDsfT8G6FUxq86I+tgWHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yY13RK0cKLrRjyvVBZully+r67kfxos978vIN0ruhpk=;
        b=QKw+RACQb+QLrcj+TYEq085a+3sgVhxkJra5rthr+wBCJP29OUmz1Bl2xdWF9gIZnH
         qmBTeFv0vOR2YPNS3MYKSO9JL9djtMsLPqGUlZ9b0wrkXrGLub70XFY6vLdBosQuzXlN
         Sw+ggo6mRVFEHnSFUlVeAN6Eg/StHHk2d2GVbmSXld6ROr7DuQAtAY9nakXUS2Wy1zvS
         hD9rC1WdFXWJc8CXCc+9HCziNT3uXXVrKdAOQxD3/txWNWVbYAxLZKyifaDWed3FEIsA
         C6oi7sn76yFz9Kc1eX4o/e3xgTTGCApiIlXik3lN9E4WYWQTv1xXtzyv4fdKlyTM/J70
         DybA==
X-Gm-Message-State: AGi0PuYhL+rmnFw4TNbZCk12WzY0W0f7NEwnSBPYYqFUDhINKfIqe2X4
        4doWmaK1o4e7RDWYOxfyYvTN4Q==
X-Google-Smtp-Source: APiQypIs5T+kRG38bpYFVlAfcbXCyZRjGu+qpBmjvk/e/tatzFR3rVbYNciSAuDjjUc5Jz4/iCXxsA==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr5078110pgd.417.1585859673922;
        Thu, 02 Apr 2020 13:34:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e126sm4276397pfa.122.2020.04.02.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:34:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:34:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Slava Bacherikov <slava@bacher09.org>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>, kpsingh@google.com
Subject: Re: [PATCH v4 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <202004021328.E6161480@keescook>
References: <202004010849.CC7E9412@keescook>
 <20200402153335.38447-1-slava@bacher09.org>
 <f43f4e17-f496-9ee1-7d89-c8f742720a5f@bacher09.org>
 <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:31:36PM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 2, 2020 at 8:40 AM Slava Bacherikov <slava@bacher09.org> wrote:
> >
> >
> >
> > 02.04.2020 18:33, Slava Bacherikov wrote:
> > > +     depends on DEBUG_INFO || COMPILE_TEST
> >
> > Andrii are you fine by this ?
> 
> I think it needs a good comment explaining this weirdness, at least.
> As I said, if there is no DEBUG_INFO, there is not point in doing
> DWARF-to-BTF conversion, even more -- it actually might fail, I
> haven't checked what pahole does in that case. So I'd rather drop
> GCC_PLUGIN_RANDSTRUCT is that's the issue here. DEBUG_INFO_SPLIT and
> DEBUG_INFO_REDUCED look good.

The DEBUG_INFO is separate, AIUI -- it sounds like BTF may entirely
break on a compile with weird DWARF configs.

The GCC_PLUGIN_RANDSTRUCT issue is separate: it doesn't make sense to
run a kernel built with BTF and GCC_PLUGIN_RANDSTRUCT. But they should
have nothing to do with each other with regard to compilation. So, to
keep GCC_PLUGIN_RANDSTRUCT disable for "real" builds but leave it on for
all*config, randconfig, etc, I'd like to keep the || COMPILE_TEST,
otherwise GCC_PLUGIN_RANDSTRUCT won't be part of the many CIs doing
compilation testing.

And FWIW, I'm fine to let GCC_PLUGIN_RANDSTRUCT and BTF build together.
But if they want to be depends-conflicted, I wanted to keep the test
compile trap door.

-- 
Kees Cook
