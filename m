Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5ACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zA+fDW7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgELRgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:36:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:36:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so6091547pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVLWN+8R61IdmiSJmCy4d5j/vIO/FBU8hJurAn8zeEk=;
        b=zA+fDW7rsf78djWHisc/zKxTdzFpDcXavv1rH07ojEDeewEhVnsEyFiTm1P5RQl2T7
         HdNG/EyhEBx5LlfjqJVSbqTKhnug9o6pfsSUJ4YB/V0dQ5QZWwtxBQfIi0hfHpaHE2bf
         XJQtdLM9EaHOT+HEBDnW0qkgDmgtzmSxcE+ZmVLjdD0Cnb38c9ebVzcs3zl69c4W1uQU
         Olqhz/0vH4QLgvVPsmO6o61yffHjIwg3O2T8vickdZgFjEKRBJSpSMRTjXDbCJmFes1d
         iHbLa+wZMCXYThMyH4Txkg13a7EBsKa3RetlMf9ysJrglDypCNm9a+9w/evLE6d8nK1A
         PUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVLWN+8R61IdmiSJmCy4d5j/vIO/FBU8hJurAn8zeEk=;
        b=O8sZcM0hK67jbPd3vjJoayOFx27BEEIX0zdYgfwF2bX/e7UqDWP/Mpdl/iYDE+GF1d
         xMoH0r0CHD+du8gqjsBKJVdD2Hvmwripe0na9hC85bNr/TavkZKYMDuaTdahITUCNGlb
         4yJa9nVw/b+nX4ixlrjp+gzkgDY3dH2oFRaN1e0Vmva5zAm+eYJg/E6BaUSshbRt6j9P
         Fcv+RGqNWcrTTDwXZRF8EspxyMZwT2vtbWs61Oqob9CnyhLilVmXCK9rIg7oSqX3GV0X
         ld3djb64QJto9rJD1xkdHFMtt88OPCsE9uU06ndMnYcabD6wgr2z7XXvtd5phX18M/Ku
         kdiQ==
X-Gm-Message-State: AGi0PubUa/LMWPWbho0ys/3qAyQSyyAONDD7MwY3LvsfuHL4V0TZLa1u
        q+rJW7VnkQ5r2uOJImkhr/oeK1azRWg=
X-Google-Smtp-Source: APiQypI3Kk35T4p8NhBJk8jfgGwfSQW7xkJf5PLtNEPvhBz2PN2/gQkK1ohTJ1uYwBqOBFtUokhb8g==
X-Received: by 2002:a63:d850:: with SMTP id k16mr20711664pgj.190.1589304999651;
        Tue, 12 May 2020 10:36:39 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:3541:a94b:8f16:bfe6? ([2605:e000:100e:8c61:3541:a94b:8f16:bfe6])
        by smtp.gmail.com with ESMTPSA id t5sm10517208pgp.80.2020.05.12.10.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:36:39 -0700 (PDT)
Subject: Re: [GIT PULL RESEND] Floppy cleanups for next
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
 <565fc2e1-a790-241f-7a98-52a4c5ff8158@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6d08f09-7415-c92e-0f94-1eb521f2ecb0@kernel.dk>
Date:   Tue, 12 May 2020 11:36:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <565fc2e1-a790-241f-7a98-52a4c5ff8158@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 11:33 AM, Denis Efremov wrote:
> Rebased on for-5.8/drivers branch.
> 
> The following changes since commit 92decf118f1da4c866515f80387f9cf4d48611d6:
> 
>   nvme: define constants for identification values (2020-05-09 16:18:36 -0600)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.8
> 
> for you to fetch changes up to 0836275df4db20daf040fff5d9a1da89c4c08a85:
> 
>   floppy: suppress UBSAN warning in setup_rw_floppy() (2020-05-12 19:34:57 +0300)
> 
> ----------------------------------------------------------------
> Floppy patches for 5.8
> 
> Cleanups:
>   - symbolic register names for x86,sparc64,sparc32,powerpc,parisc,m68k
>   - split of local/global variables for drive,fdc
>   - UBSAN warning suppress in setup_rw_floppy()
> 
> Changes were compile tested on arm, sparc64, powerpc, m68k. Many patches
> introduce no binary changes by using defines instead of magic numbers.
> The patches were also tested with syzkaller and simple write/read/format
> tests on real hardware.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Thanks, pulled.

-- 
Jens Axboe

