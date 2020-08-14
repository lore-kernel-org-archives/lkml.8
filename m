Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0256C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F0822B45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="o40fi2D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgHNVPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:15:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41946 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgHNVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:15:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597439709; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2qKj4SNXimMKoQyi+qljyl20bGjTHCPTKE/IaXeY4B8=;
 b=o40fi2D/QGoZB4+ayVBIYR8lU2cuH76wvj6NXo3p7S+r+cpeFxNvSpfoItLS7IgKBTEZfMOD
 wlRhqHM0e0lw0e9gTDrsVaqvHoSp/0jJEfSUpOTmd+5cqrplmHYfDsOfQG5i454ao2LUnWg3
 KCXJlL9TCc836vnptxZ2zNeM8xI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f36fecfd48d4625cabca0ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 21:14:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 072FFC433CB; Fri, 14 Aug 2020 21:14:54 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FBB1C433C9;
        Fri, 14 Aug 2020 21:14:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Aug 2020 14:14:53 -0700
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, swboyd@chromium.org,
        khsieh@codeaurora.org, seanpaul@chromium.org,
        abhinavk@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        Vara Reddy <varar@codeaurora.org>, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org,
        Chandan Uddaraju <chandanu@codeaurora.org>
Subject: Re: [Freedreno] [PATCH v10 2/5] drm/msm/dp: add displayPort driver
 support
In-Reply-To: <db6a4104ba9fc00edaf5542693ac6bd9@codeaurora.org>
References: <20200812044223.19279-1-tanmay@codeaurora.org>
 <20200812044223.19279-3-tanmay@codeaurora.org>
 <324d61b6-fc26-03ea-f8af-ff74a9767da2@linaro.org>
 <db6a4104ba9fc00edaf5542693ac6bd9@codeaurora.org>
Message-ID: <fccbdceaf64a1e50561c6e9ece46d0d0@codeaurora.org>
X-Sender: tanmay@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-14 10:56, Tanmay Shah wrote:
> On 2020-08-14 10:12, Dmitry Baryshkov wrote:
>> Hello,
>> 
>> On 12/08/2020 07:42, Tanmay Shah wrote:
>>> From: Chandan Uddaraju <chandanu@codeaurora.org>
>> 
>> [skipped]
>> 
>>> +		} else if ((dp_parser_check_prefix("ctrl", clk_name) ||
>>> +			   dp_parser_check_prefix("stream", clk_name))  &&
>>> +			   ctrl_clk_index < ctrl_clk_count) {
>>> +			struct dss_clk *clk =
>>> +				&ctrl_power->clk_config[ctrl_clk_index];
>>> +			strlcpy(clk->clk_name, clk_name, sizeof(clk->clk_name));
>>> +			ctrl_clk_index++;
>>> +
>>> +			if (!strncmp(clk_name, "ctrl_link",
>>> +					strlen("ctrl_link")) ||
>>> +					!strncmp(clk_name, "stream_pixel",
>>> +					strlen("ctrl_pixel")))
>> 
>> This should be "stream_pixel", I believe. I don't like macros, but
>> most probably it would help here. Also function/brace alignment could
>> be better (sorry, it really hides the issue here).
>> 
> 
> Thanks for reviews and good catch!! I completely missed it when I
> renamed "ctrl_pixel".
> Use of "stream_pixel" is very limited. So, instead of macros direct
> name is used.
> Fixing function and brace alignment sounds good idea insted.
> 
>> 
Actually I will reuse dp_parser_check_prefix utility. It's already doing 
same Job.

> 
>>> +				clk->type = DSS_CLK_PCLK;
>>> +			else
>>> +				clk->type = DSS_CLK_AHB;
>>> +		}
>>> +	}
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
