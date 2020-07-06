Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45441C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F92073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIaPJSHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGFWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFWGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:06:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E70C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:06:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so36609539edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwnfFNKEwONS9Ri0ifGYnWjmFaXQolYJkOcnSn5GMT4=;
        b=SIaPJSHnhLmRrF0rL4Tr0mXNu4GbzdhL3inGoTmLraRHhU3ATbV69UucigCeM0UyY6
         wlweqZLaKFDDtt+cP2LRGqc5mhJRVEAhnK3qUNIkVR1pYyeatZ47GMd6iGs+4g44xSyG
         kf6FTNTzvq3zYHJybpri/2HgNuyJ3ScAvqy/rQ7ilMlWpDs2/ZYkPAUy9URQHqMouPbl
         uMZ3LdFj4DKdmPm3ulptAEIxsL3CGQ7j0WU4+hwc0AD+qTJhC8iN1GQVTRMltUTCy7OO
         kyT1sLuI/7DpfP4L+nyShUkAHd4aFC2dWZvXlhCv44JwSM4KFAc23YCDpsRNJNAps5cz
         rFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwnfFNKEwONS9Ri0ifGYnWjmFaXQolYJkOcnSn5GMT4=;
        b=TsjXqRMo+AZjC0hEdPGwK0lmkGXwh3G/UV3LirjInYaE887JhKQ2w1i48rslxk26Id
         BpJJQJv88qA0c4myPYOzCecez3TB4FUuMgph/jPcK1jBW/27WVSCjvgBoLBY548CvTzf
         7RsaZuqir5QwzJqDut4SfST/3jCA4UtGK9IxEuF/1fo9X6oPw082X6CzfoEwNcrNBWUx
         DFhSaYjClMY/bP300o3cFK9uZAozntG9hEETggOBPPi/I/Ok2dl5nLPZt+dNYfYV0mcy
         rsInHSGV2g3+97vankjKz+5E0eg50AXtHFPhDmwL3OW57hoZL9Jb9nI8Fn4yqbTpK+cF
         6YfA==
X-Gm-Message-State: AOAM5315HzxzuWb6Y4HlQHDAuNd9dEJxPcngsPbtk1Evssu1J2naZEHy
        qKh0ZRx61/IrvWpM42z55Ho=
X-Google-Smtp-Source: ABdhPJyJdyThAtQC3fBNxE1km/rQtK/mxUilIUsQu7tW8CAiI8COtMImlxBjU9UMeUXefvLXkFJ0lg==
X-Received: by 2002:a05:6402:16db:: with SMTP id r27mr59239987edx.139.1594073209736;
        Mon, 06 Jul 2020 15:06:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x64sm27379026edc.95.2020.07.06.15.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 15:06:49 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:06:48 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 0/4] mm/mremap: cleanup move_page_tables() a
 little
Message-ID: <20200706220648.qfzwnitoswbbkdnw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200706100819.flwgozlstn3zl66u@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706100819.flwgozlstn3zl66u@box>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:08:19PM +0300, Kirill A. Shutemov wrote:
>On Fri, Jun 26, 2020 at 09:52:12PM +0800, Wei Yang wrote:
>> move_page_tables() tries to move page table by PMD or PTE.
>> 
>> The root reason is if it tries to move PMD, both old and new range should be
>> PMD aligned. But current code calculate old range and new range separately.
>> This leads to some redundant check and calculation.
>> 
>> This cleanup tries to consolidate the range check in one place to reduce some
>> extra range handling.
>
>The patchet looks good to me. I have few nits, but nothing substantial.
>
>Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

Hi, Kirill

Thanks for your review.

Andrew,

Do you want me to send another version or you would like to adjust it
directly?

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
