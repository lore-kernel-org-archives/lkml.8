Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241DD20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI1tbBqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgE1M1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388767AbgE1M1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:27:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42936C05BD1E;
        Thu, 28 May 2020 05:27:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so11502639plr.0;
        Thu, 28 May 2020 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOoqa9uhQIJ9ODwLbFYQJr6Cq6oG2y6vghlNh5IqHLg=;
        b=MI1tbBqaqq1EB9qU+p+/p7we1p8z/T3bxQQ/pCUyNUdNsnXwZB1079dP+c+wKd4UXL
         Qb3EuL/q8tklZVaUpvN+eZuSRrimt9p+VvfYTDHiwBOI10YKeSQ9BfACqjYoAJEE1EDh
         piNHtdWluIeNyDN2rh7e39fOt4XHhcDtbGSX0C1rWM1eKWaKrpUTfcqpXEhsjM4cheF2
         IlyvCH95pk9s5Yt6c9m66ggLQxcHXVaCwTJ4uv1lGq5gLTQImSHWhl7GJnlgjCI+mPxE
         AfdzVmkKNxr+x8247nnz8eSRxFxSqXVtSxn3Ja1FfEfVWnkYe/uf2bOXHSne6I+mDP6O
         13sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOoqa9uhQIJ9ODwLbFYQJr6Cq6oG2y6vghlNh5IqHLg=;
        b=L69HRmNoKJuLGFnHJh+x4KhjyRvMDCKHKXW9hkpcWeLbWHuC6rXb3H4ZMUC+4DJ24M
         5wnXhbVQ3WHDbpY0IoHAb55uFyhtLUgHKeU+OaSyT8wQ0yiYtGLmmUqKzdLjl0J/z85q
         7K8P/TZAHcSaWce65XQa3lJnWJScemaK4BWuR0vef3VpjgX30G6FrFsM0uFReeCWqidp
         TTchnqcA4nczsSp9LHFe4R/x6ksGmAwxA+Kttlk6uNyP+nkU+uO/UsWi8CO6lI8NspVA
         jaPi2CmAeLhhIdyEKnclmZu0j6Bfo/i4svyyKb4KazgNhFoXg2UGMwZaU2A3gF00A1By
         2B+A==
X-Gm-Message-State: AOAM5333PXug5eNdNuSbJxJM3YCsPLzQmZlaHRQ9H8eyEWUdUQikwQka
        L342zkEprDcplI6+BA2HfoArLm+SeBg=
X-Google-Smtp-Source: ABdhPJz2aNhzUFF1kx85LExW7WbZsoES2i5Jr+1+6jikrvGwJstyVszp6eQta5bmv0Whr0YRaYCENQ==
X-Received: by 2002:a17:902:6947:: with SMTP id k7mr3321586plt.258.1590668858446;
        Thu, 28 May 2020 05:27:38 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:295a:ef64:e071:39ab? ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id i17sm4738987pfq.197.2020.05.28.05.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 05:27:37 -0700 (PDT)
Subject: Re: [PATCH 1/4] exfat: redefine PBR as boot_sector
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200525115110epcas1p491bfb477b12825536e81e376f34c7a02@epcas1p4.samsung.com>
 <20200525115052.19243-1-kohada.t2@gmail.com>
 <040701d634b1$375a2a40$a60e7ec0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <48fe0abe-8b1c-bea2-820f-71ca141af072@gmail.com>
Date:   Thu, 28 May 2020 21:27:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <040701d634b1$375a2a40$a60e7ec0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [snip]
>> +/* EXFAT: Main and Backup Boot Sector (512 bytes) */ struct boot_sector
>> +{
>> +	__u8	jmp_boot[BOOTSEC_JUMP_BOOT_LEN];
>> +	__u8	oem_name[BOOTSEC_OEM_NAME_LEN];
> 
> According to the exFAT specification, fs_name and BOOTSEC_FS_NAME_LEN look
> better.

Oops.
I sent v2 patches, before I noticed this comment,

I'll make another small patch, OK?

BTW
I have a concern about fs_name.
The exfat specification says that this field is "EXFAT".

I think it's a important field for determining the filesystem.
However, in this patch, I gave up checking this field.
Because there is no similar check in FATFS.
Do you know why Linux FATFS does not check this filed?
And, what do you think of checking this field?

BR
