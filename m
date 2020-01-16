Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D194C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75920748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vj1+B0II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgAPJpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:45:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbgAPJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:45:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so3031747wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZyqN5qlv5csEwwF7mhl4MB8eUdR7toL/H4ZfMDEk6g=;
        b=Vj1+B0IIOY42PaOZgZVxmKH8K8KawfI8k4ca+yD6NCdW9+m0f5RoQyWsqVZre+box/
         fdaYwemzm3+elzGhL9u8RQika/e+KsR6BCsRvDSOP7/WdmttrcXjUGi2bPNRrkEDEY+w
         3XpXWf4FWF6aOFv9YPM5+29NEYL1aRkb5JXqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZyqN5qlv5csEwwF7mhl4MB8eUdR7toL/H4ZfMDEk6g=;
        b=b0gUEUh9BmmDS3xKxCoK70dlQN805f5mGuFFxL9FkZPj0/97BOR5ZcqGLQmGYB0rWC
         jwvi7nffDSXufL9C5JaMoIXMSU4+mTNPbDtXbfkel5THWHHHa4gIMsHXIoeppvXI9vW9
         hmrlGGV2+lbH7CeyFPcNnQwEB+fNDKAk9mos7n2dQtWC7MLDFcscVPr72penQLLjdKhD
         tn/TZ4KH+tPLoUOWsOg2I7Sl8rMF5NGqB+lidxy8HNNYFB09DA4lbi0lNjPkX+aIXiaa
         weEtyZT3s9uMtl/u9z4EECFpxxNWwuKRNJmtpVoAHo/hxGDhSjv3SD/dhdfloV1VTXw8
         iYTg==
X-Gm-Message-State: APjAAAUvgeDWhVFvqe+EmuR74+ju7ZD416A5EPd87PzaC1ecV1F4B3nN
        WIC+iBTyHdiVFhAZps+HacEQzA==
X-Google-Smtp-Source: APXvYqzodqnf952non/Pp68saYtHh4fQCSMqKy/g+z0HaIiKWSZD+4CRhvDznRr+j4DRUZr2Hi54TQ==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr5300109wmc.111.1579167938030;
        Thu, 16 Jan 2020 01:45:38 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id x10sm27801564wrv.60.2020.01.16.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 01:45:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 10:45:35 +0100
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 06/10] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200116094535.GA240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-7-kpsingh@chromium.org>
 <20200115172417.GC4127163@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115172417.GC4127163@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Jan 18:24, Greg Kroah-Hartman wrote:
> On Wed, Jan 15, 2020 at 06:13:29PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > JITed BPF programs are used by the BPF LSM as dynamically allocated
> > security hooks. arch_bpf_prepare_trampoline handles the
> > arch_bpf_prepare_trampoline generates code to handle conversion of the
> > signature of the hook to the BPF context and allows the BPF program to
> > be called directly as a C function.
> > 
> > The following permissions are required to attach a program to a hook:
> > 
> > - CAP_SYS_ADMIN to load the program
> > - CAP_MAC_ADMIN to attach it (i.e. to update the security policy)
> 
> You forgot to list "GPL-compatible license" here :)

Added it to the commit log for v3.

> 
> Anyway, looks good to me:

Thanks! :)

> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
