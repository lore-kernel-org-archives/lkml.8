Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93895C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AFE20736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589291393;
	bh=x4u8qwRwelsnFwGxMzzvLAhDokYpl6TZ8GuAE0J5+lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mEw9D8ylvZR5/vgR17BgCTDe5w6nbBgU6Z+NZsA9UoF7HKbT4zEEpfZ1byIa4XDjN
	 rla3F3Tjhsy+Q7G8vxbSZQQp7m+Bdazu9S/KEhnAGvvXPmw0Awx3EBKgz93O882v2O
	 ikkZSNcOvIDL/oxKo+F7w/YCEkETujty1vxnkgwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgELNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:49:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40868 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:49:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id i27so10489170ota.7;
        Tue, 12 May 2020 06:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LmZRJWLvdzaYvU2FdqKuGphxoWLyT6wvt7iRAJujax8=;
        b=gkSt484c5OFtH7q3C4So9nIzWm3vIywloTuNgPGIalaiymyeGGTi1A/o8kEwPVu9o/
         zPee/ESKTAg1Z3OjvAc1Ew49HuusS8e9GPt4r0bjcFElKwcFn8uaKKEu35CCZA1LFI08
         /DbL+59EDpzXyRcAPu//DmvuyPabeBXxLIX8j+md71j05MJ+JtWaAtcqpFx2ln5rRauK
         R9yfhghuuuqd0+niG+dJSqlbYZllnfJ96OrwWTneMvmkFwweXzCfMA0jeFDJdB02fa0U
         zczVO0Wmu8fEC2pvfdGGBZ/5qH3ch6upRitKq6eUPvDLteZT2UI782jsM0NTIgIW2jMY
         b6tw==
X-Gm-Message-State: AGi0PuZA+RvoziEnqhp4mAy4hl1EAzxMztHK2/TWESyI6sqTuckQxNBr
        i/iylbiPas6jO0QcWCU19w==
X-Google-Smtp-Source: APiQypKHTHZSKfeZM+cTGodFQTpCrSPwVRIxzg7ilHMJfvL6v/z0YyiKdysEuTTHNjO5vJHiedt6ow==
X-Received: by 2002:a9d:6f12:: with SMTP id n18mr12671574otq.100.1589291391365;
        Tue, 12 May 2020 06:49:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm3581680oou.44.2020.05.12.06.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:49:50 -0700 (PDT)
Received: (nullmailer pid 18100 invoked by uid 1000);
        Tue, 12 May 2020 13:49:49 -0000
Date:   Tue, 12 May 2020 08:49:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 5/5] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200512134949.GA14057@bogus>
References: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
 <20200504154757.17519-5-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504154757.17519-5-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 04:47:57PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Removed contains on the compatible
>  - Moved all sub-nodes into here directly only using $ref for properties
>  - As the regulator binding only contained subnodes that file is now deleted
>  - Removed some pointless descriptions
> 
> A little nervous about the amount of clock and regulator stuff this
> pulls into the MFD file, any comments on that welcome? Would it be worth
> looking into something along the lines of the definitions stuff to keep
> some of that out in the clock and regulator bindings?

It's fine like this. Other than my comments on patch 3, looks fine. 
Respin and I'll apply.

> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  85 -----
>  .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 352 +++++++++++++++++++++
>  .../bindings/regulator/cirrus,lochnagar.txt        |  82 -----
>  MAINTAINERS                                        |  11 +-
>  4 files changed, 357 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
