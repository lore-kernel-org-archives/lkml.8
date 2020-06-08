Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9CE20812
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgFHEmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:42:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44780 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHEmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:42:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id r18so1912079pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 21:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=S+Qp59zMNfU6S+nIfV67UmHVeTFqt+XoiMNGCZ3G8usvEDwpT3cCtUTazYpbMG2iH2
         AcyB7l7ELvbjKawp4XvclWUsvGoj4k3Y7222CFs+d1EXUsTxsSfzND6/7xofLdmHtR8u
         SyXEjcxSgSsOmHOvdQja1bUccVfx6axtSIkSo+NNgm1JJ/y7P5rZxHS/mWDzOYnPW9NG
         UEXk+3Ak1xN8s749nIe9GCLAJ56voWBXhEDsVqyIYmxbQbRAgF0y7NjR3Pqe4zHIExak
         YgHEeJ8A/iDsFY6z3PvH5z67y3BCxA1GAW7Ckd3GZKiy+w8DQ3DXopWeWubK9MlCv+mm
         Yrrw==
X-Gm-Message-State: AOAM530OftaeeEOacqn1udJrV6Fdk+TN0VjYGdT8Gg42HBVIHmc5yqNK
        Caz8uvbmhDreE3XOfof70uw=
X-Google-Smtp-Source: ABdhPJzK02RNz2PGm3x5D7KGjyZ+oukieutTm+MRazsKQULHulXca4whO7raBRwcl3Ae9h894E0Vug==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr19163268pfa.219.1591591333127;
        Sun, 07 Jun 2020 21:42:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16? ([2601:647:4802:9070:5183:321c:38f8:ee16])
        by smtp.gmail.com with ESMTPSA id 73sm4737103pge.15.2020.06.07.21.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 21:42:11 -0700 (PDT)
Subject: Re: [PATCH] nvme: do not call del_gendisk() on a disk that was never
 added
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20200607114520.130756-1-niklas.cassel@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18b34afc-1c9c-e650-3836-cadf0b4a9fca@grimberg.me>
Date:   Sun, 7 Jun 2020 21:42:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607114520.130756-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
