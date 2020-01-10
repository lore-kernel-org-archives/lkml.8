Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A012082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvi+VRY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgAJUuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:50:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38480 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgAJUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:50:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so3181384qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g27tUcZAM0m6OZxjmAB5/89iWSwTrYsxjjfNa7EsAIw=;
        b=Mvi+VRY02DgdYL7P2WspKpHxV2ow+FLMGmUO3lyIPBdZ6kcdG6O4HVFlGhiG+9nKjt
         InGoNRuwiCuSQd5Ve3eiX2lfKUyZ87lrH9ALeiXGOnxgfGdiTLaU5zwdubcqXTvcsLB0
         DaO/pmhX8VxVvIadinKoWa7kOkB9Y64ByED2qL3Trpztbdo8u8X1ZMDq09q8IOvJth8y
         JUo+juVQDjNuS4t09NlmvyPVYzae8sKRlSErb7153ubjzUQblJgGvPUjil5E1HJc4/pq
         jW9fCiAhtgCiQ6Tyz4WmdQy+Ys1/hKYm3kCXGXfKxq3N7A12MUCJoUIZzD0CCKSH0wj8
         WOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g27tUcZAM0m6OZxjmAB5/89iWSwTrYsxjjfNa7EsAIw=;
        b=JQM9gtW8PkhWS1ojwVNODiOWHTZ1cwciLBuiC4Q0fs2HP6KucemgC50C37jTi9DhI/
         XlGk5nZd2unOmJw1cUKgEq9XfUJ7/yjTfX0wfRoaozhYSVjIWUq814YMrKHrivFiEK1w
         JJdjGxy/Vf2SLrrE+Svix2VKCb9msRi52fNvU1oKi6yft7mw/T+Zy61Jp0fnvntk1GZS
         Owf98Qm6D+u3b2ueTMUpMJJDIUmbdJmEFMIg3zDbuEF06m60rZ22utMqY0clZK++d22D
         0f1ZzOETsI2bjJxsYe4Y8yOQxv5zGBDGgEZjRvLMuTFqAATEIw+8czk76VEiJhRPMHYD
         at+g==
X-Gm-Message-State: APjAAAVYS0wcTNHnP8uAACgSI/j1kH579tY8q8+7D2Bi0KxVrk8drqZQ
        MgN1ZEzo2mTnY+eXwbZWaa8=
X-Google-Smtp-Source: APXvYqzqSVRxTWDacmijuX+jppZlqkfEqfdliItay6BDT/Jhn2/DhYxV9Ui3FPnIC+BA+I79v6S/YQ==
X-Received: by 2002:ac8:3853:: with SMTP id r19mr351185qtb.69.1578689431302;
        Fri, 10 Jan 2020 12:50:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e3sm1586608qtb.65.2020.01.10.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 12:50:30 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Jan 2020 15:50:29 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200110205028.GA2012059@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110203828.GK19453@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 09:38:28PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> > Pre-2.23 binutils makes symbols defined outside sections absolute, so
> > these two symbols break the build on old linkers.
> 
> -ENOTENOUGHINFO
> 
> Which old linkers, how exactly do they break the build, etc etc?
> 
> Please give exact reproduction steps.
> 
> Thx.
> 

binutils-2.21 and -2.22. An x86-64 defconfig will fail with
	Invalid absolute R_X86_64_32S relocation: _etext
and after fixing that one, with
	Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve

Similar errors with 32-bit defconfig.

Should I resend with that added to the commit message?
