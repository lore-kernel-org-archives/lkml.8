Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C7E2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="QEJTKbvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIJGwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIJGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0BCC061798
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:52:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so7044556ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Oi1/2XDsUUYYjO+oH/wfDabWVQItGTehh2EKonMuJWc=;
        b=QEJTKbvfrn59aCfMEBRpfEQ/kJORFiHadg3bAvj0a8epgIO24V/YRLT+TIxF4wjBCT
         ynSY0jiNuyTyGkAK+lLP/8MermUplXIxEgcYVm6mvTUY2X+eN0eHD4XIkRzKelSu/x5z
         DKdV1kQcwIzZetVgUemfQmoXOkoSJ4P9F23KsbWYInVlcRf/LRGBT5YAvFipoExsoIxc
         SrD+wT2r+rCG0UhOBLMxSNGuIu0vOO1Swenn9aLDfDjbjxBylRDo5RHdVYSfaKFvQ8vX
         CuZ6EFWoju0zr1LK1mpiYNyxPerDRjRx02D2R+aZZYc8ubQrnl4+IY29T3x2yXf6l7cl
         mM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Oi1/2XDsUUYYjO+oH/wfDabWVQItGTehh2EKonMuJWc=;
        b=lRuRlm8LaKLCZVB5AH4//x6KJ4kCfaJ4t8rBDcY7zHe9C3ouZ7GV9esiJcxkY52p6v
         ZeQi66spRfRXgXTXd5xdRw7lo293Nxe4s3k67gd00m5key/bPTgpKc/+9W1ssnH8udqX
         1erh/EfQ7yliuOyg2jE4NmJbAjJQJg/o5Iroe2VeoUDs4MG/nG5Qs0lhHMixOTBlE6mB
         cQhk525EvRwAZs4Niea6/i7GlCW3H8f3JWFX16Gl7O1zhVCBnbjVkcp6oWvHP2CaTwW8
         ecuupoWOEfPfWEgSR6tfdOarQfyl34buFkMqWzjWc+rF0S2LpROujFbClgKT6zjkaf17
         +/fg==
X-Gm-Message-State: AOAM532gnkjHvfAYNMgfEWZfWnNzsKzFlbhESMgQ18AQqvtVNCD2V8zS
        Ss9U/zKI8jfCnrLV0vWVIeQqXA==
X-Google-Smtp-Source: ABdhPJz3bRfUa77ec38ggN2sgGJQjjndVUIOQC/NiLOUQAToGEbGsPRpFeXtDbXL6a3j2HiR+ANpfA==
X-Received: by 2002:a17:906:4a8c:: with SMTP id x12mr7561128eju.271.1599720720300;
        Wed, 09 Sep 2020 23:52:00 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e15sm5627826eds.5.2020.09.09.23.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:51:59 -0700 (PDT)
Date:   Thu, 10 Sep 2020 08:51:58 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200910065158.GS2997@nanopsycho.orion>
References: <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
 <20200902094627.GB2568@nanopsycho>
 <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200903055729.GB2997@nanopsycho.orion>
 <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200904090450.GH2997@nanopsycho.orion>
 <20200904125647.799e66e4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6bd0fa45-68ce-b82d-98e6-327c6cd50e80@nvidia.com>
 <20200907105850.34726158@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <b0550422-83a4-4e97-46e3-cb5f431a6dd7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0550422-83a4-4e97-46e3-cb5f431a6dd7@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Sep 09, 2020 at 03:27:19PM CEST, moshe@nvidia.com wrote:
>
>On 9/7/2020 8:58 PM, Jakub Kicinski wrote:
>> On Mon, 7 Sep 2020 16:46:01 +0300 Moshe Shemesh wrote:
>> > > In that sense I don't like --live because it doesn't really say much.
>> > > AFAIU it means 1) no link flap; 2) < 2 sec datapath downtime; 3) no
>> > > configuration is lost in kernel or device (including netdev config,
>> > > link config, flow rules, counters etc.). I was hoping at least the
>> > > documentation in patch 14 would be more precise.
>> > Actually, while writing "no-reset" or "live-patching" I meant also no
>> > downtime at all and nothing resets (config, rules ... anything), that
>> > fits mlx5 live-patching.
>> > 
>> > However, to make it more generic,  I can allow few seconds downtime and
>> > add similar constrains as you mentioned here to "no-reset". I will add
>> > that to the documentation patch.
>> Oh! If your device supports no downtime and packet loss at all that's
>> great. You don't have to weaken the definition now, whoever needs a
>> weaker definition can add a different constraint level later, no?
>
>
>Yes, but if we are thinking there will be more levels, maybe the flag
>"--live" or "--no_reset" is less extendable, we may need new attr. I mean
>should I have uAPI command line like:
>
>$ devlink dev reload DEV [ netns { PID | NAME | ID } ] [ action {
>driver_reinit | fw_activate } [ limit_level  no_reset ] ]

Sounds fine.

>
>
