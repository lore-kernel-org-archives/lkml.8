Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD90C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MDxfBjsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgCQCVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:21:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39065 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgCQCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:21:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so3042466pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Aw29rKhiyHiAlXKuyQpUyz4nr74tgMa0A4Duj63zpg=;
        b=MDxfBjsKnYvi1roYKYEfUOxXgEGjY9DsjT9RTRoUPn88gZ1CTsuSi9L7Pth6PDrqCQ
         sndzVLiGOV1tqpKziDGFlre72Jt20d1XPNLo/g3AQLdi00nALR374518SqMhNIMbRLdn
         J1dwl+0NN20lx34KJq02vDH12YIPOrt/JctnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/Aw29rKhiyHiAlXKuyQpUyz4nr74tgMa0A4Duj63zpg=;
        b=Q2p71lyK4dyWPzfoy+/esy0sGXHi0dVLDHjPeyPyIOUFjo0qJGerjQj/QXeRdJdDwf
         3oNsI717O8USCLvG4rqVgpQGP9o379G3svHlD35R5RfR67Jm+f0Kqt/LhO3aHv5J66nh
         /EwO66ZzpSpD0inQn4tmO1EWhzbv5Ja+R/m7Vby20KB1bgDfJgUqvL2xNbFPMulxxgwU
         WQH0GU4UI6bdlMHRGm2cYx5X5IUWoZBkpFTRJDUplWucQhA7fA0hDMx6qH1Ou8ohRKf4
         2NkP4j6/WGScGCc+Fz+JVTyzJazNO1BxCL5cXeJPH6OfNCCvDEAdfSoSmwRxEcJs2KWj
         85Iw==
X-Gm-Message-State: ANhLgQ3zQUrtv5fuKzqaIDkWOdIZDUnLhy/N3DLhADeCiVUktG2Mvg/c
        m+R4ndzZMhq3u3UWWpJYpdO6oyVJ4Mgbx2XzzDS/ooJj+pNoiM8MicgSsEHigjYiQ2C7OCnSMRr
        kWef7xR3rnZPbBQV4l2bcA7ntHl5LAYeiUYlw58JNjz0qlgZrHs0xyJ9Eg4IT9QwE3q6hufwFlv
        RrEKffoDLhQw==
X-Google-Smtp-Source: ADFU+vvfklSq4pUaovIfcAsYVabkb1QTUtvKpsq/uR5D817W2nGrHGTX01e+ZeIQr/ix/vd10v9gdg==
X-Received: by 2002:aa7:991c:: with SMTP id z28mr2708880pff.294.1584411673914;
        Mon, 16 Mar 2020 19:21:13 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id i11sm1069862pfd.202.2020.03.16.19.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 19:21:12 -0700 (PDT)
Subject: Re: [PATCH net 1/2] Revert "net: bcmgenet: use RGMII loopback for MAC
 reset"
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1584395096-41674-1-git-send-email-opendmb@gmail.com>
 <1584395096-41674-2-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXJvPrRcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoE4DB/9JySDRt/ArjeOHOwGA2sLR1DV6
 Mv6RuStiefNvJ14BRfMkt9EV/dBp9CsI+slwj9/ZlBotQXlAoGr4uivZvcnQ9dWDjTExXsRJ
 WcBwUlSUPYJc/kPWFnTxF8JFBNMIQSZSR2dBrDqRP0UWYJ5XaiTbVRpd8nka9BQu4QB8d/Bx
 VcEJEth3JF42LSF9DPZlyKUTHOj4l1iZ/Gy3AiP9jxN50qol9OT37adOJXGEbix8zxoCAn2W
 +grt1ickvUo95hYDxE6TSj4b8+b0N/XT5j3ds1wDd/B5ZzL9fgBjNCRzp8McBLM5tXIeTYu9
 mJ1F5OW89WvDTwUXtT19P1r+qRqKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <de2ef417-ddf0-516f-4b11-ce834764497c@broadcom.com>
Date:   Mon, 16 Mar 2020 19:21:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584395096-41674-2-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2020 2:44 PM, Doug Berger wrote:
> This reverts commit 3a55402c93877d291b0a612d25edb03d1b4b93ac.
> 
> This is not a good solution when connecting to an external switch
> that may not support the isolation of the TXC signal resulting in
> output driver contention on the pin.
> 
> A different solution is necessary.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Did you want this to be tagged with:

Fixes: 3a55402c9387 ("net: bcmgenet: use RGMII loopback for MAC reset")

so as to make it more explicit how the two commits relate to each other?

Thanks!
--
Florian
