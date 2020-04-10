Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A291C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F97207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:50:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:25764 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDJRud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:50:33 -0400
IronPort-SDR: kFIH2GHpRVUL73pM1xZn27LfiopGgQw37h4wRw5Lgq0NfOow6Uk8gcMwFfYEPy9UKJjKxoRw4m
 ZvcATklV1McQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 10:50:33 -0700
IronPort-SDR: q5+ghInNYb2qr4jmUbRCOcsBHQwXwgF70HvFRePPvBftwSe+OIWlTTyk8PYiYTpBR93glK2pdm
 kvubUt0J3z1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; 
   d="scan'208";a="255539207"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2020 10:50:33 -0700
Date:   Fri, 10 Apr 2020 10:50:33 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     syzbot <syzbot+25a50e1a4e196faed650@syzkaller.appspotmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in gfn_to_pfn
Message-ID: <20200410175032.GE22482@linux.intel.com>
References: <000000000000046e4f05a2f24a4b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000046e4f05a2f24a4b@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 09:33:11AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f5e94d10 Merge tag 'drm-next-2020-04-08' of git://anongit...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1450c657e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=25a50e1a4e196faed650
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+25a50e1a4e196faed650@syzkaller.appspotmail.com

#syz dup: KASAN: slab-out-of-bounds Read in __kvm_gfn_to_hva_cache_init
