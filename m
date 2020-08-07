Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A0C2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KboiF1/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHGDwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:52:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60635 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgHGDwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596772337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWEf4pn49dLkVtcRCpVfMFyzG0kkdDtY0L/o/mAs7Gg=;
        b=KboiF1/r64Jf7wO1St11/BSYD+r2pYIffreBdz/H3lP4SdoyG0Miav3qkzc0PjiZ2Ec/DD
        01bcjFsltKYijC8qvU4rNC2N7+78xwnMavx1/V4XOEbsu1eScefekX7jwI4537lsp05Jqr
        PRoTgDn3JBOOoYKitKQj/Mn0TtEgFQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-IdSPMwuRP9iPilSmJ22-ZQ-1; Thu, 06 Aug 2020 23:52:15 -0400
X-MC-Unique: IdSPMwuRP9iPilSmJ22-ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4901C7466;
        Fri,  7 Aug 2020 03:52:14 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C339B6842F;
        Fri,  7 Aug 2020 03:52:10 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa: ifcvf: return err when fail to request config
 irq
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>
References: <20200723091254.20617-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <87ec5f62-4d99-e7b4-00dc-28664f8eb111@redhat.com>
Date:   Fri, 7 Aug 2020 11:52:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723091254.20617-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/23 下午5:12, Jason Wang wrote:
> We ignore the err of requesting config interrupt, fix this.
>
> Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
> Cc: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f5a60c14b979..ae7110955a44 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -76,6 +76,10 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>   	ret = devm_request_irq(&pdev->dev, irq,
>   			       ifcvf_config_changed, 0,
>   			       vf->config_msix_name, vf);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to request config irq\n");
> +		return ret;
> +	}
>   
>   	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
>   		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",


Hi Michael:

Any comments on this series?

Thanks


