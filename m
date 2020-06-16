Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1512C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF218207C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="u5uL0qfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgFPPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbgFPPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:19:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35EC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:18:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so21894421ejm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mCkOJwzBNQ/VPMuFm+rDhNT8WeNpDSPTUtIsQg/BHiI=;
        b=u5uL0qfz6FtKzKlMGOoJgIbLc/ZPbxodziUhBy46UmHYtjcCFCN/Q0ORlHdQ0UsnEc
         y56u/papPNrl9lbqGlnzb9g6Z4oQ6rvI8TNZor2VKQTfTX4RvLer1yNq6PgTOEY2tgvh
         3xG5Z06nbnzPsAlFo1yQWIlHsynQSae3BPsGJi3ZAqx7OlSonFzNvSNFIvrZRI9MFirq
         FmXMKvkSabtNN0dZstklPtOPjKNZ07kKAk/idu3UhIJRvz33tqNC/M0OBOyDsnxrEl1Y
         js6WT2qetmnyBPFaJLH0hZQJzp0b2UnxXkPXK3jvm1xgHTHXQaMEPBjbWC1wWxmfMff9
         yGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCkOJwzBNQ/VPMuFm+rDhNT8WeNpDSPTUtIsQg/BHiI=;
        b=o5IHJRx2WEdwCZes+9e3Y3jjooeWz4mnm9uE8k99FpClBPnqIC+LFhsjENieI9W6an
         mjPoKEX2Qlx8PGkChDReMtycMiFyCtJSEtuBawKtLJsrEwDmcHUtyA4hyCVior6Uwv5O
         PRn5NNR0ctB0w57usSo9BwKAngH0s8oFKfmBc47SAoZ6fsOYp10Vo445urpMtlYtnDkG
         fhK0sn47WXJCINlL1ebMDLoKy9uCyIYvkDuBxmrvhs2yWvGiYBDsREdeOUc7doS4H1eJ
         0W9jc1BIC8Ed+NR4WkSndKM/Duj1oQ56hDvzZOS6TTg+dNzA2c/1fc451hSMlFtc3uV4
         wjXQ==
X-Gm-Message-State: AOAM532mqs91WbBOJvYKms9FhaGaWBmnF30NlWd35fNfmgntVOLjstpK
        q/GNs6tKbITcVp/PHiGeQoLhN4GjzjU=
X-Google-Smtp-Source: ABdhPJw67sa5PWc8KBuHlwTeUyw9rWGN7u+Mqkl1KZ1SbZ0c0JI05j9hg37mtlspROJB3qDazYt/pQ==
X-Received: by 2002:a17:906:5410:: with SMTP id q16mr3381448ejo.103.1592320737997;
        Tue, 16 Jun 2020 08:18:57 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id p6sm11330395ejb.71.2020.06.16.08.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 08:18:57 -0700 (PDT)
Subject: Re: [PATCH net-next 0/3] add MP_PRIO, MP_FAIL and MP_FASTCLOSE
 suboptions handling
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <cover.1592289629.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <04ae76d9-231a-de8e-ad33-1e4e80bb314c@tessares.net>
Date:   Tue, 16 Jun 2020 17:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1592289629.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang

On 16/06/2020 08:47, Geliang Tang wrote:
> Add handling for sending and receiving the MP_PRIO, MP_FAIL, and
> MP_FASTCLOSE suboptions.

Thank you for the patches!

Unfortunately, I don't think it would be wise to accept them now: for 
the moment, these suboptions are ignored at the reception. If we accept 
them and change some variables like you did, we would need to make sure 
the kernel is still acting correctly. In other words, we would need tests:
* For MP_PRIO, there are still quite some works to do regarding the 
scheduling of the packets between the different MPTCP subflows to do 
before supporting this.
* For MP_FAIL, we should forward the info to the path manager.
* For MP_FASTCLOSE, we should close connections and ACK this.

Also, net-next is closed for the moment: 
http://vger.kernel.org/~davem/net-next.html

I would suggest you to discuss about that on MPTCP mailing list. We also 
have meetings every Thursday. New devs are always welcome to contribute 
to new features and bug-fixes!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
