Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C6CC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A888D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8+l/1SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgAMGmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:42:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42062 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgAMGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:42:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so4209293pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BpLUIBBpeUpV1O+9thahetvf61yecpH01T0vJhinKFM=;
        b=b8+l/1SJZQ3yqeJbUvB2xZMyvwiAY6T5D/jZU1adrI6P5kstOLvvZxqhCmkqIwuMep
         sYKEoCzAVeb9IMtcgLMsRlZGj/Njlq+d8Reds/98X5aiMgm3JbziB4SEIwRTkn0+NR9m
         g0KXWevccqv+j1L3ZxtD9evMLz1YZLLTdTSKLRv0pvzSjgHwIL9RmOYo3q/zJDPB0H9S
         xJ7tNU7F6sI2NVOnd606kh9pY3OCZHfIt0oXCLajWOGjWkZp5gqJsLC/fp2f7iHSMkkz
         E2NrmdpyzOj05r/NtlH0SGWLXV4Gzs7spPbOr4zoKiylBRyVGa+XozPgSQKxpvzQ8KdT
         T1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BpLUIBBpeUpV1O+9thahetvf61yecpH01T0vJhinKFM=;
        b=R7+EoTk+fy3Hg3js60++DYMS2ZaN9R4JYH5Q5HBCRMzBYIoDrAsJREC4lMJbtgu90q
         F7JAi+bldJU/dBv3wiHW1IkfgVdHKMJS7kt3t5ygawqpEDZrrwcjl59DaWVcn8a/goxK
         ZdQiuR3mfnNVyiXBCeQWFMIUdZX7cC2fDYaI8346HAcOYEPkem50YoyQ6uE1U9wPen6j
         4l5qCmbSJWoLdyhuNOvaYtST5Lnu5pbcJzF6FzOWO158o5CSnpEp01WWI64RyVaPMxuD
         C1WkqzinqrQ/T8/8XKQuf/TE+/vCr0Lds60oQoVAo81kSl3qBhznZDdjIih6MSvjxwvD
         TWQg==
X-Gm-Message-State: APjAAAWqHEP8VKDB2XM59lqu2BysU1CWfJR0oPu02JbIqeZdGgwVZ3VN
        h0HH/qLO55XMnLKChDTVHact5A==
X-Google-Smtp-Source: APXvYqwOSzh97zQUsBMR/x95EQQ3mxh4f6F/syhe9m9gMY6RlQr3rBc1Dwifd8mJceoMuBatWTlEIw==
X-Received: by 2002:a63:f70b:: with SMTP id x11mr19369380pgh.80.1578897721592;
        Sun, 12 Jan 2020 22:42:01 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id d3sm12151329pfn.113.2020.01.12.22.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 22:42:00 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:11:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200113064156.lt3xxpzygattz3he@vireshk-i7>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 12:15, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 10:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The SCMI specification is fairly independent of the transport protocol,
> > which can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent of the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the
> > mailbox transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI
> > messages, some of the transport protocols getting discussed currently
> > are SMC/HVC, SPCI (built on top of SMC/HVC), OPTEE based mailbox
> > (similar to SPCI), and vitio based transport as alternative to mailbox.
> >
> > The transport protocols just need to provide struct scmi_desc, which
> > also implements the struct scmi_transport_ops.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2:
> > - Dropped __iomem from payload data.
> 
> Simply dropping the __iomem isn't much better, now you get other
> type mismatches.

Right. So what exactly do you suggest I should do now? Drop __iomem
from the structure's payload field but keep all local variables and
function arguments with __iomem ?

> > - Moved transport ops to scmi_desc, and that has a per transport
> >   instance now which is differentiated using the compatible string.
> > - Converted IS_ERR_OR_NULL to IS_ERR.
> 
> These look good to me.
> 
> > + * @payload: Transmit/Receive payload area
> > + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> > + *      channel
> > + * @handle: Pointer to SCMI entity handle
> > + * @transport_info: Transport layer related information
> > + */
> > +struct scmi_chan_info {
> > +       void *payload;
> > +       struct device *dev;
> > +       struct scmi_handle *handle;
> > +       void *transport_info;
> > +};
> 
> Maybe you can wrap the scmi_chan_info inside of another
> structure that contains  the payload pointer, and use container_of
> to convert between them?

We don't need to convert between the two of them, isn't it ? Are you
referring some other field here ?

> It's not obvious which parts of the structure should be shared and
> which are transport specific.

All transport specific information is kept in the transport specific
structure which is saved here in the transport_info field. Is there
something else that isn't clear ?

-- 
viresh
