Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CAC206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="XZrT7p9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgFHKKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgFHKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:10:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D176C08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 03:10:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so427308edm.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FIHN9MZcZVs89vJj6qS2FPe1wOlI+KP3JEjnXkjgUIo=;
        b=XZrT7p9hpwoQ1asrimWl4mEcrJFng4P/wINbcREbRIl9S0zPQr2ZqILftR75qdvKul
         A40C4WgHf03Pxuk6un+J4HvV+TYa2ndpPV1wDxS+La6ce+buLRXoQ22CpPqdKHTIl10W
         4g/2/0TPeoFpd+KaY2US54Yjx/YEwBkkdhub9G0XgoYW4OEIuXto41aqvb9neBiSBxqQ
         Zk31fn1/vpMbPK1hs1ATveRuxmDFrSOG5/a1HsScmvLOsBl/hh4DBjccpL2hkaRHAKTn
         PtbZ1v/O27+BmScm0wc/yXctHx7lh9g+9RZqAzlC/VK2PyFcxDfNC2QzHR9aCZqLoRgE
         WPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FIHN9MZcZVs89vJj6qS2FPe1wOlI+KP3JEjnXkjgUIo=;
        b=YQZokMXVa4+6/3fAupsuqR2ssXG1HEFIal1QWAXpbyqBXppj/BoL7rxOBBMkS2m7cd
         jgruD2elE8flk21ya3Z3wPL/VRgCxsS4+gNryL/tPZvgwyuWY5jiw/gwTAw0jVUt8iAM
         WP5KwrZNVUXnSgtfA5f22HVM9OXw5OAF0iagRp0efwCed8WTtkKijqLFCOSxQ94kym8I
         wIaSfhMjxY28g51h7ratfX/GR35ZLSf/zl62TzO7DOQEwzeip9pkterWufITYrNRgoYU
         bXNpUx+sFEWzLdkzL6rmdFcBBEg0ZikNJ8CcotF9/42V331gEDHRrG6YyxK4ajVgLTJa
         k/qg==
X-Gm-Message-State: AOAM531+RAVavEcfkT6/+ByarT+tC3e58RGjsXsRbG9H13BHH6Fiqhnp
        lSgCHx5gMZmBOov+TqB7/cV6894fevk=
X-Google-Smtp-Source: ABdhPJw0ngwli2qw4dkn4AewiyqmubBF/LRY4YnInqYpXOmLTtSzPm7V16Dxo0irGyb8jE8v5df7RA==
X-Received: by 2002:aa7:df96:: with SMTP id b22mr21646067edy.348.1591611025407;
        Mon, 08 Jun 2020 03:10:25 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id p15sm10371360ejm.88.2020.06.08.03.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:10:24 -0700 (PDT)
Subject: Re: [PATCH] mptcp: bugfix for RM_ADDR option parsing
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
References: <904e4ae90b94d679d9877d3c48bd277cb9b39f5f.1591601587.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <41246875-febc-e88d-304b-2a6692f590ac@tessares.net>
Date:   Mon, 8 Jun 2020 12:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <904e4ae90b94d679d9877d3c48bd277cb9b39f5f.1591601587.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 08/06/2020 09:48, Geliang Tang wrote:
> In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
> "Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:
> 
>    +-------+-------+---------------+
>    |Subtype|(resvd)|   Address ID  |
>    +-------+-------+---------------+
>    |               |
>   ptr            ptr+1
> 
> We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This patch
> will fix this bug.

Thank you for the patch, good catch!
Indeed "ptr" should be incremented.

Because this is a bug-fix for net, may you clearly indicate that in the 
subject to help -net maintainers please? [PATCH net v2]

Also, may you add a "Fixes" tag as well as it is for -net ? I guess it 
should be:

     Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")

The rest is good!

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
