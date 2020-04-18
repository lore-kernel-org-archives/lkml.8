Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCAFC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBE6221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Qehbzq/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDRJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgDRJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:01:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E4C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:01:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so3776341lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=v2r1LNfcfZSMQjP8dr2xBneKdKcMoniQ02EHOw8mPkg=;
        b=Qehbzq/lwAQz4mxTlNzPxp6RB0mgqSy6uthfto33Yze71yukx+lvwUC0wtejhWPCrB
         ZR61llSdswVXVylEAI0rCx9MSdy836jyhFHESLcLn/3O6xufpGPw8Q3mEhjvTON1BAQn
         OWcR3LP0XXCqINT2trWlumMb9ADMtQLqZnEfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2r1LNfcfZSMQjP8dr2xBneKdKcMoniQ02EHOw8mPkg=;
        b=P+IriShHQzScdJ5lAYl9Fwn9ynFUKPGzoGiBbE9i7qOA1bJ/aQIIZ+KV1q1irMvvvh
         N2I/32PPVAzzXLd0hsXFAaV+tNOxk1QOHn19GBh6553u0vtBNaM8O9M+iJVgWAKSWply
         GQVhIGV1zt7A16i6ubaKAY1YQyw4MK9FmhNutFpk02pfhMzTzS2EL1znCH2DuhstGNS1
         56PhGvYwg2Xpe7hy0s8kJV0Xw9KRC/LdmDQGy73nkargyIUwRSTXbmQ49wmZYYP1RGVJ
         q8+twlWjiLzOJgz79xrfZAhObX+2PZzFcwpFpfQE/ToPQSvWTA2MRsREoK2dqkhTLuCK
         OndA==
X-Gm-Message-State: AGi0PuY1FiKEj/AZTxoHQX8hZ+2I7ExyvGRIN4f+ckcgroRwAZPRtj+W
        abDfcuLo9GGVQ/3lwfH+GjMZYw==
X-Google-Smtp-Source: APiQypJB7StCrR9XTUXa/d7LPRLIwRuUYoumhbZUVEivdD5SyjUZLN5f+omoQA5zGMpiIA17F4dZcw==
X-Received: by 2002:a19:4014:: with SMTP id n20mr4332985lfa.6.1587200465617;
        Sat, 18 Apr 2020 02:01:05 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id q16sm6063952ljj.23.2020.04.18.02.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 02:01:04 -0700 (PDT)
Subject: Re: [RFC net-next v5 0/9] net: bridge: mrp: Add support for Media
 Redundancy Protocol(MRP)
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <59ccd697-3c97-207e-a89d-f73e594ec7eb@cumulusnetworks.com>
Date:   Sat, 18 Apr 2020 12:01:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 14:26, Horatiu Vultur wrote:
> Media Redundancy Protocol is a data network protocol standardized by
> International Electrotechnical Commission as IEC 62439-2. It allows rings of
> Ethernet switches to overcome any single failure with recovery time faster than
> STP. It is primarily used in Industrial Ethernet applications.
> 
> Based on the previous RFC[1][2][3][4], the MRP state machine and all the timers
> were moved to userspace, except for the timers used to generate MRP Test frames.
> In this way the userspace doesn't know and should not know if the HW or the
> kernel will generate the MRP Test frames. The following changes were added to
> the bridge to support the MRP:
> - the existing netlink interface was extended with MRP support,
> - allow to detect when a MRP frame was received on a MRP ring port
> - allow MRP instance to forward/terminate MRP frames
> - generate MRP Test frames in case the HW doesn't have support for this
> 
> To be able to offload MRP support to HW, the switchdev API  was extend.
> 

Hi Horatiu,
The set still has a few blocker issues (bisectability, sysfs error return, use of extack)
and a few other cleanup tasks as I've noted in my replies to the respective patches.
I think with those out of the way you can submit it for inclusion.

Cheers,
 Nik




