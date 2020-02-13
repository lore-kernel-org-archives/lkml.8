Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0495C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C641217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xHqVFMsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgBMNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:49:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgBMNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:49:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so6660447ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNtbQDHg/1sgCok+ZoyzFMgx8nfnfEj3ekrfeoboK7M=;
        b=xHqVFMsvr5CaA5cCzOxgXJ2VcHKzsWk9DQReJ+86GD4Dp1N92v81IFCyDES9qa13qt
         0QA7jNkUmWImbgt5K2OxYuBW+pC7fCqnqJWpVewmIuUSGumSOOfq5aZVarFqllqvY8ec
         SflFEYjxvjX4PtnA8affQvBnWV3NXj2UKh+T7MzeW/S4OHyPOPm3RUjjolP1VBkGZHT0
         d4d4TTtU20gMCEVOPH+QA38dyHNQVeakBz97aNF1wskIC6P32cOH+7oXcaJMwi8afDeZ
         TeLRhdKYeIs38F0sAQBwe+QWE4ZcV5a9POlRhPlpDVXl7rBFB4v9u4Kc2kCFHQ61EIZh
         iYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNtbQDHg/1sgCok+ZoyzFMgx8nfnfEj3ekrfeoboK7M=;
        b=ARLa/DFPArAO8wpBb6RGcYRyj2DeT8MWPOoCx31QDjmdwX00kXp80KV+d6QH+PmfeR
         uh2dlDQjXdYrcZh3jfQbsHjrYoNvrVj58T4GCw6jRfeNDngKiBvjglMpBP1HVYSls+qd
         wZiSPH8hZxnA/J01JJizzKOo2y8Wsfk9E7+e3rKfp2qjUbCjbkBkMvEDJ8tEM2iK0CCN
         u8wATzPEIbkd33fkyuz+5RMzIy/RVe0bNZWN0RbSL9cJn2UVaOA00Ww5tgwVi3pHLzmA
         kiEJSn7mzeKnajZ8UphvuRxAavpPVVZOFrHfmrd3vE5Zq0BrA8W7M9EQ/5HmCVrn1qHv
         2UQA==
X-Gm-Message-State: APjAAAUhQj5mW2df+Rs6L2BOn7X3duxt9V1iHXd7IyC43oToGFKfav9L
        x+YJFQNA7/JW7SwlOCly/nNLgWv+80U=
X-Google-Smtp-Source: APXvYqyou1s4pqXdt5G8dZ+HFYGcNZy3XmUPG5ZPsqXV80/GAjdhKPzcPHv9pUcIVyNzhnx+59OOvg==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr11652827ljh.211.1581601782160;
        Thu, 13 Feb 2020 05:49:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m83sm1347841lfa.5.2020.02.13.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:49:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4BBE8100F25; Thu, 13 Feb 2020 16:50:03 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:50:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Message-ID: <20200213135003.5dedunhnsqw5vz7d@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-3-willy@infradead.org>
 <20200212074105.GE7068@infradead.org>
 <20200212130200.GC7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212130200.GC7778@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:02:00AM -0800, Matthew Wilcox wrote:
> Would this help?

LGTM:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
