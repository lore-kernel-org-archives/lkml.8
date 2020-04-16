Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92802C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8C3218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587075074;
	bh=nZ/zJJ4vg3WdeGfR1nLItUHgVbm2bu8HeYWPqXHfkq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KCeVtk3pKcdv3xNq6G7kugB3vcZ7hNDXBIwP6vTdlRpf3ArmLEHNADAG0nlHdXgUM
	 CQWHLpl3hXwGcrno7i0bA0Ht8no7SYMlJfTSVhvkToZjahcFb+Clrsf67VH/SoHLJC
	 YToCX7Wm12mhv2pvnvhmSTrwE4N+bCSIM6oZbcJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgDPWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:11:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43508 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDPWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:11:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id j16so340350oih.10;
        Thu, 16 Apr 2020 15:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e7l3KZP3LSpY+eDsEpEr417woObUBuV9o5LcUWNMomo=;
        b=ggNKrPQFrabekMJ3KU71iR8gj4m/Rd8JUMfdzOo6spjtrupBjlS1M5hbuwwcNcJZUL
         Sq8W8ikbn9kvFWOKrs/HjzYse9+UnH6FqoHLR4ZvZiVdTmA9NxHzGur58IDv4oUNNejL
         6iiukixkl3LIxiSiCZaH2pHRCStZMXUADxvNCI23CGbeFXihAsUGsKgfe24heH2ZnAUR
         ggD/PV8lXvAx9cXIJQKyiFM8ogt/sSQ8A2bYPbQkc5SPiCJ4ZiEBaE8M7bMpw6Oifnvk
         0kZrNzIfEaY3BUtcpoXmSu3lV68kCf5X0GosSRKVu6j3VHQgkiqEHNcsOaJguwMC6KCI
         M9nQ==
X-Gm-Message-State: AGi0PubdP22XPLziekBwaiiHmKzLxZ+Y+iIyS0ql/qp/Rt/d58h2pj/H
        +NzGV/ipqFEfSRLBapqKAaNP4Pk=
X-Google-Smtp-Source: APiQypJpZGsw1kWGbnlXYKpIH1hOOk/mtu6A9zy2j59ycYZEj2CEWD7Wm3bSYNsH2UKKehkIoLsxRQ==
X-Received: by 2002:aca:3983:: with SMTP id g125mr205858oia.13.1587075072415;
        Thu, 16 Apr 2020 15:11:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o128sm7465766oih.41.2020.04.16.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:11:11 -0700 (PDT)
Received: (nullmailer pid 8972 invoked by uid 1000);
        Thu, 16 Apr 2020 22:11:10 -0000
Date:   Thu, 16 Apr 2020 17:11:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 5/5] of: unittest: kmemleak in duplicate property update
Message-ID: <20200416221110.GA8899@bogus>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
 <1587073370-25963-6-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587073370-25963-6-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 16:42:50 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> kmemleak reports several memory leaks from devicetree unittest.
> This is the fix for problem 5 of 5.
> 
> When overlay 'overlay_bad_add_dup_prop' is applied, the apply code
> properly detects that a memory leak will occur if the overlay is removed
> since the duplicate property is located in a base devicetree node and
> reports via printk():
> 
>   OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
>   OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
> 
> The overlay is removed when the apply code detects multiple changesets
> modifying the same property.  This is reported via printk():
> 
>   OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
> 
> As a result of this error, the overlay is removed resulting in the
> expected memory leak.
> 
> Add another device node level to the overlay so that the duplicate
> property is located in a node added by the overlay, thus no memory
> leak will occur when the overlay is removed.
> 
> Thus users of kmemleak will not have to debug this leak in the future.
> 
> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  .../of/unittest-data/overlay_bad_add_dup_prop.dts  | 23 ++++++++++++++++++----
>  drivers/of/unittest.c                              | 12 +++++------
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 

Applied, thanks.

Rob
