Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_40,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3408EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21382082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="ovlAKkHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2QoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2QoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:44:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B62C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:44:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so3172732pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=iw9YBEqn6SiuMz3RoRL2TK68UdSA9OieFntlL99NIlQ=;
        b=ovlAKkHof3Umse9Y2jHw4bx+CyxnINV7PMCEbHpAZQKDf06U2zIe9yMW+svaK90Mau
         HCUzs1GlSiZZex1Mhud6Q5FyDbfW5Ws+HbIfXrWzs/4trxrGyrWO3/fxxN40ELXpK+j8
         OxUSvWso8BziQ3SDWZ0EuOSCUgwAaNq6mfwcAT9HPfCE6Qy3MHcXjCmj1elMvgGYGYT1
         o08mpqi8lgUzDg1hhJ/F2hD7Lexl14HQuKUwiSSA4mBGM/51dmN6WLTrEdpxEEWi/nTW
         IF3dQvs2fUfzTPjTlSXDcENMHF4coL5jSDnWPRHhkQtvzC4tfqMF4OOXou7Gjg2YxdlD
         YHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=iw9YBEqn6SiuMz3RoRL2TK68UdSA9OieFntlL99NIlQ=;
        b=HhrQhBv/MjyIPSq4Ff1haNJnkBUW24L6ZDPKOOth1a99a5vbgxgaKjYwnMp0aGf/4g
         ml03IkW203+cxK10kODI8DVjOAPn8F6Di0O1xBknwc+yqcLAgfc446biguqcEd4b7Uyt
         UuyXFUGYOGD30D9yu/qa81Nkd5Eg5YY4apk9IXXUXeTDVAC/1DC++ZJ9Acmf8V6sLRgK
         QVIx5oFYgT+7EZsdhB++lJA0OPEDnXxBfJ7uMZUiHP5FOWw/PjYV98Nk6Ng8dBKC1OHy
         D1SxFAnQVc9sHr6iniWo5NWFRXA1j4FWqhZyGRwfEP9eBD1J8WEs9B8dn1w0jFOteK9V
         pQ6A==
X-Gm-Message-State: AOAM530mqKJoRRRUP8bX8sdVC7y1uLuk6LOaaxDtFnWDHkHkYcriW82A
        VQgswHkozu5JESQwrRkYMFruyBKp5SQ=
X-Google-Smtp-Source: ABdhPJwN+UdZMIw6vMEnILNn60MfPEb+v3CHCZvPkmTki/5KAKZj08tqgp7NKMNMkNAtCT7bHtSz/Q==
X-Received: by 2002:a63:225d:: with SMTP id t29mr24492437pgm.374.1596041040091;
        Wed, 29 Jul 2020 09:44:00 -0700 (PDT)
Received: from [192.168.0.3] ([103.16.71.223])
        by smtp.gmail.com with ESMTPSA id b82sm3040051pfb.215.2020.07.29.09.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 09:43:59 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Meggan Berg <megganb@dynamicaims.com>
Message-ID: <1272faca-4495-06ff-df4a-233980a7d51b@dynamicaims.com>
Date:   Wed, 29 Jul 2020 11:34:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Meggan Berg
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".

