Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4E207CD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/B738tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgGEHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGEHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:12:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09689C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 00:12:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j18so35896583wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AJxPpTNSGM2Up6JwZGAkjjtxqNr3VNd84Ws4ki+ycY=;
        b=Y/B738tEGfbZSZNkjoWcgpYp+hm1Cc2+dGMTwdFy4XC/I6dblNNr9xxB1ya655Hdxh
         pWKb88VqqzaRZz9Cp+cPdpH3GFCAkHzhFxAiLEYjR/YOZGUTvTrzxgBqQxFsxdjPPPd4
         E/H668S1xWb1mtSNTEM2BFTDV7W+zrND/qwHhyKKimp8rAq9npuAcF6sForxpFwOHqDj
         tUvlwQL/4JB84CNpwIjg9Cnrs8vOguP7qljcUbogEWSeLHE4LL04iy+JbTcH387LL7Ht
         v9xGe46laYME9U21Oq7K1rh4ztZFkyDtMYx9AVNcPuzUl5ScUPr5pB9GK78o82W9QV4c
         eKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2AJxPpTNSGM2Up6JwZGAkjjtxqNr3VNd84Ws4ki+ycY=;
        b=d0rp1D37yd0m079dNtYyJfQPtHje+IiGNnBx62NbkyvJqLHmbm/haJmGpL+H+bSBog
         jiKgMzfrR5A16vkDKkebZ1gwrhor+S7v6XIMtOhdJHrmT9nREvSxXOcJ9zBXOT99MKhY
         eaIIJS9Ja7Y82nGxt4NGuNzTixreakqNqni5OvNAJ1m/7j8b+kUr8G1ws6fMZ4NG4yIT
         8Up2fEWdkNFpDLoeSaInpjemfC10IrGNivZxbb/1A3LLPuxmDDKM3JGOaATAbTV69PLL
         iosR5Okt4OO0zQVCieVC1Rd9RP35DXjZ4A+LopOMYNSc9x8YIGpf4aqI0ev2RR/UDJfU
         DVxg==
X-Gm-Message-State: AOAM531U7ICWDvMo/YziAjYJDy3NT59WtwMpMXe/liXaufO9Q1pp3ZI7
        KT20yqXggm0ooSVsAaDa+XbAox7HUoY=
X-Google-Smtp-Source: ABdhPJw8tmcGtA5y96e6zB4Wa3Kns4+iAalXv2HK5dCpASPbv0qCgIm2YNE2mYbhgChXRIB5z2IsTA==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr37053965wmf.38.1593933143425;
        Sun, 05 Jul 2020 00:12:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:adf2:29a0:7689:d40c? ([2001:b07:6468:f312:adf2:29a0:7689:d40c])
        by smtp.googlemail.com with ESMTPSA id 138sm13595331wmb.1.2020.07.05.00.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 00:12:22 -0700 (PDT)
Subject: Re: [GIT pull resend] x86/entry for v5.8
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
 <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
From:   Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; prefer-encrypt=mutual; keydata=
 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
 10oh++mb6s1dGf3ADAaOTRf8
Message-ID: <8fe756fb-7461-2583-b358-1a31a44d23fd@gnu.org>
Date:   Sun, 5 Jul 2020 09:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/20 00:05, Thomas Gleixner wrote:
>    - KVM
> 
>      KVM is inconsistent as well. Patches have been posted, but they have
>      not yet been commented on or picked up by the KVM folks.

Hi Thomas,

which patches are these?  I must have missed them, and I would like to
pick them up for either 5.8 or 5.9.

Thanks,

Paolo

