Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE20C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073102071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aefTb9R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYKnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:43:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbgDYKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587811420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zenMpg+2v4nQ44+/jX7Ww4Nj5mK/XgsXmzCGzWANwV8=;
        b=aefTb9R06CSZey0rgWcce0Y8X8TNDdsjWPkZA4qniRj9xB035FnpTEJejLiT861s5D/enb
        JFPPp8LvRl6H4UScjKFJGWomYyZies49OYgjM5tMb120wnFQ3cTEi1oI4tyn/ahOzH4qhQ
        AW2tbYIrzt8ZVxqckYzIygHio/DLmUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-5dVvx2_jM4mVRBrX59UMDA-1; Sat, 25 Apr 2020 06:43:38 -0400
X-MC-Unique: 5dVvx2_jM4mVRBrX59UMDA-1
Received: by mail-wr1-f69.google.com with SMTP id v9so6488728wrt.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zenMpg+2v4nQ44+/jX7Ww4Nj5mK/XgsXmzCGzWANwV8=;
        b=Q20uj/Eg5nykrD5defV2/RUk/RX2XmfiZe4CGJcjp+N34jsA6BpHYAT7b7QMy4RAZ2
         GJRdKEvOTrR2i2Ch0QwdfrQ58bpX9Dn/AYeeGHDRErfmOA8UWJCEQYC5g4n9Rm9SxloP
         6jqjPeU5XJQJndxqebrC7VlHXOXqWLjbEeqAgEpr51M5PVpxko+nifEEOENutzDeIwum
         ERj5I0gTwY9sDCQWVKFq09GjYsP2yVtW0ie8Olej1jPK45eRWHDWeZEOQg6yF+a912Nq
         u83jBjsU+/Grz3JR37opN1Pdlwq0/qe/0ruaiV6QbgHIfdfRst82xN63bOga88YHJgLJ
         AFgQ==
X-Gm-Message-State: AGi0PuaOTtl+R0ch5hXJgZwmEgVLvCTvWL/qdxBQ1nUYxYYM0pE30sQR
        R/E8wSnnT29rUOjVtibVqtbcytWSWuaGlH/hg/ThrwitCBVH8/iVHxa+rYpxXNYQNtDOPpVB8TN
        eeK5F0E8ZSO3ktvp+Thk7tPss
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr16485418wmc.83.1587811417047;
        Sat, 25 Apr 2020 03:43:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXYCKrMGcQbWZ4dmNlA4I3N70iZVCaAGf8WxW73pnTLMz5y0M53agpbgh6ZESeAQahxD4ccA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr16485405wmc.83.1587811416907;
        Sat, 25 Apr 2020 03:43:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id x132sm7007951wmg.33.2020.04.25.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:43:36 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200425075906.GA5250@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7bac482b-7940-e6a1-6256-194bc3393063@redhat.com>
Date:   Sat, 25 Apr 2020 12:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200425075906.GA5250@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/20 9:59 AM, Christoph Hellwig wrote:
> Any more comments?  Are we ready to merge this now?

Merging this fine with me.

Regards,

Hans


> On Wed, Apr 22, 2020 at 09:38:42AM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> the first three patches are my take on the proposal from Yufen Yu
>> to fix the use after free of the device name of the bdi device.
>>
>> The rest is vaguely related cleanups.
>>
>> Changes since v2:
>>   - switch vboxsf to a shorter bdi name
>>
>> Changes since v1:
>>   - use a static dev_name buffer inside struct backing_dev_info
> ---end quoted text---
> 

