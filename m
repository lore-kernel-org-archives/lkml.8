Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4664C24682
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Mq0KFbpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgBNPkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:40:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40470 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgBNPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:40:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so11223626ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uy1CqztgoQcCozHkTL1K6dkcJO5oDdn+9A9vOrHmi5Y=;
        b=Mq0KFbpLoF9RH+Q6+bpFpQUbThxc7670g4NmcANUlhxvng9ufszICF8xEA10dOqyvg
         sYpkFypNrcfijcqbmimN8MTI24oUlCmnJlLw8OLen6BekOa/Hj6Gh2gXFAotHK5ouAlZ
         hS9+xuWgLAPFIEW43m1yXgPgJoa9tt8RrsCcpwjCvlP3of9LrTGfLV4SeUO6NIdkqJDm
         KM/CrpG7ab5yoOr3w8MpB+OAAwSpQc5ICXjgo238k5xIHZVmgvvBceJT5Fhy9PQqneCb
         fulT7PRZFeOLhom9RUoYK8V5zWKeQv4wXTuMF/rX7ZZpc2+gZs795fVMZCaPkUuRFpvx
         q4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uy1CqztgoQcCozHkTL1K6dkcJO5oDdn+9A9vOrHmi5Y=;
        b=pWuqsQgnLNeG18LKwu0k1ccHhtAS7Rpd20yaVCoxjHLZgR/B/L8BEERwcs5UNAKk0B
         5w4aY7UoOs7oCU8xjmi9zW+pr5Wig7pVhXQd6m/Pq8yNGvpLlqoVA9d8lqo8f3e6CTGH
         mxTCIqK+CVLdL8TyiHyZinXpgaBV/vBK9aLVUnpz8j38kaAgaeVsGZ/bltIoQecL4Ndv
         0/fyojDfJmFkzyYVirezlHzKOCcQy2BU+6Dwyk51X1LZ8+Ru89XvXdHCzH/Y5iy2SOLp
         gPXxWjmrQdNa5VHQkKNwNi9ewydOLzMMsLppXcIxcZreDDUBJLmcBO9XKMfVLmOPyDqQ
         v4xw==
X-Gm-Message-State: APjAAAWHGA7YhZ8dTGLfbYMrmm8eNC9luRiizmXs2XwC2hxeaGHGT5ep
        hyCPYgBRYAQT7yi+H9k+OqmQGA==
X-Google-Smtp-Source: APXvYqyC35t7KSeDUk29sXEeP6DQL1WQaVxSElgrK2NjnDQFWzTLnR9PNmQep3WcsiJ7EYwiBf+M5w==
X-Received: by 2002:a2e:300e:: with SMTP id w14mr2482342ljw.222.1581694801044;
        Fri, 14 Feb 2020 07:40:01 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r9sm3835738lfc.72.2020.02.14.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:40:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0CFDA100F30; Fri, 14 Feb 2020 18:40:21 +0300 (+03)
Date:   Fri, 14 Feb 2020 18:40:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20200214154021.kgeon6i76yfdbaa5@box>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <33768a7e-837d-3bcd-fb98-19727921d6fd@linux.alibaba.com>
 <cd21f6a6-32a5-7d31-3bcd-4fc3f6cc0a84@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd21f6a6-32a5-7d31-3bcd-4fc3f6cc0a84@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:38:01PM -0800, Yang Shi wrote:
> Hi Kirill,
> 
> 
> Would you please help review this patch? I don't know why Hugh didn't
> response though I pinged him twice.

I have not noticed anything wrong with the patch.

But the function gets ugly beyond the reason. Any chance you could
restructure it to get somewhat maintainable? (It's not easy, I know).

-- 
 Kirill A. Shutemov
