Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260FC20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgFWRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:39:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39823 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbgFWRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:39:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id d66so10425577pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAIQAxiLnbAZ5BAFIcJMeyR0JdJvLnsFgfO/0/AmLPA=;
        b=cx1GisF/S+zyWvzKWzvrL5zD1LiKxcrmoRXhlE66mviJVf7yXyokTkD/uQ9NUta1yG
         f/MZjD/KH8X7rHUDEVMvA3Otj0hACO1tl31nVgpab55GZWzR3v16PkXx7VunIj7+h/Rb
         XKmOPkyMJOfU4IwspVFJ1xNwtJIonVw+Wv61+JgkjFtIZ08Ly60FrPuUrwIIuZq0TLbW
         C2z0AqRtoxNzn6alSXkV8hxqlavfCD0GSDJVSAPkrcZBkzn2jqOJTCbe5fEakffUuLXd
         0DnU/zvWhf1Och+K7v5mp94GoVLyI8bf4dkGDKs1kNHBMv346oASVBeTN7PtT9xYpx+C
         mvtQ==
X-Gm-Message-State: AOAM531EGCzgZkce6Cpj3FNOaaONJQ7+MKgP0m+XpHzJGuEwKkhgVtYY
        +sjj3CcjME/FbmkYVtQiQB+3b/7g
X-Google-Smtp-Source: ABdhPJwP+kfIPptinn90SJZmapQDZ/xaZKvE4G/xUSfG1p1yiK8fszEV/rJ0jnK8F52BozCNCteXDg==
X-Received: by 2002:a62:31c6:: with SMTP id x189mr27591959pfx.79.1592933943273;
        Tue, 23 Jun 2020 10:39:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id m1sm2880457pjr.56.2020.06.23.10.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 10:39:02 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
To:     Keith Busch <kbusch@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
Date:   Tue, 23 Jun 2020 10:39:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>  From the NVMe spec, "In order to make efficient use of the non-volatile
>> memory, it is often advantageous to execute multiple commands from a
>> Submission Queue in parallel. For Submission Queues that are using
>> weighted round robin with urgent priority class or round robin
>> arbitration, host software may configure an Arbitration Burst setting".
>> Thus add Arbitration Burst setting support.
> 
> But if the user changed it to something else that better matches how
> they want to use queues, the driver is just going to undo that setting
> on the next reset.

Where do we do priority class arbitration? no one sets it
