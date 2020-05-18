Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFFC207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewfOGWB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgERHnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:43:13 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1406C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:43:11 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id z3so2155971vka.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6Fz3grvmOGwKwIiO4rhQMwdNkIsWum4LGUtO8Cm5uw=;
        b=ewfOGWB6Q7IULYGZK2jjnw3iboiuUrKM4DhV+jFlpFQFbRA5okIM4q8ZPinJzBHjXj
         mZ8stSwg+I6/BDqQjXwU4TW+9EeA+Q7dqV33iVJT0cve85sXWZG2GKOpnbC0nazeavQW
         uD2K/aYltBH+aRgSHhQ1GL6tt1ZIiWAL4BbjgulNzJDXYao6iYmk+zspziWyeRWKizew
         1t4Gx5iG9noNUfjxFQFcIDzuUeLU5VzKWkU1jnKq1/hM4tpV42WBA0gJAyuNTAXhKrFY
         RYMcv8p3mlOBIESVYnhQ6bKiAIpTClAWAFOGYdQn8AgUml92+/lQy217nSP+eIF6Mf1L
         XuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6Fz3grvmOGwKwIiO4rhQMwdNkIsWum4LGUtO8Cm5uw=;
        b=sLZ06mMtm73RoVoX68WCAomwYoVdnpsRV5LJjRFCrQJvM5JF/U4tYFdmKF3GHrqnKP
         /HTMmucj0XKWOtWg6+3rv41eGbcCE4qjr/jL44GE1fDUeLCk+n0l4SgtyojxVCCZttPD
         F5DSIP7xC/gyqaH8DZRDgtgxmEd5Xo7dwCjytl2REs9FoEs6O5wwnGKlYDq7HryZ32IQ
         p3iva33P0qyGPrvQfqndO4HJ/TbuvD8lOjlak9VeiJaB2Wtpjp+I8ahrw5x/bVVkiLS2
         yWdxq9BCD3540Q/vJKCfuvuEfhJ/oHNu7Wp0eEuDDq26Ia8IpD1SLUIUPnHDnzPO1eft
         arbg==
X-Gm-Message-State: AOAM533Ww6s+eTpUKqImk4Ua/qAjex7i7F9XFB3Yo4AV8n1iZWwMzQP+
        /ETAc9ZBtGfEYvhPsgi702hF7cD4tmE=
X-Google-Smtp-Source: ABdhPJxwPIzeEsdVfsAIZTCk/Z/xP8GEG1alivNq3g2OZ4I1NIJDYth9EiNk49gcYQ9Lcgb+XKFKAw==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr13873074pls.275.1589787317608;
        Mon, 18 May 2020 00:35:17 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id b74sm7021330pga.31.2020.05.18.00.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 00:35:16 -0700 (PDT)
Date:   Mon, 18 May 2020 13:05:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200518073514.tjodf6qxg3wjzyb4@vireshk-i7>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <CABb+yY1wJMzakpz0h6ZxAh4Z3OB718f+Wq3RP0R4NZ_U=vRMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1wJMzakpz0h6ZxAh4Z3OB718f+Wq3RP0R4NZ_U=vRMkw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-20, 11:46, Jassi Brar wrote:
> As I asked you yesterday over the call, it may help if you could share
> some numbers to back up the doomsday scenario.

Yes, I have already asked Sudeep to get some numbers for this. He will
get back to us.

> > - With the current approach it isn't possible to assign different bits
> >   (or doorbell numbers) to clients from DT and the only way of doing
> >   that without adding new bindings is by extending #mbox-cells to accept
> >   a value of 2 as done in this patch.
> >
> I am afraid you are confused. You can use bit/doorbell-6 by passing
> 0x40 to mhu as the data to send.

That's how the code will do it, right I agree. What I was asking was
the way this information is passed from DT.

-- 
viresh
