Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC90C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B2E2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="usQNsRNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCFACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:02:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgCFACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:02:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so211358pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 16:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lEx3mbJGiKeEXvxraB+JKr/DKkGfwpgYwbWrzWfsAtI=;
        b=usQNsRNwrKXKCDE/3+Zs5C20nk/L+PZYnbzZbdLuERUPx9Gaz0MxQsTUGUO+Ok3tAB
         VkrORlFUMeKXaQCOxtkgMJLuPXcdA9woD4GUtt9hAue5jHzcEnOgw52JhkvjP911MGAD
         YOPoN8iMZ9B3Joe/Q7KyxMzgIrUqHtoO9KxqhtHPWhOAVekhQ39qHegUGtevVtNMsFrr
         uSrR7FB+MgWSntR+rq58ArfHhBCtrBNSxbJabvA8797y8TWpp7CwAJsU9/aP+XBqgzel
         jhln5m8+59B9HP0SQ8l89M7VFAPPt8zRA2Wdq33MhyNJ2RY3W9iMFKneRfpPKFTB1x5L
         7GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lEx3mbJGiKeEXvxraB+JKr/DKkGfwpgYwbWrzWfsAtI=;
        b=ovYLIvO7/NYhGOg8WGD/UGK6Fj2SHrPwpEhQ1p2W7rlUSZQpeWpnpmOdn0mh5p4SC1
         1GiQBWF5mIQK4mmHhZddQIR3Mg0RN2KQPYlsYylFIpid4FBwO47C8/5o2YgqcjDiSHHB
         1+lmtHvLbvXgGOR/MceusZ6pA4QadT0xdbyzvgkL/vEfkspXFaCwBjA4NnTniCGp/KTu
         /VE0uAiWfzYMo1Ue4aXkPkwIRNiY/67rPGDF/WXCYNzEJUwEBE/q82tSX7SFTe5gZlBP
         BsJzH3UPCJ1lugJqJu48frXfErAEFQyp8UL1ZWl9a1Z36hIkAy8diNm1dTXYuKuf6qzs
         r6aA==
X-Gm-Message-State: ANhLgQ2gLNkZeqiOLiAWUjdGpW3D3NhU5QpQSQaOG2v1ugtainLVKLPN
        1WswgQujouiwzZmKCml6exm+4oEhuRg=
X-Google-Smtp-Source: ADFU+vvxrcvqVvr1z+jGHKogkWUowyP4jcgYAaHtzqpDhXoQ6QG14zzRtSyWudWh7TydkClqn5DS0A==
X-Received: by 2002:a62:e713:: with SMTP id s19mr908777pfh.20.1583452960166;
        Thu, 05 Mar 2020 16:02:40 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id j21sm7128491pji.13.2020.03.05.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 16:02:39 -0800 (PST)
Date:   Thu, 05 Mar 2020 16:02:39 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 14:00:00 PST (-0800)
Subject:     Re: [PATCH] riscv: fix seccomp reject syscall code path
In-Reply-To: <20200223171757.GB22040@cisco>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        luto@amacapital.net, oleg@redhat.com, keescook@chromium.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tycho@tycho.ws
Message-ID: <mhng-75f7f767-2b9d-404d-817f-ac39e1b2dc50@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 09:17:57 PST (-0800), tycho@tycho.ws wrote:
> On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
>> ...
>
> Ping, any risc-v people have thoughts on this?

Thanks for fixing this.  It ended up escaping my inbox, but it's on fixes now
and targeted for the next RC.
