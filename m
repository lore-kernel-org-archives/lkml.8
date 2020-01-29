Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC9C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DE220716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO1MuPCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgA2VAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:00:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54510 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgA2VAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:00:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so320892pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mMHj7VQFJ/ru51SSc9JWwA5eIS4YpdouqCmEJIqSD3s=;
        b=gO1MuPCCzwJo6EXl1niF9Nc6Pd0XCURfNhJmEtuV0mF/2PRgvb2nXlZ62BvLzbgPoJ
         /x315s7W8W6TGg1qsy73Xm1Ujmx5N5x95A6L3xwbMJ5yzCz3tQv0+qN1xm+ac1uvJ3qi
         oq6FQIEde4mQG6wOn36dCV1T6iCQS7C10HI7Q0zEWfHyRrLwKycChsZC9pCTeFOK/XgS
         MLxk35KrU1T1sWDXMp3CHH2kJRQex6cDy2WqUJfkbYKhBWRmVrIhPTxQnYjpUQzrzjtf
         qKIm5qzhJMeVt9kj4Ugt4QQYIaUGtoOTXRQDvinBq0xHktYy+sMx//j60z5CIZEFB73T
         pTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mMHj7VQFJ/ru51SSc9JWwA5eIS4YpdouqCmEJIqSD3s=;
        b=jxYDE6XjFf8HLK8U/1LNDO1lROcgt+Ev+F6kFQJsQzMYYRIis2bg4KzVY1u25G2sW7
         5PiTtFREr7Pg5VPpUgTd4i5B0sE7Zlwl4qYd6OJfMjJnj4VAzzQByyzVnJ6qRo1AXdZ4
         /ZERKcldMm8VjDt5LX+bPpHmEejWedv2HD8L/BwyEIaoHWwNoSlXFRMcP93ZdZCdKGun
         zQAfbYX/ijq11dlbhaBglPAqU9w3CEYFvzn27EciOjDsVYMk56M7yiRzDyNYhwOHpZ/k
         TVgXN5YCIm3UZLcNlkCr1kbBT/gl/gpvjfG/2NNTRLSW1rtR5HRn7UcMi+wOgWPXARKz
         likg==
X-Gm-Message-State: APjAAAXs8a0gyeqNRo8R1e9I+VGEKIp72hPG9M1pbF1QcYNawOKwYBGy
        Hozua0HdAyoM7+wJ/zgbVxVxdA==
X-Google-Smtp-Source: APXvYqwwsgYkaH1FxmcBL16bgFwn1K3P9bSw/X5rfK8KXL1891FWdD3zVJE8MVHT+EKF+0rVog6gng==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr1284534plc.335.1580331617669;
        Wed, 29 Jan 2020 13:00:17 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z18sm3730466pfk.19.2020.01.29.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:00:17 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:00:16 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Sandipan Das <sandipan@linux.ibm.com>
cc:     Mina Almasry <almasrymina@google.com>, mike.kravetz@oracle.com,
        shakeelb@google.com, shuah@kernel.org, gthelen@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 tests
In-Reply-To: <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2001291257510.175731@chino.kir.corp.google.com>
References: <20200115012651.228058-1-almasrymina@google.com> <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020, Sandipan Das wrote:

> > The tests use both shared and private mapped hugetlb memory, and
> > monitors the hugetlb usage counter as well as the hugetlb reservation
> > counter. They test different configurations such as hugetlb memory usage
> > via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
> > MAP_POPULATE.
> > 
> > Also add test for hugetlb reservation reparenting, since this is
> > a subtle issue.
> > 
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > 
> 
> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> system with Hash MMU and ran into problems because the tests assume that the
> hugepage size is always 2MB. Can you determine the huge page size at runtime?
> 

I assume this is only testing failures of the tools/testing/selftests 
additions that hardcode 2MB paths and not a kernel problem?  In other 
words, you can still boot, reserve, alloc, and free hugetlb pages on ppc 
after this patchset without using the selftests?
