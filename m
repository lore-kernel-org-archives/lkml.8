Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FEA20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb1glgBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgBDHFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:05:24 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54366 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:05:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so926024pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5PoBe/LIYLPF7o11SYiI2aW+wfvhFdZMsKpXsr8Bdo=;
        b=Fb1glgBRu3fbQOC/zgG7Y4VjMCA8stpvNr50Txb+8JbWcrOWDzprownVQimEhveoj4
         42ZWZ6cu6r+49VQ3SDid3114jZmik+yTWU1e8vJJijU6sZ2tbmjYeUL3ZDbXqk5vg9Aw
         zHzuXk2YCj3DnOQt5uoXaL0T1ZtxFJgPY2dRvjugQvZ5c1G+R0rj3sK2qbUXTUyR9iTY
         Sc3B0ZziWPQGkYicJ/UEcGmwJ+FvPry/rIBmFVFLnAuvovoufWIp2fNetRZDMPjDqxXg
         Oyxio+189suNh0J7r5AKox4QzetQPaExRxFJmiVSHVrLPEYfcB9QTPgym8mXbAZZt65E
         DXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5PoBe/LIYLPF7o11SYiI2aW+wfvhFdZMsKpXsr8Bdo=;
        b=RNLBUokE7p/YmZRprZ1OowBnadAHfEqWyui6hCVM+6UYrBLtCC8MFZkVkHUPlg3qQY
         iXt0sVdWH0o+vLYjDVEC+/PwH0SUEQRsIwsgIRlZ5SDLcMgXWvbzeB/U2cm11TM3l2Q8
         5D8+BnhU1YK2HoUYhKElARiXOHN4fhRMC2qqBISftwwUdMSddNnci8N/2A5oHDE/8FGB
         g5j7R9ng1HE9F8khDJbOn5THT074tJrpfvTaUpkudQ2ZPp9WLq/JApDB93a8L1sntYKI
         jZGmUS7sobc8YBCM8G4SgHQVbUhB30/YUW5FbU1aKWvE79eWid9X8WTptaEs6axU/903
         jqHA==
X-Gm-Message-State: APjAAAU6dENglTTmPbN3m2A06RAeiO6Crh0K85NxKjvuQ847S7R2tMZD
        SmLKu6JlO+eFvdy10mUMUgqE
X-Google-Smtp-Source: APXvYqyEsp5NPX+idnfyOkW2uYsdtJuprUa0EiaAoIlzWdgQ3xu7qx9G7UUKaD87ZSkSp+++e8WU1A==
X-Received: by 2002:a17:90a:d995:: with SMTP id d21mr4502095pjv.118.1580799923596;
        Mon, 03 Feb 2020 23:05:23 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:184:5239:5cf8:8075:e072:4b02])
        by smtp.gmail.com with ESMTPSA id k4sm22952117pfg.40.2020.02.03.23.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 23:05:22 -0800 (PST)
Date:   Tue, 4 Feb 2020 12:35:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 13/16] MAINTAINERS: Add entry for MHI bus
Message-ID: <20200204070515.GA7452@Mani-XPS-13-9360>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-14-manivannan.sadhasivam@linaro.org>
 <CAHp75Vc2Nf9N0cPBmrqb_xZQG-=eczd=gdZxsfXv6OtZ=ysP6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2Nf9N0cPBmrqb_xZQG-=eczd=gdZxsfXv6OtZ=ysP6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Feb 03, 2020 at 12:16:16PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 31, 2020 at 3:53 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add MAINTAINERS entry for MHI bus.
> 
> > +MHI BUS
> > +M:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +M:     Hemant Kumar <hemantk@codeaurora.org>
> > +L:     linux-arm-msm@vger.kernel.org
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
> > +S:     Maintained
> > +F:     drivers/bus/mhi/
> > +F:     include/linux/mhi.h
> > +F:     Documentation/mhi/
> 
> Had you run parse-maintainers.pl afterwards to see if everything is okay?
> 

Hmm. I didn't run it before but now looks like the entries need to be sorted
as below:

M:      Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
M:      Hemant Kumar <hemantk@codeaurora.org>
L:      linux-arm-msm@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
F:      Documentation/mhi/
F:      drivers/bus/mhi/
F:      include/linux/mhi.h

Will address this in next revision.

Thanks,
Mani

> -- 
> With Best Regards,
> Andy Shevchenko
