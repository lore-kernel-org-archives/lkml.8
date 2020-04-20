Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00106C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD0D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au9flB9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDTVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDTVpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:45:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C571C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:45:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so1255895wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DH/8qrQqICPhylua4dJvzTY//5gwLzJ9ngYcGc5lZXI=;
        b=au9flB9sDH6gPHLIqRjrd3Fhx9O04xkm+qegaL7IW8telkMlURr5i4G8XPRFfv6Hdy
         rCRI7HBR7eoblUdKotUJN5waVnzQ1U8DPwG1M9UFLAYz6LRAA2lw2JSuGg+cOwNqmk0/
         9ngwcv1eIA0S8fa74FwhviXGQ9AqpATpvwj+VO/qj7qL9m9tePKZvixnvqHSqPLOwkSO
         /jE4B+T8XTGf1PQ4F5Dgs3CDfki8PC5XjOeHrlvr8fQZr09RTXZEe4O8wQ/ReqEjA7uM
         w8QTkjVYVyi7yuUc4OwPn5+JbeXvvVCCY4qBEtVPP3PiZZ43Estcw0uXajbHtaBDIUqT
         CJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DH/8qrQqICPhylua4dJvzTY//5gwLzJ9ngYcGc5lZXI=;
        b=D3LxIl05GZHdthsRNlTFiYCuApTEbWm57HmKNAOcHuxtMQnsLMYQ4ylHWvwZauotX4
         VbeuxZrz9gQSjSgSSj/gXs8+JT5X8Um6E/UpUVTzbtZkVv7GIMiYpwOoAFUfkZ0976zV
         K71KomzcFPcCJlhzT6jcoGtMB9YxL7KMe3x31MolVEAsSGSkhaIT71ky3a/ep/ahMzOu
         q2HSyjk1+n/OMGOl+pnslwHGAve8Q67sOqxRp25PWRPvnjyyRBXN6GLB1GjrobS+UaYj
         NJqpgXFjicsSyh5iVn52TfL6JvahmOkzojXC+B25rhFy/01d+Jio+9Bz7czUBlPrKsox
         r/+g==
X-Gm-Message-State: AGi0PuYpd5d1f2GCes8MBtN6ivgmO1+yBoRtFRNqN5X/SdJ4w7ctIu9o
        UwxBUIMo8keqIUARvrt99lo=
X-Google-Smtp-Source: APiQypKcxK+P0VpnOp/GwpDAOCgvl4rB3KqEt3+JSZAP4pkWCxPhwKeKiY27iqhLNngO5xdYRIGuQw==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr1458802wmf.187.1587419118919;
        Mon, 20 Apr 2020 14:45:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k14sm1001096wrp.53.2020.04.20.14.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 14:45:18 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:45:17 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4/4] mm/swapfile.c: move new_cluster to check
 free_clusters directly
Message-ID: <20200420214517.vnyc7mzxpyjhqr7b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
 <20200419013921.14390-4-richard.weiyang@gmail.com>
 <87blnnszl4.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blnnszl4.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:41:43AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> Each time it needs jump to new_cluster, it is sure current
>> percpu_cluster is null.
>>
>> Move the new_cluster to check free_clusters directly.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/swapfile.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 07b0bc095411..78e92ff14c79 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -603,9 +603,9 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>  	struct swap_cluster_info *ci;
>>  	unsigned long tmp, max;
>>  
>> -new_cluster:
>>  	cluster = this_cpu_ptr(si->percpu_cluster);
>>  	if (cluster_is_null(&cluster->index)) {
>> +new_cluster:
>>  		if (!cluster_list_empty(&si->free_clusters)) {
>>  			cluster->index = si->free_clusters.head;
>>  			cluster->next = cluster_next(&cluster->index) *
>
>In swap_do_scheduled_discard(), we will unlock si->lock, so the
>percpu_cluster may be changed after we releasing the lock.  Or the
>current thread may be moved to a different CPU.

Thanks, you are right.

>
>Best Regards,
>Huang, Ying

-- 
Wei Yang
Help you, Help me
