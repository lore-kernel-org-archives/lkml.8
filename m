Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E4C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF424670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnmfKpLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBTBbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:31:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39040 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:31:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so170006pjr.4;
        Wed, 19 Feb 2020 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szYg2AQsd4vPQUXlNOTQeaWlhRWbCJD6D1ASNIe6NPQ=;
        b=YnmfKpLlHDFp/4r9dbH9mYpcYtDzQkvfjIBwgZOS2FTAVbZEvFLZJV5cYEjVMHryDD
         ZinziWcgxAtkfqZWej/jlk7ErptUcF9zL/uzSUXVV0X8Y/ituH3Puhd62Y94Aby9OSkG
         3UbWxTFpyekwXSZdOygXreubDyUmc65byNxSAW4/uIxvOjBoGj1tmYLH0V8Xds/Gg/TB
         wiCCGBqvOvG9wBmmK/W8WPoO9RMwtjz/i6JLUr2rGsuV4PSe0tqMxW13nlDTwF5PGwPY
         melwQyeC74boGcoqQU9vlVMFYWCOnAYj9pFLH6QPl1xq/lpWe0zHUKeugY3TkPMfI2ps
         bZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=szYg2AQsd4vPQUXlNOTQeaWlhRWbCJD6D1ASNIe6NPQ=;
        b=e1AKUOUZx1wX7n0+5hRqARI9gKqpzdiJYqLZJxkyf6ssdXZOpvJVdzPLwxvo38p4Yr
         Om0ZuVBlKaRi+z3DSUjgr2f5bzXbqkJzONEWIGxJHngrCWv1ofZrkGG86GPQYAOBTmyn
         c0Mp9aI28rf8NveDkN7xB61Irjxg/EPdD2iKkpAltdWSXfJnMlLH9PqyNIGXCB70bWnK
         sw7LJ0HUIFwopgfft53j8yfu6Qo7tukcQGubhe3W5yko+d7QQC8Ci1JnPu0Y0RI5Ix+R
         ICWNUDoy8ZUkUFGILYQ2bvEzTRb1cRNChp1nXUKYeeVhFXTKXw6506x8QZRwaUyw6pxA
         GSNw==
X-Gm-Message-State: APjAAAUDBcEFPQgFi2TNL5aARp7qYr3d2184atYrgvRqGW6Jaq0cL6vB
        VhZeRRD9Bide4+tK6dCInLI=
X-Google-Smtp-Source: APXvYqyzmgvxyBGFHEKtfmbVHh4nsUmpCnOiJOLklUkLLXD00WNKvL2PU2ls8e+TkkBLFHlsbUTTpw==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr687568pjr.142.1582162274835;
        Wed, 19 Feb 2020 17:31:14 -0800 (PST)
Received: from taoren-ubuntuvm (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id u13sm957679pjn.29.2020.02.19.17.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 17:31:14 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:31:04 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v3 0/5] aspeed-g6: enable usb support
Message-ID: <20200220013103.GA4830@taoren-ubuntuvm>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
 <5d295199-d0d7-4d58-be29-4621738d7f28@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d295199-d0d7-4d58-be29-4621738d7f28@www.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:55:10AM +1030, Andrew Jeffery wrote:
> 
> 
> On Tue, 18 Feb 2020, at 13:43, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > The patch series aims at enabling USB Host and Gadget support on AST2600
> > platforms.
> > 
> > Patch #1 replaces hardcoded vhub port/endpoint number with device tree
> > properties, so that it's more convenient to add support for ast2600-vhub
> > which provides more downstream ports and endpoints.
> 
> Ah, something I should have mentioned on the previous series is you'll need
> to update the binding documentation with the new properties.

Looks like we don't have dt binding documentation for this driver. I will add
the document in my 2nd patch set "allow to customize vhub device IDs/strings"
so all the new dt properties are included in the doc.

> > 
> > Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.
> 
> Also need to add the 2600 support to the dt binding document.
> 
> Looks good to me otherwise.
> 
> Andrew

Thanks again for the quick review, Andrew.


Cheers,

Tao
