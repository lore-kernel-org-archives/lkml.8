Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DAAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A6820842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="XjkRWk2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHETuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:50:20 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:29120 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgHEQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=2018; bh=tYTZlfDivesu
        wi6sEO939lAeryFUt15mP3CTKxRkvYg=; b=XjkRWk2CAyjuwIB2PasUeibrCqn0
        oZQGGZh2d1cOJFoXN9VtHHOsD44G2F5k+LIKoY84qeEpsKAaiXYb5IRzgwJcv8yE
        YBx9Ac9QFJELvZN9dapV+4Bz67Lyghsc8ov5yBMLeiu1i7GytxQk9P7/iChTf1Qd
        NCJOufApk/g1R5g=
Received: (qmail 62778 invoked from network); 5 Aug 2020 16:53:32 -0000
Received: by simscan 1.4.0 ppid: 62756, pid: 62775, t: 0.2959s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 5 Aug 2020 16:53:31 -0000
Date:   Wed, 5 Aug 2020 12:53:17 -0400
From:   Hgntkwis@vfemail.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: PROBLEM: IO lockup on reiserfs FS.
Message-ID: <20200805125317.10bf1d34@Phenom-II-x6.niklas.com>
In-Reply-To: <20200728223440.0fd8681e@Phenom-II-x6.niklas.com>
References: <20200728222041.5d88b2e1@Phenom-II-x6.niklas.com>
 <20200728223440.0fd8681e@Phenom-II-x6.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been over 1 week since I sent this into the reiserfs-devel mailing
list. I'm escalating this as the kernel docs recommend.
I'm still willing to help debug and test a fix for this problem.

"Given enough eyeballs, all bugs are shallow".
This bug is visible, could we please quash it?

Original message:
https://lkml.org/lkml/2020/7/28/1435
Filed bug:
https://bugzilla.kernel.org/show_bug.cgi?id=208719

Thanks,
David
