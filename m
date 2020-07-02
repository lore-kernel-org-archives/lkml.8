Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2027EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C8220747
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaFKyhxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgGBLJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGBLJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:09:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A5BC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:09:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 67so8332332pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yhigYLbWyjdsAB9RV5ESFpQHrd9hYU8lMH15hyZFCnY=;
        b=QaFKyhxf8DWdqHCoBR7wcAJtJhSWTLmOq73EfJeILfgTPQ+r3lbxMvn0QaFg3H4Jor
         kGAGOuAcCDAzQ1pdqJVZ1K+T4iUVnXee+e7lNdaSh8vcgakDnO9X8VjkkxDz8StU4IZ5
         UFYInc7MKK4e1QfOyuvMtr2CQ0wqdRikn5X2IJanxG1ckNW/VlFmZ9qGV8eKVl2abN+v
         C5Js25yWSxkq5Hqu5q2ccV7TqXoTnO07k4NTTzGE3VRUx4F5uIT0Piy2CcH22Ra5V4nr
         4pzuEZx7sVsGblioXc4LUHpXko5GcQag+5UB10RQlOvnLAiWx9uzfUpSYQ4K8Hi37/Kq
         Tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhigYLbWyjdsAB9RV5ESFpQHrd9hYU8lMH15hyZFCnY=;
        b=l72v81AtLoTpYARWfjHaF7bKKcVlmok0jxl7Ier3q0TwBRe8elApzbkYdRamHqEML+
         zrZAno71SqKfRfYj/I3HATw1DSAB922PQJxSdfDspHUJvrJAacLxGnCuqYKJuThjqhKs
         tp+FYYxmB6cDXliLvv+nvrLlp+wLhAmPBVwh12ojZ/Es6IXdFYS0n5ohYTDDUn+tPAml
         uL8C1Y4XfTA/tw7nEL0gCdD8BrHkErOhTzMwznLNjmgxRdeaWywT0L6cM9NfE+3/rYde
         JxQtnoiyiTiH5KfGdjtJfKvUXjxVvZ0mUm58UYqZg487JY5rTZlkpUuWRt/+wGZLHQe2
         Ow9Q==
X-Gm-Message-State: AOAM531wCmyWCHE2Sx4Iqnz4d01wHBfxMzUPWSgVi3VDBhJhu+D0mgw3
        zfLMbUMJIe8+gf4FfyH2XyyEnJgF0zk=
X-Google-Smtp-Source: ABdhPJxlVNCwXfn6C22bczd8Htuqow4Tvki3nCCKWAYtAYbsfI1TaTlyTODZ4a2UqF61DIaleZyzWA==
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr2527763pfi.145.1593688162280;
        Thu, 02 Jul 2020 04:09:22 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id i125sm8602401pgd.21.2020.07.02.04.09.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 04:09:21 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:39:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200702110919.qejdmao5uuodftk6@vireshk-i7>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
 <CAJZ5v0iRW25n9CqvJ=ODbVh2osocx+wJVz62GqaWV9m4sdL12g@mail.gmail.com>
 <20200702023746.li2uf4zl7bwzg62x@vireshk-i7>
 <CAJZ5v0jbsinLBZqNiCPH0NFk0b8H4Uxuf8U5y0R5nkxUH8tX8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jbsinLBZqNiCPH0NFk0b8H4Uxuf8U5y0R5nkxUH8tX8g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-20, 13:06, Rafael J. Wysocki wrote:
> But you could respond to the "applied" message from me. :-)

Haha. I was expecting you to pick the other patches (around governor
cleanup) from me and I completely missed that you picked cppc one as
well. In fact, I had to go to the thread again now to check if you
replied at all :)

Sorry about that. My fault.

-- 
viresh
