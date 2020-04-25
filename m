Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36FCC54FD0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FAC214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Qpzj/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYAaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDYAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:30:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE30C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:30:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so13467049wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y7OSUUlX1RAKYJlkMObxl1MgLKnZif1MLfSHlBdua08=;
        b=R9Qpzj/qsrg1RgIMyKxMuRZqV0VSAH97oK37CFZM5ozt5vphDVIFHcl2Uy/gvoC+DJ
         Y2KD1LTYctrrCf5mmK39OhbpSqNTfsX08slzpnSDkq17KRsDx4Tps6t16gl9HBUs4eFP
         NQO7s4VHZdG9saXIe3O9HYXUSsD6DD76ZdmuLvEwj0PiY+SwsvkJxKETZgfaEKETmIGs
         MFU1IhyH5IkiHGJmcPWw8amU30qfBUMi9j8ReiCvaNwDKY0IwwWJTkIbu9tdSM0/lBLm
         JBrWhMFv3wFNM6YsWvUlZLUN+MlQ8sh4uWUC/lpb3uhHoe3C4ilQcgcxAI8hC4bi0/Oz
         gRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y7OSUUlX1RAKYJlkMObxl1MgLKnZif1MLfSHlBdua08=;
        b=gCMcfXAOLjkRJxJxa/JcdO1qCX4IR1GOUE2U/CTooB5PwsU7xlKJmwypzquhDI5bQc
         ZHMSpti9Us4LdeicJC7S4F4C8d0JunmP+7b1D1+cBw9oUS+iuFvCvvMPRKWAHSfoa+LY
         djV86PZyXboOtI7HakbujOf/tGnt7sm2/5vHrxWRANrsi/UXmTzgipGLaUMH7Zy0GDe8
         g66JkPuqumdhr+xRq4ALQtPrb3PwGDi3I9YxwkYFqH2txzx41Pu6ZeFx+gZXBerwWT/l
         M1UROFEfvA3LCu7snyAX3t8sW01SepLEWHJXww6bAiW9dOn3WkZ3FL72Bt8qW6tZkmNo
         oQsQ==
X-Gm-Message-State: AGi0PuafeJ5LceF5tKvk0G8qSv/RoVON+5U+2Q5/EQf08kbM1oJGjd5n
        J/sOH9bAHH+4VajXNic3NMlKyeBx
X-Google-Smtp-Source: APiQypJe/RyviRQ0Arjdjlyd8vAASJTdfNB3Qjqis+cugV3WpQ+RlbOTL4FAJYn5Yn1+8C+Goz+KLg==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr13587375wrs.32.1587774613609;
        Fri, 24 Apr 2020 17:30:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k17sm5000384wmi.10.2020.04.24.17.30.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 17:30:12 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:30:12 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200425003012.uuqh547feq3kz4y5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
 <87d07y2181.fsf@yhuang-dev.intel.com>
 <20200423131507.2rgrk3okh42oo6gh@master>
 <87r1wdzlm5.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1wdzlm5.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
[...]
>>>
>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>scan_base need to be returned.
>>>
>>
>> When this case would happen in the original code?
>
>In the original code, the loop can still stop.
>

Sorry, I don't get your point yet.

In original code, there are two separate loops

    while (++offset <= si->highest_bit) {
    }

    while (offset < scan_base) {
    }

And for your condition, (offset > highest_bit) && (offset < scan_base), which
terminates the first loop and fits the second loop well.

Not sure how this condition would stop the loop in original code?

>Best Regards,
>Huang, Ying
>
>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>
>>>Best Regards,
>>>Huang, Ying

-- 
Wei Yang
Help you, Help me
