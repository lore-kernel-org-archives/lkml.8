Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7827C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E82F2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgFOJSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:18:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbgFOJSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:18:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DEC3ABE3;
        Mon, 15 Jun 2020 09:18:40 +0000 (UTC)
Date:   Mon, 15 Jun 2020 11:18:50 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Serge Hallyn <serge@hallyn.com>, ltp@lists.linux.it,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [LTP] 303cc571d1: ltp.setns01.fail
Message-ID: <20200615091850.GA3373@yuki.lan>
References: <20200615085836.GR12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615085836.GR12456@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x20000)
> setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x40000000)
> setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x20000000)
> setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor
> setns01     0  TINFO  :  setns(12, 0x4000000)
> setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22: errno=EBADF(9): Bad file descriptor

The messages here are a bit cryptic, I will fix that later on, but what
it means here is that the errno has changed from EINVAL to EBADF in a
case we pass file descriptor to a regular file to setns().

-- 
Cyril Hrubis
chrubis@suse.cz
