Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3D0208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXN/9Lte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgHDQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgHDQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:21:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A8C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:21:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q76so3501887wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ST9UBbZKghuCFpLuvhcBi8OC0S5lAPRob4gGRkqUBQI=;
        b=SXN/9LteKBtddUwm0e5UMFZX3bzVy6GxJDciQvp2jhpu55QK068xpA0TfA0ee205Gq
         DgEXzVRWBbixlxxR6B5P0TtoYIbj4NJ9A9ZNkb7quhHTJZkqIkp0P909n8sCBYYLkAV2
         8AVP2oyeTNXt8vnnqVD/PXQoMn9T+CH8sjMFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ST9UBbZKghuCFpLuvhcBi8OC0S5lAPRob4gGRkqUBQI=;
        b=BhmWABWBPwtu3fewKGXbVPhDyJMA/m5uncB/WH128phOt4CnmGWSrV35aXYYO8kJo5
         sqbHnahLtdzIOT3mPHbKw+vz/7nnBpEVPzBuam8ZXCGa/YRXy6I3d3ug6utVLLP6dPwN
         z0Ysd4iKDdUwafqTOUUbx+AVZkFSNCnykHFLgaS30Ra6V1OhxPaQxrhOZKK2vKFLEbip
         A1mokFkqCdD7I9lxGBCCxml76VNM2qCsFAJ0K3wyYKxvTvYvPAOtwK5pSvNbJbIaequL
         uvOPEs0tK0kqghJ3U19VdHufqnKChULUn1PxYT8zLU61rIvoO737Gc6OGzViIBtAqrTE
         9rdg==
X-Gm-Message-State: AOAM531FqZzpuJV9UKdp9oWHaet9yT7d9CZoTpJrYiTkkV1voXn0ZMbM
        VpNpv8cpCFrqIPvNwomJq5OWjca+X+3IMUhb9EBrQaogBhDDrRer5lAMPnMjnCj7c4q0ll8dPyb
        OWEpsmKlhdNEHP/9OU6lKuk19U33qU+o1lK9QiDJAF71eF3Oo8Ac6KG801E8RXiuF29P0EFv/Jj
        MiBghkpw==
X-Google-Smtp-Source: ABdhPJyzl7yOei+IZoGA9xJVGGHeQUKJPzBjfKEeN12WVpymiUK9Opk6H6+2KeAThLEQGdLe2xVkHA==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr3422486wmc.181.1596558089133;
        Tue, 04 Aug 2020 09:21:29 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z12sm29956754wrp.20.2020.08.04.09.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:21:28 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Add the missed misc_deregister() for
 lpfc_init()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200731065639.190646-1-jingxiangfeng@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <ace2c669-5fc6-e6c5-9d39-382ba02b1adf@broadcom.com>
Date:   Tue, 4 Aug 2020 09:21:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731065639.190646-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2020 11:56 PM, Jing Xiangfeng wrote:
> lpfc_init() misses to call misc_deregister() in an error path. Add a
> label 'unregister' to fix it.
>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
>
Looks fine.

Reviewed-by: James Smart <james.smart@broadcom.com>


Thanks

-- james

