Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9FC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698E220722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="qe7hPOoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgBTUKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:10:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41566 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgBTUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:10:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so2446678pfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 12:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2w+R3Z75BVcBJL4mHaaewYE8ej5x4YeGxTQpsg56oM0=;
        b=qe7hPOoCCTMNdxtIg3f5Pg5ViViUneZC/ftBiK39R+KVP0JYxDL98CFA0YNadsMx/O
         GGsjFOFhKwL8Dvxs5SCZQpNJ5gOJIPlgouPjCxdNRQp+s+RFDuDAXO9/krV4g++BYW9e
         jUYlrUfhlkzvoQAw7wlqGZRWjNjf/75L6hTA0vG08+8mrmHo7+JtHFFfm6y8viK6NmHD
         CBxpa3ASk5oqLVuxb3mJTy+0cOGMBm5lzDsJXgAYiWGZRC68iYsB0jRPc6DmaRBZNVzu
         f3Lph20DUJ5Xf4OOvB2aB9VxfUVK8VMWveuVv4tTteDBeKfIqKl2E8naXchVBmNTXEc9
         fV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2w+R3Z75BVcBJL4mHaaewYE8ej5x4YeGxTQpsg56oM0=;
        b=ALpXbZxSs91JodwHQC04EUdEadfnZAJk3eMFVWsJyNuBLC86Do1gBv8EjiKZUEwSS/
         +1pttlS8pFTo9RpccaR8xqP2fPHiJbEuSX4hGjJFggPaSAB1X6VLyCqXCOfwwtu7wgok
         3zkagWzS77CQJeySYu39Yjw5NTRbt8hffdn5nD7liVBB51tLRAT8B3SfbSUjHJLB9Fyq
         JYn5OoFl6pozVyfUvXkcoKaZ1G+wG/fUkdd8VU7pjvtZtnVA/uhm1b+jNH8CdvFyBUxP
         Fg3+okBLfNmpGzR0QcOs06azDVXzs4FjAWBukVygpcInukSED0H3fRB/0BTxBfzcfDE6
         JxlQ==
X-Gm-Message-State: APjAAAXS1QGP2F5JXU5WJpvKiGsOfRpIuPfjONCXOYvM+tgi9XbKn373
        IJP1rIznTZkoM8N/198VRHCryt5E2O6Gmcwo
X-Google-Smtp-Source: APXvYqzHNbmO1s9R3NGefmrkNGHZZe0xixDdrQKTauLTfQfkXcLz68TcQ+ehcG7N+NwoOzOY7LsmHg==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr32854344pfc.94.1582229439310;
        Thu, 20 Feb 2020 12:10:39 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id l1sm262100pjb.28.2020.02.20.12.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 12:10:38 -0800 (PST)
Date:   Fri, 21 Feb 2020 01:40:33 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: match parentheses alignment
Message-ID: <20200220201033.GA14855@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match the next line with open parentheses by giving appropriate tabs.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/octeon/octeon-stubs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index ea33c94fa12b..d06743504f2b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1345,7 +1345,7 @@ static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-						       cvmx_pow_wait_t wait)
+					       cvmx_pow_wait_t wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
-- 
2.17.1

