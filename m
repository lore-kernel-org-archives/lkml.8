Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCBC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138EA222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBZXIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:08:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42343 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:08:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so1112069otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hQAkKTaL4JV4n57mkve8qkeDSm7tUdm9PuV50CXwuBqeq+OCAIVn405iKs89a6u7tV
         Igoy0YDeb0HcNiQ+dnsEdWTJap6etF7XVgiAxpRO02ql2N6M0MKMxT7BUfU4WCfySjFL
         KigHFaKxo6DpFCiXqgynB+Zr2UMqyXjDgv3EJw79avSapIBHTkMpAKhqDOdPrlSg2E8l
         i2I9NNmBBuV3JzjR67hUrPqWUEOdzYXDPv5tdyXi4xNHvsEgdM2Nct1VqK3Wau2WUNCE
         Ytu7QrqlbBL9D1d68bVET9b0goLWo+cohw9734LN7ZwUov67+WhU9Z3Mg/m9OyEsfd4U
         QOAQ==
X-Gm-Message-State: APjAAAU//RtTUfyK1rnBips5U6nBqGhsEa79jqt7nGLx4Lhfp+U3ppyK
        1W7FpPhNrUrZ/sUQ6EwB1lw=
X-Google-Smtp-Source: APXvYqzO+D732Y9sL6GiQeR8dO7WbtaCh1X0mxbtVIS1E9eqqPe3HHDpW2Ci2PyVA0ICc7GMmRdhJg==
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr1049677oto.30.1582758521904;
        Wed, 26 Feb 2020 15:08:41 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z10sm1308741oih.1.2020.02.26.15.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:08:41 -0800 (PST)
Subject: Re: [PATCH v11 1/9] nvme-core: Clear any SGL flags in passthru
 commands
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-2-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dee2201b-9bfe-c3f6-d381-eb478a311e04@grimberg.me>
Date:   Wed, 26 Feb 2020 15:08:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
