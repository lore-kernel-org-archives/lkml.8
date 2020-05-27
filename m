Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5386320787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma0FMBM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbgE0Nui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388516AbgE0Nuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:50:37 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE4C08C5C1;
        Wed, 27 May 2020 06:50:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so19142139otp.13;
        Wed, 27 May 2020 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c1yMGFc/Yll5Sz5MGXdvhG1FugIsGM9W+ytuc/q7G4Q=;
        b=ma0FMBM6TOulssZLJOKChFLjqdDRS/WTu2agPcAhvqBzUtQ3cMhQakybz4wdiDwYVr
         XvVV31eGWlqhGUZ0akT0oD28uzuZb4++ket+9Wu24g2pcLfKT/AU6tPC6IaFYYzo/wyN
         d2sODLhOedCRfoLcuBPzMSfV2Khq0GpkeJaFdE0tAwSSSwfH8D9wQpHBC9YgvXTRcq8g
         58WENqPRhCm1RoMPVNzR9+ooPgb/hXaaCm38lW+IIpmhD1Iv+9HrRSacHuktz9ZSOTHA
         GPgvvHJm+8ZgWfdcjR/iRn+C97Xus5VS5nHzJiMXeqqYpY+kyuykqFA3U8pMCWW/HRNQ
         FVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1yMGFc/Yll5Sz5MGXdvhG1FugIsGM9W+ytuc/q7G4Q=;
        b=K5nyRwey1DkpcStSJbq+GgrrIP5xZlv6/HW/Td2hcT3k+nTkVbERP+WfrToJo5QL5t
         cGlMPtR18dBiTdihTgjSQvP9k0OJXGw1t4hGexUoZDlfmJdnQ3OILEMBehl6yjUNQZMR
         Ucrb0pfZ6fYlpljf7J769JpmIMTUpIOnJgCKK5iSiOd8z8LeU96WZz5SZsEw5vjeWSeb
         lEj4GzL/UAzXAqBG/4pECi9uFIPqDpPbwvRSS6otmcwdmQxMKcuwZAMN3DPpQm72DTd7
         gBgTuhGJB/UdBnupjzKosZHUtHr2BPTmlnl6H9ek+/xxTRmNv6DiXOpshREx8lrzzY2i
         qeTA==
X-Gm-Message-State: AOAM530ij7kXDaJ14DY7RyF7MV5QXBSvsodqvomEoIVW2vt//uNcO6FJ
        5gePeHK28Mztljax1C21/0hpJf7Q
X-Google-Smtp-Source: ABdhPJyXfhc1ET4DwZfQZb1+KWAEECTnrOjE6+YNAs+r7ggG7n7CKsSqqBEx3Odtfn8LQ7TSio9TDA==
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr4652252otb.217.1590587437175;
        Wed, 27 May 2020 06:50:37 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:85b5:c99:767e:c12? ([2601:282:803:7700:85b5:c99:767e:c12])
        by smtp.googlemail.com with ESMTPSA id g10sm57046otn.34.2020.05.27.06.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:50:36 -0700 (PDT)
Subject: Re: [PATCH net-next] nexthop: Fix type of event_type in
 call_nexthop_notifiers
To:     Nathan Chancellor <natechancellor@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200527080019.3489332-1-natechancellor@gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <37961e7c-3f71-a095-f2c4-bd9e768fc05b@gmail.com>
Date:   Wed, 27 May 2020 07:50:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527080019.3489332-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/20 2:00 AM, Nathan Chancellor wrote:
> Clang warns:
> 
> net/ipv4/nexthop.c:841:30: warning: implicit conversion from enumeration
> type 'enum nexthop_event_type' to different enumeration type 'enum
> fib_event_type' [-Wenum-conversion]
>         call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh);
>         ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Use the right type for event_type so that clang does not warn.
> 
> Fixes: 8590ceedb701 ("nexthop: add support for notifiers")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1038
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  net/ipv4/nexthop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@gmail.com>
