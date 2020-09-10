Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F502075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IkeNfVmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIJFQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:16:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:16:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so2866643lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNaWRPfvQ1XxVWAI6kNf+vVCg0KMsJ3HdTduaBia/kU=;
        b=IkeNfVmX4rXBNZyJTD78STYbSTVFethpaKshgRl/PM9Z9/Xn+HAET4qdYT7/SPV1Et
         c7jJxpo8t7d1n11m65lPYV3wdDLsO1958sEA5kB75h+q49RMY/DvgcO+/sy14wX8fuTP
         X6wb6nTxXpyV1Jjw/h4K/mUgjLpraSfOz0VvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNaWRPfvQ1XxVWAI6kNf+vVCg0KMsJ3HdTduaBia/kU=;
        b=VWKlw3KH9MJOOheCnV8HehgaIbPMBM8t8mCaA8RG+vRtID6CuXhjYErrifsbUm01vT
         t1UnDE1iA+F1PuXLsJ4/AbR2SRSDR9kOP591OarzgEAqrZ4jBcnP0NF6eDx1XE9SeGG/
         ZQvwqpFcx/Glh4imqLLm4D9Li9a5OZAkuxIeX3aQNR3kbkj1TaJtirPVtNgc2zTf/CbX
         19PzC8vW3Y62TCHuiK4tI1oA/Ke/fhE+0b5oliMrQ7zu2+LRax/I797CGCo3eac96OSL
         pqSzgwPasM+jGt2PNbGQVyvy2YowsNFE8ByZFuF64aICsDGtkhqT7AtiTKn5Ehg4RpOt
         C+YA==
X-Gm-Message-State: AOAM530Oim/XisxZWA6hxgWMS1oz085DPImVGZ+VPLvns3VhhRCXeGt1
        nKzx54rR+KYEzo8KHTMlobLqRd4OOq9/Gme2w7R5zQ==
X-Google-Smtp-Source: ABdhPJyJqT2ZjDvGjz6phD7q/Arwnk+jaD0SyUsQXAoybtzTiya54zCf4vraR4yLALDMRj8h04YOtWXqQbXVM83hzfI=
X-Received: by 2002:a05:6512:34d1:: with SMTP id w17mr3482420lfr.30.1599714984722;
 Wed, 09 Sep 2020 22:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
 <1598801254-27764-2-git-send-email-moshe@mellanox.com> <20200831121501.GD3794@nanopsycho.orion>
 <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com> <20200902094627.GB2568@nanopsycho>
 <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200903055729.GB2997@nanopsycho.orion> <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200904090450.GH2997@nanopsycho.orion> <20200904125647.799e66e4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6bd0fa45-68ce-b82d-98e6-327c6cd50e80@nvidia.com> <20200907105850.34726158@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <b0550422-83a4-4e97-46e3-cb5f431a6dd7@nvidia.com>
In-Reply-To: <b0550422-83a4-4e97-46e3-cb5f431a6dd7@nvidia.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Thu, 10 Sep 2020 10:46:13 +0530
Message-ID: <CAACQVJqJcdahA8PaxR82YVEyioCPQ2dwa3kkH1=PSDPE5k_s+Q@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:51 PM Moshe Shemesh <moshe@nvidia.com> wrote:
>
>
> On 9/7/2020 8:58 PM, Jakub Kicinski wrote:
> > On Mon, 7 Sep 2020 16:46:01 +0300 Moshe Shemesh wrote:
> >>> In that sense I don't like --live because it doesn't really say much.
> >>> AFAIU it means 1) no link flap; 2) < 2 sec datapath downtime; 3) no
> >>> configuration is lost in kernel or device (including netdev config,
> >>> link config, flow rules, counters etc.). I was hoping at least the
> >>> documentation in patch 14 would be more precise.
> >> Actually, while writing "no-reset" or "live-patching" I meant also no
> >> downtime at all and nothing resets (config, rules ... anything), that
> >> fits mlx5 live-patching.
> >>
> >> However, to make it more generic,  I can allow few seconds downtime and
> >> add similar constrains as you mentioned here to "no-reset". I will add
> >> that to the documentation patch.
> > Oh! If your device supports no downtime and packet loss at all that's
> > great. You don't have to weaken the definition now, whoever needs a
> > weaker definition can add a different constraint level later, no?
>
>
> Yes, but if we are thinking there will be more levels, maybe the flag
> "--live" or "--no_reset" is less extendable, we may need new attr. I
> mean should I have uAPI command line like:
>
> $ devlink dev reload DEV [ netns { PID | NAME | ID } ] [ action {
> driver_reinit | fw_activate } [ limit_level  no_reset ] ]
>
This sounds good. As coming to our device, user can issue

$devlink dev reload DEV action fw_activate

which resets both firmware and driver entities to activate the new
firmware (either pending flashed firmware or reset current firmware).

Thanks for the patch series.
