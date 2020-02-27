Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D669C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABC4246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgB0XNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:13:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37946 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:13:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id 2so1028226oiz.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 15:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuP2i555x9rQeLyB1v3KlAfJsd5dT+gQKeEPZLvbG7U=;
        b=MZnzQCh/KHh1q6YatutvUIKjISYoDqGQhcbCP4OkDL95tcIUM1zAdp6/tduCCh8RVH
         kFUwZp/wR5WXL2+r55G3iUvlen4pWvRLUovoM7LdewKpo0gebbaIUBRWoO+jCool/Hr4
         i6xyKiDjaBtKfpctvdOfbRO2SopVOUTSXHq/3Kv3bQmkYyFhRIDqRbyajegLa+e6bdZc
         MRy8pq1m5JBwdhvxQ1T/d9ZhkY0U6WHbiqWmDN6LL6Y+o6zz9L1NRA4XI9K+Z+UmPYXS
         5xtYFtj6RAsLsU5Hchoyj3fsSohDlnq8qT5oHv6162fkIjaJ6KrLk5aZyq+bvjja4hej
         vJJQ==
X-Gm-Message-State: APjAAAXbegV8WFOZAkUQK9Pu5+Shd8F9ojrdVoNlD191MCgEgrwVeg1F
        +mcC1/ACNTmPyLFolz5lSZg=
X-Google-Smtp-Source: APXvYqzigNcduadD51SnQ3RWu/qpj0QrIQNpNPc0NMbtWNTDLeraVQfc5Y6jSTpgNetyyTPyGtkGng==
X-Received: by 2002:aca:c646:: with SMTP id w67mr1011516oif.171.1582845192170;
        Thu, 27 Feb 2020 15:13:12 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id t23sm2479235oic.28.2020.02.27.15.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 15:13:11 -0800 (PST)
Subject: Re: [PATCH v11 8/9] nvmet-passthru: Add enable/disable helpers
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-9-logang@deltatee.com>
 <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
 <9c6355d8-cf4e-9932-1cef-0a7140f0fa7e@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <283c563a-06a9-9c12-bd4e-d15e790fad57@grimberg.me>
Date:   Thu, 27 Feb 2020 15:13:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9c6355d8-cf4e-9932-1cef-0a7140f0fa7e@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +    if (subsys->ver < NVME_VS(1, 2, 1)) {
>>> +        pr_warn("nvme controller version is too old: %d.%d.%d,
>>> advertising 1.2.1\n",
>>> +            (int)NVME_MAJOR(subsys->ver),
>>> +            (int)NVME_MINOR(subsys->ver),
>>> +            (int)NVME_TERTIARY(subsys->ver));
>>> +        subsys->ver = NVME_VS(1, 2, 1);
>>
>> Umm.. is this OK? do we implement the mandatory 1.2.1 features on behalf
>> of the passthru device?
> 
> This was the approach that Christoph suggested. It seemed sensible to
> me. However, it would also *probably* be ok to just reject these
> devices. Unless you feel strongly about this, I'll probably leave it the
> way it is.

Sounds ok to me.

>>> +    }
>>> +
>>> +    mutex_unlock(&subsys->lock);
>>> +    return 0;
>>> +
>>> +out_put_ctrl:
>>> +    nvme_put_ctrl(ctrl);
>>> +out_unlock:
>>> +    mutex_unlock(&subsys->lock);
>>> +    return ret;
>>> +}
>>> +
>>> +static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
>>> +{
>>> +    if (subsys->passthru_ctrl) {
>>> +        xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
>>> +        nvme_put_ctrl(subsys->passthru_ctrl);
>>> +    }
>>> +    subsys->passthru_ctrl = NULL;
>>> +    subsys->ver = NVMET_DEFAULT_VS;
>>> +}
>>
>> Isn't it strange that a subsystem changes its version in its lifetime?
> 
> It does seem strange. However, it's not at all unprecedented. See
> nvmet_subsys_attr_version_store() which gives the user direct control of
> the version through configfs.

You're right.
