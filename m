Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7B2065D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5GmWLsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgFNEH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNEH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 00:07:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C28C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KdZmbzKkPmpckL1U4hYFdBeoi6DJ0np+Y8xoq7vH/6U=; b=h5GmWLsQcvIt/aEFDPHoCu8ffg
        Frz3xLShxk9mFYQWuFp3Y6KEFZB4nQbRjX7B1rsJm89483x01gYTwVDhvZOEKHC0DaF0+KCQ7ne0U
        CW0bAUt1hDj7iy5MYLjaXrMmy3Mh+hmw3d0p5Eq8HYA1E6iWzY2U53wn2g8vctUeTMXLUj3K8yYOm
        5XIUMliuj8JGLsl7KZIkGnxsyfMTnsokk6TAtaM3ysqB1Jae5tDr/yj8Tp29eAWZEVt9U0QSUmxqL
        /+wcsePnLXmN8fZRVbiJ8SdhM9wi9z/+YHZldthUI+cRew592MnegtmtI54Fkb8RKvtDFMKZxUY4q
        YXXmqU7w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkJvZ-000403-3b; Sun, 14 Jun 2020 04:07:25 +0000
To:     LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr,
        Julia Lawall <julia.lawall@lip6.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: coccinelle issues
Message-ID: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
Date:   Sat, 13 Jun 2020 21:07:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, I've not used Coccinelle and now I am trying to use it.
It seems that I am having a few issues.
The primary one is when I run spatch (via 'make coccicheck' in
the kernel source tree), it tells me:

Python error: No module named coccilib.elems

I do see "elems.py" in /usr/local/lib64/coccinelle/python/coccilib.

I am using coccinelle-master downloaded from github on
Friday June 12, 2020.


I have also made the following notes while building/installing it.


Note1: The latest coccinelle tarball is not actually available
at the coccinelle home page although the kernel documentation says it is.

Note2: https://github.com/coccinelle/coccinelle/blob/master/install.txt
says that 'spatch' is a script, but it seems to be a binary executable
file.

Note3: https://github.com/coccinelle/coccinelle/blob/master/install.txt
probably should say to use 'sudo make install' instead of just
'make install', just like 'coccinelle.rst' file in the kernel tree says.


thanks for any help that you can provide.

-- 
~Randy

