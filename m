Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5840520776
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ofpa0GRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgEaB5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgEaB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 21:57:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42881C08C5CA
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 18:57:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a4so1798228pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/WemXoImhsNurvgvrjEvBKKt3N1OcqQaztjA3rpMsOA=;
        b=ofpa0GRSc19UCmmYAeJ1gtOd8ud77uSLXoC08oedhK8bjrfrzl8EngvyEIrG7O6r8a
         NTVckZLNnM1BaFZ2pEkdOq4k3dioXPAbN8oKyUcZvCHIfsnlpd+xxEMoFFqTmiP1D4Ba
         fzj1VEnxhxHiTuHBEmN+aDc9ctAMh2HuAsDSjAYXqgF6WYtQpPcDv6qTsO6dYzk5Ysbj
         1z+ctmnbNik5+6DsIBoZBLd9dL49RSaIuDUOzb1+jg9/8j8p2ZWmyQvabuIvYkIc6GyU
         xeJbaKTZUcxCI9a1YTz0RJLt2oO9CQlhUbLHAILywxh1pmFk8vCRsy6VDrE4MBsCMQMj
         f+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WemXoImhsNurvgvrjEvBKKt3N1OcqQaztjA3rpMsOA=;
        b=O/huMoMoMyDZwq0DErKXnBuvNzXIqfUK+aVYHxZD0BhaYswC0ADeRWjNmI0PW3DLnS
         2r+lfNzQ8E3fs+PbdHxYNLCSi6f8Zdv4j9iXLxba5FlwgSIirvUzyU2E10rO4i3PytHF
         KjRLcHc2lHNr452GPD9/eVBFofRt1fWz4krpPbnCKlsoaeLHKIYZqpL6yVGnSp6WXRDT
         hliywxUwZPpwbdmWUvefjkBehD6zi7zz9Sh3f3tp+Lz2o6v+NVKa2cosuKx71n1SIRMO
         EdLPRK7yXYl+PlLwfBTMaeMv0GV+QhWIKOlC/4AfThS5MhoQJEBaS6QEPCXaAui3mpew
         S/mQ==
X-Gm-Message-State: AOAM531x9Wi2ooxJYllG1JsISeBAGBHQC5a3jS3QwBM4zOMimJ9NtF7Z
        Cs46nNVeTyrRn5Q+mCfjiUPkeA==
X-Google-Smtp-Source: ABdhPJw6sUzC2QmIdh/46N6SW7kJ6geIM+mogd6Zf0NHPly6gKiWjN/PHRTVUbAl2wQ1IE2MhqWBpA==
X-Received: by 2002:a63:f854:: with SMTP id v20mr14543363pgj.0.1590890267589;
        Sat, 30 May 2020 18:57:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k12sm10444543pfg.177.2020.05.30.18.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 18:57:46 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
To:     sedat.dilek@gmail.com
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <CA+icZUWfX+QmroE6j74C7o-BdfMF5=6PdYrA=5W_JCKddqkJgQ@mail.gmail.com>
 <bab2d6f8-4c65-be21-6a8e-29b76c06807d@kernel.dk>
 <CA+icZUUgazqLRwnbQgFPhCa5vAsAvJhjCGMYs7KYBZgA04mSyw@mail.gmail.com>
 <CA+icZUUwz5TPpT_zS=P4MZBDzzrAcFvZMUce8mJu8M1C7KNO5A@mail.gmail.com>
 <CA+icZUVJT8X3zyafrgbkJppsp4nJEKaLjYNs1kX8H+aY1Y10Qw@mail.gmail.com>
 <CA+icZUWHOYcGUpw4gfT7xP2Twr15YbyXiWA_=Mc+f7NgzZCETw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <230d3380-0269-d113-2c32-6e4fb94b79b8@kernel.dk>
Date:   Sat, 30 May 2020 19:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUWHOYcGUpw4gfT7xP2Twr15YbyXiWA_=Mc+f7NgzZCETw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/20 12:57 PM, Sedat Dilek wrote:
> Here are the numbers with your patchset:
> 
> # cat systemd-analyze-time_5.7.0-rc7-4-amd64-clang_2nd-try.txt
> Startup finished in 7.229s (kernel) + 1min 18.304s (userspace) = 1min 25.534s
> graphical.target reached after 1min 18.286s in userspace

Can you see if this makes a difference?

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c296463c15eb..ccb895f911b1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,8 +374,7 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		\
-	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
+#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)

-- 
Jens Axboe

