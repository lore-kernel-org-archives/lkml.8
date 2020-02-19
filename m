Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A206AC3524E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776C724656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cYcZaClt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBSVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:33:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBSVdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:33:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2227883wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDc3+2LTXdeT4DFS6yiHXemjisG4SKrPsn7wcWKNyc0=;
        b=cYcZaCltkuSpbD/WoHJZ+CIv9gG+julOvJ1jka7rOBCY5GMl9cks8jtPmd4v6WArov
         1mHzdIUClTgGLHl2fqzIiUqoBc8skRZLZ8VCXOzUhSxYUtPRmmsLAY/U0BJ56qUcmUmH
         RCcTREkweJYOkTucwK/nzuiNGNow0+L6tS9qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDc3+2LTXdeT4DFS6yiHXemjisG4SKrPsn7wcWKNyc0=;
        b=XtXszZBJMzxkq0BKPcHsqvZBMwROCTr2Yk10lDwG2/qslQNJUs33LX4LCfDvus9U7b
         grVKJzGxyRTNmT6+E5xt2ApmP903n0Ez+McCW0BnjYK1AxDcqow7UM5nSyksTEzrPBR2
         DeXkvQGIq8SFg44018Kz4f/scXEFhTMg6t5kyzOHW7QGsYJ3UnyK40k/lrYr4+zdtl+4
         TNT7c0ivt6E2IN5Z8dBCoOqmu6vaW1cYnhZYYdo+edT1Z8zU6U/un/f8c9CdSXA5wHL/
         HnDxH3Wh9g5AkREEANtUscL4GcMUvYwfEAUVOusVsR0W0ZbEQ7FzrHeVl4ptlFpXEglR
         QQNg==
X-Gm-Message-State: APjAAAUOYK0dGKjM5Fpiy2z7ny7+f8tp5971wnxESYN2rtMyztbx7ER4
        3EGAgU+RHeE3d7nv2IdcMmQwjg==
X-Google-Smtp-Source: APXvYqxO0pamPxMf/8ILBFlAvOSGJ6ULjaU2B+PG28ryNIhHvKKg9F63tlUJbqWykPnAHbIThnz+8g==
X-Received: by 2002:adf:90e1:: with SMTP id i88mr39007634wri.95.1582148009688;
        Wed, 19 Feb 2020 13:33:29 -0800 (PST)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h13sm1626791wrw.54.2020.02.19.13.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:33:29 -0800 (PST)
Subject: Re: [PATCH] cfg80211: Pass lockdep expression to RCU lists
To:     Johannes Berg <johannes@sipsolutions.net>,
        Amol Grover <frextrite@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20200219091102.10709-1-frextrite@gmail.com>
 <ff8a005c68e512cb3f338b7381853e6b3a3ab293.camel@sipsolutions.net>
 <407d6295-6990-4ef6-7d36-e08a942607c8@broadcom.com>
 <855dec1f598d8b43400089cd0c5a7ac9b3533fc7.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <795b0dd6-23e7-8780-7cde-cf309f08109f@broadcom.com>
Date:   Wed, 19 Feb 2020 22:33:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <855dec1f598d8b43400089cd0c5a7ac9b3533fc7.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2020 10:29 PM, Johannes Berg wrote:
> On Wed, 2020-02-19 at 22:27 +0100, Arend Van Spriel wrote:
>> On 2/19/2020 10:13 AM, Johannes Berg wrote:
>>> On Wed, 2020-02-19 at 14:41 +0530, Amol Grover wrote:
>>>>    
>>>> -	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_rtnl_is_held());
>>>> -
>>>> -	list_for_each_entry_rcu(pos, &rdev->sched_scan_req_list, list) {
>>>> +	list_for_each_entry_rcu(pos, &rdev->sched_scan_req_list, list,
>>>> +				lockdep_rtnl_is_held()) {
>>>
>>> Huh, I didn't even know you _could_ do that :)
>>
>> Me neither ;-). Above you are removing the WARN_ON_ONCE() entirely.
>> Would it not be good to keep the WARN_ON_ONCE() with only the
>> !rcu_read_lock_held() check.
> 
> Not needed, the macro expansion will already contain
> rcu_read_lock_any_held() just like in all the other cases where you pass
> a lockdep condition to RCU helpers.

Ah, yes. I see it in __list_check_rcu().

Thanks,
Arend
