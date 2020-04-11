Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB7C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D64C20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITaIMaoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDKBfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:35:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38992 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKBfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:35:31 -0400
Received: by mail-io1-f68.google.com with SMTP id m4so3510936ioq.6;
        Fri, 10 Apr 2020 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UB3JPabx88AV5laKQE5DlYpQCtXofHwvodxXPVmkdrc=;
        b=ITaIMaozjOJzim7ipFt1UNZt9IDFA28AWrmhaY9W5lInseciNJCqe3azdWfEDET378
         HFa0LaKRksIw0z/Mqq8GK96PH/ywhjvUqGSoQ3nkeWuglpU4P+/owc2KPb7y39IvXqyL
         AaT7tUOjbKDnxPjrqK2ZBlmD4O1lEPyHHXC9GEdwBW/nAdTlhsCzCSNQrDuG/fh8Es0v
         ozN3AYEFMOiFVBErVEaP66qqEz+BnU15RqJCzf2Zdo2uhRFtT/My3xPBhK8UaQNU9BY4
         9iJdTdJwr2L/XBa3nggTtYo5uUEoPbp/1nQZgixbd1fCwhI2usO/NjPxjhm6W5KfVF/5
         uKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UB3JPabx88AV5laKQE5DlYpQCtXofHwvodxXPVmkdrc=;
        b=Rup68ZI9hKPv6jTE2zqGooJ0p8GvE44f6Lw69duBbkbJry2mx6mPdYZ/lyuWPcEKsL
         aFIk7LJ0wchpKKz+hg+tm23Fl1GLZ6zA7EZMtnhFF7hy15yJLC7PXbTlr5up5UxGxXrl
         yF0RpLMTe0vqomN4ZqfcHBM4e/0dz0qdYHDDG4RbRDKfP6YNGRxqY0HO0uTmFGX/TZEV
         rJepBmfhbs3wYE+h6tSirCvdQIEnK9Y8UylDE70cIRKsPJYlBZwGupLSN6eO6Tg7KHxZ
         QOrlObcz2rL5U3rioi90HCfQuJoilA4DYyrl4jglW0PR1zKztvHEdUURfytElatHYZa2
         9HeA==
X-Gm-Message-State: AGi0PuaQCFsL7eUIoSaPwaP2Tcu4/qIh/4XU0zWBz2TjeyGTw/LJdkNE
        PYPF2dlNxVGzQqtKfP3LEQgm5oex3Yr7oAayFao=
X-Google-Smtp-Source: APiQypJDFqEkgeLLITQpEj6qAfHuTYAk21iNMDZjClSmNuBFBLMrfAxdBZuLavvWdDTu62qHk6nGdpTsw9eMGBiYr+s=
X-Received: by 2002:a5d:9281:: with SMTP id s1mr2794735iom.197.1586568929544;
 Fri, 10 Apr 2020 18:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144324.21178-1-aford173@gmail.com> <20200324144324.21178-2-aford173@gmail.com>
 <CAOMZO5AnsYi9xM392NofOyuzCmHe6Pry=C9GHWR3JmgEkVJ5Gg@mail.gmail.com>
In-Reply-To: <CAOMZO5AnsYi9xM392NofOyuzCmHe6Pry=C9GHWR3JmgEkVJ5Gg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 10 Apr 2020 20:35:18 -0500
Message-ID: <CAHCN7x+ykXKu-sSCywijbkkYpiSY30Hc2Qo-PFwr0mtGB0Gfdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add Beacon i.MX8m-Mini development kit
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 8:19 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 11:43 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > Beacon Embeddedworks is launching a development kit based on the
> > i.MX8M Mini SoC.  The kit consists of a System on Module (SOM)
> > + baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
> > has an wm8962 audio CODEC, a single USB OTG, and three USB host ports.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Shawn,

Is there any possibility to get applied to imx-next before RC1 is cut?

adam
