Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4BDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1641820716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmDkVADb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgICRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgICRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:19:39 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D0C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:19:37 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z46so1137188uac.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E34pUevinBPv9nlXlIDgJMiC3srQBnGMK5fNngoX64=;
        b=PmDkVADbtD+P3BALcHVP//xg0AuB6aWvk4S4gu9sCpMAAnIbG5kIKMRDXGJZUnOnpv
         19dDkFukgPEmzBuz5+V4Iiuu06vmhK5xWi/Zd1gnPzov0WQoOplNfg7qsnXCHxRFg3GM
         yOIy36WMvr9ejpSc2O4jD7r/yuxbTIRILzrbpe3p3RVDXBmL/mqj+1m0owASDioa/NpD
         iVSUaCSYRRMtkE3z8dXToCXV53S8oS9lOUapu3JS5LvKkpb4eNNAhKeRNK88j8P3fXBX
         ycuBYY11/Yo/W14NDIm2SBtqfqAPn8UfM9Llgpji/wRYo3yDnhvdN+eWarhXHCIxsbmy
         bZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E34pUevinBPv9nlXlIDgJMiC3srQBnGMK5fNngoX64=;
        b=dUq665UNgztUEQtm49crAoShiC7yWvGHE3P4uYUs33YniRl9fVFDQo0H0Y82HFh4vo
         PmIo/u2bpBfXu6+P8Xwune+2AtMX6Yt3wCD4EWqEvif2d7dXfCTLYj+bnSgP9d8mL/Ca
         Wflu73slVGCRG6UfFDge41xM0Pf3wYsPfFtPYBb/Qg49pwzQ3/LMiMG86CUP6DEnVShp
         yM6UDCl2Z1oWQxMGWbY/qIXNC6eK7CNm5iFCvNkQxISdKKsR/9S+St64EcspLBjdnKkG
         x17dEND5QAjS8lnY5jfkgHCLWpwVKkQ0k+Vhk95rPxGWi9JU59zYc3L1HIcH1jVv4sIo
         /JGw==
X-Gm-Message-State: AOAM531mBf73t+sWqy9fDgQoVa+ySvOzbSE/5PHYc23SJ1cPANBLnF3U
        vmELkrsCg9EkqHzahFNn2N2jgxTyZ9QwXA==
X-Google-Smtp-Source: ABdhPJx2Jsh8K7VdXJFmtWoOKbSsK8rhIEsViyM8Dn1peSF6LPM/4R7OFyyR3EjdLEUQTBN17Cq/DQ==
X-Received: by 2002:ab0:7849:: with SMTP id y9mr2153221uaq.66.1599153576574;
        Thu, 03 Sep 2020 10:19:36 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id y15sm374953uag.4.2020.09.03.10.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 10:19:36 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id v20so1154675ual.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:19:36 -0700 (PDT)
X-Received: by 2002:a9f:2237:: with SMTP id 52mr2117679uad.141.1599153575566;
 Thu, 03 Sep 2020 10:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902150442.2779-1-vadym.kochan@plvision.eu> <20200902150442.2779-6-vadym.kochan@plvision.eu>
In-Reply-To: <20200902150442.2779-6-vadym.kochan@plvision.eu>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 3 Sep 2020 19:18:59 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfNX0vYL2QmomVBrjXzmQ7WUUmOhtyM_9WfMkSQD1EuPw@mail.gmail.com>
Message-ID: <CA+FuTSfNX0vYL2QmomVBrjXzmQ7WUUmOhtyM_9WfMkSQD1EuPw@mail.gmail.com>
Subject: Re: [PATCH net v6 5/6] net: marvell: prestera: Add Switchdev driver implementation
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mickey Rachamim <mickeyr@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:07 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>
> The following features are supported:
>
>     - VLAN-aware bridge offloading
>     - VLAN-unaware bridge offloading
>     - FDB offloading (learning, ageing)
>     - Switchport configuration
>
> Currently there are some limitations like:
>
>     - Only 1 VLAN-aware bridge instance supported
>     - FDB ageing timeout parameter is set globally per device
>
> Co-developed-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
> Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
> Co-developed-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
> Signed-off-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
> Co-developed-by: Taras Chornyi <taras.chornyi@plvision.eu>
> Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>


> +int prestera_switchdev_init(struct prestera_switch *sw)
> +{
> +       struct prestera_switchdev *swdev;
> +       int err;
> +
> +       swdev = kzalloc(sizeof(*swdev), GFP_KERNEL);
> +       if (!swdev)
> +               return -ENOMEM;
> +
> +       sw->swdev = swdev;
> +       swdev->sw = sw;
> +
> +       INIT_LIST_HEAD(&swdev->bridge_list);
> +
> +       swdev_wq = alloc_ordered_workqueue("%s_ordered", 0, "prestera_br");
> +       if (!swdev_wq) {
> +               err = -ENOMEM;
> +               goto err_alloc_wq;
> +       }
> +
> +       err = prestera_switchdev_handler_init(swdev);
> +       if (err)
> +               goto err_swdev_init;
> +
> +       err = prestera_fdb_init(sw);
> +       if (err)
> +               goto err_fdb_init;
> +
> +       return 0;
> +
> +err_fdb_init:
> +err_swdev_init:
> +err_alloc_wq:
> +       kfree(swdev);
> +
> +       return err;
> +}
> +
> +void prestera_switchdev_fini(struct prestera_switch *sw)
> +{
> +       struct prestera_switchdev *swdev = sw->swdev;
> +
> +       prestera_fdb_fini(sw);
> +       prestera_switchdev_handler_fini(swdev);
> +       destroy_workqueue(swdev_wq);

this cleanup is also needed on the error path of prestera_switchdev_init

> +       kfree(swdev);
> +}
