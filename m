Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A23C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2702078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK+7kN6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHMRDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgHMRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:02:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BADC061757;
        Thu, 13 Aug 2020 10:02:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so2876534plb.12;
        Thu, 13 Aug 2020 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w0HX6Ms7J59aY7v+H6lsDXSO/qCU5OzjkYB+jXfYoQE=;
        b=QK+7kN6y7ySnkdkMTMLiLdrZA7aKAudDtauIMVgYHTB0n2KN3padLuBo9edFkbl4Q4
         fYffiFSUzbUv2Z81C1j8IC47C3r1o8gJIo7LcmRGIMGhHxDMdPzOmJC9msICB4IOfmV3
         b1abdjmH6U6RYI0/Uxsz0I6/ebSXcfIiDi8/+WFcO4ZX85iz8BnecoYgOLPnv98kPsri
         HJbHxpQpwdYMwOiu5Wots6k6KE2ji30cZsjHrGeodQl6Wj9tJfKJ3OzitmNaFl1GZJ1X
         30dMHXtXskfq3/MFla1cYMwHfRgPUYlaYYjJGhTi/UzccmXCbe7Y+nyOme3hbms7kuUW
         Lp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0HX6Ms7J59aY7v+H6lsDXSO/qCU5OzjkYB+jXfYoQE=;
        b=dbUtJK0jbGFsFTmYXH2REPk95XR2ppMAOnpsXi3OAePfWhD0PYmbQLJrGRBrDXiU/l
         qLyXB5dNoP6fLWsB7qoejOJtr3I3jQR7tVf8eFG905pDXZpF+kfq1BNI6Tfao+uPK7if
         ztGGfXieEb0sS2t6Qd7PbWe6nukVdWGGpDlcwq3Ww5P65o1LykRavWNkRmfNTW+EIa7M
         SaTdnOLZZZeAN4SWpSE/ggwtLoiESNd8l9QHutc5XeEeszy4ERXlXmHQZYG2shuwerOL
         KidEID8Y7KEonFNa73s3y3gDiVZ9IezpAmPnwnZd0F75EAsJBrnJWrRo1Ith166teFbs
         daLg==
X-Gm-Message-State: AOAM5322wLmwDtDcDREpGTI/sg+iaGho35NDBaA0KRbUd8owZ8hMiYad
        H6Tv9FIf4fi6khdBUKQUlWwVnAkF
X-Google-Smtp-Source: ABdhPJzJP/15Zem7Le6v8YgMOGYIN7zSd+czft4LonweRh71EHvEmXTaITMNh/3Tu8nIh8fAwf+H9Q==
X-Received: by 2002:a17:902:8347:: with SMTP id z7mr4779952pln.20.1597338168631;
        Thu, 13 Aug 2020 10:02:48 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s61sm6020005pjb.57.2020.08.13.10.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:02:48 -0700 (PDT)
Subject: Re: [PATCH 08/14] mips: bmips: add BCM63268 irq definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        robh+dt@kernel.org, tsbogend@alpha.franken.de,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200812063129.361862-1-noltari@gmail.com>
 <20200812063129.361862-9-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <46445978-d169-87fb-bdf6-18c1c61f4d8f@gmail.com>
Date:   Thu, 13 Aug 2020 10:02:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812063129.361862-9-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2020 11:31 PM, Álvaro Fernández Rojas wrote:
> Add header with BCM63268 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
