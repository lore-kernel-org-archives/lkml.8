Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE69207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWUptrz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:26:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39060 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:26:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so6121844pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a0thWxtcKc9YM15dZdbAE3AeXYoB4GtLK4BXGH2HS3E=;
        b=iWUptrz+rNTUSdgrIRAaDyg1wkGN/How5iOmIQtXnA+jPIGeiZhPadCACKCjLh+UdI
         WxKjQKzxmjkL6/Zsy1BwmOlbmo4VXPq1rBW0+LJROYG/YnXFIbWvCL72qMUHf9a3X5g5
         NaIpJsuBc3rBj9hI3Gdn5Eof6SoTsve7Zv0BOg0SU7TUfnjlnj0hp2aGWNE4nBQkvwrO
         qzlU+6xoeum4A6lXhFclsUDbm+OWMbVr9V/mEgZUFWxy5i5tXt5R4w6IHKOjyHIsCFND
         Jjvapz5RwQSE7KEphcEHhWiWpuM9fL6x3AHSMX1uERdIKh8NPjnNXhEKIbC5j5qBDU8x
         ZUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0thWxtcKc9YM15dZdbAE3AeXYoB4GtLK4BXGH2HS3E=;
        b=mIyOMzreYOoVUdOJrJntmV6RnxRwAZqWz7rWRN/lQ8Iz34XNQ5cWbDJr9uaL8LJW+3
         OwGwnY6E1xF65QQrQ6aQ+azFE/J/mvnGNfO2MIGErHXrey0DT+Ks29g6poo38pQk3zBs
         Dq0+19pkzPj7HEAGFbNsS/BxcZRmab/DGtlmJTyQcFmAQIr8raxUYZYxribF9i9Womzb
         ZgbT9l6BketfPnVeSrG4HhEAmfN/lbnErOZq+4F2N/S0m0k9KuAVrjykwi7nwDgS9uEH
         A2HO7vlW8WR+qNGqgeJikcnV1LjmtryHwkPLy3Pp09sksAArpAeA9FszANicbXGcBta8
         4FeA==
X-Gm-Message-State: APjAAAUZNXX2VKNJyrU3mmP9XnvWp2gqUKq+JyX9KtUi/PNo3WSTavSg
        GNDT6fBkt3OO0GvKXAW4kdYEfQ==
X-Google-Smtp-Source: APXvYqxQobfYo6GwcAO4bk/IVTqj/Zk0rz3y1sjNS0OlQ8+mVGPrXLr/Ip2uSae9HdvrhPxLlMbgtg==
X-Received: by 2002:a62:8202:: with SMTP id w2mr24834647pfd.100.1578993979012;
        Tue, 14 Jan 2020 01:26:19 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id 200sm17798271pfz.121.2020.01.14.01.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 01:26:18 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:56:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7>
 <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 12:36, Arnd Bergmann wrote:
> On Mon, Jan 13, 2020 at 7:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 10-01-20, 12:15, Arnd Bergmann wrote:
> > > On Fri, Jan 10, 2020 at 10:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Simply dropping the __iomem isn't much better, now you get other
> > > type mismatches.
> >
> > Right. So what exactly do you suggest I should do now? Drop __iomem
> > from the structure's payload field but keep all local variables and
> > function arguments with __iomem ?
> 
> > > > +struct scmi_chan_info {
> > > > +       void *payload;
> > > > +       struct device *dev;
> > > > +       struct scmi_handle *handle;
> > > > +       void *transport_info;
> > > > +};
> > >
> > > Maybe you can wrap the scmi_chan_info inside of another
> > > structure that contains  the payload pointer, and use container_of
> > > to convert between them?
> >
> > We don't need to convert between the two of them, isn't it ? Are you
> > referring some other field here ?
> 
> > > It's not obvious which parts of the structure should be shared and
> > > which are transport specific.
> >
> > All transport specific information is kept in the transport specific
> > structure which is saved here in the transport_info field. Is there
> > something else that isn't clear ?
> 
> To answer all three, what I meant is that the payload pointer appears
> to be transport specific and

I am not sure if I understood the below statement properly. Is there
something missing from it ?

> should not be part of the common
> structure if there is generic way to access it.

The scmi protocol requires a block of shared memory which is
represented by struct scmi_shared_mem, and payload is this memory
block itself. This block of memory is accessed throughout driver.c
file using ioread/write commands. If payload is transport specific, so
will be those accesses, isn't it ? Are you suggesting to move all this
to mailbox.c (the transport specific file) instead ? I am sorry, but I
am not able to understand how exactly you want me to reorder code here
:(

@Sudeep: I had a question for you though. Looks like we are doing
ioremap() of this payload for every channel's tx/rx, why ? Why is the
same memory area mapped that way ? Can we just map the area once for
scmi block ?

-- 
viresh
