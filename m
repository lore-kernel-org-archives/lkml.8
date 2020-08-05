Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239DD22CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt6q8EiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHENEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgHEMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDF8C034612
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:23:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so5599404wrf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=25E2/2xbSRBzjcvf36fx5mELs9Z7mR2luHPFCx5dswU=;
        b=pt6q8EiNxdYJOIPC2R5wpilJY3+6rxN3hCNM+q86g9Cgzgdbs4dRETpg8UAm3tJ9Ba
         k9gFwHFMeGIfvN+qFLimBOhf9eAL3ec7qmpwHTWh8yT7vs6UXnoUQ0xvY0tXBK1fwGG4
         a8P4KchTodXW9qhB8f0xD4TcuBKpW8JDv6v1RdDDOJfjbuNKjkD2wJ0rJ2nGoS1E5yNF
         uZmt1AfIgpx1Zg8HVgXbfh7iWg1zmYJvFt3zmEcxk5txf4VOU1QzVCMWTWF8ZlbDUS48
         zsODZv3Wzl/s2VaXYBIzo9iG7t7J27Uu8+b+jjzDa+KJeSsK9dMJ6TVbQ7GtUBjsy2o3
         VBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=25E2/2xbSRBzjcvf36fx5mELs9Z7mR2luHPFCx5dswU=;
        b=aIvVqYJH+eD7grrFi4Fj6qaeeqOnLwbop7DIciLiy9iwKbBfFIKxPLFs7lxDHPXhhx
         92Cnf3npzcY0THG3R8gW1SzI3w4zQ53fMXuQs/ByQQcLF+YglATMn1q9yfGOlTdfOoje
         muivPdfnhQx5X4fWv06P58JT8IVaOo0NLx1xICsdyevU+O5JUlbAG17aApkmV3UAv1kQ
         vBJ+P7YVtUi1Jmb5ZwStpCQ9Yy0vV411vke+po3ZJ2u2nKvVgQdceH3m8adh5bc3hFzT
         fl3m4Z8LidJVeBzJEgQd3N8K/+l7aS5td5zJ9GHVFHZ//aQN2jHDSuKqv3mIzqE0Pcky
         fPvQ==
X-Gm-Message-State: AOAM530z71bbniV6HCRxhHRmgpSDbP+0+kUf2DUdWFJ7ZvkQEa8tmklr
        JUQODtug+1/mS0zkSYmy31OwZV5Zfl8=
X-Google-Smtp-Source: ABdhPJyThzyrVD88CUtXaMhGvOGU5mXiUHTHWUnHRHBPXzZNS/kXe+0dONyD5HbGE80tBfJdMJKnIQ==
X-Received: by 2002:adf:e486:: with SMTP id i6mr2552656wrm.258.1596630189936;
        Wed, 05 Aug 2020 05:23:09 -0700 (PDT)
Received: from [192.168.0.93] (88-113-28-221.elisa-laajakaista.fi. [88.113.28.221])
        by smtp.gmail.com with ESMTPSA id m8sm2624459wro.75.2020.08.05.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 05:23:09 -0700 (PDT)
Subject: Re: Tests failed for linux.git:master
To:     kernelci-results-staging@groups.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5f2a9e1b.1c69fb81.d843c.3184@mx.google.com>
From:   Nikolai Kondrashov <spbnick@gmail.com>
Message-ID: <28513ff7-c0d0-f4a3-01b0-fad513e6ca54@gmail.com>
Date:   Wed, 5 Aug 2020 15:23:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f2a9e1b.1c69fb81.d843c.3184@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 2:55 PM, staging.kernelci.org bot wrote:
 > REVISION
 >
 >      Status
 >                  ✅
 >      Repo
 >             URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 >          branch: master
 >      Discovered
 >              by: 4da9f3302615f4191814f826054846bf843e24fa
 >              at: 2020-08-05T05:07:59.239000+00:00

Aahh, I forgot to update the templates to v3 schema.
Fix coming in a few minutes.

Nick
