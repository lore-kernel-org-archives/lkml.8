Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E91207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="msuXnHFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgIGQvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbgIGQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:51:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40CEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:51:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so12683322wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MkAhet+wlF++7FXN/+TlBF4gd0vCDBXRks1SAOZwHBo=;
        b=msuXnHFD7qVdbxah+AfMpKoWioy4ntWc1e+qaUJe457XpG07QWuqkCUbHKklZiU7X/
         XfRHgmy8FjJuYRyoyO0PDVVqS8Sv7U9kkFMgFIuroa9UXAU1ylCab7e1eMHVkZpDQYuP
         U9R89KcpNBvN2Uin1XuUuE/s2Ez/+q8kECql5LrwzMOka2Y3lUJx7vPuICrkDQ1R2xyz
         fA+lmIl7+MtE19uhdyzFKhKIitVpQpg2c+SHjblJb0+Csrdr24StPy0kMWPz/gNzwAAT
         7QN4fCdDUgiaG9R6VxvcxhWZpVYVSM/T0V8iGwhz8mglr8v1SKLS5BdYO/p3voDif3Gb
         wNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MkAhet+wlF++7FXN/+TlBF4gd0vCDBXRks1SAOZwHBo=;
        b=cMPYFcEz86bjEazunymFThKFHi3LTAkZ3XP4QCwHe6QGCvj+pWrAR0G4wJsgeWrLvZ
         ss7dNjCny5l1OR+PlCrFF0u//buhDL8y1tlncYz9rOEkxEgTUj1tKtZ/MP25TH3QL79Z
         DUBpZllpR0zha8EEgU4t0wxzCirWJLG35Ktw+EfbOQsxjqGnHMUqto0yM6D/sXWJb5rF
         IlITRqFJo+E9VpllvZIxxdFEm1IiSSYN3LxhbkF9AzAL8ZvyMD3KvDgyYCJMz4zyYcIQ
         llKtCLuXUQlHsv09nCUWrogAKXR7G0to89nKGRaCgsaDzzu8UhuTdYjzNGQMmDF5wR64
         AIqA==
X-Gm-Message-State: AOAM531I0qBAGgK4AoBQBL7vRcph62j43t2LGoPJXxb5QcwODSukL56v
        9RoTSfWKqwv4ZC8/KVsn0nMeAw==
X-Google-Smtp-Source: ABdhPJwnhG+q4RURga4Peq9RwwUWPja6cnlXV5h0sMrqUKnxF3s+3ta2GRXU/c+paOwv5zDODpupZw==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr243417wmh.14.1599497481336;
        Mon, 07 Sep 2020 09:51:21 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id h6sm27190637wmb.22.2020.09.07.09.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:51:20 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] xfrm: Add compat layer
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20200826014949.644441-1-dima@arista.com>
 <20200907094314.GI20687@gauss3.secunet.de>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <2804926c-47cd-9756-065e-e17c517e31eb@arista.com>
Date:   Mon, 7 Sep 2020 17:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907094314.GI20687@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 10:43 AM, Steffen Klassert wrote:
> On Wed, Aug 26, 2020 at 02:49:43AM +0100, Dmitry Safonov wrote:
[..]
> 
> Thanks for the patches, looks good!
> 
> Please fix the issue reported from 'kernel test robot' and resend.

Thanks, will do!

-- 
          Dmitry
