Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33540C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032A8207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Xa/mOAvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgERPJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:09:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9BAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:09:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e18so10905721iog.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EoQJxytLsFGCAk3q/7V3Tuf1AW7qKilLYTk5aTLBhcg=;
        b=Xa/mOAvgktEy/edGsiwSknxENTMVnXDZnct8VSHmceVRhW0R+Uu4bbW6j1RucOQwTw
         c/OpVz97Nj5FT8T4Fk2k95gvWEPKRI4PZWst9KGzXmGi2EZjltxsxdne4mW/2I9oQ2hm
         dlzeoMxfi43TLHHihkOEqmFRA4fAoI2pLxfIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoQJxytLsFGCAk3q/7V3Tuf1AW7qKilLYTk5aTLBhcg=;
        b=imUBzuTRP9KQdZlsbOadb73M35v/LBNXt7v6N46rVrySYKmuGOMoHjt1YN+OyozuB4
         uWoIVhx5mcslVHM02zXtKzCfAI79rlMiCivHDbXrWL1V8udo/PxClI2M0my4y/OAH4pK
         mJf19tMSDMG0hacsHvqWd0MRDNmblp+JWRdZprX5B1YwRnLd+U//BcS4rosUGqA2IRWy
         0HIQ2meGOSxWNGugW1m0Zm5Acybr6MC6tKgR4K+6bspl9RojedEHvQ++xxJfABdixYVe
         iBTdE0nrnnnIGe2bN3z3QD8XVbBfAjljxI+vRdV1WdDwHbPeJt9ckKTGVqE1Yn9Lt9YU
         AMbQ==
X-Gm-Message-State: AOAM533f4ds1mHKLSLAbOc4WjogOykD6acYW9jo1bXoli7dycYxylfnX
        I7fR7Avf27D3FGY+pmsdWgdeAA==
X-Google-Smtp-Source: ABdhPJzxtGE0kyWovKLjj1ZjkpU1Orj0dBN9J7mwhxZPjRoKmSdxPx9HQCZbv39NxP5h40g/AsFqEA==
X-Received: by 2002:a6b:e911:: with SMTP id u17mr14732527iof.29.1589814561599;
        Mon, 18 May 2020 08:09:21 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w88sm4871104ilk.83.2020.05.18.08.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 08:09:20 -0700 (PDT)
Subject: Re: [PATCH] drivers: ipa: fix typos for ipa_smp2p structure doc
To:     David Miller <davem@davemloft.net>, wenhu.wang@vivo.com
Cc:     elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
References: <20200514110222.3402-1-wenhu.wang@vivo.com>
 <20200514.130717.1848307407646007455.davem@davemloft.net>
From:   Alex Elder <elder@ieee.org>
Message-ID: <15c868b1-f74a-3267-1e67-702af1938152@ieee.org>
Date:   Mon, 18 May 2020 10:09:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514.130717.1848307407646007455.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 3:07 PM, David Miller wrote:
> From: Wang Wenhu <wenhu.wang@vivo.com>
> Date: Thu, 14 May 2020 04:02:22 -0700
> 
>> Remove the duplicate "mutex", and change "Motex" to "Mutex". Also I
>> recommend it's easier for understanding to make the "ready-interrupt"
>> a bundle for it is a parallel description as "shutdown" which is appended
>> after the slash.
>>
>> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
>> Cc: Alex Elder <elder@kernel.org>
> 
> Applied, thanks.

Thank you.	-Alex

