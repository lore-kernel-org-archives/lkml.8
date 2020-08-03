Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64309C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABF620775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hP9FRbXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHCRqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:46:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EFC061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:46:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so13747490ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QCxlN42Dpf84QDKc0qNus6gWzEZ8znuGVzXWLcSubyU=;
        b=hP9FRbXXvcCm9F2+Wqs0j3rmyEJRG+8t5EVqRFjDnC5hm4FqT4WBPLUq73Sb9qc7np
         D8dMYVZTFv/0S7nXIaYjw/Ra0hqxpc4Sz4jUtEeMEZO4ZYpD2arb217osnZlA9Oslrlg
         Ofskn98SUkekGhf9ehHzgNMM1NkVoxYW3wr8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QCxlN42Dpf84QDKc0qNus6gWzEZ8znuGVzXWLcSubyU=;
        b=qXaQXGJ1qayemR0VPtIrsRvSOLAnf/2YtJetu39uce5U5dAJgnC4Nz14jPXwyu+7Mf
         /2gqppH+QVeS3t9QYgLYkemOfuoeRIDbIfZk4ilkw4G28sirszlCY4gVj/HiVQHkrxlZ
         BusIdfA7VMw0TI6uOkxnifQAf3yg9XwGVd3In+Jo1Z5w7zqBS8JUGKChnz/pjsgWZ7aZ
         p88yUro2rCKdHt4BUXFwMdAIiFFtJptJCzVXM17b9cA1OU3m4Rea3ws5fN6dEOUN4tQQ
         GvkOJ+rVkBo72jhv/5plAxqUNjujiuHA0TZtkMCWLp7QAv54npYLVQIjXvPIbNGdtSDZ
         RFdg==
X-Gm-Message-State: AOAM530kxmSo92rnA7mI+KY6z7OOm1Wr/Z6g5bd4Tc/hkP5IkSRnf5gn
        4Z0h83noTFjvTRyk0cRc7SWutg==
X-Google-Smtp-Source: ABdhPJyNNPVKXrY36jyeJNuzk0LxD1oXgVP7J7CQ47kNYPls3Pu5B40PEXTllT4nwQno3oYrllGgRg==
X-Received: by 2002:a17:906:454e:: with SMTP id s14mr17331927ejq.147.1596476803256;
        Mon, 03 Aug 2020 10:46:43 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id u4sm9480396edy.18.2020.08.03.10.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 10:46:42 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 0/7] Generalizing bpf_local_storage
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
Message-ID: <dc832ef3-37a5-fbcb-cb87-607232fe67b4@chromium.org>
Date:   Mon, 3 Aug 2020 19:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803164655.1924498-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/20 6:46 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v7 -> v8
> 
> - Fixed an issue with BTF IDs for helpers and added
>   bpf_<>_storage_delete to selftests to catch this issue.
> - Update comments about refcounts and grabbed a refcount to the open
>   file for userspace inode helpers.
> - Rebase.
> 

Apologies, I missed that bpf-next is already closed. 

I will resend this as a v9 after it opens again.

[...]
