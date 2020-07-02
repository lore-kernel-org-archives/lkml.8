Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC0FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E52820724
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LpHBpy/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGBUUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:20:30 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:20:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so26870519qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg7b2Gpb1xwhbPPAs3f/5zlrWsmCaI8VPFPJDIO7oCs=;
        b=LpHBpy/61tYHcbDhOlQTjymqaKpK8J7rjMk4O+FxTS5NK5wsajUBEDiNHJEIxDNrmb
         A/vjKlla5gFM9d87viW/fHklmhK1tz+CtGJjuLrOgKm1ZEF2DF0uohGaSUa3Od6uFgwF
         IwHbe9Uqjfw7uPuVBoh6o2uO3A9wCt0Y8mEwBxwU9GfTM8E8u1sUqDN/34Q6gUmbE6EE
         ziMKMEkt0n4svSAzY7929lErAeLqCQMYa4VIMUTzg5NGv46LiX8uJXvBZ8rB8C3++1H4
         P9iDLw5QIGqyZfad3TJGYKL8vyWL6exkLjaf4NXLoRBjSGaOQyIA7Z8ANbrxEJFmW8s1
         EKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg7b2Gpb1xwhbPPAs3f/5zlrWsmCaI8VPFPJDIO7oCs=;
        b=E+RRIJJYJPwrfwwWx8XJS8ft7hSQb28kIp0y+PkTEe8Uah8PYTmkKzgwRvBF6cpzhn
         Qor9DO2Sfzmp/LnLqqIXu7TaKSmIDzHNtaDbCmuN1TlK0Fr3cKLwnseTXJbKvQe/Z0v5
         75DqhsRlW1VII2ht5cBAFnxErOATKb6iReOrsX7b/7mvjpEeElXdMv0dYYE105jkMTIS
         gM2vNQKn7xvi7grKk3e5HqddyHWDjwd2pxlGK5jpJuh8NxkneMrwf6jSiRfD/93/HcJ8
         Nrs7PvQl/dUMYA5Y3Tw/PbPEsi5WPZdkI99scpb7TbKYcDqQCoXl3bT5YllxP5IzeS29
         QS4Q==
X-Gm-Message-State: AOAM531ReMoZ1GBiIq/jTQgR14mgYvLr2k7nUm4SlfQ0zo3AXzjgy5OT
        LxBh9Isuef8+WwoMYgsUoGeaaeIz8zvRCempOvbc2A==
X-Google-Smtp-Source: ABdhPJzESDQ4tCGpwJuT9gwjDr5sMmtLBgj+5Xday1tr8AbXF/DNxfrO2eOsGxU2iUNCm4NFuhVI4oXEJD/1BRXoKqY=
X-Received: by 2002:a37:a5cc:: with SMTP id o195mr32699648qke.326.1593721229404;
 Thu, 02 Jul 2020 13:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
 <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
 <CA+HUmGhfxYY5QiwF8_UYbp0TY-k3u+cTYZDSqV1s=SUFnGCn8g@mail.gmail.com> <61CC2BC414934749BD9F5BF3D5D9404498748B57@ORSMSX112.amr.corp.intel.com>
In-Reply-To: <61CC2BC414934749BD9F5BF3D5D9404498748B57@ORSMSX112.amr.corp.intel.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 2 Jul 2020 13:20:18 -0700
Message-ID: <CA+HUmGi6D8Ci5fk7vyengJN4qOEH6zz18Kw6B9Us-Kav-78oAg@mail.gmail.com>
Subject: Re: [PATCH] igb: reinit_locked() should be called with rtnl_lock
To:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Cc:     "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So will you be sending a v2 of your patch to include the second fix?

Yes, I am working on it. Just to confirm, v2 should include both fixes, right?

Thanks,
Francesco
