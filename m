Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30549C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E6206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="nZB3nTfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHZCf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHZCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:35:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:35:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so310858pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTTirhS4tgARwSmt2CrwMKjZEtQBfU50yJZ95gB7kI0=;
        b=nZB3nTfXwtirj0Dfa02h5DsBk22b7a15AQG/8Ko2SeqemhlIzMy2w39Fz8bbh4K2vO
         Fx4gyfYwOFf7zThB7wyYq3gwTm4oCfF00+tWqQLQ5IHYhUicQMJe9P2XjChp8LWnXu2P
         iom5SDmp3BW0+4qVS62AIRq5kMP56kAxjqSnQmas1O04vVMWoV22LzXVTMYT5SoSZ7QE
         NU/agOeI6zKO/At7M99eJzFK1s0Sg9rcOmqEpTZLK56yLXSE36ai0sOUoug8hvnduR6k
         NbKzXDn4VPDzl6vW910Vi2GWUk6nJhlTNP/mCMEvxJ78J2R3JqB7Tq+8iHQXAuOV2nZD
         JTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTTirhS4tgARwSmt2CrwMKjZEtQBfU50yJZ95gB7kI0=;
        b=afaYkKC//NGoTzBbIFzl5MepR6w8ylpPq9KS25ohdQGq/tmV8VebpB64Gr0Ee+HDks
         QuemoqBxZdRqYjCgjF1uMg48CorZmOzACGAkUXhT8GI436bOg43cpYkXq0Ui3qOuSvj6
         VdVl2lWW6p9ECXAZkqAqCCpwIDprjtdmS4Dc8NcHmkGMTRzp5r6PPUGNAz+LhE19CZrS
         DUymBN/k8VymTQx8ruURVDerJ4COE5FY4gsDbODZN5POcsUNXMNv2g4IdmNi4UwgMbvu
         veB86LCoTq5m+eU5o+gwYj3yweLt2DOSRVwb6dumdFbNJEBHEivjafVwbvZrTAn2RFIq
         QaJg==
X-Gm-Message-State: AOAM531uxoyr5F7wYhohHo6etixKcqLWAlhZ4LRZ9y96jajgu3HIr4mQ
        mNmAHvgg88MsSBoH4WiLnqzZtwqQ91FxH0ymYjpvNQ==
X-Google-Smtp-Source: ABdhPJxqehxvxHho/3bJPXX1aOLT+XLYCBV/K23o3fqsovbLI048DponkAKzpgPKb3HyHIcb6ngfLWsifOHzCM+sS3U=
X-Received: by 2002:a62:6497:: with SMTP id y145mr10157831pfb.97.1598409324792;
 Tue, 25 Aug 2020 19:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200822095328.61306-1-songmuchun@bytedance.com> <20200825152509.GO1509399@tassilo.jf.intel.com>
In-Reply-To: <20200825152509.GO1509399@tassilo.jf.intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Aug 2020 10:34:48 +0800
Message-ID: <CAMZfGtUiN2GVA7scEyA3d=-Vk=8R58p6LWg3kU0URkkxzAJ8CA@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] Re: [PATCH] mm/hugetlb: Fix a race
 between hugetlb sysctl handlers
To:     Andi Kleen <ak@linux.intel.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        npiggin@suse.de, agl@us.ibm.com, nacc@us.ibm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Andi,

On Tue, Aug 25, 2020 at 11:34 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
>
> I don't think the Fixes line is correct. The original patch
> just used a global variable and didn't have this race.
> It must have been added later in some other patch that added
> hugetlb_sysctl_handler_common.

I don't agree with you. The 'e5ff215941d5' is not used a global
variable. Below is the code snippet of this patch. Thanks.

@@ -1037,8 +1109,19 @@ int hugetlb_sysctl_handler(struct ctl_table
*table, int write,
                           struct file *file, void __user *buffer,
                           size_t *length, loff_t *ppos)
 {
+       struct hstate *h = &default_hstate;
+       unsigned long tmp;

Here is a local variable of tmp.

+
+       if (!write)
+               tmp = h->max_huge_pages;
+
+       table->data = &tmp;
+       table->maxlen = sizeof(unsigned long);
        proc_doulongvec_minmax(table, write, file, buffer, length, ppos);
-       max_huge_pages = set_max_huge_pages(max_huge_pages);
+
+       if (write)
+               h->max_huge_pages = set_max_huge_pages(h, tmp);
+
        return 0;
 }


>
> -Andi



-- 
Yours,
Muchun
