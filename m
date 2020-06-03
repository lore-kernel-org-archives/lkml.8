Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658E120679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB1J20VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFCKWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:22:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E0C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 03:22:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so1442806pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gywm26xbzcC5sdjTvVeyjB7NiVJ+nJwHGQ5uOCG0NYE=;
        b=vB1J20VFGewR4H/3VgNf96mwVbgrJhCTNOZQToO37jkblxQ8CWkPCmDTeoEzXtdN4r
         lEu9fVYygQXOsv3/MxY/Qr1iSDz8MLdOzcwWAS0gSkZbSPQrzDskkpgkWMJps0ALgL8U
         xbjgGk6Pt4wWNeRYBWKnpIwLU3stXsDJoAqaj0IskXM7acKqvA392vO7ccUDfrNHg7Op
         yYgBhQzWUo13glFGkIqFV7eVPXUq/ZnLHqc3Hhj/fPP/F/QAMCSH/onyKp9VkU7GzzXb
         y/A6JKQLAxf+wQcyOlnA2OD9/JJwQTCnHO49DQnjYDKRr0Eu/WoQ00ZuDbt7+4SenJaH
         gs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gywm26xbzcC5sdjTvVeyjB7NiVJ+nJwHGQ5uOCG0NYE=;
        b=VgcsxgL1NJDp3HWGJ94kxx/up8a87XZFFz0mQnYyTtp1fsoQVAejaO2fUtHDPBpfCx
         qmju9njfwIuys9yPoMkjrCxsaNxlu7oKOA4DcgXeHQp2tvWEm55HXyDAc9YHcfnKHam9
         x8D3tl16NhOhH/tNyO3h3vCz9/EMH3+UkyDt93nj3gLIYZZqfVNUjWS38aJw5+IjJCO1
         /wrd/vY0huf6l8J7C+jhV+s96ILcyxlB3w9y8I3pXELUJOvR+4P8v79DlltDwTYpjDET
         j4wkeL1bXL49xxQJKKInTMHzbKm7QtxN//2s0wxs1C4aFJACA/8agDu81uJpKYvvN06J
         XbCA==
X-Gm-Message-State: AOAM532SS3bgYI5oh40ZQ1dTZjjedZBLMGlUvMtBKPmwRPcjodrtXk+Y
        RQUldg2kcky3PrpxCvkXk2p9Kg==
X-Google-Smtp-Source: ABdhPJx7hGed1u73cga8aPJW4199IO02IItfgP1iacq9bOqJEYbhgjOEe5p1iizcRmE3PxyDxJMNRw==
X-Received: by 2002:a63:e550:: with SMTP id z16mr26873816pgj.92.1591179722363;
        Wed, 03 Jun 2020 03:22:02 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id 2sm1561645pfd.163.2020.06.03.03.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:22:01 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:51:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603102159.hzctwiqiukwhrpo7@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <20200603100727.GB7259@bogus>
 <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
 <20200603101753.GC7259@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603101753.GC7259@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-20, 11:17, Sudeep Holla wrote:
> On Wed, Jun 03, 2020 at 03:40:10PM +0530, Viresh Kumar wrote:
> > On 03-06-20, 11:07, Sudeep Holla wrote:
> > > But I have another question. If we can detect that CPPC on some platforms
> > > rely on CPU registers(I assume FFH registers here and not system/io/...
> > > type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
> > > flag name) to false if not already done to prevent such issues. Or I am
> > > talking non-sense as it may be applicable only for _set operation and
> >
> >           Yes, non-sense :)
> >
> 
> Thanks for confirming 👍.

Hehe.

So, do you agree that we better do the read from the CPUs themselves ?

-- 
viresh
