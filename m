Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DDC35660
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD3208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjzllT9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBUTly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:41:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37406 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgBUTlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:41:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so3323629wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lF+X01NQeyowOxsjGyQ+K+InDP6nyF3s7HMSuCIuqwU=;
        b=EjzllT9j0FNgXh1gzp7ZKM8N0I91TP8vAm+bivdngSVLKq+0Euegsefdl+EWU6IdGD
         JfHB+Oo9gLRRQrSy4UYadFpYIhdU5UzkXn6LbpRsAoT1YKLo7m/QhEGJMp4BVC1oX25h
         fxQ/ObVXBcP3rVK/4oaOYEep3dzK7dFngxXR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lF+X01NQeyowOxsjGyQ+K+InDP6nyF3s7HMSuCIuqwU=;
        b=rih+5zh1CQpMqOPhnvAmUB3Bclve0kiDp35DhQHOlIGs0nBWSP0y6trTsNKDvgf6Cw
         WF0N/HMSbAD5uhQvXIywj6A2WLP/qq5iIxUGDPmi0iFsaOWIhOsah+iZE8KGYFBMkmos
         eRPsK+WqEfNzaKiwY+fIGVg3qgkTduo3Ss3xtpARlfxb3AJt/wXc+x5MZ3UOJi6kTWhf
         9wHg9wCsEnbDrkgeq+zBN65mrbQToqeSFmx8Cp1MCDcb1h2PstpR0DnSe/E2nRhzcZtx
         tCacKk4OjmsZIYpMUtkZPyWbb0nWcOQXfOMeknBvRjG/Ey6KnWh10+BW5u5qd7jvk4sq
         X6kg==
X-Gm-Message-State: APjAAAVoQDCJWkuxQQO53c9cmJ4X3QlAS3o2L0COPZEyTm3b7HK92p0U
        Chx8BtyP60PBWJpn2ttpomK1Dg==
X-Google-Smtp-Source: APXvYqyL2tJY+xCx1IxetlPHAreYcfbb2r6BdONhVVQhPwEP6L4cDen3gHqn7ZWgxMe1TyhBVYCdtw==
X-Received: by 2002:a05:6000:128a:: with SMTP id f10mr52557069wrx.116.1582314111976;
        Fri, 21 Feb 2020 11:41:51 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 25sm5152414wmi.32.2020.02.21.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 11:41:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 21 Feb 2020 20:41:49 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200221194149.GA9207@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Feb 11:19, Casey Schaufler wrote:
> On 2/20/2020 9:52 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> Again, apologies for the CC list trimming.
> 
> >
> > # v3 -> v4
> >
> >   https://lkml.org/lkml/2020/1/23/515
> >
> > * Moved away from allocating a separate security_hook_heads and adding a
> >   new special case for arch_prepare_bpf_trampoline to using BPF fexit
> >   trampolines called from the right place in the LSM hook and toggled by
> >   static keys based on the discussion in:
> >
> >     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/
> >
> > * Since the code does not deal with security_hook_heads anymore, it goes
> >   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
> 
> I've finally been able to review the entire patch set.
> I can't imagine how it can make sense to add this much
> complexity to the LSM infrastructure in support of this
> feature. There is macro magic going on that is going to
> break, and soon. You are introducing dependencies on BPF
> into the infrastructure, and that's unnecessary and most
> likely harmful.

We will be happy to document each of the macros in detail. Do note a
few things here:

* There is really nothing magical about them though, the LSM hooks are
  collectively declared in lsm_hook_names.h and are used to delcare
  the security_list_options and security_hook_heads for the LSM
  framework (this was previously maitained in two different places):

  For BPF, they declare:

    * bpf_lsm_<name> attachment points and their prototypes.
    * A static key (bpf_lsm_key_<name>) to enable and disable these
       hooks with a function to set its value i.e.
       (bpf_lsm_<name>_set_enabled).

* We have kept the BPF related macros out of security/.
* All the BPF calls in the LSM infrastructure are guarded by
  CONFIG_BPF_LSM (there are only two main calls though, i.e.
  call_int_hook, call_void_hook).

Honestly, the macros aren't any more complicated than
call_int_progs/call_void_progs.

- KP

> 
> Would you please drop the excessive optimization? I understand
> that there's been a lot of discussion and debate about it,
> but this implementation is out of control, disruptive, and
> dangerous to the code around it.
> 
> 
