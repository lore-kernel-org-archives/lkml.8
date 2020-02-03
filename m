Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F69C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FE120721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck+6WlQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgBCQCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:02:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45567 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgBCQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:02:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id d9so11770694qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HjCX6DKDZRyPuFTxNQ4aU6A2wq9gYlzmfJ8lD17itU8=;
        b=Ck+6WlQcJE25BiRrSHIVOnUYvne1jlfg117XTo2PNNq6uEUOjiDM2DVNysgwlny73c
         Gr/Pov+u+tJ7ypNSAh9YWJlOwWoS5x+mPK+wlkwCkniM2sqbFM1noFgK+6ub+jSiO3i4
         /Jl0qXo9bIQA68v9DhAzx++tsGKg9XTgwwX+jhmgc0rH6/wP7BZStFZcNSk+VRkTH0NH
         MsKa8WGWWn5UKl8FIiBzCnz3M0IQJYlKEqo7IKNuUNm1GxeHVuiU+UfSBVnpRuBv1SV1
         oK9Vewblu1pxqJLqNlaM852tNEond7EIB04Q5+yJ7UkhM82u0dlq4J4WPCNtw5pFfNxH
         qLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HjCX6DKDZRyPuFTxNQ4aU6A2wq9gYlzmfJ8lD17itU8=;
        b=T4cGmb0BghAkeXhGcV800rF3BnVAJQDkPghNb34aDtnjFHxHPc3HVtthL/2rzr6AMv
         a1cyeVZ3TQcoxy0d2ICOzQM3VZUW7rr+Rc3toopL6L6ARBXLmi0MQ9TxlHZJlunyE4cy
         nnUBd4DS8361bPb1SY/8VV7ZcZZHPIWPJpGvBGHSAlOi7qsKD8ykau+Mm0WRl8NjxNqR
         kB+P3X02Avz1JNtVZCut9031Q9VCWN5rr5pR8mxIDo6ghFVybgoLxG97Ym8Ouk9kDQMG
         uw6rD5cNOZg7AJwfjBv6LFXDeRMhHgSJKSAbZ325zDjidjJWgbCXSKNG8Hd137TKMenG
         UPPw==
X-Gm-Message-State: APjAAAX2t8C2CQdgF6+kBlDlgay6e2jCp9LawBgGA6Kkx2NYq4GH+35w
        jHGMqJcD8/gHXHyLJr0daJQwUw==
X-Google-Smtp-Source: APXvYqyY7dtDRgnvWHUdqnTYwCPWVXSMT4+TGGcETAa+e/TUe/FBUMLERL5AvnhEUkfLTW4GLqgMtg==
X-Received: by 2002:ac8:6ec1:: with SMTP id f1mr24196773qtv.144.1580745734160;
        Mon, 03 Feb 2020 08:02:14 -0800 (PST)
Received: from [172.20.20.20] ([73.61.14.12])
        by smtp.gmail.com with ESMTPSA id 21sm9393262qky.41.2020.02.03.08.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:02:13 -0800 (PST)
Subject: Re: [iommu/vt] c9ac3b69cf:
 WARNING:at_drivers/iommu/intel-iommu.c:#dmar_parse_one_rmrr
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
References: <20200203091023.GH12867@shao2-debian>
From:   Barret Rhoden <brho@google.com>
Message-ID: <abfc90f3-1b2a-9784-e688-209913c1d9a4@google.com>
Date:   Mon, 3 Feb 2020 11:02:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200203091023.GH12867@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 2/3/20 4:10 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: c9ac3b69cfdbc46a0504fa353b5126827e4b0bdb ("iommu/vt-d: skip RMRR entries that fail the sanity check")
> https://github.com/0day-ci/linux/commits/Barret-Rhoden/iommu-vt-d-bad-RMRR-workarounds/20200109-051817

This looks like your system's firmware might be buggy, which is what the 
warning is all about.

 From the kmesg:

> kern  :info  : [    2.912758] DMAR: RMRR base: 0x0000009f271000 end: 0x0000009f290fff
> kern  :info  : [    2.919226] DMAR: RMRR base: 0x000000a1800000 end: 0x000000a3ffffff
> kern  :err   : [    2.925692] DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000a1800000-0x00000000a3ffffff], contact BIOS vendor for fixes
> kern  :warn  : [    2.939636] ------------[ cut here ]------------
> kern  :warn  : [    2.944436] Your BIOS is broken; bad RMRR [0x00000000a1800000-0x00000000a3ffffff]
>                               BIOS vendor: Dell Inc.; Ver: 1.2.8; Product Version: 


The e820 map has this:

> kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000a0000000-0x00000000a00fffff] reserved
> kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved

The region 0xa1800000-0xa3ffffff isn't explicitly reserved (it's not 
listed at all), which the IOMMU-folk say is the fault of the firmware.

My commit made it so that it merely spits out a warning, instead of 
failing to use the IOMMU at all.

Thanks,

Barret

