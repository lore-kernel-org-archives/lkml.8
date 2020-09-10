Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4798C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7293620720
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0XCiJD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIJGsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgIJGsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:48:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F6C061796;
        Wed,  9 Sep 2020 23:48:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so5432585wrn.0;
        Wed, 09 Sep 2020 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyBji0jUnhO4oYGrGFt75emLfTDTbis+giL1ABCyBwk=;
        b=F0XCiJD4CO+YHJwA/K4EHHG0lF7D3Q17O3rGJYK/fG5W3zJAj+YrB0utZzE+LdGDKW
         BIMK+W1trbYLEIyRiGfoG9XnhBHZ8s6oC8OnrnXAoFBqh0unW6scXNoRKUZSunOaRXl6
         3CA73+Zbc5NpnXYEjmNEIuR91sChvOR4ovdjXTc2UJUqtMLQLLadedyXc+pCAbGc6q05
         AdrKMW7y5CxWvfAlXOqRERMGaep5GVGp34LdD9Rt1f3QdbqwETxyQn3F0WLb7Wfaa01/
         Kmb6V4MYd3/wRAQp7i4Q+CfBnHnYI+PkxyoRafmrpSUI/AEl1eRbANzmBqNLFlw3PH5m
         1UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyBji0jUnhO4oYGrGFt75emLfTDTbis+giL1ABCyBwk=;
        b=KRL0Qq8NEgdYb0I8dp1HvSQb4nUlssptrmRugIpfi3nkkaeCbslMYjKXEMPoTWsKqs
         ajeJxq/8vheS+5H3cphQTr5snMwZnLkz9KQ54l04xe/Wyfdi+wm1W/zVZak213m0eCAl
         K0sPPydYPAVZk5l4f2UwXfx/8lKv+1q/mGdEKiKfLYVHf9g7YBZrlMf2GfNpIpc9dvJB
         7eF5BkPmTFWsM808tjFzsd82oshNhumuLaKiK4hybj4P00qHJtaN72SHySxVLCJn8C+S
         /jp2mTLe8ZiyjMBmJExtHDvmbcCFu8+QOPAqdkGsErRHJQqFtKkUmIbMvb+nlcXjOLnJ
         7wcg==
X-Gm-Message-State: AOAM532n/A0ufnZ7aAoTdQLFMdsBWes6BPX2bvIEvoQtu+btEHs9kUfS
        +5ZtwIqB5eUXO4tB5joKy49dL1lGiQT7Y/qoiXs=
X-Google-Smtp-Source: ABdhPJzLSkdu/NgL5WJvAPPoWZi/tRfyBd1FYIBZ+DfsVm5stBb+zn2uEr03LpzvmbnbdsOLuMVlcVHLa4O383pQUVM=
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr7214695wrx.173.1599720499997;
 Wed, 09 Sep 2020 23:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
In-Reply-To: <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 00:48:07 -0600
Message-ID: <CADvTj4q+b6nLBV6LEdd6K-daNbhTf6rUMOYnj+p0FO6+NTCg7A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Lars Melin <larsm17@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:34 PM Lars Melin <larsm17@gmail.com> wrote:
>
> On 9/10/2020 10:02, Oliver Neukum wrote:
> > Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> >> This patch detects and reverses the effects of the malicious FTDI
> >> Windows driver version 2.12.00(FTDIgate).
> >
> > Hi,
> >
> > this raises questions.
> > Should we do this unconditionally without asking?
> > Does this belong into kernel space?
> >
>
> My answer to both of those question is a strong NO.
>
> The patch author tries to justify the patch with egoistical arguments
> (easier for him and his customers) without thinking of all other users
> of memory constrained embedded hardware that doesn't need the patch code
> but have to carry it.
If that's a concern it would not be difficult to add a kconfig option to allow
disabling it.
>
> The bricked PID is btw already supported by the linux ftdi driver so
> there is no functionality gain in the patch.
By the kernel driver sure, but userspace is where things get messed up
without something like this.
>
> br
> Lars
>
>
>
