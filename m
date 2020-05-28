Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C30C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A72208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437198AbgE1Wdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:33:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36225 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436867AbgE1Wdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:33:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id d128so938009wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=UCFfOsdBjNR1XpgODS6Fjc9+KXh5AjbtbE0r4Sh6+tDqHYVoQ+6MpK2qhK11Nam/Lh
         EkHohzirskaPktVf+u+8ffpOLKFoQeyBRRscsxPmZni7mkOAeiYt0fY8QzaX9KCZFQus
         6xXVE5WomhlSPBI0ryTFk0PtenMFbL/HAgH9up+Tl95ZAiS3vmf0XbN9PQmUmzHsiTKz
         qsQpeOAv7SoKqKgO96NY73GnpgmwdjCESK3YhMwcAi92o1Lrm8E2HjwVpGNFKrRHaZLH
         m1Jz66KkDt75nddYtINAaf/uZ8BQqYpEvyWukDpw/UyTJpnfhCkRtIKAQL2z93p4Ug7S
         U+dQ==
X-Gm-Message-State: AOAM5331ORw3acFSRHW7yERYl91w+fEO/DRvoZ0T4eh/nw4pQkBIbr+O
        hunKeXLwUbIpAQ4KLS10smQ=
X-Google-Smtp-Source: ABdhPJwEZfDHlpwsy1mFCARRbXVqxrK1dKlDKEk1jt7eqpK6Gomcr69D17z694cOBBjiGDDhrGFDNw==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr5364820wmb.65.1590705217487;
        Thu, 28 May 2020 15:33:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5097:90c2:ff61:dbed? ([2601:647:4802:9070:5097:90c2:ff61:dbed])
        by smtp.gmail.com with ESMTPSA id s2sm7522941wmh.11.2020.05.28.15.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:33:36 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: constify static struct blk_mq_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cf61893f-7af0-c253-a3e0-f507e5ae608b@grimberg.me>
Date:   Thu, 28 May 2020 15:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
