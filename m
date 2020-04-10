Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8379C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD62C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJKOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:14:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgDJKOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:14:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55CB3AB5F;
        Fri, 10 Apr 2020 10:14:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FC56DA72D; Fri, 10 Apr 2020 12:14:06 +0200 (CEST)
Date:   Fri, 10 Apr 2020 12:14:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leonard Lausen <leonard@lausen.nl>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [btrfs] 8d47a0d8f7: fio.write_bw_MBps -28.6% regression
Message-ID: <20200410101406.GI5920@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leonard Lausen <leonard@lausen.nl>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190513031733.GI31424@shao2-debian>
 <d82835ec-c99c-bb40-be9f-f49f8101e921@linux.intel.com>
 <a52f10f7-cdf6-9b00-9e49-b1344c17a190@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a52f10f7-cdf6-9b00-9e49-b1344c17a190@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 02:44:55PM +0800, Qu Wenruo wrote:
> On 2020/4/10 下午2:34, Xing Zhengjun wrote:
> > Hi Wenruo,
> > 
> >    We test it in v5.6, the issue still exist, do you have time to take a
> > look at this? Thanks.
> 
> This is expected.
> 
> The extra check brings new overhead mostly equal to another CRC32 run.
> 
> We believe it's worthy, as our read time tree checker has exposed quite
> some bit flip corruption.

The test probably runs on a PMEM device so there's no slowdown from the
actual IO and the in-memory checks are measurable, though 28% is a lot,
I'd expect something like 5-10% at most.
