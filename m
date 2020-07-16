Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C01C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E562076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sIftRPRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGPNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgGPNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:17:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DBC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:17:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so7100784ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5qvqp7i9pGe/AtHlHz71cVG+5e0FG1RqQpp4GXhoLM=;
        b=sIftRPRG702Z1I1WOW4Fzuf+q99t3ZflmLuikxRMy5BxwR0rtDQ16lcc/wpZ3zaPfU
         yMdgtl4RwI8M0PSkF3LcuQvwavEbpcbx4TUOBXfMTe+wfyULYrlrepSZYODe7HQCfki7
         JbsA+W57eVgW34ZS6t67KVCbO6UxCDukJgodJ6CyglTzJIaewo9slKd8E+Nuj77eawRf
         8qUFkBsvMta/7L/HGyaqYYJdtijGwphH7Kqv/JfBrPMD+SepIiIpalUXgHKSfeUlpin9
         iPvn53qhRGm9DxvI8JvUml+5VbKPW+xUIaebJjYUXWjBaGPieygJ1q6h4gSUihCKtLgl
         d2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5qvqp7i9pGe/AtHlHz71cVG+5e0FG1RqQpp4GXhoLM=;
        b=iLwG/VMjSm+vCIIPyUnuGTLDAwW+xuTqm9S0UPySc7gsPwINBDFKxln5Dh18mL8y6x
         TKhOv4QqlD1CpR2NCXF7CRVw+CiEx+Nae8wn0rdnguDWCNbotntIU7srVTcaYgSm11H7
         vXD5R4NbiRdFKsVGsLzD8KroLUVlTU1YU0uJhZxBwwdGvKxupodBmhhAKE241SWlA4Pu
         aPMPFHeqZPg7h5apLuiMhIcHShRGegYMc+78St+b1zxrOaQuc0Cf0XDeiivMXR6/Vf/1
         6VtVmO+uTj4KGOosQBthIfNHMRRgWDsE1py1ddOX0LHZ+KKxYkvulZGSFYcQKgf8C/U6
         Mjaw==
X-Gm-Message-State: AOAM530PCyDEQnQHJ6nxXDooD/Ueeqa2dmG7jTm5fhdBU3aMpOfMz1XN
        +SxZqd7ZOlEN+5SIfFIMwISJSg==
X-Google-Smtp-Source: ABdhPJx2+owb73fQ/D4FeUCKaDliqhWjIyO0fRPipW5Ly6Tr1wDXXJj32vmz37eS+aB9Y+DT6iqbOg==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr2132595ljj.411.1594905421188;
        Thu, 16 Jul 2020 06:17:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w15sm1176686lff.25.2020.07.16.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:17:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ABF391020C1; Thu, 16 Jul 2020 16:17:06 +0300 (+03)
Date:   Thu, 16 Jul 2020 16:17:06 +0300
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
Message-ID: <20200716131706.h6c5nob4somfmegp@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
 <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:59:48PM +0800, Alex Shi wrote:
> Hi Kirill & Matthew,
> 
> Is there any concern from for the THP involved patches?

It is mechanical move. I don't see a problem.

-- 
 Kirill A. Shutemov
