Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D3520767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J73y+bMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgGIRZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:25:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgGIRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594315552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayL2zRv44zVA/vI/qKLO5dT3uiTyNFjJ4KJMkaO+qQI=;
        b=J73y+bMPdnIGMDWCHkX869bnwSUpf2LHoAmTAiVkl6UJbP8FoCq08R4mHZW7fG6UnBzW/R
        3mPc2SdJm16B3Y0L4v0TkVkA6KPGsZXJzOJHI0OptcLfwypzxLUDj8Jz9gRlSZhxdapG2g
        FeOG2QTbcUIROPPaCq59grv4futADEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-9_UDc4jkPKeIGr8U28bE1w-1; Thu, 09 Jul 2020 13:25:51 -0400
X-MC-Unique: 9_UDc4jkPKeIGr8U28bE1w-1
Received: by mail-wm1-f71.google.com with SMTP id v6so2865336wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ayL2zRv44zVA/vI/qKLO5dT3uiTyNFjJ4KJMkaO+qQI=;
        b=Zzxg9Bc/rqSebmWKOCtREgqj+vSv+ZAJsfkD9Ohbg80SE14I3dQcgcWSqzYX5VcVwK
         TP+NaHidVlFvvqfLKO7dh7H/U9cC/2PI7T6K4QTksAv1giNjGeDS7yhsegua9MH1DXIG
         iuiehW9xF8Lp2pPCLwFhHoelWL+Ex5iLEdM8aFaQqXfGtAQW7vTP6z5ClHjtxOP8PLCl
         cPM3WU2Tm5tLoKla/X/SGokxsXW6W3SuZmNkT/2ihj7xur1VV/Qabnbal/BKsBvTyUgD
         DKxYulbSVoJLffX0FqYQQr9GCQZqBykn7G7jlx8cRgCcv9UfPzdtkuAV42a43jL0F5SQ
         2Adw==
X-Gm-Message-State: AOAM533VdF9laqUPD5saSMPs92C40FA+/CNCbg/dchJV/QN+bMtqW9JR
        nNx/iPt7NEOd79XUeNMw2YM3Cs7+Z9KUxnL6ji5XD0SBAvscI0cLjGRug8RySKkISZKc/mGkkfN
        vDkLIPQ1XOo9oh+1LTv0OnuIe
X-Received: by 2002:a1c:28a:: with SMTP id 132mr1009949wmc.109.1594315549628;
        Thu, 09 Jul 2020 10:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2sedbzLwqgP/3k7XdcalLS7M8QME+eSe2xcF5rOIoSPUGVWnnJi2vGFbzZPqABCs7ueR2IQ==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr1009940wmc.109.1594315549388;
        Thu, 09 Jul 2020 10:25:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id c15sm5608087wme.23.2020.07.09.10.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:25:48 -0700 (PDT)
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
To:     Markus Elfring <Markus.Elfring@web.de>,
        Xianting Tian <xianting_tian@126.com>,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
Date:   Thu, 9 Jul 2020 19:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 19:16, Markus Elfring wrote:
>> +	mempool_destroy(virtscsi_cmd_pool);
>> +	virtscsi_cmd_pool = NULL;
>> +	kmem_cache_destroy(virtscsi_cmd_cache);
>> +	virtscsi_cmd_cache = NULL;
>>  	return ret;
>>  }
> 
> How do you think about to add a jump target so that the execution
> of a few statements can be avoided according to a previous
> null pointer check?

The point of the patch is precisely to simplify the code, executing a
couple more instruction is not an issue.

Paolo

