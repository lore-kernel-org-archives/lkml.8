Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D3C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BE32078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmq9EUdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbgDCNIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:08:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33146 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgDCNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:08:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id 22so7211674otf.0;
        Fri, 03 Apr 2020 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tU19EWZx8u2e2uV3dXR0FXwxIY/5U2XJW8CrROjNUIg=;
        b=fmq9EUdhdn++eKwVsAKvmtE6dEOtCu87AzVYsS8RdLDIW9lhNi2aEJOROLq/8YC0cp
         0NtDqpQaHOt02earYciLZFbMHdvr0oO3V04QvdXy8xdw5jfNZwJ5rCWYTGYEinHScC0b
         QB8YAgWxNnOWYx7UZw1/Vcp2HZ7xe8MlU3mY4egH5fsefs7+83mEZoF+87uWHAG8PASB
         6HPQCf64opNRU+9Pm7PJ1ulZVviDAVR2DvSb/2hB+xM2pqJ2/0yRYbQALF2JO9kd/UH+
         e+Qo4mr05Nu4mst9MWQVjXl94DWlXTSQ/5MNFErnwh7ht2gB6EKnTFdrMEvc9HFjVSrR
         O+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=tU19EWZx8u2e2uV3dXR0FXwxIY/5U2XJW8CrROjNUIg=;
        b=cMaXcEhCsaVfO0ia1QsaILYGvhOnOU8XmXPWh77R8dYssuhsXNTZ3ot7DVI8s5fq/O
         U9dZQSVmxGIEpWFg9oohBACPYLNSBCcKsqMm0G/lRMtTdT4Eco+SVo0TJPBJ+6vnYLho
         nJpSyZf3id85F3xkmBCp2a3N4+jhi9Ugn/nFacX/R9GI87ifMfqLIdOSWjp1+6k/F/Un
         GCmwbPxJbQUL3z6IaQ7PMPZUBr5SD93nSXe1sBUepNRc6ycna01yHlnZgaHgAG3mgUAQ
         c6Dq3HFm1BHMB0XFMRAZYsHFETmCS8nwIp8DoRzQ93g+c/NRIR6qJl5zdX4wKgfCOZ/g
         N34g==
X-Gm-Message-State: AGi0PuZ4Xm96hr01WQ+xA7Indew5R9dVnR5gkBGxH/TojNpwDZxhSKv3
        Z043F4C0TStPsNN+Xa3WOw==
X-Google-Smtp-Source: APiQypJOH5J7K90OLTvE4up+WlGYwk/WIHDu36NWekh7qDcyAQo4WCvI75rBiKzmy/uvySr5/C0L0A==
X-Received: by 2002:a9d:644:: with SMTP id 62mr5581256otn.177.1585919323801;
        Fri, 03 Apr 2020 06:08:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 12sm2192250oii.54.2020.04.03.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:08:42 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 0586B18016D;
        Fri,  3 Apr 2020 13:08:42 +0000 (UTC)
Date:   Fri, 3 Apr 2020 08:08:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ipmi: kcs-bmc: Rework bindings to clean up DT
 warnings
Message-ID: <20200403130840.GR2910@minyard.net>
Reply-To: minyard@acm.org
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
 <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 02:20:21PM +1030, Andrew Jeffery wrote:
> 
> 
> On Mon, 16 Dec 2019, at 12:57, Andrew Jeffery wrote:
> > Hello,
> > 
> > This is a short series reworking the devicetree binding and driver for the
> > ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
> > changes enable removal of more than 100 lines of warning output from dtc.
> > 
> > v1 can be found here:
> > 
> > https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au/
> > 
> > v2 cleans up the commit message of 2/3 and changes the name of the property
> > governing the LPC IO address for the KCS devices.
> 
> Ping?

Sorry, I've been busy.  I've looked this over and it seems ok, and it's
in my next tree.

Thanks,

-corey
