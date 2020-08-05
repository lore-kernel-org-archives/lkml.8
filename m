Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A048C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A720792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="mImzrEAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHECUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHECUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:20:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 19:20:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so3460782pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=01MxYpKFXDZaXCcX+RooTiv/T8V3zULRixPU7jN/r44=;
        b=mImzrEAl0d6G/+6l8JJFXutcAF+pXD6CTUNLi9RPwj9e2tKa9TUK80JAu1WHnV5yBW
         RuwBsp8YYqdgi2IEqeS+lCkvkEe4YlVfelQe9AOa/Czl8Cu3vYTzrmPB0fJZGQ4O33eA
         P1q6ixfFAlVA1xzkpocndvzWTSh2e1J+VqbGA/R84QHadggRQ1PugQqLyiNx5n92DPqp
         jqhgnuYwFWk+smjVTIS5/9YaU6v1p3Ub7hCuBQZL6xuxJV6oCbOjx+eFKe0c4AW8vozQ
         CrP4ymyoAYHrzo0s1skjUfgRL26M+Z6JuSLN9+gcCGaHZIOCYjoE3QG62oHl0blm55b3
         hkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=01MxYpKFXDZaXCcX+RooTiv/T8V3zULRixPU7jN/r44=;
        b=s2iqD6VNS3pBAlbjHnmFccAgC3NIt13LRtQT+LYcxJ6JPHWuP1kp2lWvrdyX4ZzMMr
         l0HjKR915ujaXYKBkpevkNEUjkEZEf3/dvXkpo87tqvo4Nh6BPv5jzHI7kk6b9C2g8uz
         kZF1B5h2UExPqpt7pRYg948B8W0fjbg+qEsSK6qsNxZN8Qidg0z11c05u7Jljx+8V7Nu
         CAErbfbBl5QuBsfNbn9nqx58l3swODK5oGMWp+XKrhg265WIGAVpeiInqSDKs820eXry
         PBGcQrX1ZkD1QwJZD67o0K6yALGdOJT+lX5+WQAfRrvTnRfOD+bnJEmupCNmk5CaWLcs
         rhew==
X-Gm-Message-State: AOAM532zlSEhxtSQQhJn0zgADmzA2IMqT1ZGM6w58lwv0FZc45jvoFju
        7ZV3GDUOKvchM+WyI2TGIr3t+A==
X-Google-Smtp-Source: ABdhPJyEtXmvM6xJHC6ANpTYfrSoC3v9n1iu0e+qTUYSwlXsTq02/bh0EUkORzHX/tsNdyc24vBIXg==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr1012253plq.221.1596594006023;
        Tue, 04 Aug 2020 19:20:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d17sm582843pjr.40.2020.08.04.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 19:20:05 -0700 (PDT)
Date:   Tue, 04 Aug 2020 19:20:05 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 19:20:03 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: ptrace: Use the correct API for `fcsr' access
In-Reply-To: <20200805020745.GL1236603@ZenIV.linux.org.uk>
CC:     macro@wdc.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     viro@zeniv.linux.org.uk
Message-ID: <mhng-cd1ff2e9-7d34-4d56-8d79-b2d02a239290@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Aug 2020 19:07:45 PDT (-0700), viro@zeniv.linux.org.uk wrote:
> On Tue, Aug 04, 2020 at 07:01:01PM -0700, Palmer Dabbelt wrote:
>
>> > We currently have @start_pos fixed at 0 across all calls, which works as
>> > a result of the implementation, in particular because we have no padding
>> > between the FP general registers and the FP control and status register,
>> > but appears not to have been the intent of the API and is not what other
>> > ports do, requiring one to study the copy handlers to understand what is
>> > going on here.
>
> start_pos *is* fixed at 0 and it's going to go away, along with the
> sodding user_regset_copyout() very shortly.  ->get() is simply a bad API.
> See vfs.git#work.regset for replacement.  And ->put() is also going to be
> taken out and shot (next cycle, most likely).

I'm not sure I understand what you're saying, but given that branch replaces
all of this I guess it's best to just do nothing on our end here?
