Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B66E22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vQVQN9m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGTIhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:37:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:37:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so19336162ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=74/+EzKUAAKlAxACD2N9LwyXc8GIiGB7bIu4cn5OH/s=;
        b=vQVQN9m3LFq9Ac9pxVX05L3jLmD+2U9Pg1NxkoR0om6MN0CgbAArh2CJ12CXyxrFL+
         3IiUGT7KD5izRqhVEEWIKJ1KhzHpmeUgBTXRK4tmYXrW5WPJUyvjKhX8m0dnyhs09+oR
         t1dtcXDwSBOkQvQ/TfJJGBUo92n6DLuwqrJ601PkTy6Od1gF51Bi7eX6vu3TsT7C7PVn
         c/DB1ZpauA4MiBkr0bPc6oMt7vhuCfZqK1rcCXl/s6VT7E7q1kuWtLu+R2y01txevzpH
         8yDU7lAbqd60QD5jlYltL3AAJxoUEeBpsKjJhlFwY2RtgUXj085jYnNnDTfB78cdrtWC
         vmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=74/+EzKUAAKlAxACD2N9LwyXc8GIiGB7bIu4cn5OH/s=;
        b=aAlL1emdoNUDIvLuLg19MoVNupp0zBI8nAy6TW3+X/jqEXH1mQ0FLRQoL4EOqLYHD+
         GbkC3aKt1CLCrz/zSU5wXTvW4iZb86L2KyORQgKvl10CpelYHbjM/KL9GbIJPCKqX5eM
         IMF8iw+e4GvXhaacUTzSB5PqU7erGYXnK6GRZyDgXXb6ddnX5nHHAnv/39PiJabIK/YK
         eWU8PC+JW6iy7jnJu2ltyOHsnJUIp0vYxSI/6J/p4eFRYphcVEW5KT14Bjnlf4K1FLom
         7LptVgKnv1ukHgrW+De/RqPFNdKG3st3eEM48iNUIKoV80aclAeU1zyIOVxBTuXa4xFQ
         pZ9g==
X-Gm-Message-State: AOAM532O6J6DbvQ1HlY6772mH0mqAZLHyQVPIIdHKk9KZKbOAEsvnM4g
        cx/5VuVzCybxWiPuro2Jlt+hmw==
X-Google-Smtp-Source: ABdhPJzvyfql7KnOLFGB+ImTGN6HNKSHcKgVJ1tI3HQEzzu+N7RZLG971Ge+Rm1WAvLpPKPQIT3sww==
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr9222483ljo.341.1595234272759;
        Mon, 20 Jul 2020 01:37:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 193sm4274310lfa.90.2020.07.20.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:37:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 38B47102393; Mon, 20 Jul 2020 11:37:51 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:37:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v16 05/22] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200720083751.7q4wgmrsefknzwyd@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
 <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
 <20200716131706.h6c5nob4somfmegp@box>
 <045c70c7-e4e4-c1d1-b066-c359ef9f15a5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045c70c7-e4e4-c1d1-b066-c359ef9f15a5@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:13:21PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/7/16 下午9:17, Kirill A. Shutemov 写道:
> > On Thu, Jul 16, 2020 at 04:59:48PM +0800, Alex Shi wrote:
> >> Hi Kirill & Matthew,
> >>
> >> Is there any concern from for the THP involved patches?
> > 
> > It is mechanical move. I don't see a problem.
> > 
> 
> Many thanks! Kirill,
> 
> Do you mind to give a reviewed-by?

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
