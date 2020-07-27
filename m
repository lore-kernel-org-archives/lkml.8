Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B3C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7EA205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595848043;
	bh=NGcUfl8lavn6ZeK91scmTkFFYtWAxgZV2zukCJirtOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hj3iikEcmuTIMujcTY9HsMadKhjPnAQxWw56WiToJsGv3JDfD5kw1NHwvRi9Po6Av
	 picSugIJUvZ6gBqvPuE65FRXHIuvNfWxIgWhX3w+/V3CCl8op8Y1Uy6LMDD+Sl16TO
	 aCIFqu7GnjaYnTu3VDUXeAefpH0tR7kmGgU433vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgG0LHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgG0LHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:07:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:07:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so3680350ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dEfM/EY8tC154C2rwL5ogODobRFKuF9CxDLsGxT0WGI=;
        b=rc3tXNyV7R276wYboOBdHzxUVwpGu0Vb1efwroUxr0x2jtmmlXlDZS77LrS1hr6WPq
         wQsJLUcoxyOO5JBVTiSwvumjjuNPucbAXaHLXPu99BpHgXFf4k0W3ttAYa0/raduQWBp
         hSEg7WzJa9LEKwP+LbGnTn0jo6B1KySB19gg/f/1bVmKFYiKF/w2C4nCMOvxYiNELCDU
         YPrhbZZdsr2ozjBeVoceMzRkJiAhhAbiVCcvrzu79R03utauD6v9sj1sf35swl+A/RK1
         8GpZQQCnEapcfHqfj3PS1skIDxHKAxtvs8hIjuZ9wNXIAdabXqYU+nB1otvEKJDzN81j
         vlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dEfM/EY8tC154C2rwL5ogODobRFKuF9CxDLsGxT0WGI=;
        b=sqMemL9Xowxo0BeRau3spyfcY5daUL3wk26LWsJrcEGsHbeAC8ztlO+XVpZ3WIoT+O
         T/r/lep7rg1CgECBLTp5ZvTM3SC24kOufVhUPGl34fzTF7vR/2yJcrG3tsGgKzZLtXI7
         SkGvUm5EFERUQkTOz+tkB3Uo/dFQh70R7ddEJhI2sMk7CGMtNtCztRN1bZBn4G61Wwfq
         7qI+crTKpcGM1uFTKAGZeeVUvopzjtY1kQ35TFNzsUkCtvFIpi5N9YX5OrrOCKw9Du7C
         05XXtB8OKjyWJZ6mxuBSvXTUHlYUIz0Dj6wVvlkuHr+8DaP9QfCcqjT2quu/lnNkVIof
         6Icw==
X-Gm-Message-State: AOAM530dod87iluIEdtCAaonEP1eD1+3oQu1gz4we6utKaJXM9+LXvDo
        dLjnkGnV5QBN33EZLEFSM9JiQ9fJ
X-Google-Smtp-Source: ABdhPJx5UpAjUiDPyQWPnVmC0GUYi5YiDTyW1gnQivR7D1ZNlC9f+M2/5A5tzRu2zUzScyGIATGimg==
X-Received: by 2002:a17:906:a3d5:: with SMTP id ca21mr4868901ejb.453.1595848031489;
        Mon, 27 Jul 2020 04:07:11 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j5sm7271212edh.41.2020.07.27.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:07:10 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:07:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 0/4] x86/cpu: Use SERIALIZE in sync_core()
Message-ID: <20200727110708.GA3174@gmail.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> A recent submission to LKML introduced a CPU feature flag for a new
> Intel architecture Serializing Instruction, SERIALIZE [1]. Unlike the
> existing Serializing Instructions, this new instruction does not have
> side effects such as clobbering registers or exiting to a hypervisor.
> 
> As stated in the Intel "extensions" (ISE) manual [2], this instruction
> will appear first in Sapphire Rapids and Alder Lake.
> 
> Andy Lutomirski suggested to use this instruction in sync_core() as it
> serves the very purpose of this function [3].
> 
> For completeness, I picked patch #3 from Cathy's series (and has become
> patch #1 here) [1]. Her series depends on such patch to build correctly.
> Maybe it can be merged independently while the discussion continues?
> 
> Thanks and BR,
> Ricardo
> 
> [1]. https://lore.kernel.org/kvm/1594088183-7187-1-git-send-email-cathy.zhang@intel.com/
> [2]. https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> [3]. https://lore.kernel.org/kvm/CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com/
> 
> Ricardo Neri (4):
>   x86/cpufeatures: Add enumeration for SERIALIZE instruction
>   x86/cpu: Relocate sync_core() to sync_core.h
>   x86/cpu: Refactor sync_core() for readability
>   x86/cpu: Use SERIALIZE in sync_core() when available

I've picked up the first 3 preparatory patches into tip:x86/cpu, as 
they are valid improvements even without the 4th patch. The actual 
functionality in the 4th patch still needs work.

Thannks,

	Ingo
