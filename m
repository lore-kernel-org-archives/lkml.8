Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F2204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mFk49No5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEQPXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgEQPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:23:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:23:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t7so3125073plr.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ARcj1uUB48FbteuMdUsFLSwb4pQE/AQvlz9aFRa1Ftk=;
        b=mFk49No5ggCzuCtMIXt9quTeqnBXTqM6tkZWOR/lJ73iZJoq/oI69Kac4pJ0I43ynh
         6pgP0N7dSuD6fP7YFJ27TN8C6nkVy1FlEWAkupwYEiK3eOOIkVDevxQEnrNu5NhgkuSv
         019kz+XIxIf/NSaer4esWvHHFeyEobF0S0SnyDzRxkieMgqz6+EHU98iGyDQ/BuOKrsY
         4+wPIWpmmK6eDSbaY/eCVTAx65Te7fM2UAgSuNTYTmXkOfkyFu8BVah4H9m8C9Y07l8d
         0qzCL4oJ8kEqmysCltdf5r74/kC+vhQODpk2xDrFlI6//Kjj+1mCh7RfH6eggRCi1FNS
         nUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARcj1uUB48FbteuMdUsFLSwb4pQE/AQvlz9aFRa1Ftk=;
        b=SIkUGulQzp3PlgtjWngKI7P6TOnhZWCSXw/l98+n6B9FmDwOAAFVQW5HmfYbsxZJy+
         ggOfBlypGzcWvGjQ8FlaDQgPLQvFey7yDjBVvR/aWVOSOQDkDTikERSYnAFSsTcaPiXz
         94s4TWAAYe7ZZ0MpZgnNryLeyo5O1DxPPZutBn93wc9zo6FsfYk8dcEnjgjDCc1RxpzB
         kRarj+Kq0awf7atwKVfRzIBx6yqN8OQLlEG1PFqlrm+AIGZ2EnubWRAyQLNjvKKzlpOq
         GqW6z+ZzLklsmq4jCQlI9jTOe8MHiBvAqJ2JCIZvS6grgF5INaEh8EoARfnpnUgxVYym
         LMJA==
X-Gm-Message-State: AOAM530gjZaQEBTroHhXoEi2OoIP+GYWfAwMAGfVcW3RGxy+3JqW36qe
        anaDUWLHjKKsy9LzXRhYOAjg1Q5l8pQ=
X-Google-Smtp-Source: ABdhPJxhlCgouCxFptr4eXyvWHC/HFKOrCWJ1DYR/hvquk54lcIgQPa1DipIYjqTKKb8IPEZLRPy8g==
X-Received: by 2002:a17:90a:1aa2:: with SMTP id p31mr14124234pjp.233.1589728981510;
        Sun, 17 May 2020 08:23:01 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:91d6:39a4:5ac7:f84a? ([2605:e000:100e:8c61:91d6:39a4:5ac7:f84a])
        by smtp.gmail.com with ESMTPSA id u9sm6407821pfn.197.2020.05.17.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 08:23:01 -0700 (PDT)
Subject: Re: [PATCH for-5.7 0/2] fortify async punt preparation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1589712727.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ccf5342-c3f3-feff-f92d-dd580199ce30@kernel.dk>
Date:   Sun, 17 May 2020 09:23:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1589712727.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 5:02 AM, Pavel Begunkov wrote:
> [2] fixes FORCE_ASYNC. I don't want to go through every bit, so
> not sure whether this is an actual issue with [1], but it's just
> safer this way. Please, consider it for-5.7

LGTM, applied.

-- 
Jens Axboe

