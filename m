Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147BC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B171224656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FGXmWU8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgBSV1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:27:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:27:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so2296927wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zgJNy1KN5aZ3jMvMKrXLxUkXUfdBKayzMP92yT7iHAE=;
        b=FGXmWU8bAD8kS9TpjALm6lTDIzKEM9meY5HeNSkKJPkzHzhg/k09WFkAsVEGRUyTBD
         J9UXjrhWBuyfw42dewC3J234eI7aSOqCqUAdKciYUisPy2wBTL6B6Yz/LbPzQQMMs2z7
         7OEBSxlj6X/ESkBO5VcghYzI9VU3ifW+GihV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zgJNy1KN5aZ3jMvMKrXLxUkXUfdBKayzMP92yT7iHAE=;
        b=pbrxKZvuESKYkXUqfyuIVySskUEoZ8aGNtbQx29gdq/3MK81LwlO74MRr+RBxix1UM
         DQRMMwBfumL5oi/mt366HNEqOM2DTdZZHxJMuIrs3NZ919qeD/ei0Lp79NL8zc/QIbwK
         icAqcTHg+mKJ70eIYEyhYATxY6aNxRnvcPkQU0bOWltIITf30lVwDfOnfJR9xeD3SA93
         NIvLfl9iPUZ31XDYriOa5Tq3vIPfVAUAec772+CxIjYuT8hqUQejlO0dPHlRLczRYU1H
         17FaAFT9jkUGequjpIlmYsWfpFFlCdu3ik49IkE0OZNinhDQDK/tyYrRLLnrAICLD8/e
         CqpA==
X-Gm-Message-State: APjAAAVz0d8WZ71gZ420w2jhWUnWfOWgSV+Fldjd5PE9ij0op2JDbQ07
        fqPa59/irTGPZE6G1J2NEOCg/g==
X-Google-Smtp-Source: APXvYqwePhEgOkvM/EIQNB+HOs5OjzPgzhV4uhXr5jSWIDSHJI7kwYeIriKLGeciYkhfL7O+/YNc2w==
X-Received: by 2002:adf:ea48:: with SMTP id j8mr40049378wrn.363.1582147665137;
        Wed, 19 Feb 2020 13:27:45 -0800 (PST)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id f1sm1356611wro.85.2020.02.19.13.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:27:44 -0800 (PST)
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
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <407d6295-6990-4ef6-7d36-e08a942607c8@broadcom.com>
Date:   Wed, 19 Feb 2020 22:27:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ff8a005c68e512cb3f338b7381853e6b3a3ab293.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2020 10:13 AM, Johannes Berg wrote:
> On Wed, 2020-02-19 at 14:41 +0530, Amol Grover wrote:
>>   
>> -	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_rtnl_is_held());
>> -
>> -	list_for_each_entry_rcu(pos, &rdev->sched_scan_req_list, list) {
>> +	list_for_each_entry_rcu(pos, &rdev->sched_scan_req_list, list,
>> +				lockdep_rtnl_is_held()) {
> 
> Huh, I didn't even know you _could_ do that :)

Me neither ;-). Above you are removing the WARN_ON_ONCE() entirely. 
Would it not be good to keep the WARN_ON_ONCE() with only the 
!rcu_read_lock_held() check.

Regards,
Arend
