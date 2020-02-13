Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C90EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCbiiiRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgBMRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:23:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37486 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgBMRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:23:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so7688059wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=CV85bk6ID9w9qqLWKqmaw6gPSwhI+3a5wQYBZuJvupE=;
        b=jCbiiiRZujf0aw66N8Kanx2+W+IUbknnVlB+lZGXYxs/uUPYwz0YX7r9XaZ9jcf1cV
         ex7AHrUipCPAAVDzdNWTsHExM8fGIKJvh0bMSFDiRBIAEkLBJd2PzHb56mqAFuAeH4E9
         R2ki0Mog7pUUTbR8rA1m9SNliuh2XP5mCLYl/iqisC1KNYPd5zw979GQ3eQoZQvxp6NS
         bGoGt3PUPftqDmDlGK8UDuc4wY+D6RoeHw0Ywl0Bnbw6W4fumIvdfYOP4zR+Ys/iS9Ot
         um2zPCqcHC0oR/WePUCljgVVxRZo9hoZ4zWwZxYESL+F8NlThUJDXWhRPcvc+qkn0x7q
         oD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=CV85bk6ID9w9qqLWKqmaw6gPSwhI+3a5wQYBZuJvupE=;
        b=O4qKe67l+ohxe4kzQ/WW5lET4AMTuTGFGQAziL3bAadljCghkOOY4D9Mkt4lRaGfwI
         b5GPwYmvwZ1Uc/enho+uR3JmnYVbCqswxC6k8h7z9jpKc7QOnD80Rwe2RJoZg8mPrsBJ
         PsIrOBZcxmjAqANOxGMs82TzaxMYepr7UZU2AJ3uT9AaPotiXpQunvxu1TNHZPqKYUiL
         JyeiPOYWHsGT3zJMu+i++kJm6iz+WL/zWWfJE4yBIDI/W2VDgDbEY5SuhhaYAS7GbZ3o
         RPe+XEu2Kbw0ajr1yj61w0U6bD4D+JsKKWHLV05+BOs0tSX9e5do7yYEl/iMKQNedhmy
         EmSw==
X-Gm-Message-State: APjAAAUIlZSxbjJKi7x5QiD+2Et2L3Zdir0ULm3kMXrQSBtb8ULowNcX
        mW6qz/c4pyMaW9Ic5uJipLI=
X-Google-Smtp-Source: APXvYqzbcoMtiASfXswpi9fb+X7XP1QiFKWKz5ELS/FVcz/QDQIJxIWK6B3Mqi+uxV52KqBNy2MWaQ==
X-Received: by 2002:a1c:3204:: with SMTP id y4mr6641095wmy.166.1581614634384;
        Thu, 13 Feb 2020 09:23:54 -0800 (PST)
Received: from dumbo ([83.137.6.251])
        by smtp.gmail.com with ESMTPSA id z21sm3838941wml.5.2020.02.13.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:23:53 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:23:51 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200213172351.GA6747@dumbo>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  at some point between 5.2 and 5.3 my laptop started to refuse
hibernating and come back to a full functional state. It's fully 100%
reproducible, no oopses or any other damage to the state seems to happen.

It took me a while to follow the trail down to this commit. If I revert
it from v5.6-rc1, the hibernation is back as in the old times.


commit e6bc9de714972cac34daa1dc1567ee48a47a9342
Merge: b6c0d3577246 dc617f29dbe5
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Sep 18 17:35:20 2019 -0700

    Merge tag 'vfs-5.4-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux

    Pull swap access updates from Darrick Wong:
     "Prohibit writing to active swap files and swap partitions.

      There's no non-malicious use case for allowing userspace to scribble
      on storage that the kernel thinks it owns"

    * tag 'vfs-5.4-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux:
      vfs: don't allow writes to swap files
      mm: set S_SWAPFILE on blockdev swap devices


Is it possible to do anything?

Regards,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
