Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF1C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699FC207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DWnpDyFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgCSRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:00:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37008 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgCSRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:00:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so2241733lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=vtMkzIwErSV95ddMs8+z368iZRh2IGDxPAeyTBG0cRU=;
        b=DWnpDyFyEjuHzu+kRPx00hpMuT06IvaqqLSwmamJaN9ZNBGgnTK9dVYcoEswiuB9so
         2zppWBUEL5zX+7W7st4WJ9jc3k2T6d1kDdTytPDB8t+kMIV2ZJyj2IlkTO7DLiPxOiGx
         yRxuE+k07s8wSpC/DdTrKGRVHg8PluVX0yNT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=vtMkzIwErSV95ddMs8+z368iZRh2IGDxPAeyTBG0cRU=;
        b=Vk/VV/QK5King34npSOY5K7O/GZM+6EKfIO4uCIP8SDcNMEkPCnyg+V+V1KMkaNXD0
         kKFsdJhD8KId2TdL+NzYGK1M3SisiXCxKph0qUsAf794p0+ilii8h1X+DP7ctRZe/2Bf
         PK8ncVPprtLY3mx6WHZb3hycePzDW7/w8D66FUp/oDwP8eDzeLhRDMQMBbI+jgf76afQ
         xLhEmDcA2EgR15JSQQBZEUmwbwvhfVzUiJeECemHmNRPbexpFy8dg4Tn+S78HHIgpmnV
         w2H6RRMquSINhHHEQmIBVZ+TKudQgWV8yhFiwGYv4T7b8Qjzley48lXWIgD+s/ggkQND
         dXzA==
X-Gm-Message-State: ANhLgQ3TggolYDUPKEta0JInwE8o7BtVVCMyQ83AmuXunWeQ5tLtCWUi
        LTV7b7+lL8u9tSd73pXOhY6BCw==
X-Google-Smtp-Source: ADFU+vvvm/Zy8geTn5pwmr1xdKqSGIlU4wTLcd+FA6SFqyZdZVOBmSRCEIBDJWaa85K8mP1TxQOxEA==
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr2791061lff.1.1584637226598;
        Thu, 19 Mar 2020 10:00:26 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 64sm1793944ljj.41.2020.03.19.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:00:25 -0700 (PDT)
References: <20200319124631.58432-1-yuehaibing@huawei.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lmb@cloudflare.com, daniel@iogearbox.net, john.fastabend@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: tcp: Fix unused function warnings
In-reply-to: <20200319124631.58432-1-yuehaibing@huawei.com>
Date:   Thu, 19 Mar 2020 18:00:24 +0100
Message-ID: <87fte4xot3.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 01:46 PM CET, YueHaibing wrote:
> If BPF_STREAM_PARSER is not set, gcc warns:
>
> net/ipv4/tcp_bpf.c:483:12: warning: 'tcp_bpf_sendpage' defined but not used [-Wunused-function]
> net/ipv4/tcp_bpf.c:395:12: warning: 'tcp_bpf_sendmsg' defined but not used [-Wunused-function]
> net/ipv4/tcp_bpf.c:13:13: warning: 'tcp_bpf_stream_read' defined but not used [-Wunused-function]
>
> Moves the unused functions into the #ifdef
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

In addition to this fix, looks like tcp_bpf_recvmsg can be static and
also conditional on CONFIG_BPF_STREAM_PARSER.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
