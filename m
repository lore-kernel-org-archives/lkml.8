Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FBAC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AC52467E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fDjftacl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDFPUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:20:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40003 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgDFPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:20:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so12167074lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VN7tXM9WpWG9Sex4ME8LHgSGrAm2umkz7YNU7j8s4/s=;
        b=fDjftaclnJNAHgUIzctyYVGlJOYjK1zg48mQXrNidXzE6ENUWI3HD+BbyQeXUlv0pb
         pwhmdsJ1ZJSbOf1kpPXSNz/juf7ho7MUfcvHZXuyREAMAFQ+mu5ANmmtturoYtr9+NXj
         QPYvB9/hZRG2qd6Z/PpdpH48ZWjwUXQ5pXDZMuEyDtnqUmEUjYJ3lz6oR8j5QkOeGZME
         InccEQclxTn0Wk0It5QjzItTZmOiC6lyK0/Vn7d7F6jPDksRIdubxO94etUl4hg5AMa0
         jp7U6MQ3Qmdo4cU/6rqv8xesBYLZ1rMZGCdoAwhDd3+vornfy5zK1kQ5vtVjrdAYnsVU
         jpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VN7tXM9WpWG9Sex4ME8LHgSGrAm2umkz7YNU7j8s4/s=;
        b=uG01FDQhZex2g/4zfH3JgEkgZxirr3bHpMRU7E44Jl6nCLg5XbynLVrXcrwIMo6XUB
         qBaUXtKAJDtpbRF/YT9jLSN0Y0rXcKmDZyJa9Mpd4Lts04nTEA9WY3kkqEq4KoB3HLl4
         j9LjUuspmH6jOA3H/4laq6VmdUzRdGiepob6HB4uAwEiIMkB4PuHyhUnnihIvHHNrzoJ
         UVhlDyx0BJqHllf/8KKb7jYIJoePma76fZkSpY5VKqWy5Xw6T59byPveiuGdGYj6zk1H
         j3hDsP1bHkyf9DCYWtigZnI9ftZmIGPVT2BgZ/uOmxiO+O12QbiSpSJ2W1wCccpZRZ5B
         Vi3g==
X-Gm-Message-State: AGi0PuaQbbyq9l8l2hnHLCh/P/M4rps1SoB9CPyRmUyBwxSVpAJr3YPE
        EDvmM3V5t1ONnDut8GM21k2eig==
X-Google-Smtp-Source: APiQypLr20J7wFsgSBvkpQ/qciIciJhmrONztZPR/8e8xi0AtXx2Jm9+0FF68/7o2ANPhGiR+o2kEA==
X-Received: by 2002:ac2:545a:: with SMTP id d26mr13913427lfn.85.1586186434219;
        Mon, 06 Apr 2020 08:20:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z9sm9454960lfd.9.2020.04.06.08.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:20:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B505F1017CF; Mon,  6 Apr 2020 18:20:35 +0300 (+03)
Date:   Mon, 6 Apr 2020 18:20:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Message-ID: <20200406152035.ga7hk6jfaqzvlete@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:59:52AM -0400, Zi Yan wrote:
> I ran this test with all patches from this series applied to Linus’s
> tree, but still see several failures. Is it expected?

[Thanks for catching all my typos]

No. It works fine for me.
Well, occasionally, it fails to swap out a page, but nothing like you have
here.

Could you try to trace it? I used script like below after mounting
tracefs. You may want to comment out all tests but a failing one.

#!/bin/sh -efu

echo > /sys/kernel/tracing/trace
echo 1 > /sys/kernel/tracing/events/huge_memory/enable

while ./khugepaged; do
	echo > /sys/kernel/tracing/trace
done

cat /sys/kernel/tracing/trace

-- 
 Kirill A. Shutemov
