Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE69C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C464F2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbY2Dpz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgFCKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:10:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BBC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 03:10:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z64so1316293pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMA8UswHoR10ZkKb/xOBjfFah7opSPUF3++8T+IfxFs=;
        b=bbY2Dpz1nYTTpJmtv4MB4qZePaCtWdI2q0cWL16Ks+j0wZKR8/5Ks5hu4TPVUai1sr
         RYBRPO4yT9Wwkur4+WZRMT1CZ3rIvVrNEiparBSnRiDOx4HgDLldQ26qvGo2mgR+70MW
         +qD6UM9LZC1GqAPuvv3Om2jH99di6UMYJtvICVhDyQ4cVkXchRRpGdZhQT+FMPbg0Vif
         oDnFjOudHWJwuHzUq18DbSfR/TV442MJ2N/xa6Ch/Uj4O27wgsOLZVlTXb2zyu5hALVQ
         c7WL7a9RDlgB9qnUGHusQ+Ygqo9gzRZVMX/faO5lc1xArPgKQdwoA24EsDHFVvKxrTDp
         QyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMA8UswHoR10ZkKb/xOBjfFah7opSPUF3++8T+IfxFs=;
        b=OrazwTabj3Y88IygtC+FaCTK1WL+dV2slDyc4euOh34HYSIjo+TuJw83AX5HHVCZcQ
         nStlomE2sBK7p+FxfD/C8IdQ8QUClxs3J6Dw50pRq9YLK9iSfyE4ufHT/o6htBuk19UX
         tHFKjwcx1hJxmdnMhmgrIz8ELfYuwjT9S15+si/rACIFeYNDckJecm27vbYDdnW5bVKH
         QIzb5BATnitC12zIexhiLDqttpILBQMXHjERzKWkCZYtWMEt3WfYLmFEYZp9jhlNfjCT
         rblaMw+ZB8RHwp0kmsl5hk/yqSDCL7YCBJ6isfy1qEZDgxCLNAtIs5kl72zTIRUX6cfo
         hrxA==
X-Gm-Message-State: AOAM530XfS149jKbu4QFkZEVrBtxX+LTCq+/gq7wvVuUyH7URD0VW86+
        ZauaDxoUeuL1PhPYxftcmUYR1A==
X-Google-Smtp-Source: ABdhPJxkZFOpVSUQKBvnC0ohU+GJ++eICExvZmctfWCbjff/g0JyLwrXZZFZxU+HAISkO3HyZGHNww==
X-Received: by 2002:aa7:96d7:: with SMTP id h23mr14182341pfq.320.1591179013326;
        Wed, 03 Jun 2020 03:10:13 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id w6sm1947722pjy.15.2020.06.03.03.10.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:10:12 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:40:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <20200603100727.GB7259@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603100727.GB7259@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-20, 11:07, Sudeep Holla wrote:
> But I have another question. If we can detect that CPPC on some platforms
> rely on CPU registers(I assume FFH registers here and not system/io/...
> type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
> flag name) to false if not already done to prevent such issues. Or I am
> talking non-sense as it may be applicable only for _set operation and

          Yes, non-sense :)

> not _get.

-- 
viresh
