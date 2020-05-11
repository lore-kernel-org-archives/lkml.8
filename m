Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CF52075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgEKEGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:06:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:48024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgEKEGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:06:46 -0400
IronPort-SDR: 78flkJke5T4+9SrJCgyUbATRBoqF/vowHLOam1FbbwrT6ViNcY6xmUq6XpapBM9dpYJhZQgfuU
 ciD5gU2P4ysw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 21:06:46 -0700
IronPort-SDR: R1+LY30KTPMSOw3qDGYQEwMNTCGL+HNvL/01ZR5wLVUwTtX7DSFXL+Fn6YNhELVlGkVEd4tj6F
 XrKpDYJbtJpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="scan'208";a="306062857"
Received: from wxiao3-mobl.ccr.corp.intel.com (HELO [10.255.28.27]) ([10.255.28.27])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2020 21:06:41 -0700
Subject: Re: [LKP] Re: [pipe] f2af7d90e2: xfstests.btrfs.052.fail
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200511010957.GW5770@shao2-debian>
 <20200511011601.GV16070@bombadil.infradead.org>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <b6cb98f4-4265-b518-f692-d56d3fb1cad5@intel.com>
Date:   Mon, 11 May 2020 12:06:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200511011601.GV16070@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew

with a quick look into the dmesg
looks this commit broke the preparation of LKP tests

[   32.677588] install debs round two: dpkg -i --force-confdef 
--force-depends /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
[ 32.677593]-
[   32.697180] tar: ./control: Cannot write: Invalid argument
[ 32.697184]-
[   32.705025] tar: ./md5sums: Cannot write: Invalid argument
[ 32.705030]-
[   32.710034] tar: ./postinst: Cannot write: Invalid argument
[ 32.710039]-
[   32.743721] tar: ./prerm: Cannot write: Invalid argument

i tried apt command, it also failed with this commit
root@vm-snb-186 ~# apt update
Ign:1 http://linux-ftp.sh.intel.com/pub/mirrors/debian stretch InRelease
Get:2 http://linux-ftp.sh.intel.com/pub/mirrors/debian testing InRelease 
[116 kB]
Ign:2 http://linux-ftp.sh.intel.com/pub/mirrors/debian testing InRelease
Get:3 http://linux-ftp.sh.intel.com/pub/mirrors/debian unstable 
InRelease [146 kB]
Ign:3 http://linux-ftp.sh.intel.com/pub/mirrors/debian unstable InRelease
Get:4 http://linux-ftp.sh.intel.com/pub/mirrors/debian stretch Release 
[118 kB]
Err:4 http://linux-ftp.sh.intel.com/pub/mirrors/debian stretch Release
   Error writing to output file - write (22: Invalid argument)
Get:5 http://linux-ftp.sh.intel.com/pub/mirrors/debian testing Release 
[115 kB]
Err:5 http://linux-ftp.sh.intel.com/pub/mirrors/debian testing Release
   Error writing to output file - write (22: Invalid argument)
Get:6 http://linux-ftp.sh.intel.com/pub/mirrors/debian unstable Release 
[145 kB]
Get:7 http://linux-ftp.sh.intel.com/pub/mirrors/debian unstable 
Release.gpg [1601 B]
Err:7 http://linux-ftp.sh.intel.com/pub/mirrors/debian unstable Release.gpg
   Error writing to output file - write (22: Invalid argument)
Reading package lists... Done
E: The repository 'http://linux-ftp.sh.intel.com/pub/mirrors/debian 
stretch Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is 
therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user 
configuration details.
E: The repository 'http://linux-ftp.sh.intel.com/pub/mirrors/debian 
testing Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is 
therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user 
configuration details.
E: The repository 'http://linux-ftp.sh.intel.com/pub/mirrors/debian 
unstable Release' is not signed.
N: Updating from such a repository can't be done securely, and is 
therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user 
configuration details.

everything works well without f2af7d90e2 in our environment


Thanks


On 5/11/20 9:16 AM, Matthew Wilcox wrote:
> On Mon, May 11, 2020 at 09:09:57AM +0800, kernel test robot wrote:
>>      --- tests/btrfs/095.out	2020-04-09 10:45:28.000000000 +0800
>>      +++ /lkp/benchmarks/xfstests/results//btrfs/095.out.bad	2020-05-06 21:13:51.276485703 +0800
>>      @@ -1,35 +1,9 @@
>>       QA output created by 095
>>      -Blocks modified: [135 - 164]
>>      -Blocks modified: [768 - 792]
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
> This looks like a problem with the test setup.
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

