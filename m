Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94977C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731E320760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0tclTPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbgGAPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbgGAPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:32:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC09C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:32:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so22997139lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E6gS+aimqImN8wBG5+fSzUi/+Q8Ho4/+Ovczo+UEJ8=;
        b=O0tclTPUIRDyocJzpve2ClFwX5Z1L28E0KbQC5v/PQoNPfQ5Dr/MzJ19NwKd8iaxC5
         PR6UIoQi9qbJRi0wulRv81DgOK/PBtq/ZgzJcYlIBUknimgsY3vlIZxa0lDECm0XfyUF
         vHMPwisphdyXisPXJ2LxJgHzEs9WLR1CVpYIhYSSrTmDfdhBUfYO51+HcruuCOAVgotD
         AzOR7ff80d0kmKWQokgC4mDLGe8K9JuwhBzVdyv9Jwr8S8L3RuEw9PzOazQ8ctaTssB4
         Mkz1r2/SX1os/yqxLJ0HtGJXRjVEJocWuTqi6e1/ZmcO2sGO22tFwAz6V+s5Qu3weMn0
         nDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E6gS+aimqImN8wBG5+fSzUi/+Q8Ho4/+Ovczo+UEJ8=;
        b=VGG1NTcnggmjin+kc2foOCRp4LdzObo+zjDLdTjbD/vWuc0WSAon+YYVkciUdsV35V
         Y0ueLNIXLY3lIKyzirOCbSvLIepuTV7g5TRNCPzd18wQWysYFkHd1CDupUybL/n+P1bV
         idgSmKA5eAlc+Oq5oXllfcJQrZ4Xrcg1KV7usQ4D2dQRZqRfbWlgqA4WsGXlXbItMUFs
         6vn+TK1bURG7tduYXq1GfLHjtqfRiW8/Z2GvX182ndc3N/7u9tLkgiEdic8DZRfYiMLK
         YkjUe6swDpKVVPqjN6sO8dSBgaJsxtgqZWqeqfbnZLUu3GBL/EzFrcQUhzW791hMghVX
         wspg==
X-Gm-Message-State: AOAM5339R67U6q7KrWM/zZqd/duKQozIq/A4wOa3UEfn0t6FEMAKwao/
        AQiKXPESWJp0Mk0p3YdYqPh+/N0rf9M/FoRJt2Z9LPQ0NOs=
X-Google-Smtp-Source: ABdhPJxH0tAyYaikM2xZRhlRBRKZnnib7zifb/cQLXU2hzrQfwymdQBeQ4wNR/zBauVX1v0st1fPQz6/JuAYSVxfkgM=
X-Received: by 2002:a2e:a375:: with SMTP id i21mr9502233ljn.403.1593617540325;
 Wed, 01 Jul 2020 08:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200701032651.12420-1-linux@roeck-us.net> <20200701152442.GA3609842@bjorn-Precision-5520>
In-Reply-To: <20200701152442.GA3609842@bjorn-Precision-5520>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 1 Jul 2020 12:32:09 -0300
Message-ID: <CAOMZO5CzHKGN5=g7eW2oxqxj3J4smTxi1ya27S7eCM4sJQ3c0A@mail.gmail.com>
Subject: Re: [PATCH] imx: Provide correct number of resources when registering
 gpio devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Jul 1, 2020 at 12:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> Thanks for the fix.  If there are others like this, I'd be glad to
> help fix them since I made the kernel grumpier about this.  Just point
> me at the info.

I am seeing the same warning on drivers/input/touchscreen/mxs-lradc-ts.c

Will Cc you on that discussion.

Thanks
