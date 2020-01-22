Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A660C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B7B24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQXSQYrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:51:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46706 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVGvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:51:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so5484587ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 22:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ME6d4DYyOi6wbW88pXk/iuT1W4qA5ULF0fCJAkJm1XM=;
        b=nQXSQYrJ2oqbSQ7650g3xuvOFMoW1eYSr1Y2vBe69pePUHA7rdFyLrPd7ppQUPKH1B
         KmkEtItK/B7F/YNkABerW+IF/W7QbfPRlx4lomIQAVYygpM0HBv28j65y1BNyjEXITDb
         kYdW2REkQkRLOZ3IuH+qZj1R5bOl1FwbRkJfLOkm6JC2GvzSliwdrboNlCDKvjJwhtzT
         9zkMLFCFU/f8eQqJf76HTz4dZdLNQcd4gkRKre4vQS/wS1ydpxe3gP6Od2Wa3K6Kq9WY
         0qUnPyTYQupW7fdmiNAf5ghZ0pbOs8HzQESFyP4yr5rqU8K8JBXj8F78p2fHG7v/uLjO
         IZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ME6d4DYyOi6wbW88pXk/iuT1W4qA5ULF0fCJAkJm1XM=;
        b=hUr2k5KSWkV0P6NspmnUMipEcEmQMUwF2FhbEvo5bbkeZgidCno/bcC3bmhweMvvEJ
         +QdBiar0YV7bRn9QJ0sQMbY6jd7MC0UBzEuLwCwa1E/RqVd40NqhRcbcfqzUP4yybKFQ
         vpvkENJ7W5PPocu3USIZUsRBXiAhoc+FuNjzJeVva3jxE3KjUk7SOckyOBL4kJYCtPxt
         j/etsq/fDfwC/6ArEgDW9vgKO/eoBWpEOjONqrUdSbmdC1NiirqimFQrxa3TrxIHbKCX
         vUx2QFnINEco2sCnTTn9yTq6QIcSxvYoFA5SbixyuMV8Mulmgh1uNkJAxEJrnSZ5V5jK
         MNJg==
X-Gm-Message-State: APjAAAXnHgGZfQ56NVfS5y/uzvrYuSNVPBCvui83eApDwx0GZiGnm4ux
        dolvAMD+Ey2L1++v+5S1eAI=
X-Google-Smtp-Source: APXvYqzHFY6vS5IiNOIULBQpGo/xY0ERyxJOWn7zDjAHb2au4GKUva0HzgYXMPT2SAK+6sSx+MyG8w==
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr4308582ljn.216.1579675908551;
        Tue, 21 Jan 2020 22:51:48 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id v8sm19864330lji.16.2020.01.21.22.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 22:51:47 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0521F4615C6; Wed, 22 Jan 2020 09:51:47 +0300 (MSK)
Date:   Wed, 22 Jan 2020 09:51:46 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: remove unused macros
Message-ID: <20200122065146.GI2437@uranus>
References: <1579596611-258536-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200121114326.GF2437@uranus>
 <73a88e85-6995-6e3e-5eb8-a8c2b233364d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a88e85-6995-6e3e-5eb8-a8c2b233364d@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:07:23PM -0800, Dave Hansen wrote:
> FWIW, I'm not a massive fan of blindly removing stuff like this.  Maybe
> it's better to remove the cruft, but it's even better to try to figure
> out why I might have added them in the first place. :)
> 
> I *think* it was an attempt to ensure that a resulting PKRU value can be
> written to PKRU, independent of the type it was stored as.
> 
> Let me see if I can come up with something nicer than ripping these out.

Sure. Thanks a huge, Dave!
