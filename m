Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895ACC2D0F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B220757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxUBFLQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgDBMbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:31:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35516 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgDBMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:31:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id k5so1782861pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cyyNKGr84nAUGth9V6QOSpSd2bcLsQ6KwbQ3bniVMOc=;
        b=NxUBFLQOrCSONkys5dj18c0oWyT3PVRqtiUocT4J6sk408ZsJkiQFYiGisTZTnA7Pt
         4Yp+HiDe+RcbSStekYBHPtkRiXZjm7gyOkmcrTpacSdc9W0KROFJKfPve3OROuVEoa/k
         iNDI0/JfgHpzbx/GQs/cLgTbWI7+cix1YxoJ9Sb7bGhR663ajMgWVMVRp3Zt0BwsLe6V
         GJdC9Oe+hJFmGnedqJzGrG+kosXGrjgW48beN9mQhC++U/NWagz/euGifdd2iS/R9VQo
         eBr1K35kZJgGXA4c4MQU2/jUnOGcLIJWgrLn435LWBwOi5UQS/r/ryZZoNZKIZ8Yuie0
         3asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cyyNKGr84nAUGth9V6QOSpSd2bcLsQ6KwbQ3bniVMOc=;
        b=QaVIuDUKPEJlszPrFyUadzTySdhLynsirXDssIAHbb6dQ2PeKI5nt0ht4LD+w9lugp
         qHO5g4E81uCPRrND4LF/JflZXhh7SE8LM25V3/0oOJ5GvV7VDPJG+zyjC+FYrDMQIetH
         Ov7RIom+9Vave803dokFUItchuM42DZvBlyuj8JV42shT6AKhdOcB/8HFoc9O5I7+9pc
         fN4DN1oxpKSK8AegVPgrFWnAQFgzCKxTtcqY5giy+VsguoM21cUe52dZj6O4JAVWp0M4
         zmXbLPprH58ZdKPKfmnRhZl/ga9s0KvmLgArQzTB8C5VdSU12eVUdiX6Kbl9l1nYlFgs
         7TLw==
X-Gm-Message-State: AGi0PuawwN+gCUwCq+5/Kc4GUvG8TEuDG3p0L1/8wsiqNDhqXqwFXzg4
        Spizy5NWAJrBP4bWbwI9E/MAeuqMPeo=
X-Google-Smtp-Source: APiQypIclPAW+TvtCRpdRlKa1QGKO7Wf1avFwXx+fvR7EnIBqlpHiZ8Lowr5mZmOzPPI+g/F8Fxyew==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr3016568pgd.357.1585830660482;
        Thu, 02 Apr 2020 05:31:00 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id p1sm3703112pfq.114.2020.04.02.05.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:30:58 -0700 (PDT)
Subject: Re: [Update PATCH] x86/Hyper-V: Initialize Syn timer clock when it's
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
 <20200402112137.GM2001@kadam>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <98c0deb9-1cb6-c73d-4fa1-cb587f30b9e5@gmail.com>
Date:   Thu, 2 Apr 2020 20:30:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402112137.GM2001@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan：
     Sorry. Please ignore this patch and it's based on the old code.

On 4/2/2020 7:21 PM, Dan Carpenter wrote:
> This doesn't apply to today's linux-next.
> 
> regards,
> dan carpenter
> 
