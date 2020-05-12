Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E20C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D22207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heaGQ23g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgELSxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELSxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:53:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:53:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so6804318pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10CAtnJPyt3YsHXJ+2Wwl/Z5XTY3/zgL7Nq5MQ1jRF0=;
        b=heaGQ23gQS+0fqlyfYmHBx+MAlnUe0fojiixaSjG46yoB8ra2O5SPA0QiOOPoMwZfq
         JipEIaffmFm0n+zhSY/POjSl6DvPBF+KOFv4UNyKeWK4OJyKNacYo1bK69MEr/vqJHs5
         aSZ2U41dwR3fnQORRVGv0bFwdCEUvVXRuO9rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10CAtnJPyt3YsHXJ+2Wwl/Z5XTY3/zgL7Nq5MQ1jRF0=;
        b=Nynm7/rzyiRtOpCI4WAsyHBSNttq4dWS58ciBV1ruBItzBKmlBEUTCyAhhX0Vi2Pyp
         NCF2beOIk2JFBjEIBzRImxqAGoVca0ucR1SIllZa4sICLPv7ndfLpYhGzx3P7oTywDBt
         cDBpKpsZlwJE5aEYgGis3vPspDZNfLwDhOofNmaMhmElKNehVK4dcre4krURXD3R0VVj
         uRY0rUsVz0DgpVNsmrUuQqihGak2L8VB7G+pFiu94jGTuCE2Qx9zH6C1TpVv6Q4/VcBJ
         p9QIUQ3Ps7kFz1l5jhjTuERSRBK6I1vpidDXHxDUfr2+ASYN3sqHT6NYx/evv1zdfyYZ
         wZ3A==
X-Gm-Message-State: AOAM530YoplDyBEMMcgEXlYHO2HHOOLLuLDDFHzlxko3uIDkn6BkKQLa
        4SqRSPyyw7yItYpUyaLpIco03A==
X-Google-Smtp-Source: ABdhPJzXPMZiCC2kuNmM2zIsvtc0DroVVWaVG/lLtZUDXw0W8UTadX12hTFMgAIvscCnjlE9FYDLXA==
X-Received: by 2002:a63:3c8:: with SMTP id 191mr1850816pgd.320.1589309624226;
        Tue, 12 May 2020 11:53:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a196sm12690995pfd.184.2020.05.12.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 11:53:43 -0700 (PDT)
Date:   Tue, 12 May 2020 11:53:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Petr Mladek <pmladek@suse.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Message-ID: <202005121146.3B3C1FE0D@keescook>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
 <20200512155207.GF17734@linux-b0ei>
 <CA+CK2bC0argMNHzynedpwN6ekOg8yypN03JvmAKGWQ5Aegxh+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC0argMNHzynedpwN6ekOg8yypN03JvmAKGWQ5Aegxh+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 12:49:10PM -0400, Pavel Tatashin wrote:
> On Tue, May 12, 2020 at 11:52 AM Petr Mladek <pmladek@suse.com> wrote:
> > I wonder if anyone is actually using the ramoops.dump_oops parameter
> > in reality. I would personally make it deprecated and change the
> > default behavior to work according to printk.always_kmsg_dump parameter.
> 
> This sounds alright to me with one slight problem. I am doing this
> work for an embedded arm64 SoC, so controlling everything via device
> tree is preferable compared to having some settings via device tree
> and others via kernel parameters, especially because the kernel
> parameters are hardcoded by firmware that we try not to update too
> often for uptime reasons.

I'm entirely convinced that this area of pstore needs to be cleaned up
and I want to have the pstore backends be able to declare their kmsg
dump reason filters in a configurable fashion. So at least on the pstore
end, I intend to have some way to do this.

> > IMHO, ramoops.dump_oops just increases complexity and should not have
> > been introduced at all. I would try hard to avoid introducing even bigger
> > complecity and mess.
> 
> I agree, amoops.dump_oops should be depricated with or without
> max_reason change.

Yup. dump_oops will be deprecated in favor of whatever we settle on here.

> > I know that there is the "do not break existing userspace" rule. The
> > question is if there is any user and if it is worth it.
> >
> > > I agree, the reasons in kmsg_dump_reason do not order well  (I
> > > actually want to add another reason for kexec type reboots, and where
> > > do I put it?), so how about if we change the ordering list to
> > > bitfield/flags, and instead of max_reason provide: "reasons" bitset?
> >
> > It looks too complicated. I would really try hard to avoid the
> > parameter at all.
> 
> OK. Should we remove max_reason from struct kmsg_dumper and also
> remove the misleading comment about kmsg_dump_reason ordering?

I'm also fine with this. I can have pstore infrastructure doing the
filtering if kmsg dump doesn't want to. Given the existence of
printk.always_kmsg_dump, though, it seemed like it was better to have
kmsg dump do this filtering instead.

At this point my preference is to switch to a bit field -- I don't see a
reason for ordering. The only cases that remain "special" appear to be
PANIC and EMERG (which, again, aren't ordered adjacent).

-Kees

-- 
Kees Cook
