Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B09F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIKPlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:41:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIKPgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD21AAC2B;
        Fri, 11 Sep 2020 15:36:45 +0000 (UTC)
Date:   Fri, 11 Sep 2020 17:36:59 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH] syscalls/ptrace10: Add new regression test
Message-ID: <20200911153659.GA7234@yuki.lan>
References: <20200904180030.14838-1-chrubis@suse.cz>
 <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> the code looks good, though it might make sense to simply integrate the
> check into ptrace08. Just 6 extra lines in the existing test should
> achieve the same coverage.

I would like to avoid triggering the "your system may be vunerable"
messages on fixed kernel, hence the separate test.

-- 
Cyril Hrubis
chrubis@suse.cz
