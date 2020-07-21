Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E173120717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgGUOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:55:15 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43891 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbgGUOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:55:15 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 932DF20646091;
        Tue, 21 Jul 2020 16:55:12 +0200 (CEST)
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
        Duncan <1i5t5.duncan@cox.net>,
        Anthony Ruhier <anthony.ruhier@gmail.com>,
        Vinicius <mphantomx@yahoo.com.br>,
        Thorsten Leemhuis <regressions@leemhuis.info>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [Regression] hangs caused by commit 3202fa62fb (slub: relocate
 freelist pointer to middle of object)
Message-ID: <15cbac6d-1f96-2ba9-cb54-08af6682f56d@molgen.mpg.de>
Date:   Tue, 21 Jul 2020 16:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kees, dear Andrew,


No idea, if you are aware of it yet, but three people verified that 
commit 3202fa62fb (slub: relocate freelist pointer to middle of object) 
causes a regression on AMD hardware [1].

It’d be great, if you took a look, and advised if this commit (and 
follow-ups) should be reverted, until the issue is analyzed.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=207383
      "[Regression] 5.7 amdgpu/polaris11 gpf: amdgpu_atomic_commit_tail"
