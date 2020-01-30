Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DBC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797152082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkqC/jdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgA3EVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:21:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42583 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA3EVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:21:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so795201pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jhh4QgLWyaoYG8HAwtQ4AQhj4HFkJJcmjwzfU/Y1O+4=;
        b=MkqC/jdD5ZsDZmSULeKNrUD+fwzcx0l5j4gt27QA0CPLXUPT63tYapSetcx4Jflovb
         OIEyfkl+TQ/cv91KYNDm0Vp+cuzOmMeCabedE8Yhvcpt0OaUATGZFe9jJ3wZHuLqlIWa
         4NUyBKxvo/R5afw9Y+pV/GgtR0Rmr23dYPosWwoAEwVnfsZzOpn3B76eeubqM71TtoxY
         uq7lBrnDK9i2CC1bGOhs+ezMLM6uCpvfjclgfvkIw0sV3BgPALSKvPftW6tdOkf2fxcX
         haB75aSlAwY6BDja4yc2etMTSlpFimhgPsadJH+1NvpnkuTw6SpuieB6cB+CmV3VQer5
         EORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jhh4QgLWyaoYG8HAwtQ4AQhj4HFkJJcmjwzfU/Y1O+4=;
        b=MBGX8/I/Lby4rEGlWPcXcol4HnjWk1gpUZqLVx7DX4jWBCmdaK0s/Et9oVaG1DDqD/
         wIF5hZyNlCysE8oI3G0YtoHlcsyX+xRpks5SrA+plLeRQ3jUrGYx5zREltGKA8ibHq+W
         0c+hlUjCZlFo21zZo0wJLfanqLmmL3YSBsuxOv8cBvVapMPHVBmzwOt3J4r3J6T2GLbK
         b4PvJRhYeWFTt0LSOTOxgAtgRP3SWI+0zn1POV5z8NMPKe61zaMJ54dSHxZsqeY3JZ2X
         xV6li1pFMboFywxavlga1BH7AzcwJ57Kmrx84I6S+U8mcs+beam2SBT6E0USYcYcpSHm
         eCPw==
X-Gm-Message-State: APjAAAWeIGVOO6B8Y5YrAMhyTKKlX70p6WcMIl6RWk6fjhR64LIg9aLG
        fdAC2Uuu0FvnjpAG60BenDwXS/rjic4=
X-Google-Smtp-Source: APXvYqxth7XbsK5bbuSd8tnRy7pwS+h2pI5149XunMRDZJGJi44uZDJ5EJDkQ1uB6UTdZSDqQwahrw==
X-Received: by 2002:a65:5281:: with SMTP id y1mr2579435pgp.327.1580358089558;
        Wed, 29 Jan 2020 20:21:29 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id k63sm4296235pjb.10.2020.01.29.20.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:21:28 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:51:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-20, 19:04, Sibi Sankar wrote:
> I don't have a gen-pd use case to test against but with the is_genpd
> check removed it works as expected when I used it against this
> series: https://patchwork.kernel.org/cover/11353185/
> 
> In the lazy_link_required_opps fn shouldn't we skip the dynamic
> opps in the the opp list?

Tables with dynamic OPPs should not be there in pending_opp_tables
list and so that function shall never get called for them.

> With ^^ addressed:
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>

Thanks Sibi.

@Saravana: Can you please give your feedback as well? I don't want to
push something that may end up breaking something else :)

-- 
viresh
