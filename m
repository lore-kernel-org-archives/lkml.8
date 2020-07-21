Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80915C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5998420720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFCV90tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgGUWuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:50:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C53FC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:50:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so137762pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLNdH1kD/r0ZIb2tu8/TgP4snAvM1ZTMGSbpuMEUzJ0=;
        b=lFCV90tH97Pb6IUKGAYrNt12b5wuCcmXuFEJFddsbwBXzFZoz0k8E8VSJy3qgWofq3
         /1yQRik2NbTNXJQy5EhYNXZpbYD1/aF8LbWIJT8daIkgwHt1+VwR90DgsW5DkvA7DLlB
         D4aoanXxkb05rh1ZYlQy6u3gt/3QoCLyk3taY2OpmARU6lCVcZAZyrPYvAOcMEIA2hf8
         ivhV7pj0ufVquRBesEccfZX59zK3paqPDWoj2RtGxIPkwj8MJ98a+Qc3cp3uA3+SsWJQ
         nOcuSp/KTBHSsHHCM/6p9bPjhY4HPBKcdGKiTe2UtwJ5s5ATZ2AdyGlb+M58qtK/vxLU
         T+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZLNdH1kD/r0ZIb2tu8/TgP4snAvM1ZTMGSbpuMEUzJ0=;
        b=ShOSBDst4zS82QbkgVZsy96uUdHNKGq/qE8WyKxBM6wGMQVeektQnjifuGmkmX4Aqi
         +FEOvR74wGDRBRJzc370XFAaqMlE2D+XGf9Oo3yhRPPvHqygLlDS2Jj4x7Nq2wRZ+7IZ
         afwRfbybpaoB3IGHwNj2x0AmStNioxe6aNCclInrwKMdkxNZ4pPy3jPHBWd3fUZ/hTyc
         d9KZXVEWtaz/cCtaqMdvgVjz9v0encLPTOUIDcno/I2FQOxBLN3MRVar+C2tB+Wl1xts
         BWiBMVMGDo6TEdzGdt8d8neIvphUAOmfXFt2xEIx/pOH14tfhBYswJRcmJeo3IjivxoM
         A24Q==
X-Gm-Message-State: AOAM530wBxf80CV8KPOZWy5rZt6zPhoPAKcVdlE/zFHr2S2dn5IvvZwD
        MTeW4XTSvAyBQPdvHAvJ0rHCjXJZ+Os=
X-Google-Smtp-Source: ABdhPJxHyIJuOLzjsh1YKVqRwqYPvmrAkkW5JmyuN5Vf3DVI3bsiiLA67CkyTtHMXCt5a0meKsedkw==
X-Received: by 2002:a17:90a:a68:: with SMTP id o95mr7764522pjo.64.1595371836547;
        Tue, 21 Jul 2020 15:50:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c134sm21417979pfc.115.2020.07.21.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:50:35 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:50:35 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 15:50:27 PDT (-0700)
Subject:     Re: [PATCH 5.7 233/244] RISC-V: Acquire mmap lock before invoking walk_page_range
In-Reply-To: <20200720191403.GB1529125@kroah.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, naresh.kamboju@linaro.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, lkft-triage@lists.linaro.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>, walken@google.com
Message-ID: <mhng-903745bf-c5df-4e70-ade8-c1e596265fc4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 12:14:03 PDT (-0700), Greg KH wrote:
> On Mon, Jul 20, 2020 at 06:50:10PM +0000, Atish Patra wrote:
>> On Mon, 2020-07-20 at 23:11 +0530, Naresh Kamboju wrote:
>> > RISC-V build breaks on stable-rc 5.7 branch.
>> > build failed with gcc-8, gcc-9 and gcc-9.
>> >
>>
>> Sorry for the compilation issue.
>>
>> mmap_read_lock was intrdouced in the following commit.
>>
>> commit 9740ca4e95b4
>> Author: Michel Lespinasse <walken@google.com>
>> Date:   Mon Jun 8 21:33:14 2020 -0700
>>
>>     mmap locking API: initial implementation as rwsem wrappers
>>
>> The following two commits replaced the usage of mmap_sem rwsem calls
>> with mmap_lock.
>>
>> d8ed45c5dcd4 (mmap locking API: use coccinelle to convert mmap_sem
>> rwsem call sites)
>> 89154dd5313f (mmap locking API: convert mmap_sem call sites missed by
>> coccinelle)
>>
>> The first commit is not present in stale 5.7-y for obvious reasons.
>>
>> Do we need to send a separate patch only for stable branch with
>> mmap_sem ? I am not sure if that will cause a conflict again in future.
>
> I do not like taking odd backports, and would rather take the real patch
> that is upstream.

I guess I'm a bit new to stable backports so I'm not sure what's expected here.
The failing patch fixes a bug by using a new interface.  The smallest diff fix
for the stable kernels would be to construct a similar fix without the new
interface, which in this case is very easy as the new interface just converted
some generic locking calls to one-line functions.  It seems somewhat circuitous
to land that in Linus' tree, though, as it would require breaking our port
before fixing it to use the old interfaces and then cleaning it up to use the
new interfaces.

Are we expected to pull the new interface onto stable in addition to this fix?
The new interface doesn't actually fix anything itself, but it would allow a
functional kernel to be constructed that consisted of only backports from
Linus' tree (which would also make further fixes easier).  It seems safe to
just pull in 9740ca4e95b4 ("mmap locking API: initial implementation as rwsem
wrappers") before this failing patch, as in this case the new interface will
function correctly with only a subset of callers having been converted.  Of
course that's not a generally true statement so I don't know if future code
will behave that way, but pulling in those conversion patches is definitely
unnecessary diff right now.

> I will drop this patch from the tree now, so everyone can figure out
> what they want to do in the future :)

That certainly seems like the right way to go for now, thanks!
