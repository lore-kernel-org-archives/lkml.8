Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BD1206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="AVHFyKBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgD0Qex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgD0Qev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:34:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DEDC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:34:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so9263945pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fbHM1UO8ZCsiegGn5ySxeV/75VUNG8WD+xMilKzGDK0=;
        b=AVHFyKBaT3lWtILdsn7lZbmxuZqLoXBACX+5oScB4Ni5aArwxsJ6qGE8HLSV8BTb9R
         jyR/oGhu7x83HmelJV7BfQxEM2p97lF9zL+Z0LTiB096JYKfSVi/FGfwL33jTP+aF5vZ
         SVdjrqIjF+5LJr4e70MVqjl+QwzGsm+G6laRPOuqao1Lt1ZDqTv+5iD/cvj2LaTOVuPh
         uOP931J9qGvclu8Vnku+rbLzIsfgJN4Emx5SOXDnhM+CLIrD07it7a3tkWSVQKgAiSE1
         xCC1NcUjETwzx28zzLY1K4/ftDdcYeB+2J/HlFl2wmr3lek0dzHuzdYKqpxnvO+nvhWw
         +Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fbHM1UO8ZCsiegGn5ySxeV/75VUNG8WD+xMilKzGDK0=;
        b=P/VrMMvHneet55FbTuptPcE98rRPuAdkRhhg/VNJuFbrhXvL6m4ocZLrPme1dBK8WK
         FqZh2tkDBeN8wyP1KiRGQpLfdmPR+27wJ7hvhynp2mhNnJXNTCwdx+xA16yX7O6Vm+TN
         QYeiEm2+TcPmlRbmgWpC8Ez7kK2fpj0mw1kDnyNI3u6cJcjo9arqi3Q20HlwrchI5FST
         hqZrT2UgjQZEIuMYmhzNUd1uObGEJRXI/wbmVvPDN+aBz1ltNARCuP54mxAQ8lE6P/b+
         HaT252HTu7MmXGkG06DbwmmiYiVrxL9t8SaZRIqb5Dg8WOkrjb32IS3ZTuu8CydUYDUy
         rB0g==
X-Gm-Message-State: AGi0PuZcbNIyp6yYAWy3kBQHk11RRVjdjN1VpEX+aONw3mB7eIRr1tvV
        SvW1B35bDg41XZOwdyOPnPs8TA==
X-Google-Smtp-Source: APiQypLRWUHLrcl4eewb2MZpebmvrOe2d15ENGwSBTtBtqZ8Qsa654XlBZq7p87Qzgo0xDc/BXO4jQ==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr23328255pgc.111.1588005290612;
        Mon, 27 Apr 2020 09:34:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 23sm11675960pjb.11.2020.04.27.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:34:49 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:34:49 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Apr 2020 09:34:46 PDT (-0700)
Subject:     Re: [PATCH 0/3] Refactor patch text interfaces and mechanism
In-Reply-To: <cover.1587453338.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-7876a56a-d387-46f1-9f54-95b18654a571@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 00:29:58 PDT (-0700), zong.li@sifive.com wrote:
> This patch set contains the difference from the newest strict memory
> permission. These changes are suggested by Masami Hiramatsu, including
> deprecating old style of kprobe annotation, lock protection and so on.
>
> Zong Li (3):
>   riscv: Remove the 'riscv_' prefix of function name
>   riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
>   riscv: Use text_mutex instead of patch_lock
>
>  arch/riscv/include/asm/patch.h |  4 +--
>  arch/riscv/kernel/ftrace.c     | 15 ++++++++++-
>  arch/riscv/kernel/patch.c      | 46 ++++++++++++++++++++--------------
>  3 files changed, 43 insertions(+), 22 deletions(-)

Thanks, this is on for-next.
