Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB43C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D2220722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1KzNSZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgELLjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:39:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:39:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d207so6223245wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aRx5ifukbyXHBpYop8zJGM+6ZoqLcs6pq/yN5X7+duM=;
        b=m1KzNSZ+WcZKOrG8Yu99L41DqbyTLo0LaJg64dfxJwegZ+cEcEgHIiosMwGyX+S9AV
         nGv/kqu2v74jBaOTa0Tdh34LWCbXTrRqhjm7kZTSuuFWhBczakAax3U9DGTzmjteE1V6
         0bkAVUkOcQ7Ub0ooLgA2k37iwlt4dTJUnddQklEcRNiymzDWqoCp68Vfpfyls91meLBb
         Awx8oTtzAX/nzYDTeNhz9OkMR11gsBXNKWdJ8QN0YcrQXYZSYEZKTC8XnrusU4WUmZzx
         hHn1oAYKb3i7rhyvE4FOM7gHo1sXNEYruHV/4oFToj0S4JrAp2/pHgVUKYwj5pfUZigH
         JYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aRx5ifukbyXHBpYop8zJGM+6ZoqLcs6pq/yN5X7+duM=;
        b=FnPMCWPkY2w+p7odBpkO/dfUjUd4dkOZm1DuuCbLRmtS2PeBkrpdyLJDJJeWTj5IOK
         LIzubkLL+xhp6l6ots8x7sANfVHQIvV6yH/9217NGcCNptTN5o5TuS+Gf0WCNVe8cvM5
         70QpGdA31vUo1hwlVjY7KwVimYyyfw/PC6b+clNlzfwyoz5/xtXJoLckszl+zfVvjhjy
         cRVi6oaQpDR2eoysZ5b8v+gBr/XlSh+VTvBD7FfQT5LDUFODZijm7Ju1kWlKM8lmijgm
         pNVAPmKi+O/uEkcbLD/4rdYQIdRNNZxab01kP04t5cHe6NId8MnOBVczDEsIJgN1n3IJ
         nfpA==
X-Gm-Message-State: AOAM533KtjVZXkHltBRcRN8vKzZulfqhcZgx7vXf9pR5rC5lkKUOO99q
        JYDbSd22XPWAgF8NFXkOl7A=
X-Google-Smtp-Source: ABdhPJz/C1qypSkWBLt8HBfx4bWh6tEuqCRNWhbVCJ0aYAN8J65wswAL7MJeUrTrQZ2xecbLFM10Jg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr2414972wmg.162.1589283558499;
        Tue, 12 May 2020 04:39:18 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:3d38:90c1:858b:902e? ([2a00:23c6:9e09:2900:3d38:90c1:858b:902e])
        by smtp.gmail.com with ESMTPSA id d9sm6916462wmd.10.2020.05.12.04.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 04:39:17 -0700 (PDT)
Subject: Re: x86/smp: adding new trace points
From:   Wojciech Kudla <wk.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
References: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com>
Message-ID: <b638ef03-04c2-94bf-f026-a01691888624@gmail.com>
Date:   Tue, 12 May 2020 12:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was trying to trace some IPIs (remote tlb shootdowns in this case) and noticed that:

1) irq_vectors:x86_platform_ipi_entry and irq_vectors:x86_platform_ipi_exit are not hit at all for my case. The backtrace on the receiving CPU:

0xffffffff81079535	flush_tlb_func_common.constprop.10+0x105/0x220 [kernel]
0xffffffff81079681	flush_tlb_func_remote+0x31/0x40 [kernel]
0xffffffff8111f76c	flush_smp_call_function_queue+0x4c/0xf0 [kernel]
0xffffffff81120253	generic_smp_call_function_single_interrupt+0x13/0x30 [kernel]
0xffffffff81a030c6	smp_call_function_single_interrupt+0x36/0xd0 [kernel]
0xffffffff81a02679	call_function_single_interrupt+0xa9/0xb0 [kernel]

I would expect that we would hit those trace point somewhere around call_function_single_interrupt()


2) there is no equivalent of ipi:ipi_raise for x86. For the following call stack:

0xffffffff81055d10	native_send_call_func_single_ipi+0x0/0x20 [kernel]
0xffffffff8111f86f	generic_exec_single+0x5f/0xc0 [kernel]
0xffffffff8111f9a2	smp_call_function_single+0xd2/0x100 [kernel]
0xffffffff8111fe3c	smp_call_function_many+0x1cc/0x250 [kernel]
0xffffffff8107982c	native_flush_tlb_others+0x3c/0xf0 [kernel]
(...)

I would expect to have a irq_vectors:x86_platform_ipi_raise (or similar) tracepoint.

Are there any reasons my expectations are wrong?
I'd love to submit a patch that addresses these issue but I'd rather get some more context (history maybe) before that.

Thanks,

Wojtek

