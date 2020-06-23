Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E831C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB30206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="qSsa6OU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgFWKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgFWKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:08:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:08:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so6313779qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9c5WFc7U6zTXjrlhiVZtfgtzr3l/N/zum3a6S9gkYE8=;
        b=qSsa6OU9kW5ScBHY9Uije4v8qAfThq0HASHHxyOLqkFDkz2exTmO2KggpFOyzKBIIe
         H1IYv3oIyFcJXZvRc95KHlIkeryIiG4gVJNUChVq+pu6qLQuIkeA4TLfygIIdd0z/ONF
         uO3bIAr5JKQEmQ1cgYUhVJ6WVsNYtgxiF3EtVMad1Uy/fV8h7xlwdT5VP1vpON9Qj5bt
         w3RGdJJWEmdWZCCWY0uo2QtXCt0R9SKbKjLRQ45lcDpczcHURFKtKFBrCrTBdM4VWx8e
         K0d+KwQjdx6BPkqP4WZC6q8s/bqxzWSSnIbtBdPFXOq/JHYvw1N+13QsWe1Yr9wZWhkr
         Nvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9c5WFc7U6zTXjrlhiVZtfgtzr3l/N/zum3a6S9gkYE8=;
        b=dplu97cl+MizXd3b/QuyREucjOlq2IZSUHMskF7XOOimRoCtk0FW8Au/9DGLifOeak
         SIJ61xbMhhsXFSc3JgLsrU0M/H8yJARKs4KWZArzL4CNUL3zp99q8bUzL9Sc1zcc44lp
         OyoIQLhBbZ280e/MdvjTUFRB1mcl9g9DgRrq82NYdfY2A0QXV6Bug+3F3lwsEusMdBgy
         qFBkq4XFI2HtvOC7cG78xshYjN6pn2zbRTpaLXlrsfXzlxgK9KF3TTcq1f53vaj0I7++
         p5t+FRSXag44taMqf4Z8uvjww/pgQIBZYTklEyLUkZJst29SZLi4yvCtQfwowRzbCMU1
         zYtg==
X-Gm-Message-State: AOAM533g2gRoySIliDKSGREZS7bhUdMaPmg3SQRbP9KbY5EYb7MotpGL
        xVEall6YkUcL3MY0ZdF9XFcgYw==
X-Google-Smtp-Source: ABdhPJy24UnGM7Z8N2w5Eq1VoE3RKa41iF21QECGwxIDrvqHQGElYtwGPT2VGIyrKkEIqxzwgZtktQ==
X-Received: by 2002:ac8:19cb:: with SMTP id s11mr20521359qtk.105.1592906918001;
        Tue, 23 Jun 2020 03:08:38 -0700 (PDT)
Received: from [192.168.1.117] (23-233-27-60.cpe.pppoe.ca. [23.233.27.60])
        by smtp.googlemail.com with ESMTPSA id b53sm141741qtc.65.2020.06.23.03.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:08:37 -0700 (PDT)
Subject: Re: [v1,net-next 3/4] net: qos: police action add index for tc flower
 offloading
To:     Po Liu <po.liu@nxp.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        idosch@idosch.org
Cc:     jiri@resnulli.us, vinicius.gomes@intel.com, vlad@buslov.dev,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        alexandru.marginean@nxp.com, michael.chan@broadcom.com,
        vishal@chelsio.com, saeedm@mellanox.com, leon@kernel.org,
        jiri@mellanox.com, idosch@mellanox.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        kuba@kernel.org, xiyou.wangcong@gmail.com,
        simon.horman@netronome.com, pablo@netfilter.org,
        moshe@mellanox.com, m-karicheri2@ti.com,
        andre.guedes@linux.intel.com, stephen@networkplumber.org,
        Edward Cree <ecree@solarflare.com>
References: <20200306125608.11717-7-Po.Liu@nxp.com>
 <20200623063412.19180-1-po.liu@nxp.com>
 <20200623063412.19180-3-po.liu@nxp.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <77323916-6815-4044-eff5-8cafc4950749@mojatatu.com>
Date:   Tue, 23 Jun 2020 06:08:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623063412.19180-3-po.liu@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This certainly brings an interesting point which i brought up earlier
when Jiri was doing offloading of stats.
In this case the action index is being used as the offloaded
policer index (note: there'd need to be a check whether the
index is infact acceptable to the h/w etc unless there
2^32 meters available in the hardware).

My question: Is this any different from how stats are structured?
In this case you can map the s/w action index to a h/w table index
(of meters).
My comment then was: hardware i have encountered (and i pointed to P4
model as well) assumes an indexed table of stats.

cheers,
jamal

On 2020-06-23 2:34 a.m., Po Liu wrote:
> From: Po Liu <Po.Liu@nxp.com>
> 
> Hardware may own many entries for police flow. So that make one(or
>   multi) flow to be policed by one hardware entry. This patch add the
> police action index provide to the driver side make it mapping the
> driver hardware entry index.
> 
> Signed-off-by: Po Liu <Po.Liu@nxp.com>
> ---
>   include/net/flow_offload.h | 1 +
>   net/sched/cls_api.c        | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index c2ef19c6b27d..eed98075b1ae 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -232,6 +232,7 @@ struct flow_action_entry {
>   			bool			truncate;
>   		} sample;
>   		struct {				/* FLOW_ACTION_POLICE */
> +			u32			index;
>   			s64			burst;
>   			u64			rate_bytes_ps;
>   			u32			mtu;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 6aba7d5ba1ec..fdc4c89ca1fa 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3659,6 +3659,7 @@ int tc_setup_flow_action(struct flow_action *flow_action,
>   			entry->police.rate_bytes_ps =
>   				tcf_police_rate_bytes_ps(act);
>   			entry->police.mtu = tcf_police_tcfp_mtu(act);
> +			entry->police.index = act->tcfa_index;
>   		} else if (is_tcf_ct(act)) {
>   			entry->id = FLOW_ACTION_CT;
>   			entry->ct.action = tcf_ct_action(act);
> 

