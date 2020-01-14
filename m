Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C51DC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6783721556
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oymZxqri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgANEIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 23:08:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36910 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgANEIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:08:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so11304237qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QNtmqVWbAOjUDHLbU1JCi3aKgbul5T2rh8pths+pE7w=;
        b=oymZxqrihFL3YmpIhDckL7mg3PzqoVq4ec9gBVmoGi5ub7OKrYTSerEU/LhIgUoYIF
         d1jYOoM5uC75vzyMt/se2T0tPgxQqVBCyYY4necJXtTsUODdy63vPnWSbD9F0RKVkGRr
         Fy9CklL2UZZNHfiqb8SvM/Y8OErZ8yWkcs6YODzz/AsZRLXIVEHukwEuDj/QKJjjDWv1
         Lw+2MwPO253p3NoGiiJsuz8I2ltNJJoCl+r/RUTUy0N3GP6+BZo0pfTKVlN1UHYZ089m
         PlaEtf0YHwc73fqCRM31C/Ez2N+xlH1cQe0XlBOxjFOCJOnK+E4BBoP0UBUsFJBdLo+J
         Qccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QNtmqVWbAOjUDHLbU1JCi3aKgbul5T2rh8pths+pE7w=;
        b=S3ZAhOZIGhzuDQAITJwSqaU3MqyPWqaFWw0/KLcoe2lJ4JbM+59ESXG8o3F+s7xQ0X
         pT11Lp/1gQWA9ZF9O4nH5bAbz8drfVMrH7GrN36aQjKsv5PuZNcHGIzok1TNK038ZZ3C
         IUxWzFF1C04JufPLrX9kGPECjmGlUrXFEiJOfj4H84lkOXxml0bYtBLrefLt3ICbBfYe
         GE54D5Kq111yY/y8MidBmNOrVfsm+t/k8MgWHZ+dijSCbX8EuOt7wV5kg1WibxixbLfG
         Co6/EkVHmAVJKgcp0n3/fv8dvMe51are4uV0WJi7/nHrvkbNnkWNXD2XZ/BjyQP1ipLF
         Vq0A==
X-Gm-Message-State: APjAAAW0nHubH/Bb9g9JQbilm6TvY9hp5bagMmruK/7TA4VfAnquaGqh
        qWGFm4IpIY19rGaScLHOeGw=
X-Google-Smtp-Source: APXvYqxWLXUjYjYQLbIYilETh56sVPwldMspTUOxKHEeFza4KHArtcHVyD7dKd5nXB/wg3IFYVQ7tA==
X-Received: by 2002:ac8:66c5:: with SMTP id m5mr1886832qtp.356.1578974895063;
        Mon, 13 Jan 2020 20:08:15 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d51sm6853425qtc.67.2020.01.13.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 20:08:14 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 23:08:13 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200114040812.GB2536335@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113163855.GK13310@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:38:55PM +0100, Borislav Petkov wrote:
> On Mon, Jan 13, 2020 at 11:13:10AM -0500, Arvind Sankar wrote:
> > I will note that the purpose of S_REL in relocs.c was originally to
> > handle exactly this case of symbols defined outside output sections:
> 
> And we should try not to do hacks, if it can be fixed properly, as
> binutils expects symbols to be usually relative to a section.
> 

I've poked around a bit more, and all the hacks in relocs.c in S_REL,
other than init_per_cpu__.*, are only there to work around old and/or
buggy binutils versions from the 2.21-2.22 days.

The current code is *not* broken for binutils-2.23+, where none of these
symbols are marked as absolute. IOW, the current code is perfectly fine
and generates relative symbols for any binutils not of 2.21-2.22
vintage.

So we have the following choices:
* bump minimum supported binutils version to 2.23, and remove all the
  hacks for earlier versions.
* add a couple of hacks to relocs.c to account for new symbols, as in v2
* complicate regular code, as in v3, which Kees says might break new
  code [1] and Tom says is bad for future kernel hackers [2]

[1] https://lore.kernel.org/lkml/202001131750.C1B8468@keescook/
[2] https://lore.kernel.org/lkml/3e46154d-6e5e-1c16-90fe-f2c5daa44b60@amd.com/
