Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC7C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335A0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By00QkCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDVIPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:15:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbgDVIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587543337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXurTIYnOIPkTIWMnh3upHjfMNa21BNU9O3zU5Qjfj0=;
        b=By00QkCSxFKbNND44Top3PAbY3fOzosCfpEf/f7xKzpUMRw2amHp3HA/dXW+Ie6MM/3TMB
        owqb+GOCzwXWzVA/+AlmIN49i3MOm9bPjiuAgp07NW6S+3bBXhJ+3Vjxat4dt32RYK2x5b
        vHDXP9bqnQmdzU5c5LXTah9Pi7mnRjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-_xbePcN_NFWC_8-A5difIA-1; Wed, 22 Apr 2020 04:15:36 -0400
X-MC-Unique: _xbePcN_NFWC_8-A5difIA-1
Received: by mail-wr1-f71.google.com with SMTP id r17so666235wrg.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXurTIYnOIPkTIWMnh3upHjfMNa21BNU9O3zU5Qjfj0=;
        b=lFmcrpWfKEmyxRqPNvnZNrHQ8f0ETlqjHVJvpLbr6MpqUpLY6Y796Pj6yq8B20yckP
         ZdaGxcZlMe+9pqviAph3iofpEg7lpTm8sD6Jf7c3lEw+9+t8FU1q1Kt9VoJWrS8IpYAb
         TBYp/dZlxNCoE2hOP97k8846agrPDonfTy40QoRc8BZS3zoU+wDWQSm4rgdAkUT++AEt
         /QOgVZ6mOjaRB62SGwyzV59ri+t8zbPq4W1155BzmyI29+KMX6SfOpNauoNhS85KDz0o
         J+4ATgVHujk+dvJ/216ChVj9udGkHcJBuIzdNGq9zDn3Pioj0DhqdmbjzRd768kC+orY
         NG/A==
X-Gm-Message-State: AGi0PuaEzcb/sNumqi77XUWPB/OYaq1ebZV0TPq2tLmqYUwB+nURlqmN
        dMcchR5qF0CJTaDD9HoAyaxfAQ0AsVjCCfy9uF69EH+ZGWjdznkBGdth9KrD/0/1MQqfzjHShOQ
        pfkjTiaHJ4NiVvs12yEmtoouJ
X-Received: by 2002:adf:fecd:: with SMTP id q13mr30110665wrs.12.1587543334596;
        Wed, 22 Apr 2020 01:15:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypK8ri1CshnlO1XFFdM+QKzk3a4Kr/Em91ovuJ/P1UV1w2OrtY8Flej8WviighrL8SP4ZX9a6A==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr30110647wrs.12.1587543334384;
        Wed, 22 Apr 2020 01:15:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n2sm7933262wrq.74.2020.04.22.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:15:33 -0700 (PDT)
Subject: Re: [PATCH 1/9] vboxsf: don't use the source name in the bdi name
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-2-hch@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2db7b68b-5117-4dab-ce57-6e8011711c23@redhat.com>
Date:   Wed, 22 Apr 2020 10:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/20 9:38 AM, Christoph Hellwig wrote:
> Simplify the bdi name to mirror what we are doing elsewhere, and
> drop them name in favor of just using a number.  This avoids a
> potentially very long bdi name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   fs/vboxsf/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 675e26989376..8fe03b4a0d2b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -164,7 +164,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto fail_free;
>   	}
>   
> -	err = super_setup_bdi_name(sb, "vboxsf-%s.%d", fc->source, sbi->bdi_id);
> +	err = super_setup_bdi_name(sb, "vboxsf-%d", sbi->bdi_id);
>   	if (err)
>   		goto fail_free;
>   
> 

