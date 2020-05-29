Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7CE204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="LBMcOJog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE2G5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:57:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47232 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgE2G5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:57:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590735425; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5iWcCbiGZvVMQ5YMmDXPCoC0HJ2lp8gKX/3kGxQlqf0=;
 b=LBMcOJogjveTf3sWp4l7C0b4OVtbPKkM95KgpcxoMDXfCZFV9uIfy5MGyMwqqofptQdVVqrG
 Mok7XWFmovEvckxvZnOrrmFH+UMtkPQleg8YOsBdeDg2WlQdwHdOdbqh96stIZuLC3TDohwJ
 Xn/Y1tWNAXsNKF3CQqd8U6C5TCk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ed0b233809d90496789b20a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 06:56:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 954CAC433CB; Fri, 29 May 2020 06:56:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F38B0C433C9;
        Fri, 29 May 2020 06:56:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 12:26:50 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 08/10] clk: qcom: Add graphics clock controller driver for
 SM8250
In-Reply-To: <20200529011127.GJ279327@builder.lan>
References: <20200524210615.17035-1-jonathan@marek.ca>
 <20200524210615.17035-9-jonathan@marek.ca>
 <c4d43cf01b6d014fdc2258abb94eb2c5@codeaurora.org>
 <20200529011127.GJ279327@builder.lan>
Message-ID: <dbcb5c24f8888d6b0cfc63a80e310319@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2020-05-29 06:41, Bjorn Andersson wrote:
> On Mon 25 May 02:47 PDT 2020, Sai Prakash Ranjan wrote:
> 
>> Hi Jonathan,
>> 
>> On 2020-05-25 02:36, Jonathan Marek wrote:
>> > Add support for the graphics clock controller found on SM8250
>> > based devices. This would allow graphics drivers to probe and
>> > control their clocks.
>> >
>> > This is copied from the downstream kernel, adapted for upstream.
>> > For example, GDSCs have been added.
>> >
>> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> 
>> Since this is taken from downstream, maintain the original author's
>> signed-off and add yourself as the co-developer if you have done
>> any modifications. Same applies to all other patches.
>> 
> 
> I disagree with this.
> 
> As expressed in the commit message, this patch is based on the
> downstream driver, not the individual patch.  As such, the _patch_ is
> prepared by Jonathan and by his Signed-off-by certifies the origin of
> the contribution per section 11.a or 11.b of submitting-patches.rst.
> 

I lost at the downstream driver vs the individual patch here. So the
downstream driver is also an individual patch right or did I get
something completely wrong.

So if someone prepares a patch and includes a commit description
saying it is taken from downstream, does it mean he is the author
of that patch? Shouldn't the author be included in  "From: Author"
and his signed-off appear first before the submitter's(also a 
contributor)
signed-off? Or is it because these clock data is auto generated and it
doesnt really matter?

> 
> Regarding co-developed-by; this should not be used when "forwarding" an
> existing patch. Per section 11.c the contributor should add their
> Signed-off-by to certify the origin of the patch. Any modifications
> should be documented in immediately proceeding the s-o-b, as described
> later in section 11.
> 

Yes makes sense to not have co-developed-by for forwarding patch.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
