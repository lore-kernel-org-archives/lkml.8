Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F858206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nANjiioT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgEHNST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728591AbgEHNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:18:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAABC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:18:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so1824234wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9nChlhKbO9BjNaYzNwfsyUYTQj0xKTlbsDHkjKVD9kg=;
        b=nANjiioTUJaVJfjULoRIi8nV/rgHwSpBvsRO6EQVlFhkUVXkfEaQdlX2OM2u0OdRMu
         uukdCy4/iM7UgCG09MdWXmIArxiuZ2VMHUo2iAZzLYAtWWkPYYfMQwDfwCNpzVM62TxG
         mUOBHTf0AF4bWdYtQe+AEnyPj8Q78QjySWZnaA+WokDwSH97xWz6Bk3vkioelikKVepJ
         9B9G3DmSUyAhDyN34cSXkOfMvqlT3VuvVxV+BxCxzXfJV3Ayi17oBZ5y1hoR5SgN6YPm
         HWHKBji3uc81BImbm/IIiPjvdk9PEJxc5/eN+NZTa2lx/ooT7XplQU8h1lpoQW2UpVOg
         x9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nChlhKbO9BjNaYzNwfsyUYTQj0xKTlbsDHkjKVD9kg=;
        b=VOjGsEljeVkMnCVv1opxaIsK2Zw1yIpIqBnCz6rXpmcO072Y30uYwneJ1r71TONS9w
         HrIsrvHlpeLLMziEFXRESgbwaaUCuSx9amVcJBsXpog0FmaFGAIqEIseI4Wh/JZLALEV
         NkBWOv64RC2VtIJH0+abNMPKFjsE0v6Ge/PReWZp4fdv5p/8Gr2f86FTfZ8N3gakSBH3
         GepwKhW5z/Q9RLJ6lXOvj6C+Dpj2ifQ2pYs/cX5DrasDaZHn+xZJfUQ5JNnGzWMeA0bZ
         LSwKJF8a+iHPKtddYGYoXLx39YXPjJeMbCYUOn69X/avELdI2GdXQbi1B2ZCJBFHA6bh
         BBBA==
X-Gm-Message-State: AGi0PuaN7vqmaUb8FWKE4wcijOB2V6oUDXrWhhuowIiNRWfZoTsiGziY
        ec8R89oGN5NrDicf6jUQ61fvPA==
X-Google-Smtp-Source: APiQypL+1KhIUnHBdu8MermDCbWXNpBe6I70VK/mm3MUDxStvjwGwDUlBSSTUQKpESNMefoQrrDwTQ==
X-Received: by 2002:adf:fac5:: with SMTP id a5mr3115224wrs.210.1588943888335;
        Fri, 08 May 2020 06:18:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u12sm13658718wmu.25.2020.05.08.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:18:07 -0700 (PDT)
Date:   Fri, 8 May 2020 14:18:04 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508131804.GC10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508053359.ul5dbws6vkpdrbef@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053359.ul5dbws6vkpdrbef@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Friday 08 May 2020 at 11:03:59 (+0530), Viresh Kumar wrote:
> IMHO, you have over-broken the patches, like first two could be merged
> together and all exports could have been done in a single patch, etc.
> i.e. all related or similar changes together...

Right, I don't mind squashing the first patches. For the exports, I'm
guessing they'll need a case by case discussion, so it's probably
reasonable to keep them separate, at least for now.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
Quentin
