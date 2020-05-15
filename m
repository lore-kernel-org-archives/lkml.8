Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E3220657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsJj1e2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgEOHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgEOHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:34:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:34:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so589584pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WQFb4IJQ/4IoZHdxesfrZNvoUgDxuGz7bG3/JBTJetA=;
        b=rsJj1e2q3t2jwORxdG78LcT6xJZCtY/mIbAQgq6pnxoYwdVPWgmpOEnAKOe0P6lK/I
         d4iicScMe0ReXFld3E1/nNty4GU4K3Lqox4S5BjJqHzyuzc766S+bxNR1nIlUIWkacvb
         WNtsAkF45rOLxs59qe50lW1YszlEN980Efy0JUns6riVloZF/CpR4DG1Zc0g60SFFfhP
         Nuq15a0uILo7F26S7Yl1C4OAeUramBg2726LRQJHB+v8CEvPYVX3iXAv57hHoDkTnD71
         Wi4B7eNYJuLhgf2oUDFCuNbHa620Md8FQN7Emqv/pWlcXtrgiVlI2BSYCp44KzJ1/kLO
         Vgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WQFb4IJQ/4IoZHdxesfrZNvoUgDxuGz7bG3/JBTJetA=;
        b=I59w3qFQe5qSl3po0pD+VsWHbOq6sXn5yZdZoHE5a0Rjot31r8hzJO1LRzOS4D7K5e
         iec/vMBeIYx8w/O4qYnnVHeEb+Tjqjdfxxy6s512I8u1JdqNCrZ+s+Dw1mX274uX/qx0
         YKglyaD2t6eIVtIskzlF0iPe6MvsWZcLGokBVb9tyUM4FIciBcnfVH3pFi89UHjFYcRB
         YKl6+b6lIsF0abam6Ro6dRieLl5MIZYjDe9Niaj7cC3dqwM/C/V6CaiVPpOUld6BIYpq
         0XO4dBxw2y+eR6LHh/5S142S4l5eGVeyy2GSz4Q57tjGoEEAu+AqR4YE8sSu11CMqwal
         1dbg==
X-Gm-Message-State: AOAM5331b+hAli3EVIbrF8cj5f65pN3HdtuM7eTQrge2rnpV3RyTxn3m
        NvzKqleIif1NicVLlVgwwkVgfhHy2ys=
X-Google-Smtp-Source: ABdhPJy3eYPQrEimsfl4R6hgnQ1yTD2PP+uByYo4iQSSNxbBvQQzt3+AvPUsfo1S5dbxP/VlmPlx1Q==
X-Received: by 2002:a62:3006:: with SMTP id w6mr2543044pfw.29.1589528095930;
        Fri, 15 May 2020 00:34:55 -0700 (PDT)
Received: from [166.111.139.117] ([166.111.139.117])
        by smtp.gmail.com with ESMTPSA id y21sm1143149pfm.219.2020.05.15.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 00:34:54 -0700 (PDT)
Subject: Re: [Jfs-discussion] [fs] 05c5a0273b: netperf.Throughput_total_tps
 -71.8% regression
To:     Hillf Danton <hdanton@sina.com>, Rong Chen <rong.a.chen@intel.com>
Cc:     Christian Kujau <lists@nerdbynature.de>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de
References: <20200512030929.GA5770@shao2-debian>
 <alpine.DEB.2.22.395.2005132123020.14542@trent.utfs.org>
 <20200514154251.18184-1-hdanton@sina.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <096463bb-cef1-495b-5ef9-460f8f41fffb@gmail.com>
Date:   Fri, 15 May 2020 15:34:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200514154251.18184-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/14 23:42, Hillf Danton wrote:
> On Thu, 14 May 2020 13:12:18 +0800 Rong Chen wrote:
>> On 5/14/20 12:27 PM, Christian Kujau wrote:
>>> On Tue, 12 May 2020, kernel test robot wrote:
>>>> FYI, we noticed a -71.8% regression of netperf.Throughput_total_tps due to commit:
>>> As noted in this report, netperf is used to "measure various aspect of
>>> networking performance". Are we sure the bisect is correct? JFS is a
>>> filesystem and is not touching net/ in any way. So, having not attempted
>>> to reproduce this, maybe the JFS commit is a red herring?
>>>
>>> C.
>> Hi,
>>
>> The commit also causes -74.6% regression of will-it-scale.per_thread_ops:
>>
>> in testcase: will-it-scale
>> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
>> with following parameters:
>>
>> 	nr_task: 100%
>> 	mode: thread
>> 	test: unlink2
>> 	cpufreq_governor: performance
>> 	ucode: 0x21
>>
>> I'll send another report for this regression.
>>
>> Best Regards,
>> Rong Chen
> Hi
>
> Would it make sense in terms of making robot and fuzzer happy to replace
> spin lock with memory barrier, say the changes below?
>
> Hillf
>
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -416,6 +416,7 @@ tid_t txBegin(struct super_block *sb, in
>   	 * memset(tblk, 0, sizeof(struct tblock));
>   	 */
>   	tblk->next = tblk->last = tblk->xflag = tblk->flag = tblk->lsn = 0;
> +	smp_wmb(); /* match mb in txLazyCommit() */
>   
>   	tblk->sb = sb;
>   	++log->logtid;
> @@ -2683,10 +2684,16 @@ static void txLazyCommit(struct tblock *
>   {
>   	struct jfs_log *log;
>   
> -	while (((tblk->flag & tblkGC_READY) == 0) &&
> -	       ((tblk->flag & tblkGC_UNLOCKED) == 0)) {
> -		/* We must have gotten ahead of the user thread
> -		 */
> +	for (;;) {
> +		u16 flag = tblk->flag;
> +
> +		smp_rmb(); /* match mb in txBegin() */
> +		if (flag & tblkGC_READY)
> +			break;
> +		if (flag & tblkGC_UNLOCKED)
> +			break;
> +
> +		/* We must have gotten ahead of the user thread */
>   		jfs_info("jfs_lazycommit: tblk 0x%p not unlocked", tblk);
>   		yield();
>   	}
> @@ -2698,9 +2705,9 @@ static void txLazyCommit(struct tblock *
>   	log = (struct jfs_log *) JFS_SBI(tblk->sb)->log;
>   
>   	spin_lock_irq(&log->gclock);	// LOGGC_LOCK
> -
> +	smp_mb__after_spinlock();
>   	tblk->flag |= tblkGC_COMMITTED;
> -
> +	smp_wmb();
>   	if (tblk->flag & tblkGC_READY)
>   		log->gcrtc--;
>   
>

I think this patch is okay.
Thanks a lot, Hillf :)


Best wishes,
Jia-Ju Bai
