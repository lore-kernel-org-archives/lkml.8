Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB2C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C570C222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFOBTaZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBFP3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:29:53 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36118 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:29:53 -0500
Received: by mail-qv1-f65.google.com with SMTP id db9so3037030qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YRGPQTxySG8GGpnc9qj5oMJ9OxtV3T+CuCWWaPN4Sm4=;
        b=kFOBTaZbZk+6VKEeWwEi3ZTRFP/6WLlVpOAShTiRr6XWtBhvXRtaP9jNzjcAtx6mC4
         XLPvHoCNhHi6uHkJp2f8UYY+pa7Psn7d5gKhEKBimDVNaaf4ntcqdXDrpTTnSA+ukBgK
         LmJZ1U9B8ui6kIWVlnXutoSc+pjCv7h//L/BRrY6HOzk9M5R+ySe5/cbDJkv6DScyvd5
         eE8Kwrn41QarPcUKuFzYM1deV2vxmVaYXb2U2nkAlMpNCQpH+Wsu59bLZt30EvJdrFfM
         CHUAl52gdg+8/Ulbz+2TKm7X3gjMhfqFNPJP4oDdxXMzdm18yolhvGgBKlLI+8KxLAj/
         NSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRGPQTxySG8GGpnc9qj5oMJ9OxtV3T+CuCWWaPN4Sm4=;
        b=OsT3gbZh8dybKIvc1Od54riN9MzR2Cb8LuU+UytWA/MSnsaL39gpu2Wbcm6vicqgKf
         Appsi+7v2AUi2vhDFGQ6c3PRdol7Zbd+pmSChzpvNNa5O0X/HvusPrpr2hCZKfQ5YmVF
         JO/SoQu7j2iIKM4LmDckVmDiYKTAAunD6XYQ+qzZxtpTkcpkkj6NkPND66EZLIynIVa7
         sErlpfgy/aRWtzQVmU/SIWmnWDrsuj9OpPpipRopHf2a4rV/gdyfnlmfJcddmHl0gKqn
         1w6JACSDAvB2oFd8CsjYYGjosd9ksipy1shDZfAsu2TjjnSZMR7MrdPm9HjcPbaxf9oc
         cMVw==
X-Gm-Message-State: APjAAAV4T3CArGoNBG9NazF8PyJLNZye+NyiX9IMBuCquc3eg3Zcatg4
        RUgj//coJzwC+DQqVcLPvLg=
X-Google-Smtp-Source: APXvYqxxQY40erXrrieQVRQf7QWTeCZdyuefKx4EU2WMpDcQ4vU+EACDTUD+UXJEsoRGYnQmhHLxbw==
X-Received: by 2002:a0c:fac8:: with SMTP id p8mr2824512qvo.47.1581002992198;
        Thu, 06 Feb 2020 07:29:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s48sm1808973qtc.96.2020.02.06.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:29:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 10:29:50 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200206152949.GA3055637@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-7-kristen@linux.intel.com>
 <202002060408.84005CEFFD@keescook>
 <20200206143941.GA3044151@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206143941.GA3044151@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:39:43AM -0500, Arvind Sankar wrote:
> On Thu, Feb 06, 2020 at 04:26:23AM -0800, Kees Cook wrote:
> > I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
> > what function start alignment should be. It seems the linker is 16 byte
> > aligning these functions, when I think no alignment is needed for
> > function starts, so we're wasting some memory (average 8 bytes per
> > function, at say 50,000 functions, so approaching 512KB) between
> > functions. If we can specify a 1 byte alignment for these orphan
> > sections, that would be nice, as mentioned in the cover letter: we lose
> > a 4 bits of entropy to this alignment, since all randomized function
> > addresses will have their low bits set to zero.
> > 
> 
> The default function alignment is 16-bytes for x64 at least with gcc.
> You can use -falign-functions to specify a different alignment.
> 
> There was some old discussion on reducing it [1] but it doesn't seem to
> have been merged.
> 
> [1] https://lore.kernel.org/lkml/tip-4874fe1eeb40b403a8c9d0ddeb4d166cab3f37ba@git.kernel.org/

Though I don't think the entropy loss is real. With 50k functions, you
can use at most log(50k!) = ~35 KiB worth of entropy in permuting them,
no matter what the alignment is. The only way you can get more is if you
have more than 50k slots to put them in.
