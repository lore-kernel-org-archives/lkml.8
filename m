Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D96AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB02076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJhG8orP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgFVQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgFVQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:09:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD6C061573;
        Mon, 22 Jun 2020 09:09:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so4140978qko.7;
        Mon, 22 Jun 2020 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XMziTAReggV8cPAuUjcDsW9X5b6xE1JpK9TNborUBOU=;
        b=MJhG8orPav1AYK2ETOPNu4cBBY4tMHZVI/mufHGSHxANJrEwJoAsNA/0nDzK50VJ0m
         nOGHG5uR1AL7PAILE3fBokX3QWxK5USDt+PNZrSMkGOqrDSHfdP7D7nqX21BeBq/X+vJ
         09OTdcMJ6FGLISfTaCz3OamgoCWCJ+f2Euc0Fb78/qKRUeQKKPospZhPMTjPM4h3yJ7L
         EdyObI4OScXAjCD9h8FAl59zF8wqnZkND516f9tZ24+NfWkvDgF/0vTb7Qev2hDtXN0j
         Q4wJQmWjhy1GulrO6+ZBVy+muwvq1dJIJpclDQLTLthByeVR5CESWm/IUk+uyg+Bs8eQ
         w7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMziTAReggV8cPAuUjcDsW9X5b6xE1JpK9TNborUBOU=;
        b=lJJir9p4AKxUToA1FSKy65bfaPMdop61y5lkgXpWarAT5Rbg+dEup6qw5g6Eahch7R
         2MbaJ9ww7wpJvIfmNDxpYFi/SlowKPgpKzXvrSG6ivVWCBAh5Qhm78YdKGnTEZ0NwiBy
         GUtm4OwOtyvyFBEkzYGd2lDWepxPNwdYbEAoiOKsqCFdpx9bdOajfIBcEJ62N5V+2DbW
         YePYl+9iuNY/dsSpO+KxlX4Riv8OSslia92LfsAy6+s6YKR7Cbmhp05TAsJjrr2IUmd2
         SRPu7o7GAytECJ+ewiwUKMBo9er4lMQ9hE4wTHWE90H0N9mYlP8NZAoo3IO4I5gG6C5/
         wlyg==
X-Gm-Message-State: AOAM533zqWVIeIB03HA+RByYgYR8s3KUOvul7kOpL/DtiqPsiDcX0azy
        /soCm1GuK97Ui7/xQBCWkS0dkmMkRXU=
X-Google-Smtp-Source: ABdhPJw8IGp1XM6bglkDUhuZK0Gi9PEqdX+50SW/65k6xMxLuOOWrKHawZTz1THzehYG4YmYCvywrg==
X-Received: by 2002:a05:620a:810:: with SMTP id s16mr16003595qks.360.1592842153712;
        Mon, 22 Jun 2020 09:09:13 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id s42sm15774713qtk.14.2020.06.22.09.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:09:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>, andy.shevchenko@gmail.com,
        michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux@roeck-us.net, andriy.shevchenko@linux.intel.com,
        robin.murphy@arm.com, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <20200622080913.GO954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3aa3c8ad-4e6a-9b9b-be58-bd9da5a0fb0a@gmail.com>
Date:   Mon, 22 Jun 2020 11:09:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622080913.GO954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 03:09, Lee Jones wrote:
> On Thu, 11 Jun 2020, Lee Jones wrote:
> 
>> Currently, when a child platform device (sometimes referred to as a
>> sub-device) is registered via the Multi-Functional Device (MFD) API,
>> the framework attempts to match the newly registered platform device
>> with its associated Device Tree (OF) node.  Until now, the device has
>> been allocated the first node found with an identical OF compatible
>> string.  Unfortunately, if there are, say for example '3' devices
>> which are to be handled by the same driver and therefore have the same
>> compatible string, each of them will be allocated a pointer to the
>> *first* node.
> 
> Any more reviews/comments before I apply this?
> 

Yes, outstanding issues, so please do not apply.

Shortly after you sent this email, you sent a reply to one of my
earlier emails in this thread.  I have replied to that email,
so we still have an ongoing conversation where we are trying
to resolve my understanding of the problem and whether the
solution is appropriate.

-Frank
