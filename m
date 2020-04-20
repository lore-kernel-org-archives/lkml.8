Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5228C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06C820722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tS5kOR3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDTVhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDTVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:37:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:37:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so8627819wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4Bn1MKtUzPQNpJZJxjnYoMLdILkHx07ckmoRRYi+ms=;
        b=tS5kOR3qoRdmcADQh2JwfruP6cP7oYTN2pWbVQvnFxntw/YVLrXxpPVGiN63ZezMIS
         plBnDsbuZJNqmm3OT8EQyL45pKUg2NTa1H4hINr0pKz53vePltPUwxaiRPhY4qHIA1bU
         9JtGc/mJcSVNRN87ewx9FNh3VOS+iam+Hd/35UsRfe6xknjSwTcwqHwRP/5Lgq8YptIO
         LHZSCeSKM+tkyVP+vzJjyyLKFxOILE5BKTAFS5RySgqNs0tBBPcACIkLEJv63g2J7mVI
         UDCSDwGEdzCgOl4DJw6nvEArO1f35IxL4Y5qPPdf46F+gcoXUXjlVNdquYHEDoegc0qw
         wEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4Bn1MKtUzPQNpJZJxjnYoMLdILkHx07ckmoRRYi+ms=;
        b=co2hTYuXhe8NCI4MyrobKcxXd862N+1Fv1N9/XwY3bXORHlactX5IbxgdwtzGC0Pav
         I+kyHmzMIEDTLQRFLN78qCz0KJ9hhQf4IXkblrA2NIE13c4Ghn72Gk1J1cPrBuNLnrBe
         SkAMClEVoDc0T6MoQUXZk7fZLPK7pfxf5n2qMIqOxpLP3QQ0w7ocpQU3RB6dUOuGU6cI
         iYwrRFsydVOEiYccRjw6TLnsUjrTVNDp9dmroAITNG/UGkkIXYgFYmyo99GggWK8Pym3
         lEQhZ8YccF5vuswKxBK8IcuD6HCg0EFV3B/dvzPDYdetgrBS2/O15gZ06e2w+atrTbsU
         zYwQ==
X-Gm-Message-State: AGi0PuZKJQWghCEFUFD6ArjYKjZ7lpp0OvV3REQRWeHtfL7t5Fakj3+P
        f/RlOGP2lbQZll/aRugL76k=
X-Google-Smtp-Source: APiQypLKQe0tdxzMNB/vMLEy2jql+PPVAPjM0a7sQ7uIMk/qr+dKAYtIAx/FYpr5da1PzWMg1Gmx2A==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr5595480wru.417.1587418648160;
        Mon, 20 Apr 2020 14:37:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a7sm857114wmj.12.2020.04.20.14.37.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 14:37:27 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:37:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 3/4] mm/swapfile.c: compare tmp and max after trying to
 iterate on swap_map
Message-ID: <20200420213726.juehv5yr5kyhlbxv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
 <20200419013921.14390-3-richard.weiyang@gmail.com>
 <87ftczt1cg.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftczt1cg.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:03:43AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> There are two duplicate code to handle the case when there is no
>> available swap entry. Just let the code go through and do the check at
>> second place.
>>
>> No functional change is expected.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/swapfile.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 3aae700f9931..07b0bc095411 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -629,10 +629,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>  	tmp = cluster->next;
>>  	max = min_t(unsigned long, si->max,
>>  		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
>> -	if (tmp >= max) {
>> -		cluster_set_null(&cluster->index);
>> -		goto new_cluster;
>> -	}
>
>The code is to avoid to acquire the cluster lock unnecessarily.  So I think
>we should keep this.
>

If you really want to avoid the lock, my suggestion is to add:

  if (tmp < max) {
      ci = lock_cluster(si, tmp);
          while (tmp < max) {
	  ...
	  }
      unlock_cluster(ci);
  }

Instead of do the similar thing twice.

>Best Regards,
>Huang, Ying
>
>>  	ci = lock_cluster(si, tmp);
>>  	while (tmp < max) {
>>  		if (!si->swap_map[tmp])

-- 
Wei Yang
Help you, Help me
