Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F06C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E34A2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgHDINW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:13:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDINV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:13:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2114FB64A;
        Tue,  4 Aug 2020 08:13:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Aug 2020 10:13:19 +0200
From:   osalvador@suse.de
To:     Qian Cai <cai@lca.pw>
Cc:     =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
         =?UTF-8?Q?=E4=B9=9F=29?= <naoya.horiguchi@nec.com>,
        nao.horiguchi@gmail.com, linux-mm@kvack.org, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
In-Reply-To: <20200804014942.GC8894@lca.pw>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803190709.GB8894@lca.pw>
 <20200804011644.GA25028@hori.linux.bs1.fc.nec.co.jp>
 <20200804014942.GC8894@lca.pw>
User-Agent: Roundcube Webmail
Message-ID: <3349ee83873c944a4276e4547e78ab1e@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-04 03:49, Qian Cai wrote:
> 
> Well, each iteration will mmap/munmap, so there should be no leaking.
> 
> https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L376
> 
> It also seem to me madvise(MADV_SOFT_OFFLINE) does start to fragment 
> memory
> somehow, because after this "madvise: Cannot allocate memory" happened, 
> I
> immediately checked /proc/meminfo and then found no hugepage usage at 
> all.

Unfortunately I will be off for a week, but out of curiosity, could you 
try out with below tree [1] and see if you still see those issues?

Thanks for your time

[1] https://github.com/leberus/linux-mm-1/tree/hwpoison



