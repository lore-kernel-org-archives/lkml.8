Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9AC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E30320787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ZZ+QkkHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503891AbgDOTLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416851AbgDOSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:45:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:45:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l25so18524292qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PBQchXV5h+GZBKvpNdyH5xHjxEMUXqW14Qdp3U1Zwvc=;
        b=ZZ+QkkHQTKXaxC1zVQQ/q2prKNkCzlHQabzEGSspciFAhzhlpUCTKgjhDQ6pOYiBfh
         51t2+Gv6VtlAUaVxJo5ggnMII7sRvKSwKbUSot03CmpO+mHUrmC9f4HNo4rmDByEUH+g
         VZZZUtgfWDK5ODUYpfCym8yp/CWQWcErBKkAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBQchXV5h+GZBKvpNdyH5xHjxEMUXqW14Qdp3U1Zwvc=;
        b=OG/nor7xtoP9+Ws9A9NYYOwUiVqgC7Qxe6qQCOCuY9Ts7Wo5NFbFP5lOILEJMjhAFo
         FOZjuL+hnpMoH8mNuBpTtsJ27Ze7upS2UZvm4/NjqQVFI83VzUsWBEV91EfLgTBoee6N
         4/I55QBOd4zv82BkdmZe2vvYdsyuUCuabrLgLi4Fy3e+svjjUFK6xMBeBhd4o/z1z26P
         MmlB/rR+b1/Tr7lI2vmV2KZ8y2+Js14QyhdPKkezW1OgAAKBH4/rDAd6KnnXIPzUui18
         T4kATiB4kiFgaWrgOfMexy/18EzmRwDsdFGPQVyRgJCBTak9MLUuMq0niodKUkUCijzc
         ysOQ==
X-Gm-Message-State: AGi0PubSYpufgiFRpkroF+je8U4oz9raN0edDMGVMz6OP3PjjDSJsGEI
        S951kdwMruYO/CWXlW7abRlIPw==
X-Google-Smtp-Source: APiQypKIGgPLSnD/hI0ZniHM0EIt5UECe27dLHztwyrc5P2U+rUjJibDWwAjqlDUrk55s9PeRu8flg==
X-Received: by 2002:a37:5a02:: with SMTP id o2mr27246247qkb.380.1586976352184;
        Wed, 15 Apr 2020 11:45:52 -0700 (PDT)
Received: from bacon.ohporter.com ([2605:a000:1234:47c6:a553:c33f:1562:b0b1])
        by smtp.gmail.com with ESMTPSA id p31sm11105853qtf.11.2020.04.15.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:45:51 -0700 (PDT)
Date:   Wed, 15 Apr 2020 14:45:48 -0400
From:   Matt Porter <mporter@konsulko.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yibin.gong@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mm: fix dma peripheral type for SAI nodes
Message-ID: <20200415184548.GA29919@bacon.ohporter.com>
References: <20200331203551.20914-1-mporter@konsulko.com>
 <CAEnQRZCqeJkRPEUYL3k8seuNusLZ6QpT-X-A7E20AMHSYcmaUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZCqeJkRPEUYL3k8seuNusLZ6QpT-X-A7E20AMHSYcmaUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:04:43PM +0300, Daniel Baluta wrote:
> On Tue, Mar 31, 2020 at 11:36 PM Matt Porter <mporter@konsulko.com> wrote:
> >
> > The peripheral type specified in the dma phandle for each SAI node
> > is incorrect. Change it to specify the SAI peripheral.
> >
> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> 
> Hi Matt,
> 
> Why do you think this is incorrect?  AFAIK script number 2 works fine
> for SAI. Can you add
> more details on what bug are you encountering?
> 
> Adding Robin the owner of SDMA.

Hi Daniel,

Thanks for the response. I was experiencing timeouts that were traced
back to dma incompletions. Changing the script at the time fixed that
issue. Now, given your response I went back and checked this again and
verified that script 2 does work for me now. I did change firmware to
the latest v4.4 from something quite old so now I'm suspecting I had
bad firmware loaded up. Does that sound plausible? In any case, I can
confirm this is not needed.

-Matt
