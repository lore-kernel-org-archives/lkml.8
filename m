Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DBC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82466207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Rhl6gyeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgIGQlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbgIGQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:41:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59EC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:41:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so16468986wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6HzmAVHlN6inWuhNR/qi7K/O/N8qBgMh/gLHImP3oLI=;
        b=Rhl6gyeocRUMRqArAntovDuFoSik3QlgtAtzFotLuXqcpSRMRkqtNsIv5Gcb9Fnw0e
         N/C/m4yQ5ky/du94q5SXnkioiql9UDJriC3NLtyFKxqOjpCS6j6HsXlJU+KoORAAK054
         5t4BCXfaclazE189avFgwVgxqYI0mokQOcsUErfyVofMTwu5z/kxWSugjP7H8Ic89MCN
         Yr2LriQYIN1sgWopbfmKeM1rhyMgk6hHOwOVM/TW8uCwOLJ9wPgV3wuJDZDTt3lcpt+n
         XqyjICws/7JQsA0tlT5s/wKwXFpkcMKeZETFvzg9ltUJnKqljlYh+9QbrE0QKEdgi9R0
         WHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6HzmAVHlN6inWuhNR/qi7K/O/N8qBgMh/gLHImP3oLI=;
        b=RMSZeg9KP0BtBZmDfL592Nqb7eebBnIgGAOH6JJzxkfJBQ9Qfvx4ivWOwhwH3hSJ3K
         XqGwESBu/cCYWe8p5oQOJ+/31/zm/q/SZ6jDGn9OTQgvb+q2KSnkAFDwxBoS4ldmLFeR
         1HiqA0ikJnNhNyE0S7P9sq+OEHm2l444I/tQ3EBD02H/2lgUXcyPj3ChTCnc0RBWn+U4
         6nd0UjWCdAjIxmYdTNkNRvZj8haf+avfgy0zPhwlNGh+YXjRBOLbQC3jxKlci1bEuao2
         18nZL0zCa61qO0pKeVBa8aUq5TSNCWhj04irzDBXrFLG2w6wYOjtJMbRigeNxHbBHr3r
         G/3w==
X-Gm-Message-State: AOAM531RjBQXi0FQGwDaO9D38vy6dIY9/BgAfGDHpcE1e8nrORAE1VHr
        HK3xc9h6pEKP16OrkGpLhBRMlw==
X-Google-Smtp-Source: ABdhPJwwFuqsNpeKNr2Xcj0G7bwyHTIOXQSxqV9C4cdGzfqKQXz/HEY2/yNVuuYEC8tByhO7f/FTTA==
X-Received: by 2002:adf:f082:: with SMTP id n2mr16879077wro.35.1599496861873;
        Mon, 07 Sep 2020 09:41:01 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i1sm34957035wrc.49.2020.09.07.09.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:41:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] netlink/compat: Append NLMSG_DONE/extack to
 frag_list
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netdev@vger.kernel.org
References: <20200826014949.644441-1-dima@arista.com>
 <20200826014949.644441-4-dima@arista.com>
 <f579efc1375e46d9c2ff999ada1bcfed40ec2a8f.camel@sipsolutions.net>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <ff2e3bfb-f97b-6982-05d8-5448193225ab@arista.com>
Date:   Mon, 7 Sep 2020 17:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f579efc1375e46d9c2ff999ada1bcfed40ec2a8f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 8:19 AM, Johannes Berg wrote:
> On Wed, 2020-08-26 at 02:49 +0100, Dmitry Safonov wrote:
[..]
>> +	nl_dump_check_consistent(cb, nlh);
>> +	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno,
>> +			sizeof(nlk->dump_done_errno));
> 
> nit: indentation here looks odd.
> 
> Other than that, looks reasonable to me.
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thank you for the review!

-- 
          Dmitry
