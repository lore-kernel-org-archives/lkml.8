Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D075AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8BA20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgBKOUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:20:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57047 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgBKOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:20:40 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01BEIxQr052722;
        Tue, 11 Feb 2020 23:18:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Tue, 11 Feb 2020 23:18:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 01BEIxhe052716
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Feb 2020 23:18:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
 <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <51306985-90ac-6e6b-d085-4e076698c48c@i-love.sakura.ne.jp>
Date:   Tue, 11 Feb 2020 23:18:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/10 16:27, Wang, Wei W wrote:
>> Well, my comment is rather: "Do not try to reserve guest's memory. In other
>> words, do not try to maintain balloons on the guest side. Since host would
>> be able to cache file data on the host's cache, guests would be able to
>> quickly fetch file data from host's cache via normal I/O requests." ;-)
> 
> Didn't this one. The discussion was about guest pagecache pages v.s. guest balloon pages.
> Why is host's pagecache here?

I'm expecting a mode: "Guests should try to minimize pagecache pages (and teach
host to treat reclaimed pages as if POSIX_FADV_DONTNEED) instead of managing
guest balloon pages". In other words, as if

  while :; sleep 5; echo 1 > /proc/sys/vm/drop_caches; done

is running in the guest's kernel. And as if

  echo 2 > /proc/sys/vm/drop_caches

is triggered in the guest's kernel when host requested guests to reclaim
memory. No long-life balloons. Guest balloons do not need to care about
NUMA. Just leave the management of pagecache pages to the host.

